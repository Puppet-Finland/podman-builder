#!/bin/sh
#
# Build librdkafka
cd $BASEDIR

git clone --branch $REF https://github.com/confluentinc/librdkafka.git
cd librdkafka

./configure --prefix $OUTPUT/librdkafka/usr/local
make
make install

cd $OUTPUT/librdkafka

fpm -t deb --force --name "${FPM_NAME}" --description "${FPM_DESCRIPTION}" --license "${FPM_LICENSE}" --vendor "${FPM_VENDOR}" --maintainer "${FPM_MAINTAINER}" --url "${FPM_URL}" --version "${FPM_VERSION}" --iteration "${FPM_ITERATION}" -s dir .
