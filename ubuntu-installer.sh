#!/data/data/com.termux/files/usr/bin/bash

# ============================================================
# Termux Ubuntu Installer Tool
# A colorful menu-based Ubuntu installer for Termux
# ============================================================

# Color Definitions
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
MAGENTA='\033[1;35m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
RESET='\033[0m'
BG_RED='\033[41m'
BG_GREEN='\033[42m'
BG_BLUE='\033[44m'
BG_MAGENTA='\033[45m'
BOLD='\033[1m'
DIM='\033[2m'

# ============================================================
# Banner Function
# ============================================================
show_banner() {
    clear
    echo -e "${CYAN}"
    echo -e "  ╔══════════════════════════════════════════════════════╗"
    echo -e "  ║                                                      ║"
    echo -e "  ║${MAGENTA}   ██╗   ██╗██████╗ ██╗   ██╗███╗   ██╗████████╗██╗   ██╗${CYAN}║"
    echo -e "  ║${MAGENTA}   ██║   ██║██╔══██╗██║   ██║████╗  ██║╚══██╔══╝██║   ██║${CYAN}║"
    echo -e "  ║${MAGENTA}   ██║   ██║██████╔╝██║   ██║██╔██╗ ██║   ██║   ██║   ██║${CYAN}║"
    echo -e "  ║${MAGENTA}   ██║   ██║██╔══██╗██║   ██║██║╚██╗██║   ██║   ██║   ██║${CYAN}║"
    echo -e "  ║${MAGENTA}   ╚██████╔╝██████╔╝╚██████╔╝██║ ╚████║   ██║   ╚██████╔╝${CYAN}║"
    echo -e "  ║${MAGENTA}    ╚═════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝   ╚═╝    ╚═════╝ ${CYAN}║"
    echo -e "  ║                                                      ║"
    echo -e "  ║${GREEN}        ╦╔╗╔╔═╗╔╦╗╔═╗╦  ╦  ╔═╗╦═╗                   ${CYAN}║"
    echo -e "  ║${GREEN}        ║║║║╚═╗ ║ ╠═╣║  ║  ║╣ ╠╦╝                   ${CYAN}║"
    echo -e "  ║${GREEN}        ╩╝╚╝╚═╝ ╩ ╩ ╩╩═╝╩═╝╚═╝╩╚═                   ${CYAN}║"
    echo -e "  ║                                                      ║"
    echo -e "  ║${YELLOW}     [ Termux Ubuntu Installer Tool v2.0 ]           ${CYAN}║"
    echo -e "  ║${DIM}${WHITE}        Developed for Android/Termux Users           ${RESET}${CYAN}║"
    echo -e "  ║                                                      ║"
    echo -e "  ╚══════════════════════════════════════════════════════╝${RESET}"
    echo ""
}

# ============================================================
# Utility Functions
# ============================================================
print_separator() {
    echo -e "${CYAN}  ──────────────────────────────────────────────────────${RESET}"
}

print_success() {
    echo -e "  ${GREEN}[✓]${RESET} $1"
}

print_error() {
    echo -e "  ${RED}[✗]${RESET} $1"
}

print_info() {
    echo -e "  ${BLUE}[i]${RESET} $1"
}

print_warning() {
    echo -e "  ${YELLOW}[!]${RESET} $1"
}

press_enter() {
    echo ""
    echo -ne "  ${DIM}Press Enter to continue...${RESET}"
    read
}

# ============================================================
# Check if running in Termux
# ============================================================
check_termux() {
    if [ ! -d "/data/data/com.termux" ]; then
        print_warning "This script is designed for Termux on Android."
        print_warning "Some features may not work correctly outside Termux."
        echo ""
    fi
}

# ============================================================
# Get Device Information
# ============================================================
get_ram_mb() {
    if [ -f /proc/meminfo ]; then
        grep MemTotal /proc/meminfo | awk '{print int($2/1024)}'
    else
        echo "0"
    fi
}

get_cpu_arch() {
    uname -m
}

get_free_storage_mb() {
    df -m "$HOME" 2>/dev/null | tail -1 | awk '{print $4}'
}

