#!/bin/bash

# 1. Setup paths
LOG_DIR="/home/nhcp/devops-projects/01-log-cleaner/logs"
BACKUP_DIR="/home/nhcp/devops-projects/01-log-cleaner/backups"

echo "------------------------------------------"
echo "LOG MANAGEMENT START: $(date)"

# 2. Fresh Start for the ACTIVE logs (Optional, but good for testing)
# We don't delete the backup folder here, or we'd lose our 5-day history!
mkdir -p "$LOG_DIR"
mkdir -p "$BACKUP_DIR"

# 3. Pull REAL system data
echo "STEP 1: Pulling REAL logs from your Ubuntu system..."
tail -n 50 /var/log/syslog > "$LOG_DIR/system_$(date +%F).log"

# 4. ARCHIVE STEP: Move logs older than 1 day to backups
echo "STEP 2: Moving logs older than 1 day to backups..."
find "$LOG_DIR" -name "*.log" -type f -mtime +1 -exec mv {} "$BACKUP_DIR" \;

# 5. PURGE STEP: Delete backups older than 5 days
echo "STEP 3: Deleting files in backups older than 5 days..."
# This is the "30-day" logic you asked for, but set to 5 days as requested
find "$BACKUP_DIR" -name "*.log" -type f -mtime +5 -delete

echo "STEP 4: Verification"
echo "Current Active Logs:"
ls "$LOG_DIR"
echo "Archived Backups:"
ls "$BACKUP_DIR"
echo "------------------------------------------"