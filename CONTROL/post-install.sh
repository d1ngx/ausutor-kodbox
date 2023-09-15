#!/bin/sh

KodBox_TEMP_DIR="$APKG_TEMP_DIR/"

case "$APKG_PKG_STATUS" in
        install)
                ;;
        upgrade)
		cp -af $KodBox_TEMP_DIR/setting_user.php $APKG_PKG_DIR/www/config/
		cp -af $KodBox_TEMP_DIR/files $APKG_PKG_DIR/www/data/
		touch $APKG_PKG_DIR/www/data/system/install.lock

		DB_USER=$(grep "DB_USER" $APKG_PKG_DIR/www/config/setting_user.php | cut -d "'" -f 4)
		DB_NAME=$(grep "DB_NAME" $APKG_PKG_DIR/www/config/setting_user.php | cut -d "'" -f 4)
		DB_PWD=$(grep "DB_PWD" $APKG_PKG_DIR/www/config/setting_user.php | cut -d "'" -f 4)

		if [ "$APKG_PKG_INST_VER" = 1.12 ];then
			/usr/local/bin/mysql -u${DB_USER} -p${DB_PWD} -s ${DB_NAME} <<EOF
source $APKG_PKG_DIR/www/app/controller/install/data/update1.14/mysql.sql;
EOF 
		fi
                ;;
        *)
                ;;
esac


exit 0