# ============================================================
# Version 1: Custom Super-Fix Setup
# ============================================================
install_udroid() {
    show_banner
    echo -e "  ${BG_MAGENTA}${WHITE} CUSTOM SUPER-FIX SETUP ${RESET}"
    echo ""
    print_separator
    echo ""
    print_info "This will install Ubuntu using the udroid method."
    print_info "All necessary packages will be installed automatically."
    echo ""
    print_separator
    echo ""
    echo -ne "  ${YELLOW}Proceed with installation? [y/N]: ${RESET}"
    read confirm
    
    if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
        print_info "Installation cancelled."
        press_enter
        return
    fi
    
    echo ""
    print_info "Step 1/4: Updating and upgrading packages..."
    print_separator
    pkg update && pkg upgrade -y
    if [ $? -ne 0 ]; then
        print_error "Failed to update packages."
        press_enter
        return
    fi
    print_success "Packages updated successfully."
    echo ""
    
    print_info "Step 2/4: Installing x11-repo and termux-x11-nightly..."
    print_separator
    pkg install x11-repo -y
    pkg install termux-x11-nightly -y
    if [ $? -ne 0 ]; then
        print_error "Failed to install x11 packages."
        press_enter
        return
    fi
    print_success "X11 packages installed successfully."
    echo ""
    
    print_info "Step 3/4: Installing proot and pulseaudio..."
    print_separator
    pkg install proot pulseaudio -y
    if [ $? -ne 0 ]; then
        print_error "Failed to install proot/pulseaudio."
        press_enter
        return
    fi
    print_success "Proot and PulseAudio installed successfully."
    echo ""
    
    print_info "Step 4/4: Running udroid installer..."
    print_separator
    . <(curl -Ls https://bit.ly/udroid-installer)
    if [ $? -ne 0 ]; then
        print_error "udroid installer failed."
        press_enter
        return
    fi
    print_success "udroid installation complete."
    echo ""
    
    print_info "Fixing stuck processes..."
    print_separator
    killall -9 termux-x11 2>/dev/null
    rm -rf /tmp/.X11-unix 2>/dev/null
    rm -rf /tmp/.X0-lock 2>/dev/null
    
    export LD_PRELOAD=/system/lib64/libskcodec.so
    pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1 2>/dev/null
    
    print_success "Stuck processes fixed."
    echo ""
    print_success "Ubuntu installation completed successfully!"
    print_info "You can now start Ubuntu from the main menu."
    press_enter
}

# ============================================================
# Version 2: Official Repo Version
# ============================================================
install_official() {
    show_banner
    echo -e "  ${BG_BLUE}${WHITE} OFFICIAL REPO VERSION ${RESET}"
    echo ""
    print_separator
    echo ""
    print_info "This will install Ubuntu using the official proot-distro method."
    echo ""
    echo -e "  ${CYAN}Select Ubuntu version:${RESET}"
    echo ""
    echo -e "  ${GREEN}[1]${RESET} Ubuntu 20.04 LTS (Focal Fossa)"
    echo -e "  ${GREEN}[2]${RESET} Ubuntu 22.04 LTS (Jammy Jellyfish)"
    echo -e "  ${GREEN}[3]${RESET} Ubuntu 24.04 LTS (Noble Numbat)"
    echo -e "  ${RED}[0]${RESET} Back to Main Menu"
    echo ""
    print_separator
    echo ""
    echo -ne "  ${YELLOW}Select option [0-3]: ${RESET}"
    read version_choice
    
    case $version_choice in
        1) ubuntu_version="ubuntu-oldlts" ; version_name="20.04 (Focal Fossa)" ;;
        2) ubuntu_version="ubuntu-lts" ; version_name="22.04 (Jammy Jellyfish)" ;;
        3) ubuntu_version="ubuntu" ; version_name="24.04 (Noble Numbat)" ;;
        0) return ;;
        *)
            print_error "Invalid option."
            press_enter
            return
            ;;
    esac
    
    echo ""
    print_info "Installing Ubuntu ${version_name}..."
    print_separator
    echo ""
    
    # Install proot-distro if not installed
    print_info "Ensuring proot-distro is installed..."
    pkg update -y && pkg install proot-distro -y
    if [ $? -ne 0 ]; then
        print_error "Failed to install proot-distro."
        press_enter
        return
    fi
    print_success "proot-distro is ready."
    echo ""
    
    # Install the selected Ubuntu version
    print_info "Downloading and installing Ubuntu ${version_name}..."
    print_info "This may take a while depending on your internet speed."
    echo ""
    proot-distro install "$ubuntu_version"
    if [ $? -ne 0 ]; then
        print_error "Failed to install Ubuntu ${version_name}."
        print_warning "The version might already be installed or an error occurred."
        press_enter
        return
    fi
    
    echo ""
    print_success "Ubuntu ${version_name} installed successfully!"
    print_info "Use 'Start Ubuntu' from the main menu to launch it."
    press_enter
}

