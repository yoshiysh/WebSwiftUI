SIMULATOR_OS_VERSION := 15.4

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?# .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":[^#]*? #| #"}; {printf "%-36s%s\n", $$1 $$3, $$2}'

.PHONY: swift-build
swift-build: # Use swfit build
	swift build -v \
-Xswiftc "-sdk" \
-Xswiftc "`xcrun --sdk iphonesimulator --show-sdk-path`" \
-Xswiftc "-target" \
-Xswiftc "x86_64-apple-ios${SIMULATOR_OS_VERSION}-simulator"

.PHONY: show-devices
show-devices: # Show devices
	xcrun xctrace list devices
