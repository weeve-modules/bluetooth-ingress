"""
All constants specific to weeve
"""
from app.utils.env import env

WEEVE = {
    "MODULE_NAME" : env("MODULE_NAME", "bluetooth-observer-ingress"),
    "MODULE_TYPE" : env("MODULE_TYPE", "INGRESS"),
    "EGRESS_URL"  : env("EGRESS_URL", "https://hookb.in/r1YwjDyn7BHzWWJVK8Gq")
}
