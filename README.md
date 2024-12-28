# SimpleOS

A minimal CLI-focused WSL distribution.

## Building

1. Run `./build.sh` to create the distribution
2. Import into WSL:
   ```bash
   wsl --import SimpleOS C:\\SimpleOS dist/simpleos-0.1.0.tar.gz
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
