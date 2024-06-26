#!/bin/sh -el

[ -z "${INPUT_TARGET_DIR}" ] && { echo "Need to set TARGET_DIR. Default is './'"; exit 1; }
[ -z "${INPUT_CONFIG_FILE}" ] && { echo "Need to set CONFIG_FILE. Default is 'config.yml'"; exit 1; }
[ -z "${INPUT_FORMAT}" ] && { echo "Need to set INPUT_FORMAT. Default is 'PDF'"; exit 1; }

# TODO Enable env paramaters that only INPUT_TARGET_DIR works well.

echo "Run Initialization and build step"
cd $INPUT_TARGET_DIR && bundle install && npm install && npm run pdf
gs -q -r600 -dNOPAUSE -sDEVICE=pdfwrite -o "./articles/$(yq -r '.bookname' $INPUT_ARTICLE_ROOT_DIR/$INPUT_CONFIG_FILE)-GrayScale.pdf" -dPDFSETTINGS=/prepress -dOverrideICC -sProcessColorModel=DeviceGray -sColorConversionStrategy=Gray -sColorConversionStrategyForImage=Gray -dGrayImageResolution=600 -dMonoImageResolution=600 -dColorImageResolution=600 "./articles/$(yq -r '.bookname' ./articles/config.yml).pdf"
cd $INPUT_ARTICLE_ROOT_DIR && review-pdfmaker $INPUT_EBOOK_CONFIG_FILE
echo "Finish build step"