# ============================================================
# Version 3: AI Smart Auto-Detect
# ============================================================
install_smart() {
    show_banner
    echo -e "  ${BG_GREEN}${WHITE} AI SMART AUTO-DETECT ${RESET}"
    echo ""
    print_separator
    echo ""
    print_info "Detecting your device specifications..."
    echo ""
    
    # Get device info
    local ram_mb=$(get_ram_mb)
    local cpu_arch=$(get_cpu_arch)
    local free_storage=$(get_free_storage_mb)
    
    echo -e "  ${CYAN}Device Information:${RESET}"
    print_separator
    echo -e "  ${WHITE}RAM:${RESET}          ${GREEN}${ram_mb} MB${RESET}"
    echo -e "  ${WHITE}CPU Arch:${RESET}     ${GREEN}${cpu_arch}${RESET}"
    echo -e "  ${WHITE}Free Storage:${RESET} ${GREEN}${free_storage} MB${RESET}"
    echo ""
    print_separator
    echo ""
    
    # Decision logic
    local install_method=""
    local ubuntu_version=""
    local version_name=""
    local reason=""
    
    # Check storage first
    if [ -n "$free_storage" ] && [ "$free_storage" -lt 2000 ] 2>/dev/null; then
        print_warning "Low storage detected (< 2GB free)."
        print_info "Recommending minimal install with udroid method."
        install_method="udroid"
        reason="Low storage space - using lightweight udroid method"
    # Check RAM
    elif [ -n "$ram_mb" ] && [ "$ram_mb" -le 2048 ] 2>/dev/null; then
        print_warning "Low RAM detected (<= 2GB)."
        print_info "Recommending lightweight Ubuntu 20.04 with proot-distro."
        install_method="proot"
        ubuntu_version="ubuntu-oldlts"
        version_name="20.04 LTS (Focal Fossa - Lightweight)"
        reason="Low RAM - using older, lighter Ubuntu version"
    # Check architecture
    elif [[ "$cpu_arch" == "aarch64" || "$cpu_arch" == "arm64" ]]; then
        if [ -n "$ram_mb" ] && [ "$ram_mb" -ge 4096 ] 2>/dev/null; then
            print_info "ARM64 device with good RAM detected."
            print_info "Recommending Ubuntu 24.04 (latest) via proot-distro."
            install_method="proot"
            ubuntu_version="ubuntu"
            version_name="24.04 LTS (Noble Numbat)"
            reason="ARM64 with sufficient RAM - using latest Ubuntu"
        else
            print_info "ARM64 device with moderate RAM detected."
            print_info "Recommending Ubuntu 22.04 via proot-distro."
            install_method="proot"
            ubuntu_version="ubuntu-lts"
            version_name="22.04 LTS (Jammy Jellyfish)"
            reason="ARM64 with moderate RAM - using stable LTS version"
        fi
    # Default: good specs
    else
        if [ -n "$ram_mb" ] && [ "$ram_mb" -ge 4096 ] 2>/dev/null; then
            print_info "Device has good specifications."
            print_info "Recommending Ubuntu 24.04 (latest) via proot-distro."
            install_method="proot"
            ubuntu_version="ubuntu"
            version_name="24.04 LTS (Noble Numbat)"
            reason="Good device specs - using latest Ubuntu"
        else
            print_info "Moderate device specifications detected."
            print_info "Recommending Ubuntu 22.04 via proot-distro."
            install_method="proot"
            ubuntu_version="ubuntu-lts"
            version_name="22.04 LTS (Jammy Jellyfish)"
            reason="Moderate specs - using stable LTS version"
        fi
    fi
    
    echo ""
    print_separator
    echo -e "  ${CYAN}Recommendation:${RESET} ${GREEN}${reason}${RESET}"
    print_separator
    echo ""
    echo -ne "  ${YELLOW}Proceed with recommended installation? [y/N]: ${RESET}"
    read confirm
    
    if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
        print_info "Installation cancelled."
        press_enter
        return
    fi
    
    echo ""
    
    if [ "$install_method" == "udroid" ]; then
        print_info "Starting udroid installation..."
        print_separator
        echo ""
        
        pkg update && pkg upgrade -y
        pkg install x11-repo -y
        pkg install termux-x11-nightly -y
        pkg install proot pulseaudio -y
        
        . <(curl -Ls https://bit.ly/udroid-installer)
        
        # Fix stuck processes
        killall -9 termux-x11 2>/dev/null
        rm -rf /tmp/.X11-unix 2>/dev/null
        rm -rf /tmp/.X0-lock 2>/dev/null
        
        export LD_PRELOAD=/system/lib64/libskcodec.so
        pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1 2>/dev/null
        
        print_success "Ubuntu installed successfully via udroid!"
    else
        print_info "Installing Ubuntu ${version_name} via proot-distro..."
        print_separator
        echo ""
        
        pkg update -y && pkg install proot-distro -y
        proot-distro install "$ubuntu_version"
        
        if [ $? -ne 0 ]; then
            print_error "Installation failed."
            press_enter
            return
        fi
        
        print_success "Ubuntu ${version_name} installed successfully!"
    fi
    
    print_info "Use 'Start Ubuntu' from the main menu to launch it."
    press_enter
}

# ============================================================
# Start Ubuntu
# ============================================================
start_ubuntu() {
    show_banner
    echo -e "  ${BG_GREEN}${WHITE} START UBUNTU ${RESET}"
    echo ""
    print_separator
    echo ""
    echo -e "  ${CYAN}Select start method:${RESET}"
    echo ""
    echo -e "  ${GREEN}[1]${RESET} Start via proot-distro (Official)"
    echo -e "  ${GREEN}[2]${RESET} Start via udroid"
    echo -e "  ${RED}[0]${RESET} Back to Main Menu"
    echo ""
    print_separator
    echo ""
    echo -ne "  ${YELLOW}Select option [0-2]: ${RESET}"
    read start_choice
    
    case $start_choice in
        1)
            echo ""
            print_info "Available Ubuntu installations:"
            print_separator
            proot-distro list 2>/dev/null | grep -i ubuntu
            echo ""
            print_separator
            echo ""
            echo -ne "  ${YELLOW}Enter distro name to login (e.g., ubuntu): ${RESET}"
            read distro_name
            if [ -n "$distro_name" ]; then
                print_info "Starting Ubuntu ($distro_name)..."
                proot-distro login "$distro_name"
            else
                print_error "No distro name provided."
            fi
            ;;
        2)
            echo ""
            print_info "Starting Ubuntu via udroid..."
            print_separator
            if command -v udroid &> /dev/null; then
                udroid --start
            else
                print_error "udroid is not installed."
                print_info "Please install using 'Custom Super-Fix Setup' option first."
            fi
            ;;
        0) return ;;
        *)
            print_error "Invalid option."
            ;;
    esac
    press_enter
}

