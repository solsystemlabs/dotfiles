#!/bin/bash

set -e

# Colors for terminal output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print with color
print_status() {
    echo -e "${BLUE}[STATUS]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Check if we're on macOS or Linux
if [[ "$(uname)" == "Darwin" ]]; then
    OS="macOS"
elif [[ "$(uname)" == "Linux" ]]; then
    OS="Linux"
    # Check for Ubuntu
    if [[ -f /etc/lsb-release ]]; then
        . /etc/lsb-release
        if [[ "$DISTRIB_ID" != "Ubuntu" ]]; then
            print_warning "This script is optimized for Ubuntu. Results may vary on other distributions."
        fi
    else
        print_warning "This script is optimized for Ubuntu. Results may vary on other distributions."
    fi
else
    echo "Unsupported operating system. This script works on macOS and Ubuntu."
    exit 1
fi

print_status "Detected operating system: $OS"

# Install Fish shell and eza
install_fish() {
    print_status "Installing Fish shell and eza..."
    
    if [[ "$OS" == "macOS" ]]; then
        # Check if Homebrew is installed
        if ! command -v brew &> /dev/null; then
            print_status "Homebrew not found. Installing Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            
            # Add Homebrew to PATH for the current session
            if [[ -f /opt/homebrew/bin/brew ]]; then
                eval "$(/opt/homebrew/bin/brew shellenv)"
            elif [[ -f /usr/local/bin/brew ]]; then
                eval "$(/usr/local/bin/brew shellenv)"
            fi
        fi
        
        # Install Fish and eza using Homebrew
        brew install fish eza
    else
        # Ubuntu/Debian
        print_status "Updating package lists..."
        sudo apt-get update
        
        print_status "Installing Fish shell..."
        sudo apt-get install -y fish
        
        # Install eza (might need additional repository on older Ubuntu versions)
        print_status "Installing eza..."
        if grep -q "Ubuntu 20.04" /etc/os-release || grep -q "Ubuntu 18.04" /etc/os-release; then
            # For older Ubuntu versions that don't have eza in their repositories
            sudo apt-get install -y curl
            EZA_VERSION=$(curl -s "https://api.github.com/repos/eza-community/eza/releases/latest" | grep -o '"tag_name": "v[^"]*' | cut -d'"' -f4)
            curl -Lo eza.tar.gz "https://github.com/eza-community/eza/releases/latest/download/eza_${EZA_VERSION#v}_linux_x86_64.tar.gz"
            tar xf eza.tar.gz
            sudo mv eza /usr/local/bin/
            rm eza.tar.gz
        else
            # For newer Ubuntu versions
            sudo apt-get install -y eza
        fi
    fi
    
    # Verify Fish installation
    if command -v fish &> /dev/null; then
        print_success "Fish shell installed successfully!"
        FISH_PATH=$(command -v fish)
        print_status "Fish shell location: $FISH_PATH"
    else
        echo "Failed to install Fish shell. Please check for errors and try again."
        exit 1
    fi
    
    # Verify eza installation
    if command -v eza &> /dev/null; then
        print_success "eza installed successfully!"
    else
        print_warning "Failed to install eza. You can install it manually later."
    fi
}

# Set Fish as default shell
set_default_shell() {
    print_status "Setting Fish as default shell..."
    
    FISH_PATH=$(command -v fish)
    
    # Check if Fish is already in /etc/shells
    if ! grep -q "$FISH_PATH" /etc/shells; then
        print_status "Adding Fish to /etc/shells..."
        echo "$FISH_PATH" | sudo tee -a /etc/shells
    fi
    
    # Change default shell for current user
    chsh -s "$FISH_PATH"
    
    print_success "Fish is now set as your default shell!"
    print_warning "You may need to log out and log back in for the changes to take effect."
}

# Create basic Fish config
setup_fish_config() {
    print_status "Setting up basic Fish configuration..."
    
    # Create config directory if it doesn't exist
    mkdir -p ~/.config/fish
    
    # Create config.fish if it doesn't exist
    if [[ ! -f ~/.config/fish/config.fish ]]; then
        cat > ~/.config/fish/config.fish << 'EOF'
# Fish shell configuration

# Add custom paths
if test -d "$HOME/bin"
    set -gx PATH $HOME/bin $PATH
end

if test -d "$HOME/.local/bin"
    set -gx PATH $HOME/.local/bin $PATH
end

# Set editor
set -gx EDITOR nano

# macOS specific settings
if test (uname) = "Darwin"
    # Add Homebrew to PATH
    if test -d /opt/homebrew/bin
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else if test -d /usr/local/bin
        eval "$(/usr/local/bin/brew shellenv)"
    end
end

# Custom greeting
function fish_greeting
    echo "Welcome to Fish shell! 🐟"
end

# Replace ls with eza if available
if type -q eza
    alias ls='eza --icons'
    alias ll='eza -la --icons'
    alias la='eza -a --icons'
    alias lt='eza -T --icons'
    alias lg='eza -la --git --icons'
else
    alias ll='ls -la'
    alias la='ls -A'
    alias l='ls -CF'
end

# You can add more custom configuration below
EOF
        print_success "Created basic Fish configuration file at ~/.config/fish/config.fish"
    else
        print_warning "Fish configuration file already exists at ~/.config/fish/config.fish"
        print_status "Your existing configuration has been preserved."
    fi
}

# Install Fisher and plugins
install_plugins() {
    print_status "Installing Fisher plugin manager and plugins..."
    
    # Install Fisher (plugin manager for Fish)
    curl -sL https://git.io/fisher | fish
    
    # Install required plugins
    fish -c "fisher install jethrokuan/z"              # Directory jumping (fast navigation)
    fish -c "fisher install IlanCosman/tide@v6"        # Tide prompt (modern, informative prompt)
    
    print_success "Installed Fisher and plugins!"
}

# Main installation process
main() {
    print_status "Starting Fish shell setup..."
    
    install_fish
    set_default_shell
    setup_fish_config
    install_plugins
    
    print_status "Fish shell setup complete!"
    print_success "Fish shell has been installed and set as your default shell."
    print_success "Fisher, z, eza, and tide have been installed and configured."
    print_warning "Remember to log out and log back in for the changes to take effect."
    
    exec fish
}

# Run the script
main
