import logging
import sys
from app.config import settings

def setup_logging():
    # Configure logging
    logging.basicConfig(
        level=logging.INFO if settings.ENVIRONMENT == "production" else logging.DEBUG,
        format="%(asctime)s [%(levelname)s] %(name)s: %(message)s",
        handlers=[
            logging.StreamHandler(sys.stdout)
        ]
    )

    # Set specific log levels for noisy libraries
    logging.getLogger("uvicorn.access").setLevel(logging.WARNING)
    logging.getLogger("sqlalchemy.engine").setLevel(logging.INFO if settings.ENVIRONMENT == "development" else logging.WARNING)

setup_logging()
logger = logging.getLogger("al_huda")
