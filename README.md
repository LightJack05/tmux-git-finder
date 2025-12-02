# tmux-git-finder

A simple tool to find git repositories in configured directories using fzf with tmux integration, and open them in tmux sessions.

> [!CAUTION]
> THIS TOOL IS AI GENERATED
>
> While I have tested it, read through the code and am using it myself, I do not guarantee anything about this tool. 
> It seems to work quite well and appears like it is somewhat stable, but if it blows up, it blows up.

## Features

- **Find Git Repositories**: Searches configured directories for git repositories
- **Interactive Selection**: Uses fzf with tmux integration (`fzf --tmux`) for selection
- **Session Management**: Creates a new tmux session or switches to an existing one for the selected repository

## Requirements

- `bash`
- `tmux`
- `fzf`
- `git`

### Installation on common systems

**Debian/Ubuntu:**
```bash
sudo apt install tmux fzf git
```

**Arch Linux:**
```bash
sudo pacman -S tmux fzf git
```

**macOS (Homebrew):**
```bash
brew install tmux fzf git
```

## Installation

1. Clone this repository or download the `tmux-git-finder` script
2. Make it executable: `chmod +x tmux-git-finder`
3. Move it to a directory in your PATH, e.g., `mv tmux-git-finder ~/.local/bin/`

## Configuration

Copy the example config file to your config directory:

```bash
mkdir -p ~/.config/tmux-git-finder
cp config.example ~/.config/tmux-git-finder/config
```

Then edit the config file to customize your settings.

### Configuration Options

```bash
# Directories to search for git repositories
SEARCH_PATHS=("$HOME/projects" "$HOME/work")

# Maximum depth to search for repositories (default: 3)
MAX_DEPTH=3
```

## Usage

### Interactive Mode (Default)

```bash
tmux-git-finder
```

This will:
1. Find all git repositories in configured directories
2. Present an fzf selection interface (in tmux popup)
3. On selection, create a new tmux session or switch to an existing one

### List Repositories

```bash
tmux-git-finder --list
```

Lists all found git repositories without opening them.

### Help

```bash
tmux-git-finder --help
```

## Tmux Integration

### Bind to a tmux key

Add to your `~/.tmux.conf`:

```bash
bind-key g display-popup -E -w 80% -h 60% "tmux-git-finder"
```

Now press `prefix + g` to launch the finder in a popup.

### Shell alias

Add to your `~/.bashrc` or `~/.zshrc`:

```bash
alias tgf='tmux-git-finder'
```

## License

MIT License - see LICENSE file for details
