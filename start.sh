#!/bin/bash

# Startup script for Render deployment
set -e

echo "Starting LibreTranslate server..."

# Set default values for Render environment
export HOST=${HOST:-"0.0.0.0"}
export PORT=${PORT:-"10000"}

# LibreTranslate specific environment variables
export LT_UPDATE_MODELS=${LT_UPDATE_MODELS:-"true"}
export LT_LOAD_ONLY=${LT_LOAD_ONLY:-""}

# Build command arguments
ARGS="--host $HOST --port $PORT"

# Add optional arguments based on environment variables
if [ ! -z "$LT_LOAD_ONLY" ]; then
    ARGS="$ARGS --load-only $LT_LOAD_ONLY"
fi

if [ "$LT_API_KEYS" = "true" ]; then
    ARGS="$ARGS --api-keys"
fi

if [ "$LT_DEBUG" = "true" ]; then
    ARGS="$ARGS --debug"
fi

if [ ! -z "$LT_CHAR_LIMIT" ]; then
    ARGS="$ARGS --char-limit $LT_CHAR_LIMIT"
fi

if [ ! -z "$LT_REQ_LIMIT" ]; then
    ARGS="$ARGS --req-limit $LT_REQ_LIMIT"
fi

if [ "$LT_DISABLE_WEB_UI" = "true" ]; then
    ARGS="$ARGS --disable-web-ui"
fi

echo "Starting with arguments: $ARGS"
exec python main.py $ARGS
