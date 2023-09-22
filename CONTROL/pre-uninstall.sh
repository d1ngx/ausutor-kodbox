#!/bin/sh

echo "`date +%Y-%m-%d-%H:%M:%S`-pre-uninstall" >> /var/log/kodbox.log

rm -f $APKG_PKG_DIR/www/data/system/install.lock
sleep 2

