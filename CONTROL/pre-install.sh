#!/bin/sh

KodBox_TEMP_DIR="$APKG_TEMP_DIR/"


case "$APKG_PKG_STATUS" in
	install)
		;;
	upgrade)
		# config -> temp
		echo "`date +%Y-%m-%d-%H:%M:%S`-pre-upgrade-executed" >> /var/log/kodbox.log
	    	cp -af $APKG_PKG_DIR/www/config/setting_user.php $KodBox_TEMP_DIR
		cp -af $APKG_PKG_DIR/www/data/files $KodBox_TEMP_DIR
		;;
	*)
		;;
esac

exit 0
