#!/usr/bin/env bash
set -euo pipefail
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="/tmp/postgres_backup_$TIMESTAMP.sql.gz"
S3_BUCKET=""
pg_dumpall -U postgres | gzip > $BACKUP_FILE
aws s3 cp $BACKUP_FILE s3://$S3_BUCKET/postgres/
rm -f $BACKUP_FILE
echo "Postgres Backup complete: $TIMESTAMP"
