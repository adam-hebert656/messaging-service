#!/bin/bash

set -e

echo "Starting the application..."
echo "Environment: ${ENV:-development}"

# Add your application startup commands here
mix deps.get
mix ecto.migrate
mix run priv/repo/seeds.exs
mix phx.server
echo "Application started successfully!" 