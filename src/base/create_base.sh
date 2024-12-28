#!/bin/bash
# Creates the base system structure

create_base_system() {
    local ROOT_DIR="$1"
    
    echo "Creating minimal base system..."
    # Use debootstrap to create the core system
    sudo debootstrap --variant=minbase \
        --include=bash,coreutils,tar,gzip,wget,ca-certificates \
        bookworm \
        "${ROOT_DIR}" \
        http://deb.debian.org/debian/

    # Verify the download source and ensure the user has the necessary permissions
    if [ $? -ne 0 ]; then
        echo "Error: Failed to download base system. Please check your internet connection and permissions."
        exit 1
    fi

    # Create wsl.conf
    cat > "${ROOT_DIR}/etc/wsl.conf" << EOF
[automount]
enabled = false
mountFsTab = false

[network]
generateHosts = true
generateResolvConf = true

[interop]
enabled = false
appendWindowsPath = false

[boot]
systemd = false

[user]
default = root
EOF
    sudo chown -R $(id -u):$(id -g) "${ROOT_DIR}"
    # Ensure our custom profile doesn't get overwritten
    mv "${ROOT_DIR}/etc/profile" "${ROOT_DIR}/etc/profile.orig"
    
    echo "Base system structure created in ${ROOT_DIR}"
}