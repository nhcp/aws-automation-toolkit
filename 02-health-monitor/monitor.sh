#!/bin/bash

# --- CONFIGURATION ---
THRESHOLD=80
# The absolute path to your Project 01 script
CLEANER_SCRIPT="/home/nhcp/aws-automation-toolkit/01-s3-log-archiver/cleaner_aws.sh"
LOG_FILE="/home/nhcp/aws-automation-toolkit/02-health-monitor/system_health.log"

echo "------------------------------------------------" | tee -a "$LOG_FILE"
echo "🛡️ HEALTH CHECK: $(date)" | tee -a "$LOG_FILE"

# 1. Check Disk Usage
# We look at the root partition (/) and extract the percentage number
DISK_USAGE=$(df / | grep / | awk '{ print $5 }' | sed 's/%//')

echo "📊 Current Disk Usage: $DISK_USAGE%" | tee -a "$LOG_FILE"

# 2. Trigger Self-Healing Logic
if [ "$DISK_USAGE" -gt "$THRESHOLD" ]; then
    echo "🚨 WARNING: Disk usage is above $THRESHOLD%!" | tee -a "$LOG_FILE"
    echo "⚡ Executing Project 01: S3 Log Archiver..." | tee -a "$LOG_FILE"
    
    # This is where the magic happens: Script 02 calls Script 01
    bash "$CLEANER_SCRIPT"
    
    echo "✅ Cleanup sequence finished." | tee -a "$LOG_FILE"
else
    echo "🟢 Disk space is healthy. No cleanup needed." | tee -a "$LOG_FILE"
fi

# 3. Check Available RAM (Pro-active Monitoring)
FREE_RAM=$(free -m | awk '/^Mem:/{print $4}')
echo "🧠 Available RAM: ${FREE_RAM}MB" | tee -a "$LOG_FILE"

echo "------------------------------------------------" | tee -a "$LOG_FILE"
