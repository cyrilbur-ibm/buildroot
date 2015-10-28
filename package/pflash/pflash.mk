################################################################################
#
## pflash
#
#################################################################################

PFLASH_LICENCE = Apache
PFLASH_VERSION = skiboot-5.1.7
PFLASH_SITE = $(call github,open-power,skiboot,$(PFLASH_VERSION))

#Oddity in the pflash building means make needs to be called twice,
#Really we have to establish all the symlinks first. Patches welcome
define PFLASH_BUILD_CMDS
	$(MAKE) CROSS_COMPILE="$(TARGET_CROSS)" -C $(@D)/external/pflash links arch_links
	$(MAKE) CROSS_COMPILE="$(TARGET_CROSS)" -C $(@D)/external/pflash
endef

define PFLASH_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/external/pflash/pflash $(TARGET_DIR)/bin
endef

$(eval $(generic-package))
