"""
Main flask entry point
"""
from logging import getLogger


from app.config import WEEVE
from app.weeve import send_data
from app.module import module_main
log = getLogger(__name__)


def create_app():
    """ Configures the flask ap and returns it

    Returns:
        bool: [App created or not]
    """
    module_main()
