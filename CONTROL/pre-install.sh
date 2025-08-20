#!/bin/sh

# default in /usr/local/tmp/kodbox-xxx/,which is a empty dir.
KodBox_TEMP_DIR="$APKG_TEMP_DIR/"


case "$APKG_PKG_STATUS" in
	install)
		;;
	upgrade)
		# config -> temp
		echo "`date +%Y-%m-%d-%H:%M:%S`-pre-upgrade-executed, starting backup ..." >> /var/log/kodbox.log
		echo "KodBox_TEMP_DIR is $KodBox_TEMP_DIR" >> /var/log/kodbox.log

		cp -af $APKG_PKG_DIR/www/data/system/install.lock $KodBox_TEMP_DIR
		# 后台任务检测到install.lock 不存在后就会自动退出
		rm -f $APKG_PKG_DIR/www/data/system/install.lock
		sleep 2

		base="/usr/local/www/kodbox"
		[ -d "$base/data/temp" ] &&
		[ "$(find "$base" -mindepth 1 -maxdepth 1 | wc -l)" -eq 1 ] &&
		[ "$(find "$base/data" -mindepth 1 -maxdepth 1 | egrep -v 'sqlite\.lock$' | wc -l)" -eq 1 ] &&
		rm -rf "$base"

		# backup config, files, plugins
	    cp -af $APKG_PKG_DIR/www/config/setting_user.php $KodBox_TEMP_DIR
		cp -af $APKG_PKG_DIR/www/data/files $KodBox_TEMP_DIR
		cp -af $APKG_PKG_DIR/www/plugins $KodBox_TEMP_DIR

		echo "`date +%Y-%m-%d-%H:%M:%S`-pre-upgrade-executed, backup finished." >> /var/log/kodbox.log

		DB_NAME=$(grep "DB_NAME" $APKG_PKG_DIR/www/config/setting_user.php | cut -d "'" -f 4)

		case "${DB_NAME}" in
		  *".php")
		    # echo "cp -af $APKG_PKG_DIR/www/data/system/${DB_NAME} $KodBox_TEMP_DIR" >> /var/log/kodbox.log
		    cp -af $APKG_PKG_DIR/www/data/system/${DB_NAME} $KodBox_TEMP_DIR
		    ;;
		  *)
		    echo "Normal update started ......" >> /var/log/kodbox.log
		    ;;
		esac
		;;
	*)
		;;
esac

exit 0
