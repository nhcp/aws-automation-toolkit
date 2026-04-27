#!/bin/bash

# =================================================================
# PROJECT: AWS Cloud-Native Log Rotator
# GOAL: Pull system logs, compress for cost-saving, and archive to S3.
# =================================================================

# 1. AWS & PATH SETTINGS
# -----------------------------------------------------------------
BUCKET_NAME="nhcp-log-archive-2026"
LOG_DIR="/home/nhcp/devops-projects/01-log-cleaner/logs"
BACKUP_DIR="/home/nhcp/devops-projects/01-log-cleaner/backups"
TIMESTAMP=$(date +%F_%H-%M-%S)

# Create directories if they don't exist
mkdir -p "$LOG_DIR"
mkdir -p "$BACKUP_DIR"

echo "--- AWS LOG ARCHIVE START: $TIMESTAMP ---"

# 2. DATA EXTRACTION
# -----------------------------------------------------------------
# Pull the last 100 lines of system activity to create a real log file
echo "STEP 1: Capturing system logs..."
tail -n 100 /var/log/syslog > "$LOG_DIR/system_$TIMESTAMP.log"

# 3. COMPRESS & ARCHIVE TO S3 (The Cloud Logic)
# -----------------------------------------------------------------
echo "STEP 2: Processing logs older than 1 day for S3 upload..."

# find looks for files ending in .log that haven't been touched in 24 hours
find "$LOG_DIR" -name "*.log" -type f -mtime +1 | while read file; do
    FILENAME=$(basename "$file")
    
    echo "Processing: $FILENAME"
    
    # Compress the file (reduces size by ~90%, saving S3 storage costs)
    gzip "$file"
    
    # Upload the zipped file to the S3 bucket in the 'backups/' folder
    aws s3 cp "$file.gz" "s3://$BUCKET_NAME/backups/$FILENAME.gz"
    
    # Check if the AWS command succeeded ($? is the exit code of the last command)
    if [ $? -eq 0 ]; then
        echo "✅ Successfully archived $FILENAME to S3."
        # Move the local zipped copy to the backup folder
        mv "$file.gz" "$BACKUP_DIR/"
    else
        echo "❌ FAILED to upload $FILENAME to S3. Keeping file in logs directory."
    fi
done

# 4. LOCAL HOUSEKEEPING
# -----------------------------------------------------------------
echo "STEP 3: Deleting local zipped backups older than 5 days..."
# We keep them locally for 5 days for quick access, then delete them chmod +x cleaner_aws.sh
# because they are already safe in the S3 "Cloud" bucket.
find "$BACKUP_DIR" -name "*.gz" -type f -mtime +5 -delete

echo "--- LOG MANAGEMENT COMPLETE ---"