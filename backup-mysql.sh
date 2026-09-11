#!/usr/bin/env bash
set -euo pipefail
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="/tmp/mysql_backup_$TIMESTAMP.sql.gz"
S3_BUCKET=""
mysqldump -u root -p$DB_PASSWORD --all-databases | gzip > $BACKUP_FILE
aws s3 cp $BACKUP_FILE s3://$S3_BUCKET/mysql/
rm -f $BACKUP_FILE
echo "Backup complete: $TIMESTAMP"
