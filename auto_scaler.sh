#!/bin/bash

THRESHOLD=70
USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}' | cut -d. -f1)
EXISTS=$(docker ps -q -f name=flask-app-scaled)

if [ "$USAGE" -gt "$THRESHOLD" ]; then
  if [ -z "$EXISTS" ]; then
    echo "🚀 High CPU detected! Launching extra container..."
    docker run -d -p 5001:5000 --name flask-app-scaled saurabhkr24/flask-app:latest
  else
    echo "Auto-scaler: container already running."
  fi
else
  if [ -n "$EXISTS" ]; then
    echo "✅ CPU normal again. Stopping scaled container..."
    docker stop flask-app-scaled && docker rm flask-app-scaled
  else
    echo "CPU is normal. No scaling needed."
  fi
fi
