#!/bin/bash
# SimpleOS build script

set -e

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root (sudo ./build.sh)"
    exit 1
fi

# Load configuration
source config.sh

# Build steps
echo "Building SimpleOS ${SIMPLEOS_VERSION}"

# 1. Create build directory
rm -rf ${BUILD_DIR}
mkdir -p ${BUILD_DIR}

# 2. Create base system
source ${SRC_DIR}/base/create_base.sh
create_base_system "${BUILD_DIR}"

source src/security/stig_hardening.sh
apply_stig "${BUILD_DIR}"

# 3. Copy tools and scripts
cp ${SRC_DIR}/tools/simplepkg "${BUILD_DIR}/usr/bin/"
chmod +x "${BUILD_DIR}/usr/bin/simplepkg"
cp ${SRC_DIR}/scripts/init "${BUILD_DIR}/"
chmod +x "${BUILD_DIR}/init"

# Install required packages if they're not present
if ! command -v debootstrap >/dev/null 2>&1; then
    echo "Installing debootstrap..."
    apt-get update
    apt-get install -y debootstrap
fi

# 4. Copy configuration
cp ${SRC_DIR}/config/profile "${BUILD_DIR}/etc/"

# 5. Create distribution archive
tar -czf ${DIST_DIR}/simpleos-${SIMPLEOS_VERSION}.tar.gz -C ${BUILD_DIR} .

# Fix permissions on the final archive
chown $(logname):$(logname) ${DIST_DIR}/simpleos-${SIMPLEOS_VERSION}.tar.gz

echo "Build complete! Distribution archive created at ${DIST_DIR}/simpleos-${SIMPLEOS_VERSION}.tar.gz"