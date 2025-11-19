ifndef PACKAGE_MK_INCLUDED
PACKAGE_MK_INCLUDED := 1
PKGROOT :=pkgroot
PKGROOT_DIR := $(ROOT_DIR)/$(PKGROOT)
CONTROL_FILE :=$(ROOT_DIR)/DEBIAN/control

define package_deb
	cd $(SRC_DIR) && DESTDIR=$(PKGROOT_DIR) $(NINJA) -C $(BUILD_DIR) install
	if [ ! -f "$(CONTROL_FILE)" ]; then \
		echo "not exist"; \
	else \
		cp -r $(ROOT_DIR)/DEBIAN $(PKGROOT_DIR); \
		PACKAGE=$$(awk '/^Package:/ {print $$2}' "$(CONTROL_FILE)"); \
		VERSION=$$(awk '/^Version:/ {print $$2}' "$(CONTROL_FILE)"); \
		ARCH=$$(awk '/^Architecture:/ {print $$2}' "$(CONTROL_FILE)"); \
		DEB_NAME=$${PACKAGE}_$${VERSION}_$${ARCH}.deb; \
		dpkg-deb --build $(PKGROOT) $${DEB_NAME}; \
		mkdir -p "$(TARGET_DIR)"; \
		mv "$$DEB_NAME" "$(TARGET_DIR)"; \
	fi
endef

endif # PACKAGE_MK_INCLUDED

