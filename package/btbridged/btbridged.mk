################################################################################
#
## btbridged
#
#################################################################################

BTBRIDGED_VERSION = 1.0
BTBRIDGED_LICENCE = Apache2.0
BTBRIDGED_SITE = $(call github,openbmc,btbridge,master)
BTBRIDGED_DEPENDENCIES = systemd host-pkgconf

define BTBRIDGED_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" -C $(@D)
endef

define BTBRIDGED_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/btbridged $(TARGET_DIR)/bin
	$(INSTALL) -D -m 0622 $(@D)/org.openbmc.HostIpmi.conf $(TARGET_DIR)/etc/dbus-1/system.d
	$(INSTALL) -D -m 0755 $(@D)/btbridged.service $(TARGET_DIR)/usr/lib/systemd/system
	mkdir -p $(TARGET_DIR)/etc/systemd/system/multi-user.target.wants
	ln -fs ../../../../usr/lib/systemd/system/btbridged.service \
		$(TARGET_DIR)/etc/systemd/system/multi-user.target.wants/btbridged.service
endef

$(eval $(generic-package))

