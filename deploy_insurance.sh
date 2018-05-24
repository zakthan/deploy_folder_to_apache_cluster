#!/bin/bash
ZIP_PATH="/home/operation/insurance_deploy_folder"
ZIP_FILE="$ZIP_PATH/production.zip"
FOLDER_NAME=insurance
APACHE_DOC_ROOT="/var/www/www.cosmote.gr"


##if file does not exist exit

if [ ! -f $ZIP_FILE ]; then
    echo "File production.zip not found!Exiting. You need to place this file under $ZIP_PATH"
    exit 1
fi

## unzip $ZIP_FILE under $ZIP_PATH/$FOLDER_NAME
echo "Unzipping"
unzip $ZIP_FILE -d $ZIP_PATH/$FOLDER_NAME &> /dev/null
if [ $? -ne 0 ] ; then echo "Unzip has failed";echo "" ;else echo "Unzip successful";echo "";fi

##Delete old insurance.old and mv deployed insurance folder to insurance.old
rm -rf $APACHE_DOC_ROOT/$FOLDER_NAME.old
echo "Backup insurance folder"
/bin/mv -f $APACHE_DOC_ROOT/$FOLDER_NAME $APACHE_DOC_ROOT/$FOLDER_NAME.old
if [ $? -ne 0 ] ; then echo "Backup of old insurance folder has failed";echo "" ;else echo "Backup of old insurance folder successful. Folder is $APACHE_DOC_ROOT/$FOLDER_NAME.old";echo "";fi

## Deploy new folder to apache
echo "Deploying new insurance folder"
/bin/mv  $ZIP_PATH/$FOLDER_NAME $APACHE_DOC_ROOT/
if [ $? -ne 0 ] ; then echo "Deploy has failed";echo "" ;else echo "Deploy successful";echo "";fi
