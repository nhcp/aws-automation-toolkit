#!/bin/bash

# --- CONFIGURATION ---
BUCKET_NAME="nhcp-log-archive-2026"
RESTORE_DIR="/home/nhcp/aws-automation-toolkit/03-disaster-recovery/restored_logs"

mkdir -p "$RESTORE_DIR"

echo "------------------------------------------------"
echo "📂 AWS S3 DISASTER RECOVERY TOOL"
echo "------------------------------------------------"

# 1. List files inside the backups/ folder
echo "🔍 Fetching available archives from S3 (inside /backups)..."
aws s3 ls s3://$BUCKET_NAME/backups/

echo ""
echo "❓ Enter the filename ONLY (e.g., system_xxxx.log.gz):"
read FILE_NAME

# 2. Download and Decompress
if [ -z "$FILE_NAME" ]; then
    echo "❌ Error: No filename entered."
    exit 1
fi

echo "⏳ Downloading backups/$FILE_NAME from AWS..."
aws s3 cp s3://$BUCKET_NAME/backups/$FILE_NAME $RESTORE_DIR/

if [ -f "$RESTORE_DIR/$FILE_NAME" ]; then
    echo "🔓 Decompressing file..."
    gunzip -f "$RESTORE_DIR/$FILE_NAME"
    UNZIPPED_FILE=${FILE_NAME%.gz}
    echo "✅ SUCCESS: File restored to $RESTORE_DIR/$UNZIPPED_FILE"
    echo "------------------------------------------------"
    echo "📄 Preview:"
    tail -n 5 "$RESTORE_DIR/$UNZIPPED_FILE"
else
    echo "❌ ERROR: Could not find that file in the backups/ folder."
fi
