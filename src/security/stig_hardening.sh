#!/bin/bash
# STIG Hardening Script for SimpleOS
# Based on DISA STIG Guidelines

apply_stig() {
    local ROOT_DIR="$1"
    echo "Applying STIG controls to ${ROOT_DIR}..."

    # Create ALL necessary directories first
    mkdir -p "${ROOT_DIR}/etc/security/limits.d"
    mkdir -p "${ROOT_DIR}/etc/ssh"
    mkdir -p "${ROOT_DIR}/etc/audit/rules.d"
    mkdir -p "${ROOT_DIR}/etc/sysctl.d" 
    mkdir -p "${ROOT_DIR}/var/log"
    mkdir -p "${ROOT_DIR}/etc/profile.d"

    # Password and Authentication Controls
    cat > "${ROOT_DIR}/etc/security/pwquality.conf" << EOF
minlen = 15
dcredit = -1
ucredit = -1
ocredit = -1
lcredit = -1
difok = 8
maxrepeat = 3
EOF

    # System Access Controls
    cat > "${ROOT_DIR}/etc/security/limits.conf" << EOF
* hard core 0
* hard maxlogins 10
* soft nofile 1024
* hard nofile 4096
EOF

    # Audit Policy
    cat > "${ROOT_DIR}/etc/audit/rules.d/audit.rules" << EOF
# Delete all existing rules
-D

# Buffer Size
-b 8192

# Failure Mode
-f 1

# Monitor sudo usage
-w /etc/sudoers -p wa -k actions
-w /etc/sudoers.d/ -p wa -k actions

# Monitor access to sensitive files
-w /etc/passwd -p wa -k identity
-w /etc/group -p wa -k identity
-w /etc/shadow -p wa -k identity

# Monitor system admin actions
-w /var/log/sudo.log -p wa -k actions
EOF

    # Secure SSH Configuration
    cat > "${ROOT_DIR}/etc/ssh/sshd_config" << EOF
Protocol 2
PermitRootLogin no
MaxAuthTries 3
PubkeyAuthentication yes
PasswordAuthentication no
PermitEmptyPasswords no
X11Forwarding no
MaxSessions 4
ClientAliveInterval 300
ClientAliveCountMax 0
LoginGraceTime 60
Banner /etc/issue
AllowTcpForwarding no
AllowAgentForwarding no
EOF

    # System Security Configuration
    cat > "${ROOT_DIR}/etc/sysctl.d/99-security.conf" << EOF
# IP Hardening
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv4.conf.all.secure_redirects = 0
net.ipv4.conf.default.secure_redirects = 0
net.ipv4.conf.all.accept_source_route = 0
net.ipv4.conf.default.accept_source_route = 0
net.ipv4.conf.all.log_martians = 1

# System Hardening
kernel.randomize_va_space = 2
kernel.kptr_restrict = 2
kernel.sysrq = 0
kernel.core_uses_pid = 1
kernel.dmesg_restrict = 1
EOF

    # File Permissions
    chmod 644 "${ROOT_DIR}/etc/passwd"
    chmod 644 "${ROOT_DIR}/etc/group"
    chmod 600 "${ROOT_DIR}/etc/shadow"
    chmod 600 "${ROOT_DIR}/etc/ssh/sshd_config"
    chmod 600 "${ROOT_DIR}/etc/security/pwquality.conf"
    chmod 644 "${ROOT_DIR}/etc/sysctl.d/99-security.conf"
    
    # Create secure MOTD
    cat > "${ROOT_DIR}/etc/motd" << EOF
*******************************************************************
*                        NOTICE TO USERS                           *
*                    Security Information                          *
* This is a controlled access system. All activity is monitored.  *
*******************************************************************
EOF

    # Add to build script hooks
    echo "Running system hardening..." >> "${ROOT_DIR}/etc/profile.d/security.sh"
    chmod 755 "${ROOT_DIR}/etc/profile.d/security.sh"

    echo "STIG controls applied successfully"
}

# Usage in build script
# source stig_hardening.sh
# apply_stig "${BUILD_DIR}"