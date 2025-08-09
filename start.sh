#!/bin/sh

# # Run migrations and start server
# echo "Running database migrations..."
# npx medusa db:migrate

# echo "Seeding database..."
# npm run seed || echo "Seeding failed, continuing..."

# echo "Starting Medusa server..."
# npm run start

npx medusa build 

cd ./medusa/server 

yarn install --network-timeout 1000000

yarn predeploy

yarn run start