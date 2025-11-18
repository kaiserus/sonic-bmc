export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib64/pkgconfig

SUBDIRS := \
	src/boost \
	src/libpeci \
	src/libpldm \
	src/nlohmann_json \
	src/CLI11 \
	src/sdbusplus \
	src/gpioplus \
	src/webui-vue \
	src/bmcweb \
	src/stdplus \
	src/sdeventplus \
	src/phosphor-dbus-interfaces \
	src/phosphor-logging \
	src/phosphor-certificate-manager \
	src/phosphor-modbus \
	src/entity-manager \
	src/phosphor-user-manager \
	src/phosphor-host-ipmid \
	src/phosphor-power \
	src/phosphor-inventory-manager \
	src/phosphor-objmgr \
	src/phosphor-state-manager \
	src/dbus-sensors

.PHONY: all $(SUBDIRS) clean

all: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@

clean:
	for d in $(SUBDIRS); do $(MAKE) -C $$d clean; done

