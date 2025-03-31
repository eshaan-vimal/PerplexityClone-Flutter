from dotenv import load_dotenv
from pydantic_settings import BaseSettings


load_dotenv()

class Settings (BaseSettings):
    SEARCH_KEY: str = ''
    LLM_KEY: str = ''