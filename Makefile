export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib64/pkgconfig

SUBDIRS := \
	src/nlohmann_json \
	src/CLI11 \
	src/sdbusplus \
	src/bmcweb \
	src/stdplus \
	src/sdeventplus \
	src/phosphor-dbus-interfaces \
	src/phosphor-logging \
	src/phosphor-user-manager


.PHONY: all $(SUBDIRS) clean

all: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@

clean:
	for d in $(SUBDIRS); do $(MAKE) -C $$d clean; done

