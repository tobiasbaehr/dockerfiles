#!/usr/bin/env bash
set -o errexit

/usr/bin/mysqld_safe;
echo "mysql died at $(date)";
