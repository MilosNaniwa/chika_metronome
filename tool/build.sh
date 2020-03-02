#!/bin/sh

flutter clean

VERSION_CODE=$(expr $(date +%s) / 10)

flutter build ios --release --build-number=${VERSION_CODE}

flutter build appbundle --release --build-number=${VERSION_CODE}

exit 0
