# Inherit AOSP device configuration for maguro.
$(call inherit-product, device/sony/pepper/full_pepper.mk)

# Inherit from the common montblanc definitions
$(call inherit-product, device/sony/montblanc-common/montblanc.mk)

# Inherit common product files.
$(call inherit-product, vendor/minimal/products/common.mk)

# Telephony
$(call inherit-product, vendor/minimal/configs/telephony.mk)

# Inherit common build.prop overrides
-include vendor/minimal/products/common_versions.mk

# Device specific settings overlays
DEVICE_PACKAGE_OVERLAYS += device/sony/pepper/overlay

# Device specific bootlogo and charging animation
PRODUCT_COPY_FILES += \
	device/sony/pepper/prebuilt/prebuilt/logo-480x854.rle:root/logo.rle

#TWRP
PRODUCT_COPY_FILES += \
device/sony/pepper/config/twrp.fstab:recovery/root/etc/twrp.fstab \
device/sony/pepper/config/init.recovery.st-ericsson.rc:root/init.recovery.st-ericsson.rc


# Device specific keylayouts and touchscreen configurations files
PRODUCT_COPY_FILES += \
        device/sony/pepper/config/AB8500_Hs_Button.kl:system/usr/keylayout/AB8500_Hs_Button.kl \
        device/sony/pepper/config/cyttsp-spi.kl:system/usr/keylayout/cyttsp-spi.kl \
        device/sony/pepper/config/cyttsp-spi.idc:system/usr/idc/cyttsp-spi.idc \
        device/sony/pepper/config/so34-buttons.kl:system/usr/keylayout/so34-buttons.kl \
        device/sony/pepper/config/ux500-ske-keypad.kl:system/usr/keylayout/ux500-ske-keypad.kl \
        device/sony/pepper/config/simple_remote.kl:system/usr/keylayout/simple_remote.kl \
        device/sony/pepper/config/simple_remote_appkey.kl:system/usr/keylayout/simple_remote_appkey.kl


# Copy pepper specific prebuilt files
PRODUCT_COPY_FILES +=  \
    device/sony/pepper/prebuilt/bootanimation.zip:system/media/bootanimation.zip \
    vendor/minimal/proprietary/tuna/media/audio/notifications/Nexus.mp3:system/media/audio/notifications/Nexus.mp3 \
    vendor/minimal/proprietary/common/media/LMprec_508.emd:system/media/LMprec_508.emd \
    vendor/minimal/proprietary/common/media/PFFprec_600.emd:system/media/PFFprec_600.emd


# Device density
PRODUCT_PROPERTY_OVERRIDES += \
	    ro.sf.lcd_density=240

# Inherit drm blobs
-include vendor/minimal/products/common_drm.mk

# Setup device specific product configuration.
PRODUCT_NAME := minimal_pepper
PRODUCT_BRAND := sony
PRODUCT_DEVICE := pepper
PRODUCT_MODEL := Xperia Sola
PRODUCT_MANUFACTURER := Sony

# Low-RAM optimizations
PRODUCT_PROPERTY_OVERRIDES += \
		ro.config.low_ram=true \
		persist.sys.force_highendgfx=true \
		dalvik.vm.jit.codecachesize=0 \
		ro.config.max_starting_bg=8 \
		ro.sys.fw.bg_apps_limit=16 \
		config.disable_atlas=true

