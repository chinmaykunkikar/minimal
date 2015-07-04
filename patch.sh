 #!bin/bash

#Patching repos got easier

# Define everything here
MINIMAL="/home/darkfalcon/minimal";
PATCHES="$MINIMAL/extra/patches";
FRAMEWORKS="$MINIMAL/frameworks";
AV="$FRAMEWORKS/av";
BASE="$FRAMEWORKS/base";
BIONIC="$MINIMAL/bionic";
BUILD="$MINIMAL/build";
EXTERNALICU="$MINIMAL/external/icu";
NATIVE="$FRAMEWORKS/native";
SYSTEMCORE="$MINIMAL/system/core";

patches () {
	cd "$PATCHES";
}

frameworks () {
	patch -p3 < 001*.patch;
	patch -p3 < 002*.patch;
	patch -p3 < 003*.patch;
}

# Copy patches to their respective directories
patches;
cd "bionic";
cp "*" "$BIONIC";
patches;
cp "build.patch" "$BUILD";
cp "external_icu.patch" "$EXTERNALICU";
patches;
cd "frameworks/av";
cp "*" "$AV";
patches;
cd "frameworks/base";
cp "*" "$BASE";
#patches;
#cd "frameworks/native";
#cp "*" "$NATIVE";
patches;
cd "system/core";
cp "*" "$SYSTEMCORE";

echo -e "\n\nCopied all patches to their respective directories. \nNow starting the patching process.\n\n"

cd "$BIONIC";
patch -p2 < 001*.patch;
patch -p2 < 002*.patch;

cd "$BUILD";
patch -p2 < build.patch;

#cd "$EXTERNALICU";
#patch -p4 < external_icu.patch;

cd "$AV";
frameworks;

cd "$BASE";
frameworks;

#cd "$NATIVE";
#frameworks;

cd "$SYSTEMCORE";
patch -p3 < 001*.patch;
patch -p3 < 002*.patch;

echo -e "Done patching!"
