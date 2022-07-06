"""
All constants specific to the application
"""
from app.utils.env import env
APPLICATION = {
    "SCAN_TIMEOUT": env("SCAN_TIMEOUT",4),
    "MAC_ADDR"    : env("MAC_ADDR",'00:10:18:01:4b:b5'),
    "PERIOD"      : env("PERIOD",5)
}
