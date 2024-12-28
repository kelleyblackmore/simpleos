#!/bin/bash
# STIG Hardening Script for SimpleOS
# Based on DISA STIG Guidelines

apply_stig() {
    local ROOT_DIR="$1"
    echo "Applying STIG controls to ${ROOT_DIR}..."

    # Create necessary directories with sudo
    sudo mkdir -p "${ROOT_DIR}/etc/security/limits.d"
    sudo mkdir -p "${ROOT_DIR}/etc/ssh"
    sudo mkdir -p "${ROOT_DIR}/etc/audit/rules.d"
    sudo mkdir -p "${ROOT_DIR}/etc/sysctl.d"
    sudo mkdir -p "${ROOT_DIR}/var/log"
    sudo mkdir -p "${ROOT_DIR}/etc/profile.d"

    # Password and Authentication Controls
    sudo tee "${ROOT_DIR}/etc/security/pwquality.conf" > /dev/null << EOF
minlen = 15
dcredit = -1
ucredit = -1
ocredit = -1
lcredit = -1
difok = 8
maxrepeat = 3
EOF

    # System Access Controls
    sudo tee "${ROOT_DIR}/etc/security/limits.conf" > /dev/null << EOF
* hard core 0
* hard maxlogins 10
* soft nofile 1024
* hard nofile 4096
EOF

    # Audit Policy
    sudo tee "${ROOT_DIR}/etc/audit/rules.d/audit.rules" > /dev/null << EOF
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
    sudo tee "${ROOT_DIR}/etc/ssh/sshd_config" > /dev/null << EOF
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
    sudo tee "${ROOT_DIR}/etc/sysctl.d/99-security.conf" > /dev/null << EOF
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
    sudo chmod 644 "${ROOT_DIR}/etc/passwd"
    sudo chmod 644 "${ROOT_DIR}/etc/group"
    sudo chmod 600 "${ROOT_DIR}/etc/shadow"
    sudo chmod 600 "${ROOT_DIR}/etc/ssh/sshd_config"
    sudo chmod 600 "${ROOT_DIR}/etc/security/pwquality.conf"
    sudo chmod 644 "${ROOT_DIR}/etc/sysctl.d/99-security.conf"
    
    # Create secure MOTD
    sudo tee "${ROOT_DIR}/etc/motd" > /dev/null << EOF
*******************************************************************
*                        NOTICE TO USERS                           *
*                    Security Information                          *
* This is a controlled access system. All activity is monitored.  *
*******************************************************************
EOF

    # Add to build script hooks
    sudo tee "${ROOT_DIR}/etc/profile.d/security.sh" > /dev/null << EOF
# Running system hardening...
EOF
    sudo chmod 755 "${ROOT_DIR}/etc/profile.d/security.sh"

    echo "STIG controls applied successfully"
}