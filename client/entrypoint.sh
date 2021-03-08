#!/bin/sh

USER_ID=${UID}
GROUP_ID=${GID}
PASSWORD_FILE=/pw.file

echo "Starting Hydrus with UID/GID : $USER_ID/$GROUP_ID"

echo "Patching Hydrus"

cd /opt/hydrus/

if [ -f "/patch.patch" ]; then
  patch -f -p1 -i /patch.patch
fi

#if [ $USER_ID !=  0 ] && [ $GROUP_ID != 0 ]; then
#  find /opt/hydrus/ -not -path "/opt/hydrus/db/*" -exec chown hydrus:hydrus "{}" \;
#fi

echo "Creating password file from env variable VNC_PASSWORD"
x11vnc -storepasswd ${VNC_PASSWORD} $PASSWORD_FILE
#touch $PASSWORD_FILE

supervisord -c /etc/supervisord.conf
