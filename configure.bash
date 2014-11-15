#!/bin/bash
# configure config.lua file

# assign defaults for env vars that aren't set
REDIS_HOST=${REDIS_HOST-"'127.0.0.1'"}
REDIS_PORT=${REDIS_PORT-"'6379'"}
REDIS_PASSWORD=${REDIS_PASSWORD-"''"}
REDIS_TIMEOUT=${REDIS_TIMEOUT-5000}
REDIS_KEEPALIVE_POOL_SIZE=${REDIS_KEEPALIVE_POOL_SIZE-5}
REDIS_KEEPALIVE_MAX_IDLE_TIMEOUT=${REDIS_KEEPALIVE_MAX_IDLE_TIMEOUT-10000}
MAX_PATH_LENGTH=${MAX_PATH_LENGTH-1}
SESSION_LENGTH=${SESSION_LENGTH-900}
PLUGINS=${PLUGINS-"{'random'}"}
DEFAULT_SCORE=${DEFAULT_SCORE-0}

echo "local M = { }
M.redis_host = $REDIS_HOST
M.redis_port = $REDIS_PORT
M.redis_password = $REDIS_PASSWORD
M.redis_timeout = $REDIS_TIMEOUT
M.redis_keepalive_pool_size = $REDIS_KEEPALIVE_POOL_SIZE
M.redis_keepalive_max_idle_timeout = $REDIS_KEEPALIVE_MAX_IDLE_TIMEOUT
M.max_path_length = $MAX_PATH_LENGTH
M.session_length = $SESSION_LENGTH
M.plugins = $PLUGINS
M.default_score = $DEFAULT_SCORE
return M" > /opt/redx/lua/conf/config.lua