# ============================================================
# Uninstall Ubuntu
# ============================================================
uninstall_ubuntu() {
    show_banner
    echo -e "  ${BG_RED}${WHITE} UNINSTALL UBUNTU ${RESET}"
    echo ""
    print_separator
    echo ""
    echo -e "  ${CYAN}Select uninstall method:${RESET}"
    echo ""
    echo -e "  ${GREEN}[1]${RESET} Uninstall proot-distro Ubuntu"
    echo -e "  ${GREEN}[2]${RESET} Uninstall udroid Ubuntu"
    echo -e "  ${GREEN}[3]${RESET} Uninstall ALL (Complete cleanup)"
    echo -e "  ${RED}[0]${RESET} Back to Main Menu"
    echo ""
    print_separator
    echo ""
    echo -ne "  ${YELLOW}Select option [0-3]: ${RESET}"
    read uninstall_choice
    
    case $uninstall_choice in
        1)
            echo ""
            print_info "Available Ubuntu installations:"
            print_separator
            proot-distro list 2>/dev/null | grep -i ubuntu
            echo ""
            echo -ne "  ${YELLOW}Enter distro name to remove (e.g., ubuntu): ${RESET}"
            read distro_name
            if [ -n "$distro_name" ]; then
                echo ""
                echo -ne "  ${RED}Are you sure you want to remove '$distro_name'? [y/N]: ${RESET}"
                read confirm
                if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
                    proot-distro remove "$distro_name"
                    if [ $? -eq 0 ]; then
                        print_success "Ubuntu ($distro_name) uninstalled successfully."
                    else
                        print_error "Failed to uninstall."
                    fi
                else
                    print_info "Uninstall cancelled."
                fi
            else
                print_error "No distro name provided."
            fi
            ;;
        2)
            echo ""
            echo -ne "  ${RED}Are you sure you want to remove udroid Ubuntu? [y/N]: ${RESET}"
            read confirm
            if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
                if command -v udroid &> /dev/null; then
                    udroid --remove
                    print_success "udroid Ubuntu removed successfully."
                else
                    # Manual cleanup
                    rm -rf "$HOME/udroid" 2>/dev/null
                    rm -rf "$PREFIX/bin/udroid" 2>/dev/null
                    print_success "udroid files cleaned up."
                fi
            else
                print_info "Uninstall cancelled."
            fi
            ;;
        3)
            echo ""
            print_warning "This will remove ALL Ubuntu installations!"
            echo -ne "  ${RED}Are you absolutely sure? [y/N]: ${RESET}"
            read confirm
            if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
                echo ""
                print_info "Removing proot-distro Ubuntu installations..."
                proot-distro remove ubuntu 2>/dev/null
                proot-distro remove ubuntu-oldlts 2>/dev/null
                proot-distro remove ubuntu-lts 2>/dev/null
                
                print_info "Removing udroid..."
                rm -rf "$HOME/udroid" 2>/dev/null
                rm -rf "$PREFIX/bin/udroid" 2>/dev/null
                
                if command -v udroid &> /dev/null; then
                    udroid --remove 2>/dev/null
                fi
                
                print_info "Cleaning up temporary files..."
                killall -9 termux-x11 2>/dev/null
                rm -rf /tmp/.X11-unix 2>/dev/null
                rm -rf /tmp/.X0-lock 2>/dev/null
                
                echo ""
                print_success "All Ubuntu installations have been removed."
            else
                print_info "Uninstall cancelled."
            fi
            ;;
        0) return ;;
        *)
            print_error "Invalid option."
            ;;
    esac
    press_enter
}

