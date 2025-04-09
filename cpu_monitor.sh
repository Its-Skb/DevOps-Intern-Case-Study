#!/bin/bash

THRESHOLD=70
USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}' | cut -d. -f1)

if [ "$USAGE" -gt "$THRESHOLD" ]; then
  echo "⚠️ ALERT: CPU usage is high! Current usage: $USAGE%" >> ~/cpu_alerts.log
  # Optional: send alert (email, notification, etc.)
  # echo "CPU Alert: $USAGE%" | mail -s "CPU Alert" your@email.com
else
  echo "$(date): CPU usage is normal: $USAGE%" >> ~/cpu_alerts.log
fi

