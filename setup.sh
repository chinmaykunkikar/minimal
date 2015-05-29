#!bin/bash

#Makes life easier

MINIMAL="/home/darkfalcon/minimal";
DPEPPER="$PWD/device/sony/pepper";
LMANIFESTS="$PWD/.repo/local_manifests"
VMINIMAL="$PWD/vendor/minimal";
VPRODUCT="$VMINIMAL/products";

#Quick check if the source directory exists

if [ ! -d "$MINIMAL" ]; then
  echo "No valid working directory found. Exiting...";
  exit;
else
  echo "Found woking directory!"
fi

#Copy files to respective directories 

cp "clean.sh" "$MINIMAL";
cp "compile.sh" "$MINIMAL";
cp "crsc.sh" "$MINIMAL";
cp "reset.sh" "$MINIMAL";
cp "setup.sh" "$MINIMAL";

cd $DPEPPER;
cp "minimal.dependencies" "$MINIMAL/device/sony/pepper/";
rm "$MINIMAL/device/sony/pepper/vendorsetup.sh" && cp "vendorsetup.sh" "$MINIMAL/device/sony/pepper/";
echo "'minimal.dependencies' & 'vendorsetup.sh' copied to path '/device/sony/pepper'";
if [ -f "$MINIMAL/device/sony/pepper/cm.mk" ]; then
rm "$MINIMAL/device/sony/pepper/cm.mk"
else
echo "No cm.mk found, skipping"
fi

cd $LMANIFESTS;
rm "$MINIMAL/.repo/local_manifests/local_manifest.xml" && cp "local_manifest.xml" "$MINIMAL/.repo/local_manifests/";
echo "'local_manifest.xml' copied to path '/.repo/local_manifests/'";

cd $VMINIMAL;
rm "$MINIMAL/vendor/minimal/vendorsetup.sh" && cp "vendorsetup.sh" "$MINIMAL/vendor/minimal/";
echo "'vendorsetup.sh' copied to path '/vendor/minimal/'";

cd $VPRODUCT;
rm "$MINIMAL/vendor/minimal/products/AndroidProducts.mk" && cp "AndroidProducts.mk" "$MINIMAL/vendor/minimal/products/";
cp "minimal_pepper.mk" "$MINIMAL/vendor/minimal/products/";
echo "'AndroidProducts.mk' & 'minimal_pepper.mk' copied to path '/vendor/minimal/products/'";

echo "Done!"

exit
