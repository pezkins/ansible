#!/bin/bash

FILE_OWNER=`stat -c "%G:%U" *`

cat <<EOF
{
    "file_owner" : "$FILE_OWNER"
}
EOF