#!/bin/bash
# More safety, by turning some bugs into errors.
# Without `errexit` you don’t need ! and can replace
# PIPESTATUS with a simple $?, but I don’t do that.
set -o errexit -o pipefail -o noclobber -o nounset

echo "Entrypoint script for bluetooth-ingress"
echo "Container args: $@"

########################
# STANDARD ENVIRONMENT #
########################
: "${MODULE_NAME:?Need to set MODULE_NAME to string}"
: "${MODULE_TYPE:?Need to set MODULE_TYPE to string}"

# Validate the environment according to module type
if [[ "$MODULE_TYPE" == "INGRESS" ]]
then
    if [[ -z "$EGRESS_URL" ]]
    then
        : "${EGRESS_SCHEME:?Need to set EGRESS_SCHEME to string or provide full EGRESS_URL as string}"
        : "${EGRESS_HOST:?Need to set EGRESS_HOST to string or provide full EGRESS_URL as string}"
        : "${EGRESS_PORT:?Need to set EGRESS_PORT to string or provide full EGRESS_URL as string}"
        : "${EGRESS_PATH:?Need to set EGRESS_PATH to string or provide full EGRESS_URL as string}"
    fi
    echo "Ingress"
elif [[ "$MODULE_TYPE" == "EGRESS" ]]
then
    : "${INGRESS_PORT:?Need to set INGRESS_PORT to string}"
    : "${INGRESS_PATH:?Need to set INGRESS_PATH to string}"
    if [[ -z "$EGRESS_URL" ]]
    then
        : "${EGRESS_SCHEME:?Need to set EGRESS_SCHEME to string or provide full EGRESS_URL as string}"
        : "${EGRESS_HOST:?Need to set EGRESS_HOST to string or provide full EGRESS_URL as string}"
        : "${EGRESS_PORT:?Need to set EGRESS_PORT to string or provide full EGRESS_URL as string}"
        : "${EGRESS_PATH:?Need to set EGRESS_PATH to string or provide full EGRESS_URL as string}"
    fi
    echo "Egress"
elif [[ "$MODULE_TYPE" == "PROCESS" ]]
then
    : "${INGRESS_PORT:?Need to set INGRESS_PORT to string}"
    : "${INGRESS_PATH:?Need to set INGRESS_PATH to string}"
    if [[ -z "$EGRESS_URL" ]]
    then
        : "${EGRESS_SCHEME:?Need to set EGRESS_SCHEME to string or provide full EGRESS_URL as string}"
        : "${EGRESS_HOST:?Need to set EGRESS_HOST to string or provide full EGRESS_URL as string}"
        : "${EGRESS_PORT:?Need to set EGRESS_PORT to string or provide full EGRESS_URL as string}"
        : "${EGRESS_PATH:?Need to set EGRESS_PATH to string or provide full EGRESS_URL as string}"
    fi
    echo "Process"
elif [[ "$MODULE_TYPE" == "FANOUT" ]]
then
    echo "Fanout NOT SUPPORTED"
    exit 1
else
    echo "Unrecognized MODULE_TYPE = $MODULE_TYPE, choose from INGRESS, EGRESS, PROCESS"
    exit 1
fi
echo Environment validated

if [[ -z "$EGRESS_URL" ]]
then
    echo Egress url: $EGRESS_SCHEME://$EGRESS_HOST:$EGRESS_PORT/$EGRESS_PATH
else
    echo Egress url: $EGRESS_URL
fi
#↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
# YOUR CODE HERE  #
#↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

# CALL THE MAIN SCRIPT
python ./image/src/main.py $@
