THEOS_DEVICE_IP = 127.0.0.1
THEOS_DEVICE_PORT = 22
ARCHS = armv7 arm64
TARGET = iphone:10.3:8.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = anydmg
anydmg_FILES = Tweak.x
anydmg_CFLAGS += -fvisibility=hidden
anydmg_LIBRARIES = substrate

include $(THEOS_MAKE_PATH)/tweak.mk
