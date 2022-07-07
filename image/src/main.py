"""Main app file"""
from logging import getLogger
from app import create_app
from app.config import WEEVE, configure_logging


log = getLogger("main")


def main():
    """ Main app entry point"""
    configure_logging()
    create_app()

if __name__ == "__main__":
    main()
