# Security Policy

## Supported Versions

The following versions of SimpleOS are currently supported with security updates and STIG compliance patches:

| Version | Supported          |
| ------- | ------------------ |
| 0.1.x   | :white_check_mark: |
| < 0.1.0 | :x:                |

## Reporting a Vulnerability

We take the security of SimpleOS seriously. If you believe you have found a security vulnerability, please report it to us following these steps:

### Reporting Process

1. **Direct Reporting**: Submit your vulnerability report through our GitHub Security Advisory ["Report a Vulnerability"](https://github.com/owner/SimpleOS/security/advisories/new) tab.

2. **Encryption**: If the issue is particularly sensitive, encrypt your report using our [PGP key](link-to-pgp-key).

### What to Include

- Detailed description of the vulnerability
- Steps to reproduce the issue
- Potential impact
- Suggested remediation if available
- Version of SimpleOS affected

### Response Timeline

- **Initial Response**: Within 48 hours
- **Status Update**: Within 5 business days
- **Fix Timeline**: Based on severity
 - Critical: 7 days
 - High: 14 days
 - Medium: 30 days
 - Low: Next release cycle

### Classification Criteria

We use the following criteria to classify vulnerabilities:

- **Critical**: Direct unauthorized access, code execution, or data exposure
- **High**: Indirect access to sensitive components or STIG compliance violations
- **Medium**: Limited impact vulnerabilities or security control bypasses
- **Low**: Minor security issues with minimal impact

### What to Expect

1. **Acknowledgment**: You will receive an acknowledgment of your report within 48 hours.
2. **Investigation**: Our team will investigate and validate the issue.
3. **Updates**: Regular updates on the progress (at least weekly).
4. **Resolution**: Once resolved, you will be notified and can review the fix.

### Security Update Policy

- Security patches are released immediately for critical vulnerabilities
- Other security updates are bundled in regular releases
- All security updates maintain STIG compliance
- Backports are provided for supported versions

### Out of Scope

- WSL version compatibility issues
- Known limitations documented in the README
- Features working as intended
- Issues in dependencies (please report to respective projects)

### Recognition

We value our security researchers and will:
- Credit researchers who report valid vulnerabilities (if desired)
- Maintain a security acknowledgments page
- Consider including reporters in our bug bounty program (if established)

## Compliance

SimpleOS follows:
- DISA STIG Guidelines
- WSL Security Best Practices
- Linux Security Hardening Standards

## Security Updates

Security updates are distributed through:
- GitHub Releases
- Security Advisories
- Microsoft Store (if applicable)

## Vulnerability Disclosure Policy

We follow a coordinated disclosure policy:
1. Report received and acknowledged
2. Issue investigated and validated
3. Fix developed and tested
4. Advisory published with credit
5. Fix released to users

## Contact

For security-related questions or concerns:
- Security Team Email: security@simpleos
- PGP Key: [Download](link-to-pgp-key)
