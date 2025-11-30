# docker-lgogdownloader

Minimal Docker image for [LGOGDownloader](https://github.com/Sude-/lgogdownloader) - an unofficial GOG.com downloader for Linux.

## Usage

```bash
# First-time setup: authenticate with GOG
docker run -it --rm \
  -v lgogdownloader-config:/home/lgog/.config/lgogdownloader \
  ghcr.io/sharkusmanch/lgogdownloader:latest --login

# List your games
docker run --rm \
  -v lgogdownloader-config:/home/lgog/.config/lgogdownloader \
  ghcr.io/sharkusmanch/lgogdownloader:latest --list

# Download a game
docker run --rm \
  -v lgogdownloader-config:/home/lgog/.config/lgogdownloader \
  -v /path/to/games:/games \
  ghcr.io/sharkusmanch/lgogdownloader:latest \
  --download --game "game_name" --directory /games
```

## Volumes

| Path | Description |
|------|-------------|
| `/home/lgog/.config/lgogdownloader` | Configuration and cookies |
| `/games` | Download directory |

## Tags

- `latest` - Most recent lgogdownloader release
- `X.Y` - Specific version (e.g., `3.17`)

## Building Locally

```bash
docker build -t lgogdownloader .
```

## Automated Builds

Images are automatically built and pushed to ghcr.io when:
- A new lgogdownloader release is detected (checked daily)
- The Dockerfile is updated
- Manually triggered via workflow dispatch
