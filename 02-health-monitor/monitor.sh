#!/bin/bash

# --- CONFIGURATION ---
THRESHOLD=00
# Absolute path to your Project 01 script
CLEANER_SCRIPT="/home/nhcp/aws-automation-toolkit/01-s3-log-archiver/cleaner_aws.sh"
LOG_FILE="/home/nhcp/aws-automation-toolkit/02-health-monitor/system_health.log"
# Your AWS SNS Topic ARN
TOPIC_ARN="arn:aws:sns:eu-central-1:417183877568:ServerHealthAlerts"

echo "------------------------------------------------" | tee -a "$LOG_FILE"
echo "🛡️ HEALTH CHECK: $(date)" | tee -a "$LOG_FILE"

# 1. Check Disk Usage
# Grabs the usage % of the root (/) partition
DISK_USAGE=$(df / | grep / | awk '{ print $5 }' | sed 's/%//')

echo "📊 Current Disk Usage: $DISK_USAGE%" | tee -a "$LOG_FILE"

# 2. Trigger Self-Healing Logic
if [ "$DISK_USAGE" -gt "$THRESHOLD" ]; then
    echo "🚨 WARNING: Disk usage is above $THRESHOLD%!" | tee -a "$LOG_FILE"
    
    # --- AWS SNS NOTIFICATION ---
    echo "📧 Sending AWS SNS Alert..." | tee -a "$LOG_FILE"
    aws sns publish \
        --topic-arn "$TOPIC_ARN" \
        --subject "🚨 DISK ALERT: Server nhcp-ubuntu" \
        --message "Emergency: Disk usage is at $DISK_USAGE%. The automated S3 Archiver (Project 01) has been triggered to prevent a system crash."
    # ----------------------------

    echo "⚡ Executing Project 01: S3 Log Archiver..." | tee -a "$LOG_FILE"
    bash "$CLEANER_SCRIPT"
    echo "✅ Cleanup sequence finished." | tee -a "$LOG_FILE"
else
    echo "🟢 Disk space is healthy. No cleanup needed." | tee -a "$LOG_FILE"
fi

# 3. Check Available RAM (Additional Observability)
FREE_RAM=$(free -m | awk '/^Mem:/{print $4}')
echo "🧠 Available RAM: ${FREE_RAM}MB" | tee -a "$LOG_FILE"

echo "------------------------------------------------" | tee -a "$LOG_FILE"
