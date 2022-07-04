"""
All constants specific to weeve
"""
from app.utils.env import env

WEEVE = {
"MODULE_NAME": env("MODULE_NAME", "bluetooth-ingress"),
"MODULE_TYPE": env("MODULE_TYPE", "INGRESS"),
"EGRESS_URL": env("EGRESS_URL", "http://172.17.0.2:80")
}
