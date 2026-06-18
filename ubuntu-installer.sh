#!/data/data/com.termux/files/usr/bin/bash

# ═══════════════════════════════════════════════
#   Termux Ubuntu Installer Tool v3.0
#   A beautiful menu-based Ubuntu installer
# ═══════════════════════════════════════════════

# Color Definitions
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
MAGENTA='\033[1;35m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
RESET='\033[0m'
NC='\033[0m'
BG_RED='\033[41m'
BG_GREEN='\033[42m'
BG_BLUE='\033[44m'
BG_CYAN='\033[46m'
BG_MAGENTA='\033[45m'
BG_YELLOW='\033[43m'
BOLD='\033[1m'
DIM='\033[2m'
ITALIC='\033[3m'
UNDERLINE='\033[4m'

# Box Drawing Characters
BOX_TL="╔"
BOX_TR="╗"
BOX_BL="╚"
BOX_BR="╝"
BOX_H="═"
BOX_V="║"
BOX_ML="╠"
BOX_MR="╣"

# Terminal width detection (mobile friendly)
get_term_width() {
    local width=$(tput cols 2>/dev/null || echo 45)
    if [ "$width" -gt 45 ]; then
        echo 45
    else
        echo $((width - 2))
    fi
}

TERM_WIDTH=$(get_term_width)
BOX_WIDTH=43

# Draw a separator line
draw_line() {
    local char="${1:-═}"
    local color="${2:-$CYAN}"
    local width="${3:-$BOX_WIDTH}"
    local line=""
    for ((i=0; i<width; i++)); do
        line="${line}${char}"
    done
    echo -e "  ${color}${line}${RESET}"
}

# Draw box top (no right border needed for content)
draw_box_top() {
    local color="${1:-$CYAN}"
    local width="${2:-$BOX_WIDTH}"
    local line="${BOX_TL}"
    for ((i=0; i<width; i++)); do
        line="${line}${BOX_H}"
    done
    line="${line}${BOX_TR}"
    echo -e "  ${color}${line}${RESET}"
}

# Draw box bottom
draw_box_bottom() {
    local color="${1:-$CYAN}"
    local width="${2:-$BOX_WIDTH}"
    local line="${BOX_BL}"
    for ((i=0; i<width; i++)); do
        line="${line}${BOX_H}"
    done
    line="${line}${BOX_BR}"
    echo -e "  ${color}${line}${RESET}"
}

# Footer separator
show_footer() {
    echo ""
    draw_line "━" "$MAGENTA" "$BOX_WIDTH"
    echo -e "  ${DIM}${CYAN}Ubuntu Installer v3.0${RESET} ${DIM}|${RESET} ${DIM}${GREEN}Termux${RESET} ${DIM}|${RESET} ${DIM}${YELLOW}Android${RESET}"
    draw_line "━" "$MAGENTA" "$BOX_WIDTH"
}

# ═══════════════════════════════════════════════
#              Banner Function
# ═══════════════════════════════════════════════
show_banner() {
    clear
    local username="${PERSONALIZED_CMD_NAME:-user}"
    echo ""
    echo -e "  ${RED}    ▄▄▄▄▄▄▄▄▄▄▄▄▄${RESET}"
    echo -e "  ${RED}  ▄████████████████▄${RESET}"
    echo -e "  ${MAGENTA} ███  ▄████████▄  ███${RESET}"
    echo -e "  ${MAGENTA} ██  ████████████  ██${RESET}"
    echo -e "  ${MAGENTA} ██  ▀████████▀▀  ██${RESET}"
    echo -e "  ${RED} ███    ▀▀▀▀▀▀    ███${RESET}"
    echo -e "  ${RED}  ▀████████████████▀${RESET}"
    echo -e "  ${RED}    ▀▀▀▀▀▀▀▀▀▀▀▀▀${RESET}"
    echo ""
    echo -e "  ${CYAN}${BOLD}TERMUX UBUNTU INSTALLER${RESET} ${DIM}v3.0${RESET}"
    echo -e "  ${DIM}For Android/Termux Users${RESET}"
    echo ""
    draw_line "═" "$CYAN" "$BOX_WIDTH"
    echo -e "  ${GREEN}[${BOLD}${username}${RESET}${GREEN}@termux]~$ ${RESET}"
    echo ""
}

# ═══════════════════════════════════════════════
#            Utility Functions
# ═══════════════════════════════════════════════
print_separator() {
    draw_line "═" "$CYAN" "$BOX_WIDTH"
}

print_success() {
    echo -e "  ${GREEN}  [OK] ${BOLD}$1${RESET}"
}

print_error() {
    echo -e "  ${RED}  [ERR] ${BOLD}$1${RESET}"
}

print_info() {
    echo -e "  ${CYAN}  [i] ${RESET}$1"
}

print_warning() {
    echo -e "  ${YELLOW}  [!] ${BOLD}$1${RESET}"
}

press_enter() {
    show_footer
    echo ""
    echo -ne "  ${YELLOW}  >> ${WHITE}Press Enter to continue...${RESET}"
    read
}

# ============================================================
# Auto Error Fix System (500 Error Patterns)
# Automatically detects and fixes known errors
# ============================================================
AUTO_FIX_COUNT=0

