# SimpleOS
[![Build SimpleOS](https://github.com/kelleyblackmore/simpleos/actions/workflows/build.yml/badge.svg)](https://github.com/kelleyblackmore/simpleos/actions/workflows/build.yml)


A minimal CLI-focused WSL distribution.

## Usage
1. Download the latest working distro from the build action, option at the bottom of the build
2. Unzip the download
3. Then import
   ```bash
   wsl --import SimpleOS C:\\SimpleOS simpleos-0.1.0.tar.gz
   ```
4. Run the distro
   ```bash
   wsl -d SimpleOS
   ```
5. If you need to unregister just run 
   ```bash
   wsl --unregister SimpleOS
   ```


## Building

1. Run `./build.sh` to create the distribution
2. Import into WSL:
   ```bash
   wsl --import SimpleOS C:\\SimpleOS simpleos-0.1.0.tar.gz
   ```


## Features

- Minimal CLI environment
- Custom package manager (simplepkg)
- Customized shell environment
- Easy to extend and customize

## Project Structure

```
simpleos/
├── build.sh
├── config.sh
├── README.md
├── .gitignore
├── src/
│   ├── base/
│   │   └── create_base.sh
│   ├── tools/
│   │   └── simplepkg
│   ├── scripts/
│   │   └── init
│   ├── config/
│   │   └── profile
│   └── security/
│       └── stig_hardening.sh
├── build/
└── dist/
```

- `src/base/`: Base system creation scripts
- `src/tools/`: Custom tools and utilities
- `src/scripts/`: System scripts
- `src/config/`: Configuration files
- `src/security/`: Security hardening scripts


## License

MIT License
