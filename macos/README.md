# 🚀 Dotfiles Repository

A curated collection of shell configuration files and development environment setup for macOS. This repository contains optimized configurations for zsh, tmux, and various development tools to enhance your terminal experience.

## ✨ Features

### 🎯 Shell Configuration

- **Oh My Zsh** with Robby Russell theme
- **zsh-autocomplete** and **zsh-autosuggestions** for intelligent command completion
- **eza** as a modern replacement for `ls` with icons and colors
- **fzf** integration for fuzzy file finding and command history search
- **zoxide** for smart directory navigation
- **Atuin** for enhanced command history management

### 🛠️ Development Environment

- **Node.js/NVM** configuration for JavaScript development
- **Android SDK** setup for React Native development
- **Fastlane** configuration for mobile app deployment
- **React Native** development environment

### 🎨 Customization

- Custom color schemes for fzf
- Intelligent file previews with syntax highlighting
- Git-aware directory listings
- Optimized aliases and shortcuts

## 📦 Prerequisites

Before using these dotfiles, ensure you have the following installed:

- **macOS** (tested on macOS 14+)
- **Homebrew** for package management
- **Git** for version control

## 🚀 Installation

### 1. Clone the Repository

```bash
git clone <your-repo-url>
cd dotfiles
```

### 2. Install Required Tools

```bash
# Install Homebrew packages
brew install zsh-autocomplete zsh-autosuggestions eza fzf fd zoxide atuin tmux bat

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### 3. Install Node.js and NVM

```bash
# Install NVM
brew install nvm

# Install Node.js (adjust version as needed)
nvm install 18
nvm use 18
```

### 4. Setup Android SDK (for React Native)

```bash
# Download and install Android Studio
# Set ANDROID_HOME in your environment
export ANDROID_HOME=$HOME/Library/Android/sdk
```

### 5. Install Fastlane

```bash
gem install fastlane
```

### 6. Link Configuration Files

```bash
# Backup existing configuration
cp ~/.zshrc ~/.zshrc.backup

# Link the new configuration
ln -sf $(pwd)/.zshrc ~/.zshrc

# Reload shell configuration
source ~/.zshrc
```

## 🎮 Usage

### Shell Navigation

- **`z <directory>`** - Smart directory navigation with zoxide
- **`zi <directory>`** - Interactive directory selection
- **`Ctrl+T`** - Fuzzy file finder
- **`Alt+C`** - Fuzzy directory navigation
- **`Ctrl+R`** - Enhanced command history search

### File Management

- **`ls`** - Enhanced directory listing with eza
- **`**<TAB>`\*\* - Fuzzy file completion
- **`**/<TAB>`\*\* - Fuzzy directory completion

### Development

- **`nvm`** - Node.js version management
- **`fastlane`** - Mobile app deployment tools
- **`tmux`** - Terminal multiplexing

## 🔧 Configuration

### Customizing Colors

The fzf color scheme can be customized by modifying the color variables in `.zshrc`:

```bash
fg="#CBE0F0"          # Foreground text
bg="#011628"          # Background
bg_highlight="#143652" # Selected item background
purple="#B388FF"      # Highlighting
blue="#06BCE4"        # Info text
cyan="#2CF9ED"        # UI elements
```

### Adding Custom Aliases

Add your custom aliases in the aliases section of `.zshrc`:

```bash
# Example custom aliases
alias myproject="cd ~/projects/myproject"
alias gst="git status"
```

## 📁 File Structure

```
dotfiles/
├── .zshrc                 # Main zsh configuration
├── scripts/               # Custom scripts (if any)
│   └── tmux-sessionizer   # Tmux session management
├── README.md              # This file
└── .gitignore            # Git ignore rules
```

## 🔄 Updates

To update your dotfiles:

```bash
# Pull latest changes
git pull origin main

# Reload configuration
source ~/.zshrc
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Oh My Zsh](https://ohmyz.sh/) - Framework for managing zsh configuration
- [fzf](https://github.com/junegunn/fzf) - Fuzzy finder
- [eza](https://github.com/eza-community/eza) - Modern replacement for ls
- [zoxide](https://github.com/ajeetdsouza/zoxide) - Smarter cd command
- [Atuin](https://github.com/atuinsh/atuin) - Better shell history

## 📞 Support

If you encounter any issues or have questions:

1. Check the [Issues](../../issues) page
2. Create a new issue with detailed information
3. Include your macOS version and any error messages

---

**Happy coding! 🎉**
