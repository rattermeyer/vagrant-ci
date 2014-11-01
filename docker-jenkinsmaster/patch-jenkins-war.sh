#!/bin/sh
set -x
JENKINS_WAR=$1
PLUGIN_PATCH_DIR=$2
TMP_DIR=$3

if [ ! -d ${TMP_DIR} ] ; then 
   mkdir ${TMP_DIR}
fi
cd ${TMP_DIR}
unzip ${JENKINS_WAR}
rm META-INF/JENKINS.*
head -9 META-INF/MANIFEST.MF > META-INF/MANIFEST.MF.2
mv META-INF/MANIFEST.MF.2 META-INF/MANIFEST.MF
cp ${PLUGIN_PATCH_DIR}/* WEB-INF/plugins
zip -r "${JENKINS_WAR}.2" .
mv "${JENKINS_WAR}.2" ${JENKINS_WAR}
