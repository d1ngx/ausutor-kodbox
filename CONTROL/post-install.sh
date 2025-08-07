#!/bin/sh

KodBox_TEMP_DIR="$APKG_TEMP_DIR/"

case "$APKG_PKG_STATUS" in
        install)
                ;;
        upgrade)
		echo "`date +%Y-%m-%d-%H:%M:%S`-post-upgrade-executed, starting recover ..." >> /var/log/kodbox.log
		# echo "KodBox_TEMP_DIR is $KodBox_TEMP_DIR" >> /var/log/kodbox.log
		cp -af $KodBox_TEMP_DIR/setting_user.php $APKG_PKG_DIR/www/config/
		cp -af $KodBox_TEMP_DIR/files $APKG_PKG_DIR/www/data/
		cp -af $KodBox_TEMP_DIR/plugins $APKG_PKG_DIR/www/
		cp -af $KodBox_TEMP_DIR/install.lock $APKG_PKG_DIR/www/data/system/

		# DB_USER=$(grep "DB_USER" $APKG_PKG_DIR/www/config/setting_user.php | cut -d "'" -f 4)
		DB_NAME=$(grep "DB_NAME" $APKG_PKG_DIR/www/config/setting_user.php | cut -d "'" -f 4)
		# DB_PWD=$(grep "DB_PWD" $APKG_PKG_DIR/www/config/setting_user.php | cut -d "'" -f 4)

		if [ "$APKG_PKG_INST_VER" = 1.12 ];then
			mv $APKG_PKG_DIR/www/config/update.php $APKG_PKG_DIR/www/app/
			# mysql -u${DB_USER} -p${DB_PWD} ${DB_NAME} < $APKG_PKG_DIR/www/app/controller/install/data/update1.14/mysql.sql
		fi

		case "${DB_NAME}" in
                  *".php")
					# echo "cp -af $KodBox_TEMP_DIR/${DB_NAME} $APKG_PKG_DIR/www/data/system/" >> /var/log/kodbox.log
					cp -af $KodBox_TEMP_DIR/${DB_NAME} $APKG_PKG_DIR/www/data/system/
                    ;;
                  *)
                    echo "Normal update finished." >> /var/log/kodbox.log
                    ;;
                esac
                ;;
        *)
                ;;
esac


exit 0
