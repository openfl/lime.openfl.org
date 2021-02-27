#!/bin/sh
set -e
SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"
SITE_PATH=$SCRIPT_PATH/../

cd $SITE_PATH
rm -rf _deploy
mkdir _deploy
cp -rf _site/* _deploy
cd _deploy
for file in $(find . -name '*.css' -or -name '*.txt' -or -name '*.js' -or -name '*.json' -or -name '*.htm' -or -name '*.html')
do
	{ zopfli ${file} && mv -f ${file}.gz ${file}; }
	#gzip -t ${file} > /dev/null 2>&1 || { gzip -9 ${file} && mv -f ${file}.gz ${file}; }
done
#gzipped files max cache 1 minute
aws s3 sync . s3://lime.software --acl bucket-owner-full-control --acl public-read --size-only --delete --exclude="*" --include="*.css" --include="*.txt" --include="*.js" --include="*.json" --include="*.htm" --include="*.html" --include="*.map" --include="*.xml" --content-encoding gzip --cache-control max-age=3600
#uncompressed files max cache 1 minute
aws s3 sync . s3://lime.software --acl bucket-owner-full-control --acl public-read --size-only --delete --exclude="*" --include="*.xsd" --cache-control max-age=3600
#uncompressed files max cache 7 days
aws s3 sync . s3://lime.software --acl bucket-owner-full-control --acl public-read --size-only --delete --include="*" --exclude="*.css" --exclude="*.txt" --exclude="*.js" --exclude="*.json" --exclude="*.htm" --exclude="*.html" --exclude="*.map" --exclude="*.xml" --exclude="*.xsd" --cache-control max-age=864000
