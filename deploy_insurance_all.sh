#!/bin/bash
SERVERS="cosmoatgwebprd01 cosmoatgwebprd02 cosmoatgwebprd03 cosmoatgwebprd04"
ZIP_PATH="/home/operation/insurance_deploy_folder"
ZIP_FILE="$ZIP_PATH/production.zip"
ROOT_SCRIPT_HOME="/root/scripts/middleware"

for SERVER in $SERVERS
do
	echo "------------------"
	echo "$SERVER"
	echo "------------------"
	scp $ZIP_FILE $SERVER:$ZIP_PATH/ 2>/dev/null
	if [ $? -ne 0 ] ; then echo "scp zip to $SERVER failed";echo "" ;else echo "scp zip to $SERVER successful";echo "";fi
	ssh $SERVER "$ROOT_SCRIPT_HOME/deploy_insurance.sh" 2>/dev/null
	echo "------------------"
	if [ $? -ne 0 ] ; then echo "deployment to server $SERVER failed";echo "" ;else echo "deployment to server $SERVER successful";fi
	echo "------------------"
done
