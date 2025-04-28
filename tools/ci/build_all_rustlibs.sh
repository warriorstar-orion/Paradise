#!/bin/bash

# Make is fail early if theres a problem
set -euo pipefail
set -x

# Get to our folder first
cd rust

build_library() {
	TARGET_DIR="target/byond-${BYOND_BUILD_VERSION}"

	BUILD_FEATURE_FLAGS=""
	if (( ${#BUILD_FEATURES[@]} != 0 )); then
		BUILD_FEATURE_FLAGS=$(IFS=, ; echo "--no-default-features --features ${BUILD_FEATURES[*]}")
	fi

	cargo build --profile $TARGET_PROFILE --target $TARGET_TRIPLE --target-dir $TARGET_DIR $BUILD_FEATURE_FLAGS
	cp $TARGET_DIR/$TARGET_TRIPLE/$TARGET_PROFILE/$TARGET_ARTIFACT "../lib/${TARGET_ARTIFACT%.*}_${TARGET_PROFILE}_${BUILD_ARCH}_${BYOND_BUILD_VERSION}.${TARGET_ARTIFACT##*.}"
}

for BUILD_ARCH in i686 x86_64; do
	for BYOND_BUILD_VERSION in 515 516; do
		BUILD_FEATURES=("byond-${BYOND_BUILD_VERSION}")
		TARGET_PROFILE="release"

		if [[ "$BUILD_ARCH" == "x86_64" ]]; then
			BUILD_FEATURES+=("opendream")
		fi

		BUILD_PLATFORM="unknown-linux"
		TARGET_ARTIFACT="librustlibs.so"
		BUILD_COMPILER="gnu"
		TARGET_TRIPLE="${BUILD_ARCH}-${BUILD_PLATFORM}-${BUILD_COMPILER}"
		build_library

		BUILD_PLATFORM="pc-windows"
		TARGET_ARTIFACT="rustlibs.dll"
		if [[ "$OSTYPE" == "msys" ]]; then
			BUILD_COMPILER="msvc"
		fi
		TARGET_TRIPLE="${BUILD_ARCH}-${BUILD_PLATFORM}-${BUILD_COMPILER}"
		build_library

		TARGET_PROFILE="production"
		build_library
	done
done
