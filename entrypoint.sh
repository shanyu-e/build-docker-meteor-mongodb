#!/bin/bash
# Set default settings, pull repository, build
# app, etc., _if_ we are not given a different
# command.  If so, execute that command instead.
set -e

## Default values
: ${APP_DIR:="/var/www"}
: ${BRANCH:="master"}
: ${APP_NAME:="dockmeteor"}
: ${MONGO_URL:="mongodb://${MONGO_PORT_27017_TCP_ADDR}:${MONGO_PORT_27017_TCP_PORT}/${DB}"}
: ${PORT:="80"}

export MONGO_URL
export PORT

# If we are provided a GITHUB_DEPLOY_KEY (path), then
# change it to the new, generic DEPLOY_KEY
if [ -n "${GITHUB_DEPLOY_KEY}" ]; then
   DEPLOY_KEY=$GITHUB_DEPLOY_KEY
fi
# If we are given a DEPLOY_KEY, copy it into /root/.ssh and
# setup a github rule to use it
if [ -n "${DEPLOY_KEY}" ]; then
   if [ ! -f /root/.ssh/deploy_key ]; then
      mkdir -p /root/.ssh
      cp ${DEPLOY_KEY} /root/.ssh/deploy_key
      cat << ENDHERE >> /root/.ssh/config
Host *
  IdentityFile /root/.ssh/deploy_key
  StrictHostKeyChecking no
ENDHERE
   fi
fi

mkdir -p ${APP_DIR}
cd ${APP_DIR}

if [ -n "${REPO}" ]; then
   echo "Getting ${REPO}..."
   git clone ${REPO} ${APP_NAME}
   echo "Switching to branch/tag ${BRANCH}..."
   cd ${APP_NAME}
   git checkout ${BRANCH}
fi

# meteor add package
echo "start install package"
meteor add twbs:bootstrap
meteor add underscore
meteor add iron:router
meteor add sacha:spin
meteor add ian:accounts-ui-bootstrap-3
meteor add accounts-password
meteor add shanyue:errors

# Run meteor
echo "start run meteor..."
cd /var/www/${APP_NAME}
exec meteor 
meteor remove autopublish
meteor remove insecure
pkill -9 node
meteor build ${APP_DIR}/${APP_NAME}
tar xf ${APP_DIR}/${APP_NAME}/{APP_NAME}.tar.gz -C ${APP_DIR}
cd ${APP_DIR}/bundle/programs/server
npm install
cd ${APP_DIR}/bundle
exec node ./main.js
