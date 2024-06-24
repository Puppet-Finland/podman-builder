#!/bin/sh
#
# Build librdkafka
cd $BASEDIR

git clone --branch $REF $GIT_URL
cd librdkafka

./configure --prefix $OUTPUT/librdkafka/usr/local
make
make install

cd $OUTPUT/librdkafka

fpm \
  -t deb \
  --force \
  --name "${FPM_NAME}" \
  --description "${FPM_DESCRIPTION}" \
  --license "${FPM_LICENSE}" \
  --vendor "${FPM_VENDOR}" \
  --maintainer "${FPM_MAINTAINER}" \
  --url "${FPM_URL}" \
  --version "${FPM_VERSION}" \
  --iteration "${FPM_ITERATION}" \
  --after-install "${BASEDIR}/after-install.sh" \
  -s dir .