# ============================================================
# Install Menu
# ============================================================
install_menu() {
    while true; do
        show_banner
        echo -e "  ${BG_BLUE}${WHITE} INSTALL UBUNTU ${RESET}"
        echo ""
        print_separator
        echo ""
        echo -e "  ${CYAN}Choose installation method:${RESET}"
        echo ""
        echo -e "  ${GREEN}[1]${RESET} ${MAGENTA}Custom Super-Fix Setup${RESET}"
        echo -e "      ${DIM}Quick setup with X11 and audio support${RESET}"
        echo ""
        echo -e "  ${GREEN}[2]${RESET} ${MAGENTA}Official Repo Version${RESET}"
        echo -e "      ${DIM}Choose from Ubuntu 20.04, 22.04, or 24.04${RESET}"
        echo ""
        echo -e "  ${GREEN}[3]${RESET} ${MAGENTA}AI Smart Auto-Detect${RESET}"
        echo -e "      ${DIM}Automatically selects best version for your device${RESET}"
        echo ""
        echo -e "  ${RED}[0]${RESET} Back to Main Menu"
        echo ""
        print_separator
        echo ""
        echo -ne "  ${YELLOW}Select option [0-3]: ${RESET}"
        read install_choice
        
        case $install_choice in
            1) install_udroid ;;
            2) install_official ;;
            3) install_smart ;;
            0) return ;;
            *) print_error "Invalid option." ; sleep 1 ;;
        esac
    done
}

# ============================================================
# Main Menu
# ============================================================
main_menu() {
    while true; do
        show_banner
        echo -e "  ${CYAN}╔════════════════════════════════════════╗${RESET}"
        echo -e "  ${CYAN}║${RESET}        ${WHITE}${BOLD}M A I N   M E N U${RESET}             ${CYAN}║${RESET}"
        echo -e "  ${CYAN}╚════════════════════════════════════════╝${RESET}"
        echo ""
        echo -e "  ${GREEN}[1]${RESET} ${WHITE}Install Ubuntu${RESET}"
        echo -e "      ${DIM}Install Ubuntu with multiple methods${RESET}"
        echo ""
        echo -e "  ${GREEN}[2]${RESET} ${WHITE}Start Ubuntu${RESET}"
        echo -e "      ${DIM}Launch installed Ubuntu environment${RESET}"
        echo ""
        echo -e "  ${GREEN}[3]${RESET} ${WHITE}Uninstall Ubuntu${RESET}"
        echo -e "      ${DIM}Remove Ubuntu installations${RESET}"
        echo ""
        echo -e "  ${RED}[0]${RESET} ${WHITE}Exit${RESET}"
        echo ""
        print_separator
        echo ""
        echo -ne "  ${YELLOW}Select option [0-3]: ${RESET}"
        read main_choice
        
        case $main_choice in
            1) install_menu ;;
            2) start_ubuntu ;;
            3) uninstall_ubuntu ;;
            0)
                echo ""
                print_info "Thank you for using Termux Ubuntu Installer!"
                print_info "Goodbye!"
                echo ""
                exit 0
                ;;
            *)
                print_error "Invalid option. Please try again."
                sleep 1
                ;;
        esac
    done
}

# ============================================================
# Entry Point
# ============================================================
check_termux
main_menu
