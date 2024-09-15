import os

ALLOWED_HOSTS = os.environ.get("ALLOWED_HOSTS", "*").split(" ")

DATABASE = {
    "NAME": os.environ.get("DB_NAME", "netbox"),
    "USER": os.environ.get("DB_PASS", "netbox"),
    "PASSWORD": os.environ.get("DB_PASSWORD", "netbox"),
    "HOST": os.environ.get("DB_HOST", "postgres"),
    "PORT": 5432,
}

SECRET_KEY = os.environ.get("SECRET_KEY", "itsanetboxsecretforyou")

REDIS = {
    "tasks": {
        "HOST": os.environ.get("REDIS_HOST", "redis"),
        "PORT": 6379,
        "PASSWORD": os.environ.get("REDIS_PASSWORD", "redis"),
        "DATABASE": 0,
        "SSL": False,
    },
    "caching": {
        "HOST": os.environ.get("REDIS_HOST", "redis"),
        "PORT": 6379,
        "PASSWORD": os.environ.get("REDIS_PASSWORD", "redis"),
        "DATABASE": 1,
        "SSL": False,
    },
}

DEBUG = os.environ.get("DEBUG", "true")
DEVELOPER = os.environ.get("DEVELOPER", "true")


INTERNAL_IPS = ("0.0.0.0", "127.0.0.1", "::1")

PLUGINS = [
    "test_plugin",
]
PLUGINS_CONFIG = {
    "netbox_config_diff": {
        "USERNAME": "foo",
        "PASSWORD": "bar",
    }
}

SCRIPTS_ROOT = "scripts"