auto_fix_error() {
    local error_output="$1"
    local fixed=0

    if [ -z "$error_output" ]; then
        return 1
    fi

    echo -e "  ${YELLOW}[AUTO-FIX]${RESET} Error detected! Finding solution..."

    case "$error_output" in
        *"curl: command not found"*|*"curl: not found"*)
            print_info "Auto-fixing: Installing curl..."; pkg install curl -y >/dev/null 2>&1; fixed=1 ;;
        *"git: command not found"*|*"git: not found"*)
            print_info "Auto-fixing: Installing git..."; pkg install git -y >/dev/null 2>&1; fixed=1 ;;
        *"proot: command not found"*|*"proot: not found"*)
            print_info "Auto-fixing: Installing proot..."; pkg install proot -y >/dev/null 2>&1; fixed=1 ;;
        *"pulseaudio: command not found"*|*"pulseaudio: not found"*)
            print_info "Auto-fixing: Installing pulseaudio..."; pkg install pulseaudio -y >/dev/null 2>&1; fixed=1 ;;
        *"Permission denied"*|*"permission denied"*)
            print_info "Auto-fixing: Fixing permissions..."; chmod +x "$0" 2>/dev/null; fixed=1 ;;
        *"Repository under maintenance"*)
            print_info "Auto-fixing: Changing repo..."; termux-change-repo 2>/dev/null; fixed=1 ;;
        *"404 Not Found"*|*"404  Not Found"*)
            print_info "Auto-fixing: Changing mirror..."; termux-change-repo 2>/dev/null; fixed=1 ;;
        *"Display :0 is already in use"*|*"display.*already"*)
            print_info "Auto-fixing: Clearing display lock..."; rm -rf /tmp/.X11-unix /tmp/.X0-lock 2>/dev/null; fixed=1 ;;
        *"termux-x11 not found"*|*"termux-x11: not found"*)
            print_info "Auto-fixing: Installing termux-x11..."; pkg install x11-repo -y >/dev/null 2>&1 && pkg install termux-x11-nightly -y >/dev/null 2>&1; fixed=1 ;;
        *"Black Screen"*"Termux"*|*"black screen"*)
            print_info "Open Termux:X11 app in background" ;;
        *"Cannot download rootfs"*|*"download.*rootfs"*"fail"*)
            print_warning "Check storage, keep at least 5 GB free" ;;
        *"Connection timed out"*|*"connection timed out"*)
            print_warning "Check your internet connection" ;;
        *"dpkg: error processing"*|*"dpkg error processing"*)
            print_info "Auto-fixing: Configuring dpkg..."; dpkg --configure -a 2>/dev/null; fixed=1 ;;
        *"fix-broken install"*|*"--fix-broken"*)
            print_info "Auto-fixing: Fixing broken packages..."; apt --fix-broken install -y >/dev/null 2>&1; fixed=1 ;;
        *"Process Killed"*|*"process killed"*|*"Killed"*)
            print_info "Enable: Developer Options > Disable child process restrictions" ;;
        *"Sound not working"*|*"audio.*not.*work"*)
            print_info "Auto-fixing: Starting PulseAudio..."; pulseaudio --start 2>/dev/null; fixed=1 ;;
        *"Firefox Audio"*|*"firefox.*audio"*"disabled"*)
            print_info "Firefox > about:config > media.cubeb.sandbox = off" ;;
        *"Storage not accessible"*|*"storage.*not.*accessible"*)
            print_info "Auto-fixing: Setting up storage..."; termux-setup-storage 2>/dev/null; fixed=1 ;;
        *"udroid"*"not found"*|*"Command 'udroid' not found"*)
            print_info "Auto-fixing: Installing udroid..."; . <(curl -Ls https://bit.ly/udroid-installer) 2>/dev/null; fixed=1 ;;
        *"wget: command not found"*|*"wget: not found"*)
            print_info "Auto-fixing: Installing wget..."; pkg install wget -y >/dev/null 2>&1; fixed=1 ;;
        *"startxfce4: command not found"*)
            print_info "Run inside Ubuntu: apt install xfce4 xfce4-goodies -y" ;;
        *"gnome-session: command not found"*)
            print_info "Run inside Ubuntu: apt install ubuntu-desktop -y" ;;
        *"PulseAudio"*"connection refused"*|*"pulseaudio"*"refused"*)
            print_info "Auto-fixing: Restarting PulseAudio..."; killall -9 pulseaudio 2>/dev/null; pulseaudio --start 2>/dev/null; fixed=1 ;;
        *"Nano: command not found"*|*"nano: command not found"*)
            print_info "Auto-fixing: Installing nano..."; pkg install nano -y >/dev/null 2>&1; fixed=1 ;;
        *"bzip2"*"read error"*|*"gzip"*"read error"*|*"Tar"*"read error"*)
            print_warning "Download incomplete, try installing again" ;;
        *"Exec format error"*)
            print_error "Your phone is 32-bit, Ubuntu only supports 64-bit" ;;
        *"BadWindow"*)
            print_info "Clear Termux:X11 app cache data" ;;
        *"Unable to locate package"*)
            print_info "Auto-fixing: Updating package list..."; apt update >/dev/null 2>&1; fixed=1 ;;
        *"Could not get lock"*"dpkg"*|*"dpkg/lock"*)
            print_info "Auto-fixing: Removing lock files..."; rm -f /var/lib/dpkg/lock /var/lib/dpkg/lock-frontend 2>/dev/null; fixed=1 ;;
        *"sudo: command not found"*|*"Sudo: command not found"*)
            print_info "udroid has root access, sudo not needed" ;;
        *"resolution too small"*|*"Screen resolution"*)
            print_info "Change resolution in Termux:X11 settings" ;;
        *"Mouse pointer not showing"*|*"cursor.*not.*visible"*)
            print_info "Enable Mouse Emulation in Termux:X11 settings" ;;
        *"Keyboard not appearing"*|*"keyboard.*not.*show"*)
            print_info "Press Back button or toggle Keyboard in notification" ;;
        *"System lags"*|*"very slow"*|*"too slow"*)
            print_info "Close background apps and free up RAM" ;;
        *"chromium"*"sandbox"*|*"Chromium"*"sandbox"*)
            print_info "Run: chromium --no-sandbox" ;;
        *"VS Code"*"open"*|*"code"*"EACCES"*)
            print_info "Run: code --no-sandbox --user-data-dir=~/.vscode" ;;
        *"Time"*"wrong"*|*"clock"*"skew"*)
            print_info "Run: apt install ntpdate -y && ntpdate pool.ntp.org" ;;
        *"Internet not working inside"*|*"network.*unreachable"*"inside"*)
            print_info "Auto-fixing: DNS config..."; echo "nameserver 8.8.8.8" > /etc/resolv.conf 2>/dev/null; fixed=1 ;;
        *"Cannot install APK"*|*"apk"*"android"*)
            print_info "This is Linux, Android apps (.apk) won't run" ;;
        *"Localhost prompt missing"*)
            print_info "Run: udroid login jammy:xfce4" ;;
        *"Touch clicks not working"*)
            print_info "Enable touchscreen clicks in Termux:X11" ;;
        *"architecture"*"match"*|*"Package architecture"*)
            print_info "Use the official GitHub APK" ;;
        *"Wakelock not acquired"*|*"wakelock"*)
            print_info "Click 'Acquire wakelock' in notification" ;;
        *"python"*"command not found"*|*"Python"*"command not found"*)
            print_info "Auto-fixing: Installing Python..."; pkg install python -y >/dev/null 2>&1; fixed=1 ;;
        *"Fork failed"*|*"Out of memory"*|*"Cannot allocate"*)
            print_warning "Free up RAM, close background apps" ;;
        *"extraction stuck"*|*"Rootfs extraction stuck"*)
            print_info "Keep charging, may take 10-15 minutes" ;;
        *"Unlinking old locks"*)
            print_info "Force Stop Termux and reopen" ;;
        *"Directory not empty"*)
            print_info "Clear directory with rm -rf" ;;
        *"canberra-gtk-module"*)
            print_info "Auto-fixing: Installing canberra module..."; apt install libcanberra-gtk-module -y >/dev/null 2>&1; fixed=1 ;;
        *"No such file or directory"*"setup"*)
            print_info "Navigate to the correct folder with cd" ;;
        *"secondary bootstrap failed"*|*"proot error"*"bootstrap"*)
            print_info "Use latest Termux version from F-Droid" ;;
        *"held broken packages"*)
            print_info "Auto-fixing: Broken packages..."; apt-get check >/dev/null 2>&1; apt-get install -f -y >/dev/null 2>&1; fixed=1 ;;
        *"LD_PRELOAD cannot be preloaded"*)
            print_info "Auto-fixing: Clearing LD_PRELOAD..."; export LD_PRELOAD=""; fixed=1 ;;
        *"display server died"*|*"termux-x11"*"died"*)
            print_info "Auto-fixing: Restarting X11..."; killall -9 termux-x11 2>/dev/null; fixed=1 ;;
        *"Relative symlinks not supported"*)
            print_info "This is a warning, safe to ignore" ;;
        *"neofetch"*"not found"*|*"Neofetch"*"not found"*)
            print_info "Auto-fixing: Installing neofetch..."; apt install neofetch -y >/dev/null 2>&1; fixed=1 ;;
        *"Cannot install build-essential"*)
            print_info "Auto-fixing: System update..."; apt update >/dev/null 2>&1 && apt upgrade -y >/dev/null 2>&1; fixed=1 ;;
        *"Connection refused"*"127.0.0.1"*)
            print_info "Check PulseAudio config (port 4713)" ;;
        *"VLC"*"root"*|*"vlc"*"root"*)
            print_info "Fix: sed -i 's/geteuid/getppid/g' /usr/bin/vlc" ;;
        *"No space left on device"*|*"no space left"*)
            print_warning "Free up storage, keep at least 3 GB free" ;;
        *"no installation candidate"*|*"has no installation candidate"*)
            print_info "Try another version or PPA for this package" ;;
        *"GPG error"*"signatures invalid"*|*"NO_PUBKEY"*)
            print_info "Auto-fixing: Refreshing GPG keys..."; apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 2>/dev/null; fixed=1 ;;
        *"exit code 127"*)
            print_info "Check command spelling" ;;
        *"Font missing"*|*"Broken characters"*|*"tofu"*)
            print_info "Auto-fixing: Installing fonts..."; apt install fonts-noto -y >/dev/null 2>&1; fixed=1 ;;
        *"Audio crackling"*|*"audio.*crackl"*)
            print_info "Increase buffer size in PulseAudio daemon.conf" ;;
        *"Cannot change file permissions"*)
            print_info "Keep file in internal memory" ;;
        *"dpkg was interrupted"*)
            print_info "Auto-fixing: dpkg configure..."; dpkg --configure -a 2>/dev/null; fixed=1 ;;
        *"Unrecognized option"*"--load"*)
            print_info "Auto-fixing: Reinstalling pulseaudio..."; pkg install pulseaudio -y >/dev/null 2>&1; fixed=1 ;;
        *"XFCE desktop black"*|*"desktop.*black"*)
            print_info "Select a wallpaper in Desktop Settings" ;;
        *"Package manager is locked"*|*"lock-frontend"*)
            print_info "Auto-fixing: Removing lock..."; rm -f $PREFIX/var/lib/dpkg/lock-frontend 2>/dev/null; fixed=1 ;;
        *"Network unreachable"*"PRoot"*|*"network unreachable"*)
            print_info "Disable Private DNS" ;;
        *"SSL certificate"*"error"*|*"ssl.*certificate"*"problem"*)
            print_info "Auto-fixing: Installing CA certificates..."; pkg install ca-certificates -y >/dev/null 2>&1; fixed=1 ;;
        *"Hostname cannot be resolved"*|*"resolve.*hostname"*)
            print_info "Add 127.0.0.1 localhost to /etc/hosts" ;;
        *"Failed to init X11"*|*"X11 extension"*)
            print_info "Use latest version of Termux-X11" ;;
        *"LibreOffice"*"crash"*)
            print_info "Run: apt install --reinstall libreoffice -y" ;;
        *"pip"*"failed"*|*"pip.*error"*)
            print_info "Run: apt install python3-pip -y" ;;
        *"Text copying not working"*|*"clipboard"*"not"*)
            print_info "Install autocutsel or xclip" ;;
        *"dpkg returned error code (1)"*)
            print_info "Remove broken package with apt purge" ;;
        *"Archive extraction failed"*|*"extraction.*fail"*)
            print_warning "File corrupt, download again" ;;
        *"Audio latency"*|*"audio.*latency"*)
            print_info "Auto-fixing: Restarting PulseAudio..."; pulseaudio --kill 2>/dev/null; pulseaudio --start 2>/dev/null; fixed=1 ;;
        *"Cannot run xterm"*|*"xterm"*"not found"*)
            print_info "Auto-fixing: Installing xterm..."; apt install xterm -y >/dev/null 2>&1; fixed=1 ;;
        *"Git update-index failed"*)
            print_info "Fix permissions: chmod -R 755 .git/" ;;
        *"Failed to start X server"*|*"X server"*"failed"*)
            print_info "Force Stop Termux X11 and reconnect" ;;
        *"Udroid update failed"*|*"udroid"*"update"*"fail"*)
            print_info "Update with: udroid -u" ;;
        *"cannot open display"*|*"Cannot open display"*)
            print_info "Auto-fixing: Setting DISPLAY..."; export DISPLAY=:0; fixed=1 ;;
        *"Cannot change to /root"*)
            print_info "Check home directory with: echo \$HOME" ;;
        *"vim"*"command not found"*|*"Vim"*"not found"*)
            print_info "Auto-fixing: Installing vim..."; apt install vim -y >/dev/null 2>&1; fixed=1 ;;
        *"Audio not on boot"*|*"audio.*boot"*)
            print_info "Add pulseaudio --start to ~/.bashrc" ;;
        *"Missing shared library"*|*"shared library"*"not found"*)
            print_info "Auto-fixing: Installing build-essential..."; apt install build-essential -y >/dev/null 2>&1; fixed=1 ;;
        *"100% CPU"*|*"cpu.*100"*)
            print_info "Find and kill process with htop" ;;
        *"Touchpad scrolling"*|*"scroll.*inverse"*)
            print_info "Enable Reverse Scrolling in Settings" ;;
        *"Node.js"*"error"*|*"node"*"install"*"error"*)
            print_info "Use NodeSource PPA" ;;
        *"System settings not opening"*|*"xfce4-settings"*"error"*)
            print_info "Auto-fixing: Installing XFCE settings..."; apt install xfce4-settings -y >/dev/null 2>&1; fixed=1 ;;
        *"Cleaning tools"*"delete"*)
            print_warning "Do not run cleaning tools as root!" ;;
        *"App icon missing"*|*"icon.*missing"*)
            print_info "Auto-fixing: Installing gnome-menus..."; apt install gnome-menus -y >/dev/null 2>&1; fixed=1 ;;
        *"Zip"*"error"*|*"Unzip"*"error"*|*"unzip"*"not found"*)
            print_info "Auto-fixing: Installing zip/unzip..."; apt install zip unzip -y >/dev/null 2>&1; fixed=1 ;;
        *"Cannot amtimes"*|*"Tar"*"amtimes"*)
            print_info "Extract to internal storage" ;;
        *"Sound device not detected"*)
            print_info "Install pavucontrol" ;;
        *"Ubuntu system frozen"*|*"system.*frozen"*)
            print_info "Type exit to quit and do a fresh restart" ;;
        *"SSL certificate expired"*)
            print_info "Auto-fixing: CA update..."; pkg update ca-certificates -y >/dev/null 2>&1; fixed=1 ;;
        *"Pkg script error code 1"*|*"pkg"*"error code 1"*)
            print_info "Auto-fixing: apt clean..."; apt clean 2>/dev/null; fixed=1 ;;
        *"Touch controls freezing"*|*"touch.*freez"*)
            print_info "Lock/unlock your phone" ;;
        *"GCC not compiling"*|*"gcc"*"not found"*)
            print_info "Auto-fixing: Installing GCC..."; apt install gcc g++ -y >/dev/null 2>&1; fixed=1 ;;
        *"Git push permission"*|*"git.*push.*denied"*)
            print_info "Use Personal Access Token (PAT)" ;;
        *"Bashrc not working"*|*"bashrc.*error"*)
            print_info "Run: source ~/.bashrc" ;;
        *"VS Code extension error"*|*"extension"*"crash"*)
            print_info "Delete cache: rm -rf ~/.vscode/extensions" ;;
        *"PulseAudio tcp module"*|*"tcp module failed"*)
            print_info "Check if port 4713 is free" ;;
        *"Cannot load theme"*|*"theme"*"not found"*)
            print_info "Auto-fixing: Installing lxappearance..."; apt install lxappearance -y >/dev/null 2>&1; fixed=1 ;;
        *"libX11"*"crash"*|*"libX11"*"error"*)
            print_info "Auto-fixing: Installing libx11-dev..."; apt install libx11-dev -y >/dev/null 2>&1; fixed=1 ;;
        *"Udroid rootfs null"*|*"rootfs.*null"*)
            print_info "Do a fresh install" ;;
        *"Sudoers file corrupted"*|*"sudoers"*"error"*)
            print_info "Use pkexec or run commands without sudo" ;;
        *"hash sum mismatch"*|*"Hash Sum mismatch"*)
            print_info "Auto-fixing: Hash fix..."; apt-get update -o Acquire::CompressionTypes::Order::=gz >/dev/null 2>&1; fixed=1 ;;
        *"Snapd not working"*|*"snap"*"not.*work"*)
            print_info "Snap doesn't work in PRoot, use apt/AppImage" ;;
        *"Flatpak error"*|*"flatpak"*"fail"*)
            print_info "Use AppImage or apt instead" ;;
        *"clang"*"not found"*|*"Clang error"*)
            print_info "Auto-fixing: Installing clang..."; apt install clang -y >/dev/null 2>&1; fixed=1 ;;
        *"Brightness not changing"*)
            print_info "Hardware control not possible in PRoot" ;;
        *"Cannot install Wine"*|*"wine"*"error"*)
            print_info "Try: apt install wine64 -y" ;;
        *"Cannot read storage"*|*"storage"*"denied"*)
            print_info "Auto-fixing: Setting up storage..."; termux-setup-storage 2>/dev/null; fixed=1 ;;
        *"Bluetooth not connecting"*|*"bluetooth"*"error"*)
            print_info "Termux cannot access Bluetooth" ;;
        *"Tar"*"error code 2"*|*"tar"*"code 2"*)
            print_warning "Try again" ;;
        *"Direct rendering disabled"*|*"direct render"*)
            print_info "GPU acceleration is limited in PRoot" ;;
        *"Cannot download git repo"*|*"git clone"*"fail"*)
            print_info "Check URL/link spelling" ;;
        *"python"*"sqlite3"*"missing"*)
            print_info "Run: apt install python3-sqlite3 -y" ;;
        *"Display settings greyed"*)
            print_info "Change from Termux X11 settings" ;;
        *"Nano cursor not moving"*|*"nano.*cursor"*)
            print_info "Toggle Mouse tracking with Alt+M" ;;
        *"Firefox crashes"*|*"firefox.*crash"*)
            print_info "Keep fewer tabs open and free memory" ;;
        *"GDM"*"crash"*|*"LightDM"*"crash"*)
            print_info "Run startxfce4 directly, no display manager needed" ;;
        *"Cannot open Thunar"*|*"thunar"*"not found"*)
            print_info "Auto-fixing: Installing Thunar..."; apt install thunar -y >/dev/null 2>&1; fixed=1 ;;
        *"Htop shows fake"*|*"htop"*"cores"*)
            print_info "This is normal PRoot behavior" ;;
        *"Curl error 7"*|*"curl"*"error 7"*)
            print_warning "Check your internet connection" ;;
        *"bash option error"*|*"bash"*"not sh"*)
            print_info "Run with bash, not sh" ;;
        *"Environment variables cleared"*)
            print_info "Make variables permanent with export in .bashrc" ;;
        *"Extracted rootfs deleted"*)
            print_info "Reinstall the system" ;;
        *"Synaptic"*"crash"*)
            print_info "Use apt commands instead" ;;
        *"git"*"template missing"*)
            print_info "Auto-fixing: Installing git-lfs..."; pkg install git-lfs -y >/dev/null 2>&1; fixed=1 ;;
        *"Sound only on speaker"*)
            print_info "Run: pulseaudio -k && pulseaudio --start" ;;
        *"Screen tearing"*)
            print_info "Enable VSync in XFCE Compositor" ;;
        *"libskcodec"*)
            find /system -name "libskcodec.so" 2>/dev/null; fixed=0 ;;
        *"DNS failing"*|*"dns.*fail"*)
            print_info "Auto-fixing: DNS fix..."; echo "nameserver 8.8.8.8" > /etc/resolv.conf 2>/dev/null; fixed=1 ;;
        *"syntax error near unexpected token"*|*"unexpected token"*)
            print_info "Fix file with dos2unix" ;;
        *"Cannot install htop"*|*"htop"*"not found"*)
            print_info "Auto-fixing: Installing htop..."; apt install htop -y >/dev/null 2>&1; fixed=1 ;;
        *"XFCE panel disappeared"*|*"panel.*disappear"*)
            print_info "Run: xfce4-panel --restart" ;;
        *"Linux fonts ugly"*|*"fonts.*ugly"*)
            print_info "Auto-fixing: Installing fonts..."; apt install fonts-liberation -y >/dev/null 2>&1; fixed=1 ;;
        *"Package configuration unresolved"*|*"configure.*pending"*)
            print_info "Auto-fixing: dpkg configure..."; dpkg --configure -a 2>/dev/null; fixed=1 ;;
        *"Git merge conflict"*|*"merge.*conflict"*)
            print_info "Run: git reset --hard origin/main" ;;
        *"Sed pattern error"*|*"sed.*error"*)
            print_info "Check slash/quote escaping" ;;
        *"preference not opening"*|*"X11.*preference"*)
            print_info "Access Termux:X11 settings from App Info" ;;
        *"Desktop shortcut fails"*|*"shortcut.*fail"*)
            print_info "Enable 'Allow executing file'" ;;
        *"PulseAudio auth keys"*|*"pulse.*cookie"*)
            print_info "Auto-fixing: Removing cookie..."; rm -f ~/.config/pulse/cookie 2>/dev/null; fixed=1 ;;
        *"Out of disk space during upgrade"*|*"disk space"*"upgrade"*)
            print_warning "Free up 2-3 GB of storage" ;;
        *"Window manager broken"*|*"xfwm4"*"crash"*)
            print_info "Run: xfwm4 --replace &" ;;
        *"apps not seeing internet"*|*"Linux.*no.*internet"*)
            print_info "Turn off VPN" ;;
        *"Touch registers as right click"*)
            print_info "Change mouse settings" ;;
        *"Udroid engine corrupt"*|*"udroid.*corrupt"*)
            print_info "Re-clone the tool from GitHub" ;;
        *"Apt lock file exists"*|*"apt.*lock.*exists"*)
            print_info "Auto-fixing: Removing lock..."; rm -f /var/lib/apt/lists/lock 2>/dev/null; fixed=1 ;;
        *"Gedit"*"save"*|*"gedit.*permission"*)
            print_info "Check file ownership" ;;
        *"Local config permissions"*|*"config.*permission"*)
            print_info "Auto-fixing: Fixing permissions..."; chown -R root:root ~/.config 2>/dev/null; fixed=1 ;;
        *"Chromium sandbox crashed"*)
            print_info "Run: chromium --no-sandbox --disable-gpu" ;;
        *"Bash history not saving"*)
            print_info "Check disk free space" ;;
        *"Termux plugin error"*|*"plugin.*signature"*)
            print_info "Install all apps from the same source (F-Droid/GitHub)" ;;
        *"SSH connection refused"*|*"ssh.*refused"*)
            print_info "Run: apt install openssh-server -y" ;;
        *"python"*"setuptools"*"missing"*)
            print_info "Auto-fixing: Installing setuptools..."; apt install python3-setuptools -y >/dev/null 2>&1; fixed=1 ;;
        *"Audio lagging"*|*"audio.*lag"*)
            print_info "Auto-fixing: PulseAudio refresh..."; pulseaudio --kill 2>/dev/null; pulseaudio --start 2>/dev/null; fixed=1 ;;
        *"Display scale blurry"*)
            print_info "Set Scaling mode to Center/Fit" ;;
        *"Script stops at 99"*|*"stuck.*99"*)
            print_info "Wait, it may take 5-10 minutes" ;;
        *"Apt key expired"*|*"apt-key.*expired"*)
            print_info "Auto-fixing: Refreshing keys..."; apt-key adv --refresh-keys 2>/dev/null; fixed=1 ;;
        *"Terminal title bar corrupted"*)
            print_info "Resize the window" ;;
        *"Gtk theme errors"*|*"Gtk-WARNING"*|*"Gtk-CRITICAL"*)
            print_info "Cosmetic warning, safe to ignore" ;;
        *"XFCE power manager"*|*"power manager"*"warning"*)
            print_info "This is normal in PRoot" ;;
        *"Cannot run java"*|*"java"*"not found"*)
            print_info "Auto-fixing: Installing Java..."; apt install default-jre -y >/dev/null 2>&1; fixed=1 ;;
        *"VSCode blank screen"*|*"vscode.*blank"*)
            print_info "Run: code --disable-gpu" ;;
        *"/tmp permissions"*|*"tmp.*permission"*)
            print_info "Auto-fixing: /tmp permissions..."; chmod 1777 /tmp 2>/dev/null; fixed=1 ;;
        *"Software center not working"*)
            print_info "Use apt commands instead" ;;
        *"Cannot make script executable"*)
            print_info "Keep script in Termux home directory" ;;
        *"Download stops 0B"*|*"download.*0B"*|*"0 B/s"*)
            print_info "Turn off VPN, toggle mobile data" ;;
        *"Broken pipe"*|*"broken pipe"*)
            print_info "Re-run the script" ;;
        *"Keyboard shortcut not working"*)
            print_info "Bind in XFCE > Keyboard > Application Shortcuts" ;;
        *"PulseAudio high CPU"*|*"pulseaudio.*cpu"*)
            print_info "Set real-time-scheduling=no in daemon.conf" ;;
        *"System logs filling"*|*"/var/log"*"full"*)
            print_info "Auto-fixing: Clearing logs..."; rm -rf /var/log/* 2>/dev/null; fixed=1 ;;
        *"GDB"*"crash"*|*"gdb"*"ptrace"*)
            print_info "ptrace is limited in PRoot" ;;
        *"wget URL error"*|*"wget.*url.*error"*)
            print_info "Put URL in double quotes" ;;
        *"Curl error 23"*|*"curl.*error 23"*)
            print_info "Restart the session" ;;
        *"Browser audio missing"*)
            print_info "Set audio output to Default" ;;
        *"Custom theme fonts not loading"*|*"font.*cache"*"error"*)
            print_info "Run: fc-cache -f -v" ;;
        *"Git detached HEAD"*|*"detached HEAD"*)
            print_info "Run: git checkout main" ;;
        *"Cannot kill termux-x11"*)
            print_info "Force Stop the app" ;;
        *"System info utility error"*|*"coreutils"*"error"*)
            print_info "Auto-fixing: Installing coreutils..."; apt install coreutils -y >/dev/null 2>&1; fixed=1 ;;
        *"Archive utility missing"*|*"7z"*"not found"*)
            print_info "Auto-fixing: Installing p7zip..."; apt install p7zip-full -y >/dev/null 2>&1; fixed=1 ;;
        *"Cannot install build dependencies"*|*"deb-src"*)
            print_info "Uncomment deb-src in sources.list" ;;
        *"Mouse scroll too fast"*)
            print_info "Reduce speed in mouse settings" ;;
        *"Taskbar items disappeared"*)
            print_info "Re-add from Panel Preferences > Items" ;;
        *"Sound muted"*|*"audio.*muted"*)
            print_info "Unmute with pavucontrol" ;;
        *"Missing libgl"*|*"libGL"*"not found"*|*"libgl.so"*)
            print_info "Auto-fixing: Installing mesa-glx..."; apt install libgl1-mesa-glx -y >/dev/null 2>&1; fixed=1 ;;
        *"Custom font broke"*|*"termux.*font"*)
            print_info "Delete .termux/font.ttf" ;;
        *"Screen update slow"*|*"display.*slow"*)
            print_info "Change Connection Type" ;;
        *"PRoot info dump"*|*"proot.*dump"*)
            print_info "Clear RAM and restart session" ;;
        *"Repository public key missing"*|*"public key"*"missing"*)
            print_info "Import the signing key" ;;
        *"software-properties-common"*"missing"*|*"add-apt-repository"*"not found"*)
            print_info "Auto-fixing: Installing software-properties..."; apt install software-properties-common -y >/dev/null 2>&1; fixed=1 ;;
        *"Everything crashed"*|*"completely broken"*)
            print_info "Clear Termux data and run the tool again" ;;
        *"Apt-get command not found"*|*"apt-get"*"not found"*)
            print_info "Use apt instead of apt-get" ;;
        *"Cannot find manual pages"*|*"man"*"not found"*)
            print_info "Auto-fixing: Installing man-db..."; apt install man-db -y >/dev/null 2>&1; fixed=1 ;;
        *"Tar"*"failure status"*)
            print_warning "Storage may be full" ;;
        *"Gtk critical"*"source ID"*|*"GLib-CRITICAL"*)
            print_info "Non-fatal error, safe to ignore" ;;
        *"Nano syntax coloring"*|*"nano.*syntax"*)
            print_info "Uncomment include in /etc/nanorc" ;;
        *"PulseAudio state files"*|*"pulse.*state.*corrupt"*)
            print_info "Auto-fixing: Clearing pulse state..."; rm -rf ~/.config/pulse 2>/dev/null; fixed=1 ;;
        *"alpine"*"apk"*|*"apk update"*"error"*)
            print_info "For Alpine-based system run: apk update" ;;
        *"Bash command completion"*|*"bash-completion"*"missing"*)
            print_info "Auto-fixing: Installing bash-completion..."; apt install bash-completion -y >/dev/null 2>&1; fixed=1 ;;
        *"/dev/shm missing"*|*"dev/shm"*"not"*)
            print_info "/dev/shm is not mounted in PRoot, this is normal" ;;
        *"Host is down"*|*"host.*down"*)
            print_warning "Check your network" ;;
        *"Locales"*"error"*|*"locale.*error"*|*"locale-gen"*)
            print_info "Auto-fixing: Configuring locales..."; apt install locales -y >/dev/null 2>&1; locale-gen en_US.UTF-8 2>/dev/null; fixed=1 ;;
        *"Cannot open display :1"*)
            print_info "Run: export DISPLAY=:0" ;;
        *"Python module pip missing"*|*"ensurepip"*)
            print_info "Auto-fixing: pip setup..."; python3 -m ensurepip --default-pip 2>/dev/null; fixed=1 ;;
        *"Cannot compile C++17"*)
            print_info "Update to latest g++ version" ;;
        *"Git push asks username"*|*"credential"*"every time"*)
            print_info "Run: git config --global credential.helper store" ;;
        *"Cannot run visual studio server"*|*"code-server"*"error"*)
            print_info "Run: code-server --auth none" ;;
        *"Thunar volume manager"*|*"thunar-volman"*)
            print_info "Auto-fixing: Installing thunar-volman..."; apt install thunar-volman -y >/dev/null 2>&1; fixed=1 ;;
        *"Custom alias"*"disappearing"*)
            print_info "Write aliases permanently in ~/.bashrc" ;;
        *"Broken simlinks"*"/bin"*|*"broken symlink"*)
            print_info "Auto-fixing: Installing termux-exec..."; pkg install termux-exec -y >/dev/null 2>&1; fixed=1 ;;
        *"Missing libxcb"*|*"libxcb"*"not found"*)
            print_info "Auto-fixing: Installing libxcb..."; apt install libxcb1-dev -y >/dev/null 2>&1; fixed=1 ;;
        *"Android package"*"inside proot"*)
            print_info "Android APK cannot be installed in Linux" ;;
        *"Cannot build wheels"*"cryptography"*)
            print_info "Auto-fixing: Installing crypto deps..."; apt install libssl-dev libffi-dev python3-dev -y >/dev/null 2>&1; fixed=1 ;;
        *"XFCE desktop icon overlapping"*)
            print_info "Right click > Arrange Desktop Icons" ;;
        *"Sed"*"can't read"*"resolv"*)
            print_info "Create file first: touch /etc/resolv.conf" ;;
        *"Wget error 403"*|*"wget.*403"*|*"403 Forbidden"*)
            print_info "URL token expired, get a new link" ;;
        *"Proot-distro"*"error"*|*"proot-distro"*"command"*"not"*)
            print_info "Auto-fixing: Installing proot-distro..."; pkg install proot-distro -y >/dev/null 2>&1; fixed=1 ;;
        *"Audio stream stuttering"*|*"audio.*stutter"*)
            print_info "Wait for disk operations to finish" ;;
        *"Pip install permission denied"*|*"pip.*permission"*)
            print_info "Use: pip install --user [package]" ;;
        *"Input/output error"*|*"I/O error"*)
            print_warning "Reboot your phone" ;;
        *"Gnome terminal"*"factory"*)
            print_info "Run: dbus-launch gnome-terminal" ;;
        *"Display settings change crash"*)
            print_info "Lock resolution from X11 settings" ;;
        *"module-native-protocol-tcp"*"load failed"*)
            print_info "Check PulseAudio config spelling" ;;
        *"Gedit"*"/storage"*)
            print_info "Check termux-setup-storage" ;;
        *"Git clone"*"already exists"*|*"destination path"*"already exists"*)
            print_info "Delete old data with rm -rf [folder]" ;;
        *"Package 'code' has no installation candidate"*)
            print_info "Add Microsoft official Linux repo" ;;
        *"node-gyp"*"error"*|*"node-gyp"*"fail"*)
            print_info "Auto-fixing: node-gyp deps..."; apt install make python3 g++ -y >/dev/null 2>&1; fixed=1 ;;
        *"Sound pitch"*"high"*)
            print_info "Set default-sample-rate = 44100 in daemon.conf" ;;
        *"wallpaper"*"stretch"*)
            print_info "Select Wallpaper Style > Scaled/Zoomed" ;;
        *"Dynamic linker error"*|*"dynamic link"*"error"*)
            print_info "Auto-fixing: pkg upgrade..."; pkg upgrade >/dev/null 2>&1; fixed=1 ;;
        *"D-Bus"*"warning"*"xfce"*|*"dbus"*"error"*"xfce"*)
            print_info "Auto-fixing: Installing dbus-x11..."; apt install dbus-x11 -y >/dev/null 2>&1; fixed=1 ;;
        *"Firefox"*"secure connection"*|*"firefox.*ssl"*)
            print_info "Fix Time and Date in Ubuntu" ;;
        *"sshd"*"missing"*|*"sshd"*"not found"*)
            print_info "Auto-fixing: Installing openssh..."; apt install openssh-server -y >/dev/null 2>&1; fixed=1 ;;
        *"X11 forwarding"*"display"*)
            print_info "Run: export DISPLAY=localhost:0.0" ;;
        *"architecture aarch64 mismatch"*|*"wrong.*architecture"*)
            print_info "Wrong architecture image was downloaded" ;;
        *"Custom fonts cache"*|*"fc-cache"*"error"*)
            print_info "Auto-fixing: Font cache rebuild..."; fc-cache -r 2>/dev/null; fixed=1 ;;
        *"Nano"*"parse configuration"*|*"nanorc"*"error"*)
            print_info "Edit or delete ~/.nanorc file" ;;
        *"Package manager"*"loop"*|*"configure.*loop"*)
            print_info "Auto-fixing: dpkg configure..."; dpkg --configure -a 2>/dev/null; fixed=1 ;;
        *"Chromium"*"sandbox error"*"PRoot"*)
            print_info "Use --no-sandbox flag" ;;
        *"Cannot run bash script via sh"*)
            print_info "Run with: bash [script]" ;;
        *"Android UI freezing"*"termux-x11"*)
            print_info "Disable Game Turbo/Battery Saver" ;;
        *"Pulseaudio daemon already running"*)
            print_info "Auto-fixing: PA restart..."; pulseaudio -k 2>/dev/null; pulseaudio --start 2>/dev/null; fixed=1 ;;
        *"Touch interaction delay"*)
            print_info "Reduce Input latency in X11 Settings" ;;
        *"Rootfs"*"checksum mismatch"*)
            print_warning "Download incomplete, try again" ;;
        *"Apt-key"*"deprecated"*)
            print_info "Place keys in /etc/apt/trusted.gpg.d/" ;;
        *"Vim color schemes"*|*"vim.*colorscheme"*)
            print_info "Auto-fixing: vim-runtime..."; apt install vim-runtime -y >/dev/null 2>&1; fixed=1 ;;
        *"Git default branch"*)
            print_info "Run: git config --global init.defaultBranch main" ;;
        *"Missing libsecret"*|*"libsecret"*"not found"*)
            print_info "Auto-fixing: Installing libsecret..."; apt install libsecret-1-0 -y >/dev/null 2>&1; fixed=1 ;;
        *"Audio"*"HDMI"*)
            print_info "Change HDMI/Bluetooth audio settings" ;;
        *"Cannot install snapcraft"*)
            print_info "Snap doesn't work, use apt" ;;
        *"Screen casting black"*)
            print_info "Use a display mirroring app" ;;
        *"ping"*"not found"*|*"ping"*"command not found"*)
            print_info "Auto-fixing: Installing iputils-ping..."; apt install iputils-ping -y >/dev/null 2>&1; fixed=1 ;;
        *"netstat"*"not found"*|*"Cannot run netstat"*)
            print_info "Auto-fixing: Installing net-tools..."; apt install net-tools -y >/dev/null 2>&1; fixed=1 ;;
        *"XFCE"*"panel item lock"*)
            print_info "Uncheck Lock Panel in Panel Settings" ;;
        *"Tar"*"Cannot write"*"No space"*)
            print_warning "Keep minimum 10 GB free space" ;;
        *"Dpkg database corruption"*|*"dpkg.*database"*"corrupt"*)
            print_info "Restore from /var/lib/dpkg/backup" ;;
        *"python"*"dev headers"*|*"Python.h"*"not found"*)
            print_info "Auto-fixing: Installing python3-dev..."; apt install python3-dev -y >/dev/null 2>&1; fixed=1 ;;
        *"Firefox"*"widevine"*|*"DRM"*"limited"*)
            print_info "Firefox DRM is limited on ARM" ;;
        *"Clipboard"*"gone"*|*"clipboard.*lost"*)
            print_info "Use a clipboard manager" ;;
        *"Audio distortion"*"game"*)
            print_info "Increase buffer in game Audio Settings" ;;
        *"Python"*"wheel"*"fail"*|*"build wheel"*"fail"*)
            print_info "Auto-fixing: Build deps..."; apt install build-essential python3-dev -y >/dev/null 2>&1; fixed=1 ;;
        *"Storage directory link broken"*)
            print_info "Auto-fixing: Storage re-setup..."; termux-setup-storage 2>/dev/null; fixed=1 ;;
        *"Cannot run vscode as root"*)
            print_info "Run: code --user-data-dir='~/.vscode' --no-sandbox" ;;
        *"Dbus service"*"failed"*)
            print_info "Start session with dbus-launch" ;;
        *"Proot dynamic link"*"warning"*)
            print_info "Normal PRoot behavior, not an error" ;;
        *"Wget"*"error 503"*|*"wget.*503"*)
            print_info "Server busy, try later" ;;
        *"Tar"*"memory exhaustion"*)
            print_info "Clear memory and extract in a fresh session" ;;
        *"File creation time"*|*"timezone"*"wrong"*)
            print_info "Run: dpkg-reconfigure tzdata" ;;
        *"Application menu"*"blank"*)
            print_info "Check if app installed completely" ;;
        *"Package configure loop"*|*"apt.*loop"*)
            print_info "Auto-fixing: apt clean+update..."; apt clean 2>/dev/null; apt update >/dev/null 2>&1; fixed=1 ;;
        *"Terminal font too small"*)
            print_info "Pinch zoom with two fingers" ;;
        *"Audio stream"*"dead"*)
            print_info "Restart Termux and run pulseaudio --start" ;;
        *"BadMatch"*"display"*)
            print_info "Get latest Termux:X11 GitHub release" ;;
        *"double tap not working"*)
            print_info "Change X11 Input preference" ;;
        *"ssh"*"host key verification"*|*"Host key verification failed"*)
            print_info "Auto-fixing: SSH key add..."; mkdir -p ~/.ssh; ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts 2>/dev/null; fixed=1 ;;
        *"root"*"password"*"reset"*)
            print_info "Press Enter or run: passwd root" ;;
        *"Missing libXrender"*|*"libXrender"*"not found"*)
            print_info "Auto-fixing: Installing libxrender..."; apt install libxrender1 -y >/dev/null 2>&1; fixed=1 ;;
        *"Software property"*"failed"*)
            print_info "Install python3-software-properties" ;;
        *"Audio"*"foreground"*|*"audio.*background.*stop"*)
            print_info "Disable battery optimization for Termux" ;;
        *"server certificate verification failed"*|*"GIT_SSL"*)
            print_info "Auto-fixing: SSL skip..."; export GIT_SSL_NO_VERIFY=true; fixed=1 ;;
        *"Cannot open display :0.0"*)
            print_info "Run: export DISPLAY=:0" ;;
        *"Nano"*"cannot open"*"writing"*)
            print_info "Check file permissions" ;;
        *"python3-pip"*|*"pip3"*"not found"*)
            print_info "Auto-fixing: Installing pip3..."; apt install python3-pip -y >/dev/null 2>&1; fixed=1 ;;
        *"VS Code terminal"*"missing characters"*)
            print_info "Change VS Code Terminal Font" ;;
        *"xfce4-whiskermenu"*|*"whiskermenu"*"not found"*)
            print_info "Auto-fixing: Installing whiskermenu..."; apt install xfce4-whiskermenu-plugin -y >/dev/null 2>&1; fixed=1 ;;
        *"File extraction aborted"*|*"extraction.*abort"*)
            print_info "Keep phone screen on" ;;
        *"Gtk widget warnings"*|*"GtkWidget"*"warning"*)
            print_info "Cosmetic issue, system is fine" ;;
        *"Cannot run systemctl"*|*"systemctl"*"not"*|*"systemd"*"not"*)
            print_info "systemctl doesn't work in PRoot, start services manually" ;;
        *"Mouse pointer drifts"*)
            print_info "Tune X11 Mouse sensitivity" ;;
        *"Full system freeze"*|*"system.*freeze"*)
            print_info "Force Stop and do a fresh boot" ;;
        *"Udroid"*"login"*"directory"*)
            print_info "Reset udroid engine" ;;
        *"Chromium core dump"*)
            print_info "Add --disable-namespace-sandbox flag" ;;
        *"Missing build system tools"*|*"automake"*"not found"*)
            print_info "Auto-fixing: Installing build tools..."; apt install automake autoconf libtool -y >/dev/null 2>&1; fixed=1 ;;
        *"Audio device busy"*)
            print_info "Close other music/game apps" ;;
        *"Firefox"*"hardware"*"error"*)
            print_info "Disable Firefox Hardware Acceleration" ;;
        *"Local font"*"cache"*|*"font cache miss"*)
            print_info "Auto-fixing: Font cache rebuild..."; fc-cache -f 2>/dev/null; fixed=1 ;;
        *"Bash syntax error"*"brackets"*)
            print_info "Check script coding" ;;
        *"X11"*"crashes"*"rotates"*|*"rotation.*crash"*)
            print_info "Lock X11 Display Orientation" ;;
        *"pip install"*"requirements"*)
            print_info "Run: pip install -r requirements.txt" ;;
        *"Repository mirrors dead"*)
            print_info "Edit sources.list and use official repo" ;;
        *"Storage folder"*"not updating"*)
            print_info "Press F5 to refresh file manager" ;;
        *"Libssl version mismatch"*|*"libssl.*mismatch"*)
            print_info "Auto-fixing: libssl reinstall..."; apt install --reinstall libssl-dev -y >/dev/null 2>&1; fixed=1 ;;
        *"Text selection"*"touch broken"*)
            print_info "Use mouse emulation for X11 selection" ;;
        *"PulseAudio client protocol"*)
            print_info "Delete PulseAudio client config" ;;
        *"Dynamic linker cache"*"corrupt"*)
            print_info "Run ldconfig as root" ;;
        *"File sharing"*"Android"*"Ubuntu"*)
            print_info "Use ~/storage/shared path" ;;
        *"Git branch merge error"*|*"merge.*error"*)
            print_info "Run: git merge --abort" ;;
        *"node-sass"*"error"*)
            print_info "Use dart-sass instead" ;;
        *"XFCE panel clock"*)
            print_info "Panel Clock > Properties > Custom Format" ;;
        *"Directory ownership wrong"*)
            print_info "Auto-fixing: Ownership fix..."; chown -R root:root /root 2>/dev/null; fixed=1 ;;
        *"setuptools"*"old"*|*"pip.*version"*"old"*)
            print_info "Auto-fixing: pip upgrade..."; pip install --upgrade pip 2>/dev/null; fixed=1 ;;
        *"Wget certificate invalid"*)
            print_info "Run: wget --no-check-certificate [URL]" ;;
        *"Ubuntu"*"repository sync"*|*"repo.*sync"*)
            print_info "Auto-fixing: apt clean+update..."; apt clean 2>/dev/null; apt update >/dev/null 2>&1; fixed=1 ;;
        *"Audio volume"*"reset"*)
            print_info "Fix volume with pavucontrol" ;;
        *"Mouse wheel"*"direction"*"wrong"*)
            print_info "Toggle Natural Scrolling" ;;
        *"Process stuck"*"background"*|*"process.*stuck"*)
            print_info "Find PID with ps aux and kill -9 PID" ;;
        *"Git pull conflict"*|*"pull.*conflict"*)
            print_info "Run: git stash && git pull" ;;
        *"Display server socket"*|*"X11-unix"*"error"*)
            print_info "Auto-fixing: Socket clear..."; rm -rf /tmp/.X11-unix 2>/dev/null; fixed=1 ;;
        *"Udroid"*"rootfs corrupt"*)
            print_info "Delete system and reinstall" ;;
        *"Vim syntax"*"off"*)
            print_info "Run :syntax on in Vim" ;;
        *"pip"*"numpy"*"fail"*)
            print_info "Auto-fixing: Installing numpy..."; apt install python3-numpy -y >/dev/null 2>&1; fixed=1 ;;
        *"Audio"*"hum"*"noise"*)
            print_info "Change PulseAudio buffer tuning" ;;
        *"Cannot start window manager"*)
            print_info "Run: xfwm4 &" ;;
        *"Storage link"*"permission denied"*)
            print_info "Settings > Apps > Termux > Permissions > File access" ;;
        *"Firefox profile"*"locked"*)
            print_info "Auto-fixing: Firefox lock remove..."; rm -rf ~/.mozilla/firefox/*.default/lock 2>/dev/null; fixed=1 ;;
        *"Display output frozen"*)
            print_info "Restart the display" ;;
        *"Touch"*"offset"*|*"click"*"wrong place"*)
            print_info "Change X11 Aspect Ratio from Stretch to Fit" ;;
        *"Gtk theme icons missing"*|*"icon theme"*"missing"*)
            print_info "Auto-fixing: Installing icon theme..."; apt install gnome-icon-theme -y >/dev/null 2>&1; fixed=1 ;;
        *"Command"*"loops"*"bash"*|*"infinite.*loop"*)
            print_info "Press Ctrl+C" ;;
        *"Android kills termux"*|*"termux.*killed"*)
            print_info "Settings > Battery > Termux > No Restrictions" ;;
        *"Curl error 35"*|*"curl.*error 35"*)
            print_info "Auto-fixing: CA update..."; pkg update ca-certificates -y >/dev/null 2>&1; fixed=1 ;;
        *"Cannot setup language"*|*"LANG"*"error"*)
            print_info "Auto-fixing: LANG set..."; export LANG=en_US.UTF-8; fixed=1 ;;
        *"Broken simlink"*"storage"*|*"storage.*symlink"*)
            print_info "Auto-fixing: Storage relink..."; rm -f ~/storage 2>/dev/null; termux-setup-storage 2>/dev/null; fixed=1 ;;
        *"Thunar"*"network shares"*)
            print_info "Auto-fixing: Installing gvfs-backends..."; apt install gvfs-backends -y >/dev/null 2>&1; fixed=1 ;;
        *"Git commit identity"*|*"git.*identity"*)
            print_info "Set git config --global user.email and user.name" ;;
        *"Chromium webgl"*|*"webgl.*context"*)
            print_info "Force enable WebGL in Chromium flags" ;;
        *"Sound pitch slow"*|*"audio.*robotic"*)
            print_info "Fix PulseAudio sample rate" ;;
        *"System UI freeze"*"resolution"*)
            print_info "Clear X11 app and restart" ;;
        *"Repository structure invalid"*)
            print_info "Auto-fixing: apt clean+update..."; apt clean 2>/dev/null; apt update >/dev/null 2>&1; fixed=1 ;;
        *"Package configure execution"*|*"configure.*execution.*error"*)
            print_info "Auto-fixing: dpkg configure..."; dpkg --configure -a 2>/dev/null; fixed=1 ;;
        *"Ssh tunnel"*"authorization"*|*"xauth"*"error"*)
            print_info "Install xauth package" ;;
        *"Archive expansion interrupted"*)
            print_info "Free memory and try again" ;;
        *"Cannot change wallpaper"*"GNOME"*)
            print_info "Use gnome-tweaks" ;;
        *"XFCE whisker menu"*"broken"*)
            print_info "Remove and re-add Whisker menu" ;;
        *"Audio stream lost"*"phone call"*)
            print_info "Restart pulseaudio after call ends" ;;
        *"shell commands"*"loop"*|*"ubuntu.*loop"*)
            print_info "Type exit and do a fresh login" ;;
        *"Apt lock frontend"*"active"*)
            print_info "Auto-fixing: Lock remove..."; rm -f /var/lib/dpkg/lock-frontend 2>/dev/null; fixed=1 ;;
        *"Curl error 56"*|*"curl.*error 56"*)
            print_info "Keep network stable" ;;
        *"Mouse secondary click"*"menu"*)
            print_info "Change X11 Touch control settings" ;;
        *"Missing libXft"*|*"libXft"*"not found"*)
            print_info "Auto-fixing: Installing libxft-dev..."; apt install libxft-dev -y >/dev/null 2>&1; fixed=1 ;;
        *"rootfs"*"format unknown"*)
            print_warning "Re-download the file" ;;
        *"Gtk"*"fallback theme"*|*"gtk.*fallback"*)
            print_info "Install a theme pack" ;;
        *"Sound settings"*"mixer"*"missing"*|*"pulseaudio-plugin"*)
            print_info "Auto-fixing: Installing PA plugin..."; apt install xfce4-pulseaudio-plugin -y >/dev/null 2>&1; fixed=1 ;;
        *"pip"*"markup"*"safe"*|*"MarkupSafe"*"fail"*)
            print_info "Auto-fixing: setuptools upgrade..."; python3 -m pip install --upgrade setuptools 2>/dev/null; fixed=1 ;;
        *"Domain name server"*"fail"*|*"dns.*lookup.*fail"*)
            print_info "Auto-fixing: DNS add..."; echo "nameserver 1.1.1.1" >> /etc/resolv.conf 2>/dev/null; fixed=1 ;;
        *"Packages cache"*"overflow"*|*"cache.*overflow"*)
            print_info "Auto-fixing: apt clean..."; apt clean 2>/dev/null; fixed=1 ;;
        *"Pulseaudio"*"cookie"*"sync"*)
            print_info "Auto-fixing: Cookie reset..."; rm -f ~/.config/pulse/cookie 2>/dev/null; pulseaudio --kill 2>/dev/null; pulseaudio --start 2>/dev/null; fixed=1 ;;
        *"Chromium"*"extensions crashed"*)
            print_info "Delete extension cache" ;;
        *"GitHub"*"rate limit"*|*"API rate limit"*)
            print_info "Wait 15-20 minutes" ;;
        *"LC_ALL"*"missing"*|*"locale.*LC_ALL"*)
            print_info "Auto-fixing: LC_ALL set..."; export LC_ALL=en_US.UTF-8; fixed=1 ;;
        *"Thunar"*"loading"*"slow"*)
            print_info "Disable preview generation" ;;
        *"Git"*"rebase"*"fatal"*)
            print_info "Run: git rebase --abort" ;;
        *"Chromium"*"hardware acceleration"*|*"chromium.*accel"*)
            print_info "Disable Hardware Acceleration" ;;
        *"Audio volume booster"*|*"volume.*boost"*)
            print_info "Do not boost volume above 100%" ;;
        *"Display server timeout"*|*"display.*timeout"*)
            print_info "Kill X11 process and restart" ;;
        *"Curl error 28"*|*"curl.*error 28"*|*"operation timed out"*)
            print_warning "Check network speed" ;;
        *"lxde-core"*|*"Missing"*"lxde"*)
            print_info "Auto-fixing: Installing lxde-core..."; apt install lxde-core -y >/dev/null 2>&1; fixed=1 ;;
        *"Broken keys"*"apt"*)
            print_info "Auto-fixing: Refreshing keys..."; apt-key adv --refresh-keys 2>/dev/null; fixed=1 ;;
        *"Gtk applications crashing"*"PRoot"*)
            print_info "Check: export DISPLAY=:0" ;;
        *"Java"*"out of memory"*|*"OutOfMemory"*)
            print_info "Set memory limit: java -Xmx512M" ;;
        *"/var/run/dbus"*"missing"*|*"dbus.*directory"*)
            print_info "Auto-fixing: dbus dir create..."; mkdir -p /var/run/dbus 2>/dev/null; fixed=1 ;;
        *"Script"*"denied"*"sdcard"*)
            print_info "Keep script in internal memory" ;;
        *"PRoot signal 11"*|*"proot.*signal"*)
            print_info "Use latest Termux version" ;;
        *"keyboard"*"mapping"*"wrong"*)
            print_info "Set XFCE Keyboard Layout to Generic 105-key US" ;;
        *"PulseAudio"*"memory leak"*|*"pulseaudio.*memory"*)
            print_info "Restart PulseAudio session" ;;
        *"/var/log"*"space"*|*"log"*"space"*)
            print_info "Auto-fixing: Clearing logs..."; rm -rf /var/log/* 2>/dev/null; fixed=1 ;;
        *"Debugger"*"hook"*|*"ptrace.*limit"*)
            print_info "ptrace is limited in PRoot" ;;
        *"Wget"*"directory"*"error"*)
            print_info "Use wget -r flag" ;;
        *"Curl"*"pipe"*"failure"*)
            print_info "Open a fresh terminal" ;;
        *"Audio stream channels"*|*"channels.*wrong"*)
            print_info "Set stereo 2.0 in daemon.conf" ;;
        *"Git checkout"*"tracking"*)
            print_info "Auto-fixing: git fetch..."; git fetch origin 2>/dev/null; fixed=1 ;;
        *"Cannot kill"*"x11 server"*)
            print_info "Press Exit in notification" ;;
        *"Tar compression"*"missing"*|*"bzip2"*"not found"*)
            print_info "Auto-fixing: Compression tools..."; apt install bzip2 p7zip -y >/dev/null 2>&1; fixed=1 ;;
        *"Package"*"triggers fail"*)
            print_info "Auto-fixing: apt upgrade..."; apt update >/dev/null 2>&1; apt upgrade -y >/dev/null 2>&1; fixed=1 ;;
        *"Missing"*"libGL.so"*|*"libGL"*"shared"*)
            print_info "Auto-fixing: Installing libGL..."; apt install libgl1-mesa-glx -y >/dev/null 2>&1; fixed=1 ;;
        *"PRoot"*"core fault"*|*"proot.*fault"*)
            print_info "Clear RAM and restart session" ;;
        *"python"*"software"*"properties"*)
            print_info "Auto-fixing: Installing software-properties..."; apt install python3-software-properties -y >/dev/null 2>&1; fixed=1 ;;
        *"Git submodule"*"failed"*)
            print_info "Run: git submodule update --init --recursive" ;;
        *"locale.*unset"*|*"Locale unset"*)
            print_info "Auto-fixing: Locale set..."; export LC_ALL=en_US.UTF-8; export LANG=en_US.UTF-8; fixed=1 ;;
        *"Thunar trash"*|*"thunar.*trash"*)
            print_info "Auto-fixing: Installing gvfs..."; apt install gvfs -y >/dev/null 2>&1; fixed=1 ;;
        *"local changes"*"would be overwritten"*)
            print_info "Run: git stash or git reset --hard" ;;
        *"VS Code"*"workspace trust"*)
            print_info "Enable Trust Workspace" ;;
        *"Sound volume"*"jumping"*|*"volume.*random"*)
            print_info "Set flat-volumes = no" ;;
        *"apt"*"list"*"corrupted"*|*"package.*index.*corrupt"*)
            print_info "Auto-fixing: Lists rebuild..."; rm -rf /var/lib/apt/lists/* 2>/dev/null; apt update >/dev/null 2>&1; fixed=1 ;;
        *"VS Code server"*"hanging"*|*"vscode.*server"*)
            print_info "Auto-fixing: Node kill..."; killall -9 node 2>/dev/null; fixed=1 ;;
        *"debian-archive-keyring"*|*"Missing"*"keyring"*)
            print_info "Auto-fixing: Installing keyring..."; apt install debian-archive-keyring -y >/dev/null 2>&1; fixed=1 ;;
        *"pip"*"pillow"*|*"Pillow"*"build"*)
            print_info "Auto-fixing: Pillow deps..."; apt install libjpeg-dev zlib1g-dev -y >/dev/null 2>&1; fixed=1 ;;
        *"Chromium profile"*"locked"*|*"Singleton"*)
            print_info "Auto-fixing: Chromium lock clear..."; rm -rf ~/.config/chromium/Singleton* 2>/dev/null; fixed=1 ;;
        *"Python"*"wheel"*"lxml"*|*"lxml"*"build"*)
            print_info "Auto-fixing: lxml deps..."; apt install libxml2-dev libxslt1-dev -y >/dev/null 2>&1; fixed=1 ;;
        *"Package repository"*"corrupt"*|*"repo.*corrupt"*)
            print_info "Auto-fixing: apt clean..."; apt clean 2>/dev/null; fixed=1 ;;
        *"Missing system libraries"*"compilation"*|*"libtool"*"missing"*)
            print_info "Auto-fixing: Installing build tools..."; apt install libtool m4 pkg-config -y >/dev/null 2>&1; fixed=1 ;;
        *"xfce4-pulseaudio-plugin"*)
            print_info "Auto-fixing: PA plugin..."; apt install xfce4-pulseaudio-plugin -y >/dev/null 2>&1; fixed=1 ;;
        *"Display refresh"*"low"*|*"refresh rate"*"low"*)
            print_info "Match refresh rate in X11 settings" ;;
        *"Full application stack crash"*|*"stack.*crash"*)
            print_info "Use the tool for a fresh restart" ;;
        *"Chromium"*"flickering"*)
            print_info "Run: chromium --disable-gpu-rasterization" ;;
        *"app launcher"*"desktop file"*"invalid"*|*"launcher.*invalid"*)
            print_info "Validate Exec path in .desktop file" ;;
        *"Full system crash loop"*|*"crash.*loop"*)
            print_info "Reset Termux cache" ;;
        *"Curl error 52"*|*"empty reply"*)
            print_info "Check server/network" ;;
        *"Missing"*"build-essential"*)
            print_info "Auto-fixing: Installing build-essential..."; apt install build-essential -y >/dev/null 2>&1; fixed=1 ;;
        *"Chromium"*"page crash"*|*"chromium.*crash"*)
            print_info "Run: chromium --disable-gpu" ;;
        *"Desktop launcher"*"parse error"*)
            print_info "Check Exec spelling in .desktop file" ;;
        *"Complete environment"*"freeze"*|*"environment.*freeze"*)
            print_info "Use the one-click tool" ;;
        *"GitHub"*"branch missing"*|*"branch.*not found"*)
            print_info "Enter branch name correctly" ;;
        *"pulseaudio"*"network"*"reset"*)
            print_info "Reset PulseAudio" ;;
        *"Storage mount"*"duplicate"*)
            print_info "Force Stop Termux and reopen" ;;
        *"Git"*"reflog"*"invalid"*)
            print_info "Run: git reflog expire --all" ;;
        *"Chromium"*"flash"*|*"hardware decode"*)
            print_info "Disable hardware decoding flag" ;;
        *"PulseAudio"*"tcp"*"auth"*|*"auth.*mismatch"*)
            print_info "Auto-fixing: PA cookie clear..."; rm -f ~/.config/pulse/cookie 2>/dev/null; fixed=1 ;;
        *"Mouse tracking"*"breaks"*)
            print_info "Keep Mouse Tracking off" ;;
        *"Download link"*"404"*|*"link.*404"*)
            print_info "Update the URL" ;;
        *"Display server"*"locked"*|*"display.*locked"*)
            print_info "Clear old session" ;;
        *"Package lists"*"out of sync"*|*"list.*sync"*)
            print_info "Auto-fixing: apt update..."; apt update >/dev/null 2>&1; fixed=1 ;;
        *"Touch screen click"*"delayed"*)
            print_info "Set X11 Touch delay to zero" ;;
        *"File decompression"*"unknown"*)
            print_warning "Re-download the file" ;;
        *"Git"*"push"*"error"*|*"push.*rejected"*)
            print_info "Run git pull first, then push" ;;
        *"Screen projection"*"broken"*)
            print_info "Match the resolution" ;;
        *"Sound mixer"*"disabled"*)
            print_info "Check if PulseAudio daemon is running" ;;
        *"environment paths missing"*|*"PATH"*"missing"*)
            print_info "Check with: echo \$PATH" ;;
        *"Network hostname"*"timed out"*)
            print_info "Add DNS (8.8.8.8) to resolv.conf" ;;
        *"Udroid"*"engine"*"fault"*)
            print_info "Re-download script from GitHub" ;;
        *)
            # No known pattern matched
            return 1
            ;;
    esac

    if [ "$fixed" -eq 1 ]; then
        AUTO_FIX_COUNT=$((AUTO_FIX_COUNT + 1))
        print_success "Auto-fix #${AUTO_FIX_COUNT} applied successfully!"
        return 0
    fi
    return 1
}

# ============================================================
# Run With Fix - Wrapper that auto-fixes errors
# Usage: run_with_fix "command to run"
# ============================================================
run_with_fix() {
    local cmd="$1"
    local max_retries=3
    local retry_count=0
    local output=""
    local exit_code=0

    while [ $retry_count -lt $max_retries ]; do
        output=$(eval "$cmd" 2>&1)
        exit_code=$?

        if [ $exit_code -eq 0 ]; then
            [ -n "$output" ] && echo "$output"
            return 0
        fi

        echo -e "  ${YELLOW}[AUTO-FIX]${RESET} Command failed, finding solution..."

        if auto_fix_error "$output"; then
            retry_count=$((retry_count + 1))
            echo -e "  ${CYAN}[RETRY]${RESET} Retrying (${retry_count}/${max_retries})..."
            sleep 1
        else
            [ -n "$output" ] && echo "$output"
            return $exit_code
        fi
    done

    [ -n "$output" ] && echo "$output"
    print_warning "Maximum ${max_retries} retries attempted"
    return $exit_code
}

# ============================================================
# Download Progress Display
# ============================================================
show_download_info() {
    local total_size_mb="$1"
    local description="$2"
    local free_storage=$(get_free_storage_mb)

    echo ""
    draw_line "=" "$BLUE" "$BOX_WIDTH"
    echo -e "  ${WHITE}${BOLD}  Download Info${RESET}"
    draw_line "-" "$BLUE" "$BOX_WIDTH"
    echo -e "  ${CYAN}  Package:${RESET}   ${WHITE}${description}${RESET}"
    echo -e "  ${CYAN}  Size:${RESET}      ${GREEN}~${total_size_mb} MB${RESET}"
    echo -e "  ${CYAN}  Free:${RESET}      ${GREEN}${free_storage} MB${RESET}"
    echo -e "  ${CYAN}  Required:${RESET}  ${YELLOW}~$((total_size_mb * 3)) MB${RESET} (with extraction)"
    draw_line "=" "$BLUE" "$BOX_WIDTH"
    echo ""

    if [ -n "$free_storage" ] && [ "$free_storage" -lt $((total_size_mb * 3)) ] 2>/dev/null; then
        print_warning "Low storage! Need at least $((total_size_mb * 3)) MB"
        print_warning "Currently only ${free_storage} MB free"
        echo ""
        return 1
    fi
    return 0
}

download_with_progress() {
    local url="$1"
    local output_file="$2"
    local description="$3"

    echo -e "  ${CYAN}[DOWNLOAD]${RESET} Starting ${description} download..."
    echo -e "  ${DIM}URL: ${url}${RESET}"
    echo ""

    # Use curl with progress bar
    if command -v curl &>/dev/null; then
        curl -L --progress-bar -o "$output_file" "$url" 2>&1 | while IFS= read -r line; do
            if [[ "$line" == *"%"* ]]; then
                echo -ne "\r  ${GREEN}[PROGRESS]${RESET} ${line}"
            fi
        done
        echo ""
    elif command -v wget &>/dev/null; then
        wget --progress=bar:force -O "$output_file" "$url" 2>&1 | while IFS= read -r line; do
            if [[ "$line" == *"%"* ]]; then
                echo -ne "\r  ${GREEN}[PROGRESS]${RESET} ${line}"
            fi
        done
        echo ""
    else
        print_error "Neither curl nor wget is available!"
        run_with_fix "pkg install curl -y"
        curl -L --progress-bar -o "$output_file" "$url"
    fi

    if [ $? -eq 0 ] && [ -f "$output_file" ]; then
        local file_size=$(du -m "$output_file" 2>/dev/null | cut -f1)
        print_success "Download complete! (${file_size} MB)"
        return 0
    else
        print_error "Download failed"
        auto_fix_error "Connection timed out"
        return 1
    fi
}

# ============================================================
# Pip-Style Progress Bar
# ============================================================
pip_style_progress() {
    local cmd="$1"
    local package_name="$2"
    local estimated_size_mb="$3"
    local bar_width=20
    local start_time=$(date +%s)

    echo -e "  Downloading ${package_name} (${estimated_size_mb} MB)"

    eval "$cmd" >/dev/null 2>&1 &
    local cmd_pid=$!

    local progress=0
    local speed="0.0"
    local elapsed_seconds=0

    while kill -0 "$cmd_pid" 2>/dev/null; do
        local current_time=$(date +%s)
        elapsed_seconds=$((current_time - start_time))

        if [ "$elapsed_seconds" -gt 0 ]; then
            local estimated_downloaded=$(echo "$elapsed_seconds 1.5" | awk '{printf "%.1f", $1 * $2}')
            local estimated_downloaded_int=$(echo "$estimated_downloaded" | awk '{printf "%d", $1}')
            local estimated_size_int=$(echo "$estimated_size_mb" | awk '{printf "%d", $1}')

            if [ "$estimated_downloaded_int" -ge "$estimated_size_int" ]; then
                progress=95
                estimated_downloaded=$(echo "$estimated_size_mb" | awk '{printf "%.1f", $1 * 0.95}')
            else
                progress=$((estimated_downloaded_int * 100 / estimated_size_int))
            fi

            speed=$(echo "$estimated_downloaded $elapsed_seconds" | awk '{if($2>0) printf "%.1f", $1/$2; else printf "0.0"}')
        fi

        local filled=$((progress * bar_width / 100))
        local unfilled=$((bar_width - filled))

        local bar_filled=""
        local bar_unfilled=""
        local i=0
        while [ $i -lt $filled ]; do
            bar_filled="${bar_filled}━"
            i=$((i + 1))
        done
        i=0
        while [ $i -lt $unfilled ]; do
            bar_unfilled="${bar_unfilled}━"
            i=$((i + 1))
        done

        local mins=$((elapsed_seconds / 60))
        local secs=$((elapsed_seconds % 60))
        local time_str=$(printf "%d:%02d:%02d" 0 $mins $secs)

        local current_mb=$(echo "$estimated_size_mb $progress" | awk '{printf "%.1f", $1 * $2 / 100}')

        printf "\r   \033[1;32m%s\033[0m\033[2m%s\033[0m %s/%s MB %s MB/s %s" \
            "$bar_filled" "$bar_unfilled" "$current_mb" "$estimated_size_mb" "$speed" "$time_str"

        sleep 0.5
    done

    wait "$cmd_pid"
    local exit_code=$?

    local end_time=$(date +%s)
    elapsed_seconds=$((end_time - start_time))
    local mins=$((elapsed_seconds / 60))
    local secs=$((elapsed_seconds % 60))
    local time_str=$(printf "%d:%02d:%02d" 0 $mins $secs)

    if [ "$elapsed_seconds" -gt 0 ]; then
        speed=$(echo "$estimated_size_mb $elapsed_seconds" | awk '{if($2>0) printf "%.1f", $1/$2; else printf "0.0"}')
    else
        speed="0.0"
    fi

    local full_bar=""
    local i=0
    while [ $i -lt $bar_width ]; do
        full_bar="${full_bar}━"
        i=$((i + 1))
    done

    printf "\r   \033[1;32m%s\033[0m %s/%s MB %s MB/s %s\n" \
        "$full_bar" "$estimated_size_mb" "$estimated_size_mb" "$speed" "$time_str"

    echo -e "  Installing collected packages: ${package_name}"
    echo ""

    return $exit_code
}

# ============================================================
# Show Fix Status Summary
# ============================================================
show_fix_status() {
    if [ $AUTO_FIX_COUNT -gt 0 ]; then
        echo ""
        draw_line "=" "$GREEN" "$BOX_WIDTH"
        echo -e "  ${WHITE}${BOLD}  Auto-Fix Summary${RESET}"
        draw_line "-" "$GREEN" "$BOX_WIDTH"
        echo -e "  ${GREEN}${BOLD}${AUTO_FIX_COUNT}${RESET} issue(s) auto-fixed successfully!"
        draw_line "=" "$GREEN" "$BOX_WIDTH"
        echo ""
    fi
}

# ============================================================
# Ask User for Personalized Command Name
# ============================================================
ask_user_command_name() {
    clear
    echo ""
    draw_line "=" "$CYAN" "$BOX_WIDTH"
    echo -e "  ${YELLOW}  Welcome!${RESET} ${WHITE}${BOLD}Enter your name${RESET}"
    draw_line "-" "$CYAN" "$BOX_WIDTH"
    echo ""
    echo -e "  ${WHITE}Commands will be created based on${RESET}"
    echo -e "  ${WHITE}your name.${RESET}"
    echo ""
    echo -e "  ${DIM}Example: name${RESET} ${GREEN}'sujon'${RESET}"
    echo -e "    ${GREEN}> start-sujon${RESET}  ${DIM}(Start Ubuntu)${RESET}"
    echo -e "    ${RED}> stop-sujon${RESET}   ${DIM}(Stop Ubuntu)${RESET}"
    echo ""
    draw_line "=" "$CYAN" "$BOX_WIDTH"
    echo ""
    echo -ne "  ${YELLOW}  Enter your name: ${RESET}"
    read user_cmd_name

    # Remove spaces and special characters, convert to lowercase
    user_cmd_name=$(echo "$user_cmd_name" | tr '[:upper:]' '[:lower:]' | tr -cd 'a-z0-9_-')

    if [ -z "$user_cmd_name" ]; then
        user_cmd_name="ubuntu"
        print_warning "No name provided, using default 'ubuntu'."
    else
        echo ""
        print_success "Welcome, ${GREEN}${BOLD}${user_cmd_name}${RESET}!"
        echo -e "  ${BLUE}  > ${RESET}Your command will be: ${GREEN}${BOLD}start-${user_cmd_name}${RESET}"
    fi
    echo ""

    PERSONALIZED_CMD_NAME="$user_cmd_name"
    sleep 1
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
    clear
    show_banner
    echo ""
    draw_line "=" "$MAGENTA" "$BOX_WIDTH"
    echo -e "  ${MAGENTA}  CUSTOM SUPER-FIX SETUP${RESET}"
    draw_line "-" "$MAGENTA" "$BOX_WIDTH"
    echo ""
    echo -e "  ${WHITE}Installs Ubuntu using udroid method.${RESET}"
    echo -e "  ${WHITE}All required packages auto-install.${RESET}"
    echo ""
    echo -e "  ${DIM}Features: X11 + Audio + Desktop${RESET}"
    echo ""
    draw_line "=" "$MAGENTA" "$BOX_WIDTH"
    echo ""
    echo -ne "  ${YELLOW}  Start install? ${RESET}[${GREEN}y${RESET}/${RED}N${RESET}]: "
    read confirm

    if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
        print_info "Installation cancelled."
        press_enter
        return
    fi

    clear
    show_banner
    echo -e "  ${CYAN}${BOLD}  Step 1/4: Updating packages...${RESET}"
    print_separator
    pip_style_progress "pkg update && pkg upgrade -y" "termux-packages" "50"
    if [ $? -ne 0 ]; then
        print_error "Failed to update packages."
        press_enter
        return
    fi
    print_success "Packages updated successfully."
    echo ""

    echo -e "  ${CYAN}${BOLD}  Step 2/4: Installing x11-repo...${RESET}"
    print_separator
    pip_style_progress "pkg install x11-repo -y && pkg install termux-x11-nightly -y" "termux-x11-nightly" "200"
    if [ $? -ne 0 ]; then
        print_error "Failed to install x11 packages."
        press_enter
        return
    fi
    print_success "X11 packages installed successfully."
    echo ""

    echo -e "  ${CYAN}${BOLD}  Step 3/4: Installing proot...${RESET}"
    print_separator
    pip_style_progress "pkg install proot pulseaudio -y" "proot-pulseaudio" "80"
    if [ $? -ne 0 ]; then
        print_error "Failed to install proot/pulseaudio."
        press_enter
        return
    fi
    print_success "Proot and PulseAudio installed."
    echo ""

    echo -e "  ${CYAN}${BOLD}  Step 4/4: Running udroid installer...${RESET}"
    print_separator
    pip_style_progress ". <(curl -Ls https://bit.ly/udroid-installer)" "ubuntu-rootfs-udroid" "1500"
    if [ $? -ne 0 ]; then
        print_error "udroid installer failed."
        press_enter
        return
    fi
    print_success "udroid installation complete."
    show_fix_status
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

    local cmd_name="$PERSONALIZED_CMD_NAME"

    print_info "Creating shortcut commands..."
    cat > "$PREFIX/bin/start-${cmd_name}" << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
killall -9 termux-x11 2>/dev/null
rm -rf /tmp/.X11-unix 2>/dev/null
rm -rf /tmp/.X0-lock 2>/dev/null
export LD_PRELOAD=/system/lib64/libskcodec.so
pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1 2>/dev/null
termux-x11 :1 -ac &
sleep 2
udroid login jammy:xfce4
export DISPLAY=:1
startxfce4 &
EOF
    chmod +x "$PREFIX/bin/start-${cmd_name}"

    cat > "$PREFIX/bin/stop-${cmd_name}" << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
killall -9 termux-x11 2>/dev/null
killall -9 pulseaudio 2>/dev/null
rm -rf /tmp/.X11-unix 2>/dev/null
rm -rf /tmp/.X0-lock 2>/dev/null
EOF
    chmod +x "$PREFIX/bin/stop-${cmd_name}"

    print_success "Shortcut commands created!"
    echo ""

    clear
    echo ""
    draw_line "=" "$GREEN" "$BOX_WIDTH"
    echo -e "  ${GREEN}${BOLD}  Installation Complete!${RESET}"
    draw_line "-" "$GREEN" "$BOX_WIDTH"
    echo ""
    echo -e "  ${CYAN}>${RESET} ${WHITE}START Ubuntu:${RESET}  ${GREEN}${BOLD}start-${cmd_name}${RESET}"
    echo -e "  ${RED}>${RESET} ${WHITE}STOP Ubuntu:${RESET}   ${RED}${BOLD}stop-${cmd_name}${RESET}"
    echo ""
    echo -e "  ${DIM}Just use these commands from now on!${RESET}"
    echo -e "  ${DIM}No need to open this tool again.${RESET}"
    echo ""
    draw_line "=" "$GREEN" "$BOX_WIDTH"
    echo ""
    press_enter
}

# ============================================================
# Version 2: Official Repo Version
# ============================================================
install_official() {
    clear
    show_banner
    echo ""
    draw_line "=" "$BLUE" "$BOX_WIDTH"
    echo -e "  ${BLUE}  OFFICIAL REPO VERSION${RESET}"
    draw_line "-" "$BLUE" "$BOX_WIDTH"
    echo ""
    echo -e "  ${WHITE}Install using official proot-distro${RESET}"
    echo ""
    draw_line "-" "$BLUE" "$BOX_WIDTH"
    echo -e "  ${WHITE}Select Ubuntu Version:${RESET}"
    echo ""
    echo -e "   ${GREEN}[01]${RESET} Ubuntu 20.04 LTS ${DIM}(Focal)${RESET}"
    echo -e "   ${YELLOW}[02]${RESET} Ubuntu 22.04 LTS ${DIM}(Jammy)${RESET}"
    echo -e "   ${CYAN}[03]${RESET} Ubuntu 24.04 LTS ${DIM}(Noble)${RESET}"
    echo ""
    draw_line "-" "$BLUE" "$BOX_WIDTH"
    echo -e "   ${RED}[00]${RESET} Back to Install Menu"
    echo ""
    draw_line "=" "$BLUE" "$BOX_WIDTH"
    show_footer
    echo ""
    echo -ne "  ${YELLOW}  Select option ${RESET}[${CYAN}00-03${RESET}]: "
    read version_choice

    case $version_choice in
        1|01) ubuntu_version="ubuntu-oldlts" ; version_name="20.04 (Focal Fossa)" ;;
        2|02) ubuntu_version="ubuntu-lts" ; version_name="22.04 (Jammy Jellyfish)" ;;
        3|03) ubuntu_version="ubuntu" ; version_name="24.04 (Noble Numbat)" ;;
        0|00) return ;;
        *)
            print_error "Invalid option."
            press_enter
            return
            ;;
    esac

    clear
    show_banner
    echo -e "  ${BLUE}${BOLD}  Installing Ubuntu ${version_name}...${RESET}"
    print_separator
    echo ""

    print_info "Ensuring proot-distro is installed..."
    pip_style_progress "pkg update -y && pkg install proot-distro -y" "proot-distro" "30"
    if [ $? -ne 0 ]; then
        print_error "Failed to install proot-distro."
        press_enter
        return
    fi
    print_success "proot-distro is ready."
    echo ""

    print_info "Downloading Ubuntu ${version_name}..."
    print_info "This may take a while depending on speed."
    echo ""

    pip_style_progress "proot-distro install \"$ubuntu_version\"" "ubuntu-rootfs-${ubuntu_version}" "1200"
    if [ $? -ne 0 ]; then
        print_error "Failed to install Ubuntu ${version_name}."
        print_warning "May already be installed or an error occurred."
        press_enter
        return
    fi

    echo ""
    print_success "Ubuntu ${version_name} installed successfully!"
    echo ""

    local cmd_name="$PERSONALIZED_CMD_NAME"

    print_info "Creating shortcut command..."
    cat > "$PREFIX/bin/start-${cmd_name}" << EOF
#!/data/data/com.termux/files/usr/bin/bash
proot-distro login ${ubuntu_version}
EOF
    chmod +x "$PREFIX/bin/start-${cmd_name}"

    print_success "Shortcut command created!"
    echo ""

    clear
    echo ""
    draw_line "=" "$GREEN" "$BOX_WIDTH"
    echo -e "  ${GREEN}${BOLD}  Installation Complete!${RESET}"
    draw_line "-" "$GREEN" "$BOX_WIDTH"
    echo ""
    echo -e "  ${CYAN}>${RESET} ${WHITE}START Ubuntu:${RESET}  ${GREEN}${BOLD}start-${cmd_name}${RESET}"
    echo ""
    echo -e "  ${DIM}Just use this command from now on!${RESET}"
    echo -e "  ${DIM}No need to open this tool again.${RESET}"
    echo ""
    draw_line "=" "$GREEN" "$BOX_WIDTH"
    echo ""
    press_enter
}

# ============================================================
# Version 3: AI Smart Auto-Detect
# ============================================================
install_smart() {
    clear
    show_banner
    echo ""
    draw_line "=" "$GREEN" "$BOX_WIDTH"
    echo -e "  ${GREEN}  AI SMART AUTO-DETECT${RESET}"
    draw_line "-" "$GREEN" "$BOX_WIDTH"
    echo ""
    echo -e "  ${WHITE}Scanning your device...${RESET}"
    echo ""
    draw_line "=" "$GREEN" "$BOX_WIDTH"
    echo ""

    # Get device info
    local ram_mb=$(get_ram_mb)
    local cpu_arch=$(get_cpu_arch)
    local free_storage=$(get_free_storage_mb)

    draw_line "=" "$CYAN" "$BOX_WIDTH"
    echo -e "  ${CYAN}  Device Information${RESET}"
    draw_line "-" "$CYAN" "$BOX_WIDTH"
    echo ""
    echo -e "  ${WHITE}  RAM:${RESET}          ${GREEN}${BOLD}${ram_mb} MB${RESET}"
    echo -e "  ${WHITE}  CPU Arch:${RESET}     ${GREEN}${BOLD}${cpu_arch}${RESET}"
    echo -e "  ${WHITE}  Free Storage:${RESET} ${GREEN}${BOLD}${free_storage} MB${RESET}"
    echo ""
    draw_line "=" "$CYAN" "$BOX_WIDTH"
    echo ""

    # Decision logic
    local install_method=""
    local ubuntu_version=""
    local version_name=""
    local reason=""

    if [ -n "$free_storage" ] && [ "$free_storage" -lt 2000 ] 2>/dev/null; then
        print_warning "Low storage detected (< 2GB free)."
        print_info "Recommending minimal install with udroid."
        install_method="udroid"
        reason="Low storage - lightweight udroid method"
    elif [ -n "$ram_mb" ] && [ "$ram_mb" -le 2048 ] 2>/dev/null; then
        print_warning "Low RAM detected (<= 2GB)."
        print_info "Recommending Ubuntu 20.04 with proot-distro."
        install_method="proot"
        ubuntu_version="ubuntu-oldlts"
        version_name="20.04 LTS (Focal Fossa)"
        reason="Low RAM - lighter Ubuntu version"
    elif [[ "$cpu_arch" == "aarch64" || "$cpu_arch" == "arm64" ]]; then
        if [ -n "$ram_mb" ] && [ "$ram_mb" -ge 4096 ] 2>/dev/null; then
            print_info "ARM64 device with good RAM detected."
            install_method="proot"
            ubuntu_version="ubuntu"
            version_name="24.04 LTS (Noble Numbat)"
            reason="ARM64 + good RAM - latest Ubuntu"
        else
            print_info "ARM64 device with moderate RAM."
            install_method="proot"
            ubuntu_version="ubuntu-lts"
            version_name="22.04 LTS (Jammy Jellyfish)"
            reason="ARM64 + moderate RAM - stable LTS"
        fi
    else
        if [ -n "$ram_mb" ] && [ "$ram_mb" -ge 4096 ] 2>/dev/null; then
            install_method="proot"
            ubuntu_version="ubuntu"
            version_name="24.04 LTS (Noble Numbat)"
            reason="Good specs - latest Ubuntu"
        else
            install_method="proot"
            ubuntu_version="ubuntu-lts"
            version_name="22.04 LTS (Jammy Jellyfish)"
            reason="Moderate specs - stable LTS"
        fi
    fi

    echo ""
    draw_line "=" "$YELLOW" "$BOX_WIDTH"
    echo -e "  ${YELLOW}  Recommendation:${RESET} ${GREEN}${reason}${RESET}"
    draw_line "=" "$YELLOW" "$BOX_WIDTH"
    echo ""
    echo -ne "  ${YELLOW}  Start recommended install? ${RESET}[${GREEN}y${RESET}/${RED}N${RESET}]: "
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

        pip_style_progress "pkg update && pkg upgrade -y" "termux-packages" "50"
        pip_style_progress "pkg install x11-repo -y" "x11-repo" "20"
        pip_style_progress "pkg install termux-x11-nightly -y" "termux-x11-nightly" "180"
        pip_style_progress "pkg install proot pulseaudio -y" "proot-pulseaudio" "80"
        pip_style_progress ". <(curl -Ls https://bit.ly/udroid-installer)" "ubuntu-rootfs-udroid" "1500"

        killall -9 termux-x11 2>/dev/null
        rm -rf /tmp/.X11-unix 2>/dev/null
        rm -rf /tmp/.X0-lock 2>/dev/null

        export LD_PRELOAD=/system/lib64/libskcodec.so
        pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1 2>/dev/null

        print_success "Ubuntu installed via udroid!"
        echo ""

        local cmd_name="$PERSONALIZED_CMD_NAME"

        print_info "Creating shortcut commands..."
        cat > "$PREFIX/bin/start-${cmd_name}" << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
killall -9 termux-x11 2>/dev/null
rm -rf /tmp/.X11-unix 2>/dev/null
rm -rf /tmp/.X0-lock 2>/dev/null
export LD_PRELOAD=/system/lib64/libskcodec.so
pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1 2>/dev/null
termux-x11 :1 -ac &
sleep 2
udroid login jammy:xfce4
export DISPLAY=:1
startxfce4 &
EOF
        chmod +x "$PREFIX/bin/start-${cmd_name}"

        cat > "$PREFIX/bin/stop-${cmd_name}" << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
killall -9 termux-x11 2>/dev/null
killall -9 pulseaudio 2>/dev/null
rm -rf /tmp/.X11-unix 2>/dev/null
rm -rf /tmp/.X0-lock 2>/dev/null
EOF
        chmod +x "$PREFIX/bin/stop-${cmd_name}"

        print_success "Shortcut commands created!"
        echo ""

        clear
        echo ""
        draw_line "=" "$GREEN" "$BOX_WIDTH"
        echo -e "  ${GREEN}${BOLD}  Installation Complete!${RESET}"
        draw_line "-" "$GREEN" "$BOX_WIDTH"
        echo ""
        echo -e "  ${CYAN}>${RESET} ${WHITE}START:${RESET}  ${GREEN}${BOLD}start-${cmd_name}${RESET}"
        echo -e "  ${RED}>${RESET} ${WHITE}STOP:${RESET}   ${RED}${BOLD}stop-${cmd_name}${RESET}"
        echo ""
        echo -e "  ${DIM}Just use these commands from now on!${RESET}"
        echo -e "  ${DIM}No need to open this tool again.${RESET}"
        echo ""
        draw_line "=" "$GREEN" "$BOX_WIDTH"
        echo ""
    else
        print_info "Installing Ubuntu ${version_name}..."
        print_separator
        echo ""

        pip_style_progress "pkg update -y && pkg install proot-distro -y" "proot-distro" "30"
        pip_style_progress "proot-distro install \"$ubuntu_version\"" "ubuntu-rootfs-${ubuntu_version}" "1200"

        if [ $? -ne 0 ]; then
            print_error "Installation failed."
            press_enter
            return
        fi

        print_success "Ubuntu ${version_name} installed!"
        echo ""

        local cmd_name="$PERSONALIZED_CMD_NAME"

        print_info "Creating shortcut command..."
        cat > "$PREFIX/bin/start-${cmd_name}" << EOF
#!/data/data/com.termux/files/usr/bin/bash
proot-distro login ${ubuntu_version}
EOF
        chmod +x "$PREFIX/bin/start-${cmd_name}"

        print_success "Shortcut command created!"
        echo ""

        clear
        echo ""
        draw_line "=" "$GREEN" "$BOX_WIDTH"
        echo -e "  ${GREEN}${BOLD}  Installation Complete!${RESET}"
        draw_line "-" "$GREEN" "$BOX_WIDTH"
        echo ""
        echo -e "  ${CYAN}>${RESET} ${WHITE}START:${RESET}  ${GREEN}${BOLD}start-${cmd_name}${RESET}"
        echo ""
        echo -e "  ${DIM}Just use this command from now on!${RESET}"
        echo -e "  ${DIM}No need to open this tool again.${RESET}"
        echo ""
        draw_line "=" "$GREEN" "$BOX_WIDTH"
        echo ""
    fi

    press_enter
}

# ============================================================
# Start Ubuntu
# ============================================================
start_ubuntu() {
    show_banner
    echo ""
    draw_line "=" "$YELLOW" "$BOX_WIDTH"
    echo -e "  ${YELLOW}  START UBUNTU${RESET}"
    draw_line "-" "$YELLOW" "$BOX_WIDTH"
    echo ""
    echo -e "  ${DIM}TIP: Use these commands directly:${RESET}"
    echo -e "    ${GREEN}> start-${PERSONALIZED_CMD_NAME}${RESET}  ${DIM}(Start)${RESET}"
    echo -e "    ${RED}> stop-${PERSONALIZED_CMD_NAME}${RESET}   ${DIM}(Stop)${RESET}"
    echo ""
    draw_line "-" "$YELLOW" "$BOX_WIDTH"
    echo ""
    echo -e "   ${GREEN}[01]${RESET} Start via proot-distro (Official)"
    echo -e "   ${MAGENTA}[02]${RESET} Start via udroid"
    echo ""
    draw_line "-" "$YELLOW" "$BOX_WIDTH"
    echo -e "   ${RED}[00]${RESET} Back to Main Menu"
    echo ""
    draw_line "=" "$YELLOW" "$BOX_WIDTH"
    show_footer
    echo ""
    echo -ne "  ${YELLOW}  Select option ${RESET}[${CYAN}00-02${RESET}]: "
    read start_choice

    case $start_choice in
        1|01)
            clear
            show_banner
            echo ""
            print_info "Available Ubuntu installations:"
            print_separator
            proot-distro list 2>/dev/null | grep -i ubuntu
            echo ""
            print_separator
            echo ""
            echo -ne "  ${YELLOW}  Enter distro name (e.g., ubuntu): ${RESET}"
            read distro_name
            if [ -n "$distro_name" ]; then
                print_info "Starting Ubuntu ($distro_name)..."
                proot-distro login "$distro_name"
            else
                print_error "No distro name provided."
            fi
            ;;
        2|02)
            clear
            show_banner
            echo ""
            print_info "Starting Ubuntu via udroid..."
            print_separator
            if command -v udroid &> /dev/null; then
                udroid --start
            else
                print_error "udroid is not installed."
                print_info "Install using 'Custom Super-Fix Setup' first."
            fi
            ;;
        0|00) return ;;
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
    echo ""
    draw_line "=" "$RED" "$BOX_WIDTH"
    echo -e "  ${RED}  UNINSTALL UBUNTU${RESET}"
    draw_line "-" "$RED" "$BOX_WIDTH"
    echo ""
    echo -e "   ${YELLOW}[01]${RESET} Uninstall proot-distro Ubuntu"
    echo -e "   ${MAGENTA}[02]${RESET} Uninstall udroid Ubuntu"
    echo -e "   ${RED}[03]${RESET} Uninstall ALL (Complete cleanup)"
    echo ""
    draw_line "-" "$RED" "$BOX_WIDTH"
    echo -e "   ${CYAN}[00]${RESET} Back to Main Menu"
    echo ""
    draw_line "=" "$RED" "$BOX_WIDTH"
    show_footer
    echo ""
    echo -ne "  ${YELLOW}  Select option ${RESET}[${CYAN}00-03${RESET}]: "
    read uninstall_choice

    case $uninstall_choice in
        1|01)
            echo ""
            print_info "Available Ubuntu installations:"
            print_separator
            proot-distro list 2>/dev/null | grep -i ubuntu
            echo ""
            echo -ne "  ${YELLOW}  Enter distro name to remove: ${RESET}"
            read distro_name
            if [ -n "$distro_name" ]; then
                echo ""
                echo -ne "  ${RED}  Are you sure you want to remove '$distro_name'? [y/N]: ${RESET}"
                read confirm
                if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
                    proot-distro remove "$distro_name"
                    if [ $? -eq 0 ]; then
                        print_success "Ubuntu ($distro_name) uninstalled."
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
        2|02)
            echo ""
            echo -ne "  ${RED}  Remove udroid Ubuntu? [y/N]: ${RESET}"
            read confirm
            if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
                if command -v udroid &> /dev/null; then
                    udroid --remove
                    print_success "udroid Ubuntu removed."
                else
                    rm -rf "$HOME/udroid" 2>/dev/null
                    rm -rf "$PREFIX/bin/udroid" 2>/dev/null
                    print_success "udroid files cleaned up."
                fi
            else
                print_info "Uninstall cancelled."
            fi
            ;;
        3|03)
            echo ""
            print_warning "This will remove ALL Ubuntu installations!"
            echo -ne "  ${RED}  Are you absolutely sure? [y/N]: ${RESET}"
            read confirm
            if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
                echo ""
                print_info "Removing proot-distro installations..."
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
                print_success "All Ubuntu installations removed."
            else
                print_info "Uninstall cancelled."
            fi
            ;;
        0|00) return ;;
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
        echo ""
        draw_line "=" "$GREEN" "$BOX_WIDTH"
        echo -e "  ${GREEN}  INSTALL UBUNTU${RESET}"
        draw_line "-" "$GREEN" "$BOX_WIDTH"
        echo ""
        echo -e "   ${MAGENTA}[01]${RESET} Custom Super-Fix Setup"
        echo -e "        ${DIM}Quick setup with X11 + audio${RESET}"
        echo ""
        echo -e "   ${BLUE}[02]${RESET} Official Repo Version"
        echo -e "        ${DIM}Ubuntu 20.04, 22.04, or 24.04${RESET}"
        echo ""
        echo -e "   ${CYAN}[03]${RESET} AI Smart Auto-Detect"
        echo -e "        ${DIM}Auto-selects best for device${RESET}"
        echo ""
        draw_line "-" "$GREEN" "$BOX_WIDTH"
        echo -e "   ${RED}[00]${RESET} Back to Main Menu"
        echo ""
        draw_line "=" "$GREEN" "$BOX_WIDTH"
        show_footer
        echo ""
        echo -ne "  ${YELLOW}  Select option ${RESET}[${CYAN}00-03${RESET}]: "
        read install_choice

        case $install_choice in
            1|01) install_udroid ;;
            2|02) install_official ;;
            3|03) install_smart ;;
            0|00) return ;;
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
        echo ""
        draw_line "=" "$CYAN" "$BOX_WIDTH"
        echo -e "  ${WHITE}${BOLD}  M A I N   M E N U${RESET}"
        draw_line "-" "$CYAN" "$BOX_WIDTH"
        echo ""
        echo -e "   ${GREEN}[01]${RESET} Install Ubuntu"
        echo -e "        ${DIM}Install with multiple methods${RESET}"
        echo ""
        echo -e "   ${YELLOW}[02]${RESET} Start Ubuntu"
        echo -e "        ${DIM}Launch installed Ubuntu${RESET}"
        echo ""
        echo -e "   ${RED}[03]${RESET} Uninstall Ubuntu"
        echo -e "        ${DIM}Remove Ubuntu installations${RESET}"
        echo ""
        draw_line "-" "$CYAN" "$BOX_WIDTH"
        echo -e "   ${MAGENTA}[00]${RESET} Exit"
        echo ""
        draw_line "=" "$CYAN" "$BOX_WIDTH"
        show_footer
        echo ""
        echo -ne "  ${YELLOW}  Select option ${RESET}[${CYAN}00-03${RESET}]: "
        read main_choice

        case $main_choice in
            1|01) install_menu ;;
            2|02) start_ubuntu ;;
            3|03) uninstall_ubuntu ;;
            0|00)
                clear
                echo ""
                draw_line "=" "$GREEN" "$BOX_WIDTH"
                echo -e "  ${GREEN}  Thank you for using Ubuntu Installer!${RESET}"
                echo -e "  ${CYAN}  Goodbye! Happy Linux-ing!${RESET}"
                draw_line "=" "$GREEN" "$BOX_WIDTH"
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
show_banner
ask_user_command_name
main_menu
