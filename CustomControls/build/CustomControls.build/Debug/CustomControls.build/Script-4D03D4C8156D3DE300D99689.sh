#!/bin/sh
OUTPUT_FILE=/Library/Frameworks/$PRODUCT_NAME.framework
//rm -R -f $OUTPUT_FILE
//cp -R $TARGET_BUILD_DIR/$PRODUCT_NAME.framework $OUTPUT_FILE
ditto --noextattr --noacl --norsrc "${TARGET_BUILD_DIR}/${PRODUCT_NAME}.framework" $OUTPUT_FILE
cp -f -R $TARGET_BUILD_DIR/$PRODUCT_NAME.framework $OUTPUT_FILE
