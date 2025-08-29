#!/bin/bash
# =======================================
# Deploy script for shopfrombharat
# =======================================

set -e  # exit immediately if a command fails

APP_NAME="shopfrombharat"
APP_PORT=3005

echo "🚀 Starting deployment for $APP_NAME..."

# Step 1: Pull latest code
echo "📥 Pulling latest code..."
sudo git pull

# Step 2: Remove old .next build
if [ -d ".next" ]; then
    echo "🗑️ Removing old .next build..."
    sudo rm -rf .next
fi

# Step 3: Stop old PM2 process
if pm2 list | grep -q "$APP_NAME"; then
    echo "🛑 Stopping old PM2 process..."
    sudo pm2 delete "$APP_NAME"
fi

# Step 4: Build app
echo "🏗️ Building app..."
npm run build

# Step 5: Start app with PM2
echo "🚦 Starting app with PM2..."
PORT=$APP_PORT pm2 start npm --name "$APP_NAME" -- start

# Step 6: Save PM2 process list
sudo pm2 save

echo "✅ Deployment completed successfully for $APP_NAME on port $APP_PORT!"
