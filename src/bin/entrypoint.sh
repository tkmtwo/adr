#!/bin/sh

# Things to do before we turn over control to the shell

. $HOME/.cargo/env


# This will exec the CMD from your Dockerfile, i.e. "npm start"
exec "$@"
