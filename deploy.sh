#!/bin/bash
# =======================================
# Deploy script for shopfrombharat-API
# =======================================

set -e  # exit immediately if a command fails

APP_NAME="shopfrombharat-API"
APP_PORT=3004

echo "🚀 Starting deployment for $APP_NAME..."

# Step 1: Pull latest code
echo "📥 Pulling latest code..."
sudo git pull

# Step 3: Stop old PM2 process
if sudo pm2 list | grep -q "$APP_NAME"; then
    echo "🛑 Stopping old PM2 process..."
    sudo pm2 delete "$APP_NAME"
fi

# Step 4: Install Dep
echo "🏗️ Updating node_modules..."
sudo npm  install

# Step 5: Start app with PM2
echo "🚦 Starting app with PM2..."
PORT=$APP_PORT pm2 start app.js --name "$APP_NAME"

# Step 6: Save PM2 process list
sudo pm2 save

echo "✅ Thanks Sukanta Deployment completed successfully for $APP_NAME on port $APP_PORT!"
