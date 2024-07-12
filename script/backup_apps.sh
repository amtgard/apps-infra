#!/bin/bash

AMTWIKI_ASSETS_ZIP_FILE=$(date +amtwiki-assets-%d.zip)
mkdir -p /home/ubuntu/tmp/
zip -r /home/ubuntu/tmp/$AMTWIKI_ASSETS_ZIP_FILE /home/ubuntu/wiki -x *.log
aws s3 cp /home/ubuntu/tmp/$AMTWIKI_ASSETS_ZIP_FILE s3://amtgard-backups/amtwiki-assets/$AMTWIKI_ASSETS_ZIP_FILE
rm -rf /home/ubuntu/tmp/$AMTWIKI_ASSETS_ZIP_FILE