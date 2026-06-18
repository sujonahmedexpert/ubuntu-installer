#!/data/data/com.termux/files/usr/bin/bash

# ╔═══════════════════════════════════════════════════════════════╗
# ║         Termux Ubuntu Installer Tool v3.0                     ║
# ║         A beautiful menu-based Ubuntu installer               ║
# ╚═══════════════════════════════════════════════════════════════╝

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

# Terminal width detection
get_term_width() {
    local width=$(tput cols 2>/dev/null || echo 60)
    if [ "$width" -gt 62 ]; then
        echo 60
    else
        echo $((width - 2))
    fi
}

TERM_WIDTH=$(get_term_width)
BOX_WIDTH=58

# Center text helper
center_text() {
    local text="$1"
    local width="${2:-$BOX_WIDTH}"
    local text_len=${#text}
    local padding=$(( (width - text_len) / 2 ))
    if [ $padding -lt 0 ]; then padding=0; fi
    printf "%*s%s" $padding "" "$text"
}

# Draw a full-width separator line
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

# Draw box top
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

# Draw box middle separator
draw_box_mid() {
    local color="${1:-$CYAN}"
    local width="${2:-$BOX_WIDTH}"
    local line="${BOX_ML}"
    for ((i=0; i<width; i++)); do
        line="${line}${BOX_H}"
    done
    line="${line}${BOX_MR}"
    echo -e "  ${color}${line}${RESET}"
}

# Draw box content line (with padding)
draw_box_content() {
    local text="$1"
    local color="${2:-$CYAN}"
    local width="${3:-$BOX_WIDTH}"
    echo -e "  ${color}${BOX_V}${RESET} ${text}$(printf '%*s' $((width - ${#text} - 1)) '')${color}${BOX_V}${RESET}"
}

# Footer separator - shows at bottom of every page
show_footer() {
    echo ""
    echo -e "  ${DIM}${MAGENTA}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo -e "  ${DIM}${CYAN}  Ubuntu Installer v3.0${RESET}  ${DIM}${WHITE}|${RESET}  ${DIM}${GREEN}Termux${RESET}  ${DIM}${WHITE}|${RESET}  ${DIM}${YELLOW}Android/Linux${RESET}"
    echo -e "  ${DIM}${MAGENTA}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
}

# ╔═══════════════════════════════════════════════════════════════╗
# ║                     Banner Function                           ║
# ╚═══════════════════════════════════════════════════════════════╝
show_banner() {
    clear
    local username="${PERSONALIZED_CMD_NAME:-user}"
    echo ""
    echo -e "  ${RED}       ▄▄▄▄▄▄▄▄▄▄▄${RESET}        ${RED}████████${RESET} ${YELLOW}███████${RESET} ${GREEN}██████${RESET}  ${CYAN}███╗   ███╗${RESET}${MAGENTA}██╗   ██╗${RESET}${BLUE}██╗  ██╗${RESET}"
    echo -e "  ${RED}    ▄█████████████████▄${RESET}        ${RED}██${RESET}    ${YELLOW}██${RESET}      ${GREEN}██   ██${RESET} ${CYAN}████╗ ████║${RESET}${MAGENTA}██║   ██║${RESET}${BLUE}╚██╗██╔╝${RESET}"
    echo -e "  ${RED}  ▄██▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀██▄${RESET}      ${RED}██${RESET}    ${YELLOW}█████${RESET}   ${GREEN}██████${RESET}  ${CYAN}██╔████╔██║${RESET}${MAGENTA}██║   ██║${RESET}${BLUE} ╚███╔╝${RESET} "
    echo -e "  ${MAGENTA} ███   ▄▄▄▄▄▄▄▄▄▄▄   ███${RESET}     ${RED}██${RESET}    ${YELLOW}██${RESET}      ${GREEN}██   ██${RESET} ${CYAN}██║╚██╔╝██║${RESET}${MAGENTA}██║   ██║${RESET}${BLUE} ██╔██╗${RESET} "
    echo -e "  ${MAGENTA} ██  ▄██████████████▄  ██${RESET}     ${RED}██${RESET}    ${YELLOW}███████${RESET} ${GREEN}██   ██${RESET} ${CYAN}██║ ╚═╝ ██║${RESET}${MAGENTA}╚██████╔╝${RESET}${BLUE}██╔╝ ██╗${RESET}"
    echo -e "  ${MAGENTA} ██  ███████████████▀  ██${RESET}     ${RED}╚═╝${RESET}   ${YELLOW}╚══════╝${RESET}${GREEN}╚═════╝${RESET} ${CYAN}╚═╝     ╚═╝${RESET}${MAGENTA} ╚═════╝${RESET} ${BLUE}╚═╝  ╚═╝${RESET}"
    echo -e "  ${MAGENTA} ██  ▀▀██████████▀▀   ██${RESET}"
    echo -e "  ${RED} ███    ▀▀▀▀▀▀▀▀     ███${RESET}      ${CYAN}Ubuntu Installer v3.0${RESET}"
    echo -e "  ${RED}  ▀██▄             ▄██▀${RESET}        ${DIM}${WHITE}Developed for Android/Termux Users${RESET}"
    echo -e "  ${RED}    ▀█████████████████▀${RESET}"
    echo -e "  ${RED}       ▀▀▀▀▀▀▀▀▀▀▀${RESET}"
    echo ""
    echo -e "  ${CYAN}══════════════════════════════════════════════════════════════${RESET}"
    echo -e "  ${GREEN}─[${BOLD}${username}${RESET}${GREEN}@termux]─[~]${RESET}"
    echo ""
}

# ╔═══════════════════════════════════════════════════════════════╗
# ║                    Utility Functions                           ║
# ╚═══════════════════════════════════════════════════════════════╝
print_separator() {
    echo -e "  ${CYAN}══════════════════════════════════════════════════════════════${RESET}"
}

print_success() {
    echo -e "  ${GREEN}  ✅ ${BOLD}$1${RESET}"
}

print_error() {
    echo -e "  ${RED}  ❌ ${BOLD}$1${RESET}"
}

print_info() {
    echo -e "  ${CYAN}  💡 ${RESET}$1"
}

print_warning() {
    echo -e "  ${YELLOW}  ⚠️  ${BOLD}$1${RESET}"
}

press_enter() {
    show_footer
    echo ""
    echo -ne "  ${YELLOW}  ⏎  ${WHITE}Enter চাপুন চালিয়ে যেতে...${RESET}"
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

    echo -e "  ${YELLOW}[AUTO-FIX]${RESET} Error detect হয়েছে! সমাধান খোজা হচ্ছে..."

    case "$error_output" in
        *"curl: command not found"*|*"curl: not found"*)
            print_info "Auto-fixing: curl ইনস্টল করা হচ্ছে..."; pkg install curl -y >/dev/null 2>&1; fixed=1 ;;
        *"git: command not found"*|*"git: not found"*)
            print_info "Auto-fixing: git ইনস্টল করা হচ্ছে..."; pkg install git -y >/dev/null 2>&1; fixed=1 ;;
        *"proot: command not found"*|*"proot: not found"*)
            print_info "Auto-fixing: proot ইনস্টল করা হচ্ছে..."; pkg install proot -y >/dev/null 2>&1; fixed=1 ;;
        *"pulseaudio: command not found"*|*"pulseaudio: not found"*)
            print_info "Auto-fixing: pulseaudio ইনস্টল করা হচ্ছে..."; pkg install pulseaudio -y >/dev/null 2>&1; fixed=1 ;;
        *"Permission denied"*|*"permission denied"*)
            print_info "Auto-fixing: Permission ঠিক করা হচ্ছে..."; chmod +x "$0" 2>/dev/null; fixed=1 ;;
        *"Repository under maintenance"*)
            print_info "Auto-fixing: Repo পরিবর্তন করা হচ্ছে..."; termux-change-repo 2>/dev/null; fixed=1 ;;
        *"404 Not Found"*|*"404  Not Found"*)
            print_info "Auto-fixing: Mirror পরিবর্তন করা হচ্ছে..."; termux-change-repo 2>/dev/null; fixed=1 ;;
        *"Display :0 is already in use"*|*"display.*already"*)
            print_info "Auto-fixing: Display lock ক্লিয়ার..."; rm -rf /tmp/.X11-unix /tmp/.X0-lock 2>/dev/null; fixed=1 ;;
        *"termux-x11 not found"*|*"termux-x11: not found"*)
            print_info "Auto-fixing: termux-x11 ইনস্টল..."; pkg install x11-repo -y >/dev/null 2>&1 && pkg install termux-x11-nightly -y >/dev/null 2>&1; fixed=1 ;;
        *"Black Screen"*"Termux"*|*"black screen"*)
            print_info "Termux:X11 অ্যাপটি ব্যাকগ্রাউন্ডে ওপেন করুন" ;;
        *"Cannot download rootfs"*|*"download.*rootfs"*"fail"*)
            print_warning "স্টোরেজ স্পেস চেক করুন, কমপক্ষে ৫ GB খালি রাখুন" ;;
        *"Connection timed out"*|*"connection timed out"*)
            print_warning "ইন্টারনেট কানেকশন চেক করুন" ;;
        *"dpkg: error processing"*|*"dpkg error processing"*)
            print_info "Auto-fixing: dpkg কনফিগার করা হচ্ছে..."; dpkg --configure -a 2>/dev/null; fixed=1 ;;
        *"fix-broken install"*|*"--fix-broken"*)
            print_info "Auto-fixing: Broken packages ফিক্স..."; apt --fix-broken install -y >/dev/null 2>&1; fixed=1 ;;
        *"Process Killed"*|*"process killed"*|*"Killed"*)
            print_info "Developer Options > Disable child process restrictions অন করুন" ;;
        *"Sound not working"*|*"audio.*not.*work"*)
            print_info "Auto-fixing: PulseAudio চালু করা হচ্ছে..."; pulseaudio --start 2>/dev/null; fixed=1 ;;
        *"Firefox Audio"*|*"firefox.*audio"*"disabled"*)
            print_info "Firefox > about:config > media.cubeb.sandbox অফ করুন" ;;
        *"Storage not accessible"*|*"storage.*not.*accessible"*)
            print_info "Auto-fixing: Storage সেটআপ..."; termux-setup-storage 2>/dev/null; fixed=1 ;;
        *"udroid"*"not found"*|*"Command 'udroid' not found"*)
            print_info "Auto-fixing: udroid ইনস্টল..."; . <(curl -Ls https://bit.ly/udroid-installer) 2>/dev/null; fixed=1 ;;
        *"wget: command not found"*|*"wget: not found"*)
            print_info "Auto-fixing: wget ইনস্টল..."; pkg install wget -y >/dev/null 2>&1; fixed=1 ;;
        *"startxfce4: command not found"*)
            print_info "উবুন্টুর ভেতরে apt install xfce4 xfce4-goodies -y দিন" ;;
        *"gnome-session: command not found"*)
            print_info "উবুন্টুর ভেতরে apt install ubuntu-desktop -y দিন" ;;
        *"PulseAudio"*"connection refused"*|*"pulseaudio"*"refused"*)
            print_info "Auto-fixing: PulseAudio রিস্টার্ট..."; killall -9 pulseaudio 2>/dev/null; pulseaudio --start 2>/dev/null; fixed=1 ;;
        *"Nano: command not found"*|*"nano: command not found"*)
            print_info "Auto-fixing: nano ইনস্টল..."; pkg install nano -y >/dev/null 2>&1; fixed=1 ;;
        *"bzip2"*"read error"*|*"gzip"*"read error"*|*"Tar"*"read error"*)
            print_warning "ফাইল ডাউনলোড অর্ধেক হয়েছে, আবার ইনস্টল করুন" ;;
        *"Exec format error"*)
            print_error "আপনার ফোনটি ৩২-বিট, উবুন্টু শুধু ৬৪-বিট সাপোর্ট করে" ;;
        *"BadWindow"*)
            print_info "Termux:X11 অ্যাপের ক্যাশে ডেটা ক্লিয়ার করুন" ;;
        *"Unable to locate package"*)
            print_info "Auto-fixing: Package list আপডেট..."; apt update >/dev/null 2>&1; fixed=1 ;;
        *"Could not get lock"*"dpkg"*|*"dpkg/lock"*)
            print_info "Auto-fixing: Lock ফাইল রিমুভ..."; rm -f /var/lib/dpkg/lock /var/lib/dpkg/lock-frontend 2>/dev/null; fixed=1 ;;
        *"sudo: command not found"*|*"Sudo: command not found"*)
            print_info "udroid-এ রুট থাকে, sudo লাগবে না" ;;
        *"resolution too small"*|*"Screen resolution"*)
            print_info "Termux:X11 সেটিংস থেকে Resolution পরিবর্তন করুন" ;;
        *"Mouse pointer not showing"*|*"cursor.*not.*visible"*)
            print_info "Termux:X11 সেটিংসে Mouse Emulation অন করুন" ;;
        *"Keyboard not appearing"*|*"keyboard.*not.*show"*)
            print_info "Back button চাপুন বা নোটিফিকেশনে Keyboard টগল করুন" ;;
        *"System lags"*|*"very slow"*|*"too slow"*)
            print_info "ব্যাকগ্রাউন্ড অ্যাপ বন্ধ করুন এবং RAM ফ্রি করুন" ;;
        *"chromium"*"sandbox"*|*"Chromium"*"sandbox"*)
            print_info "chromium --no-sandbox দিয়ে ওপেন করুন" ;;
        *"VS Code"*"open"*|*"code"*"EACCES"*)
            print_info "code --no-sandbox --user-data-dir=~/.vscode দিন" ;;
        *"Time"*"wrong"*|*"clock"*"skew"*)
            print_info "apt install ntpdate -y && ntpdate pool.ntp.org দিন" ;;
        *"Internet not working inside"*|*"network.*unreachable"*"inside"*)
            print_info "Auto-fixing: DNS কনফিগ..."; echo "nameserver 8.8.8.8" > /etc/resolv.conf 2>/dev/null; fixed=1 ;;
        *"Cannot install APK"*|*"apk"*"android"*)
            print_info "এটি লিনাক্স, অ্যান্ড্রয়েড অ্যাপ (.apk) চলবে না" ;;
        *"Localhost prompt missing"*)
            print_info "udroid login jammy:xfce4 দিন" ;;
        *"Touch clicks not working"*)
            print_info "Termux:X11 এ touchscreen clicks অন করুন" ;;
        *"architecture"*"match"*|*"Package architecture"*)
            print_info "অফিসিয়াল GitHub APK ব্যবহার করুন" ;;
        *"Wakelock not acquired"*|*"wakelock"*)
            print_info "নোটিফিকেশন থেকে Acquire wakelock ক্লিক করুন" ;;
        *"python"*"command not found"*|*"Python"*"command not found"*)
            print_info "Auto-fixing: Python ইনস্টল..."; pkg install python -y >/dev/null 2>&1; fixed=1 ;;
        *"Fork failed"*|*"Out of memory"*|*"Cannot allocate"*)
            print_warning "RAM ফ্রি করুন, ব্যাকগ্রাউন্ড অ্যাপ বন্ধ করুন" ;;
        *"extraction stuck"*|*"Rootfs extraction stuck"*)
            print_info "চার্জে রাখুন, ১০-১৫ মিনিট লাগতে পারে" ;;
        *"Unlinking old locks"*)
            print_info "Termux Force Stop করে আবার ওপেন করুন" ;;
        *"Directory not empty"*)
            print_info "rm -rf দিয়ে ডিরেক্টরি ক্লিয়ার করুন" ;;
        *"canberra-gtk-module"*)
            print_info "Auto-fixing: canberra module ইনস্টল..."; apt install libcanberra-gtk-module -y >/dev/null 2>&1; fixed=1 ;;
        *"No such file or directory"*"setup"*)
            print_info "সঠিক ফোল্ডারে cd দিয়ে প্রবেশ করুন" ;;
        *"secondary bootstrap failed"*|*"proot error"*"bootstrap"*)
            print_info "F-Droid থেকে Termux লেটেস্ট ভার্সন ব্যবহার করুন" ;;
        *"held broken packages"*)
            print_info "Auto-fixing: Broken packages..."; apt-get check >/dev/null 2>&1; apt-get install -f -y >/dev/null 2>&1; fixed=1 ;;
        *"LD_PRELOAD cannot be preloaded"*)
            print_info "Auto-fixing: LD_PRELOAD ক্লিয়ার..."; export LD_PRELOAD=""; fixed=1 ;;
        *"display server died"*|*"termux-x11"*"died"*)
            print_info "Auto-fixing: X11 রিস্টার্ট..."; killall -9 termux-x11 2>/dev/null; fixed=1 ;;
        *"Relative symlinks not supported"*)
            print_info "এটি ওয়ার্নিং, ইগনোর করুন" ;;
        *"neofetch"*"not found"*|*"Neofetch"*"not found"*)
            print_info "Auto-fixing: neofetch ইনস্টল..."; apt install neofetch -y >/dev/null 2>&1; fixed=1 ;;
        *"Cannot install build-essential"*)
            print_info "Auto-fixing: System আপডেট..."; apt update >/dev/null 2>&1 && apt upgrade -y >/dev/null 2>&1; fixed=1 ;;
        *"Connection refused"*"127.0.0.1"*)
            print_info "PulseAudio config চেক করুন (পোর্ট 4713)" ;;
        *"VLC"*"root"*|*"vlc"*"root"*)
            print_info "Fix: sed -i 's/geteuid/getppid/g' /usr/bin/vlc" ;;
        *"No space left on device"*|*"no space left"*)
            print_warning "স্টোরেজ খালি করুন, কমপক্ষে ৩ GB ফ্রি রাখুন" ;;
        *"no installation candidate"*|*"has no installation candidate"*)
            print_info "এই প্যাকেজের অন্য ভার্সন বা PPA ট্রাই করুন" ;;
        *"GPG error"*"signatures invalid"*|*"NO_PUBKEY"*)
            print_info "Auto-fixing: GPG keys রিফ্রেশ..."; apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 2>/dev/null; fixed=1 ;;
        *"exit code 127"*)
            print_info "কমান্ড বানান চেক করুন" ;;
        *"Font missing"*|*"Broken characters"*|*"tofu"*)
            print_info "Auto-fixing: ফন্ট ইনস্টল..."; apt install fonts-noto -y >/dev/null 2>&1; fixed=1 ;;
        *"Audio crackling"*|*"audio.*crackl"*)
            print_info "PulseAudio বাফার সাইজ daemon.conf এ বড় করুন" ;;
        *"Cannot change file permissions"*)
            print_info "ফাইল ইন্টারনাল মেমোরিতে রাখুন" ;;
        *"dpkg was interrupted"*)
            print_info "Auto-fixing: dpkg configure..."; dpkg --configure -a 2>/dev/null; fixed=1 ;;
        *"Unrecognized option"*"--load"*)
            print_info "Auto-fixing: pulseaudio রি-ইনস্টল..."; pkg install pulseaudio -y >/dev/null 2>&1; fixed=1 ;;
        *"XFCE desktop black"*|*"desktop.*black"*)
            print_info "Desktop Settings এ ওয়ালপেপার সিলেক্ট করুন" ;;
        *"Package manager is locked"*|*"lock-frontend"*)
            print_info "Auto-fixing: Lock রিমুভ..."; rm -f $PREFIX/var/lib/dpkg/lock-frontend 2>/dev/null; fixed=1 ;;
        *"Network unreachable"*"PRoot"*|*"network unreachable"*)
            print_info "Private DNS বন্ধ করুন" ;;
        *"SSL certificate"*"error"*|*"ssl.*certificate"*"problem"*)
            print_info "Auto-fixing: CA certificates ইনস্টল..."; pkg install ca-certificates -y >/dev/null 2>&1; fixed=1 ;;
        *"Hostname cannot be resolved"*|*"resolve.*hostname"*)
            print_info "/etc/hosts এ 127.0.0.1 localhost যোগ করুন" ;;
        *"Failed to init X11"*|*"X11 extension"*)
            print_info "Termux-X11 লেটেস্ট ভার্সন ব্যবহার করুন" ;;
        *"LibreOffice"*"crash"*)
            print_info "apt install --reinstall libreoffice -y দিন" ;;
        *"pip"*"failed"*|*"pip.*error"*)
            print_info "apt install python3-pip -y দিন" ;;
        *"Text copying not working"*|*"clipboard"*"not"*)
            print_info "autocutsel বা xclip ইনস্টল করুন" ;;
        *"dpkg returned error code (1)"*)
            print_info "apt purge দিয়ে ভাঙা প্যাকেজ রিমুভ করুন" ;;
        *"Archive extraction failed"*|*"extraction.*fail"*)
            print_warning "ফাইল corrupt, আবার ডাউনলোড করুন" ;;
        *"Audio latency"*|*"audio.*latency"*)
            print_info "Auto-fixing: PulseAudio রিস্টার্ট..."; pulseaudio --kill 2>/dev/null; pulseaudio --start 2>/dev/null; fixed=1 ;;
        *"Cannot run xterm"*|*"xterm"*"not found"*)
            print_info "Auto-fixing: xterm ইনস্টল..."; apt install xterm -y >/dev/null 2>&1; fixed=1 ;;
        *"Git update-index failed"*)
            print_info "chmod -R 755 .git/ দিয়ে permission ফিক্স করুন" ;;
        *"Failed to start X server"*|*"X server"*"failed"*)
            print_info "Termux X11 Force Stop করে আবার মেলান" ;;
        *"Udroid update failed"*|*"udroid"*"update"*"fail"*)
            print_info "udroid -u দিয়ে আপডেট করুন" ;;
        *"cannot open display"*|*"Cannot open display"*)
            print_info "Auto-fixing: DISPLAY সেট..."; export DISPLAY=:0; fixed=1 ;;
        *"Cannot change to /root"*)
            print_info "echo \$HOME দিয়ে হোম ডিরেক্টরি চেক করুন" ;;
        *"vim"*"command not found"*|*"Vim"*"not found"*)
            print_info "Auto-fixing: vim ইনস্টল..."; apt install vim -y >/dev/null 2>&1; fixed=1 ;;
        *"Audio not on boot"*|*"audio.*boot"*)
            print_info "~/.bashrc তে pulseaudio --start যোগ করুন" ;;
        *"Missing shared library"*|*"shared library"*"not found"*)
            print_info "Auto-fixing: build-essential ইনস্টল..."; apt install build-essential -y >/dev/null 2>&1; fixed=1 ;;
        *"100% CPU"*|*"cpu.*100"*)
            print_info "htop দিয়ে প্রসেস খুজে kill করুন" ;;
        *"Touchpad scrolling"*|*"scroll.*inverse"*)
            print_info "Settings > Reverse Scrolling অন করুন" ;;
        *"Node.js"*"error"*|*"node"*"install"*"error"*)
            print_info "NodeSource PPA ব্যবহার করুন" ;;
        *"System settings not opening"*|*"xfce4-settings"*"error"*)
            print_info "Auto-fixing: XFCE settings ইনস্টল..."; apt install xfce4-settings -y >/dev/null 2>&1; fixed=1 ;;
        *"Cleaning tools"*"delete"*)
            print_warning "রুটে ক্লিনিং টুল চালাবেন না!" ;;
        *"App icon missing"*|*"icon.*missing"*)
            print_info "Auto-fixing: gnome-menus ইনস্টল..."; apt install gnome-menus -y >/dev/null 2>&1; fixed=1 ;;
        *"Zip"*"error"*|*"Unzip"*"error"*|*"unzip"*"not found"*)
            print_info "Auto-fixing: zip/unzip ইনস্টল..."; apt install zip unzip -y >/dev/null 2>&1; fixed=1 ;;
        *"Cannot amtimes"*|*"Tar"*"amtimes"*)
            print_info "Internal storage এ extract করুন" ;;
        *"Sound device not detected"*)
            print_info "pavucontrol ইনস্টল করুন" ;;
        *"Ubuntu system frozen"*|*"system.*frozen"*)
            print_info "exit দিয়ে বের হয়ে ফ্রেশ রিস্টার্ট দিন" ;;
        *"SSL certificate expired"*)
            print_info "Auto-fixing: CA update..."; pkg update ca-certificates -y >/dev/null 2>&1; fixed=1 ;;
        *"Pkg script error code 1"*|*"pkg"*"error code 1"*)
            print_info "Auto-fixing: apt clean..."; apt clean 2>/dev/null; fixed=1 ;;
        *"Touch controls freezing"*|*"touch.*freez"*)
            print_info "ফোন লক/আনলক করুন" ;;
        *"GCC not compiling"*|*"gcc"*"not found"*)
            print_info "Auto-fixing: GCC ইনস্টল..."; apt install gcc g++ -y >/dev/null 2>&1; fixed=1 ;;
        *"Git push permission"*|*"git.*push.*denied"*)
            print_info "Personal Access Token (PAT) ব্যবহার করুন" ;;
        *"Bashrc not working"*|*"bashrc.*error"*)
            print_info "source ~/.bashrc দিন" ;;
        *"VS Code extension error"*|*"extension"*"crash"*)
            print_info "rm -rf ~/.vscode/extensions দিয়ে ক্যাশে ডিলিট করুন" ;;
        *"PulseAudio tcp module"*|*"tcp module failed"*)
            print_info "পোর্ট 4713 ফ্রি আছে কিনা চেক করুন" ;;
        *"Cannot load theme"*|*"theme"*"not found"*)
            print_info "Auto-fixing: lxappearance ইনস্টল..."; apt install lxappearance -y >/dev/null 2>&1; fixed=1 ;;
        *"libX11"*"crash"*|*"libX11"*"error"*)
            print_info "Auto-fixing: libx11-dev ইনস্টল..."; apt install libx11-dev -y >/dev/null 2>&1; fixed=1 ;;
        *"Udroid rootfs null"*|*"rootfs.*null"*)
            print_info "ফ্রেশ ইনস্টল দিন" ;;
        *"Sudoers file corrupted"*|*"sudoers"*"error"*)
            print_info "pkexec ব্যবহার করুন বা sudo ছাড়া কমান্ড দিন" ;;
        *"hash sum mismatch"*|*"Hash Sum mismatch"*)
            print_info "Auto-fixing: Hash fix..."; apt-get update -o Acquire::CompressionTypes::Order::=gz >/dev/null 2>&1; fixed=1 ;;
        *"Snapd not working"*|*"snap"*"not.*work"*)
            print_info "PRoot এ Snap চলে না, apt/AppImage ব্যবহার করুন" ;;
        *"Flatpak error"*|*"flatpak"*"fail"*)
            print_info "AppImage বা apt ব্যবহার করুন" ;;
        *"clang"*"not found"*|*"Clang error"*)
            print_info "Auto-fixing: clang ইনস্টল..."; apt install clang -y >/dev/null 2>&1; fixed=1 ;;
        *"Brightness not changing"*)
            print_info "PRoot এ হার্ডওয়্যার কন্ট্রোল সম্ভব না" ;;
        *"Cannot install Wine"*|*"wine"*"error"*)
            print_info "apt install wine64 -y ট্রাই করুন" ;;
        *"Cannot read storage"*|*"storage"*"denied"*)
            print_info "Auto-fixing: Storage সেটআপ..."; termux-setup-storage 2>/dev/null; fixed=1 ;;
        *"Bluetooth not connecting"*|*"bluetooth"*"error"*)
            print_info "Termux ব্লুটুথ এক্সেস করতে পারে না" ;;
        *"Tar"*"error code 2"*|*"tar"*"code 2"*)
            print_warning "আবার ট্রাই করুন" ;;
        *"Direct rendering disabled"*|*"direct render"*)
            print_info "PRoot এ GPU acceleration সীমিত" ;;
        *"Cannot download git repo"*|*"git clone"*"fail"*)
            print_info "URL/লিংক বানান চেক করুন" ;;
        *"python"*"sqlite3"*"missing"*)
            print_info "apt install python3-sqlite3 -y দিন" ;;
        *"Display settings greyed"*)
            print_info "Termux X11 সেটিংস থেকে করুন" ;;
        *"Nano cursor not moving"*|*"nano.*cursor"*)
            print_info "Alt+M দিয়ে Mouse tracking টগল করুন" ;;
        *"Firefox crashes"*|*"firefox.*crash"*)
            print_info "ট্যাব কম রাখুন এবং মেমোরি ফ্রি করুন" ;;
        *"GDM"*"crash"*|*"LightDM"*"crash"*)
            print_info "startxfce4 সরাসরি দিন, Display Manager লাগবে না" ;;
        *"Cannot open Thunar"*|*"thunar"*"not found"*)
            print_info "Auto-fixing: Thunar ইনস্টল..."; apt install thunar -y >/dev/null 2>&1; fixed=1 ;;
        *"Htop shows fake"*|*"htop"*"cores"*)
            print_info "এটি স্বাভাবিক PRoot আচরণ" ;;
        *"Curl error 7"*|*"curl"*"error 7"*)
            print_warning "ইন্টারনেট চেক করুন" ;;
        *"bash option error"*|*"bash"*"not sh"*)
            print_info "bash দিয়ে রান করুন, sh নয়" ;;
        *"Environment variables cleared"*)
            print_info ".bashrc তে export দিয়ে ভেরিয়েবল স্থায়ী করুন" ;;
        *"Extracted rootfs deleted"*)
            print_info "আবার ইনস্টল দিন" ;;
        *"Synaptic"*"crash"*)
            print_info "apt কমান্ড ব্যবহার করুন" ;;
        *"git"*"template missing"*)
            print_info "Auto-fixing: git-lfs ইনস্টল..."; pkg install git-lfs -y >/dev/null 2>&1; fixed=1 ;;
        *"Sound only on speaker"*)
            print_info "pulseaudio -k && pulseaudio --start দিন" ;;
        *"Screen tearing"*)
            print_info "XFCE Compositor VSync অন করুন" ;;
        *"libskcodec"*)
            find /system -name "libskcodec.so" 2>/dev/null; fixed=0 ;;
        *"DNS failing"*|*"dns.*fail"*)
            print_info "Auto-fixing: DNS ফিক্স..."; echo "nameserver 8.8.8.8" > /etc/resolv.conf 2>/dev/null; fixed=1 ;;
        *"syntax error near unexpected token"*|*"unexpected token"*)
            print_info "dos2unix দিয়ে ফাইল ফিক্স করুন" ;;
        *"Cannot install htop"*|*"htop"*"not found"*)
            print_info "Auto-fixing: htop ইনস্টল..."; apt install htop -y >/dev/null 2>&1; fixed=1 ;;
        *"XFCE panel disappeared"*|*"panel.*disappear"*)
            print_info "xfce4-panel --restart দিন" ;;
        *"Linux fonts ugly"*|*"fonts.*ugly"*)
            print_info "Auto-fixing: fonts ইনস্টল..."; apt install fonts-liberation -y >/dev/null 2>&1; fixed=1 ;;
        *"Package configuration unresolved"*|*"configure.*pending"*)
            print_info "Auto-fixing: dpkg configure..."; dpkg --configure -a 2>/dev/null; fixed=1 ;;
        *"Git merge conflict"*|*"merge.*conflict"*)
            print_info "git reset --hard origin/main দিন" ;;
        *"Sed pattern error"*|*"sed.*error"*)
            print_info "স্ল্যাশ/কোটেশন এস্কেপ চেক করুন" ;;
        *"preference not opening"*|*"X11.*preference"*)
            print_info "App info থেকে Termux:X11 সেটিংস অ্যাক্সেস করুন" ;;
        *"Desktop shortcut fails"*|*"shortcut.*fail"*)
            print_info "Allow executing file অন করুন" ;;
        *"PulseAudio auth keys"*|*"pulse.*cookie"*)
            print_info "Auto-fixing: cookie রিমুভ..."; rm -f ~/.config/pulse/cookie 2>/dev/null; fixed=1 ;;
        *"Out of disk space during upgrade"*|*"disk space"*"upgrade"*)
            print_warning "২-৩ GB স্টোরেজ খালি করুন" ;;
        *"Window manager broken"*|*"xfwm4"*"crash"*)
            print_info "xfwm4 --replace & দিন" ;;
        *"apps not seeing internet"*|*"Linux.*no.*internet"*)
            print_info "VPN অফ করুন" ;;
        *"Touch registers as right click"*)
            print_info "মাউস সেটিংস চেঞ্জ করুন" ;;
        *"Udroid engine corrupt"*|*"udroid.*corrupt"*)
            print_info "GitHub থেকে টুল পুনরায় ক্লোন করুন" ;;
        *"Apt lock file exists"*|*"apt.*lock.*exists"*)
            print_info "Auto-fixing: lock রিমুভ..."; rm -f /var/lib/apt/lists/lock 2>/dev/null; fixed=1 ;;
        *"Gedit"*"save"*|*"gedit.*permission"*)
            print_info "ফাইল ownership চেক করুন" ;;
        *"Local config permissions"*|*"config.*permission"*)
            print_info "Auto-fixing: permissions ফিক্স..."; chown -R root:root ~/.config 2>/dev/null; fixed=1 ;;
        *"Chromium sandbox crashed"*)
            print_info "chromium --no-sandbox --disable-gpu দিন" ;;
        *"Bash history not saving"*)
            print_info "ডিস্ক ফ্রি স্পেস চেক করুন" ;;
        *"Termux plugin error"*|*"plugin.*signature"*)
            print_info "একই সোর্স (F-Droid/GitHub) থেকে সব অ্যাপ নামান" ;;
        *"SSH connection refused"*|*"ssh.*refused"*)
            print_info "apt install openssh-server -y দিন" ;;
        *"python"*"setuptools"*"missing"*)
            print_info "Auto-fixing: setuptools ইনস্টল..."; apt install python3-setuptools -y >/dev/null 2>&1; fixed=1 ;;
        *"Audio lagging"*|*"audio.*lag"*)
            print_info "Auto-fixing: PulseAudio refresh..."; pulseaudio --kill 2>/dev/null; pulseaudio --start 2>/dev/null; fixed=1 ;;
        *"Display scale blurry"*)
            print_info "Scaling mode Center/Fit করুন" ;;
        *"Script stops at 99"*|*"stuck.*99"*)
            print_info "অপেক্ষা করুন, ৫-১০ মিনিট লাগতে পারে" ;;
        *"Apt key expired"*|*"apt-key.*expired"*)
            print_info "Auto-fixing: keys refresh..."; apt-key adv --refresh-keys 2>/dev/null; fixed=1 ;;
        *"Terminal title bar corrupted"*)
            print_info "উইন্ডো রিসাইজ করুন" ;;
        *"Gtk theme errors"*|*"Gtk-WARNING"*|*"Gtk-CRITICAL"*)
            print_info "কসমেটিক ওয়ার্নিং, ইগনোর করুন" ;;
        *"XFCE power manager"*|*"power manager"*"warning"*)
            print_info "PRoot এ এটি স্বাভাবিক" ;;
        *"Cannot run java"*|*"java"*"not found"*)
            print_info "Auto-fixing: Java ইনস্টল..."; apt install default-jre -y >/dev/null 2>&1; fixed=1 ;;
        *"VSCode blank screen"*|*"vscode.*blank"*)
            print_info "code --disable-gpu দিন" ;;
        *"/tmp permissions"*|*"tmp.*permission"*)
            print_info "Auto-fixing: /tmp permissions..."; chmod 1777 /tmp 2>/dev/null; fixed=1 ;;
        *"Software center not working"*)
            print_info "apt কমান্ড ব্যবহার করুন" ;;
        *"Cannot make script executable"*)
            print_info "টার্মাক্সের হোম ডিরেক্টরিতে রাখুন" ;;
        *"Download stops 0B"*|*"download.*0B"*|*"0 B/s"*)
            print_info "VPN অফ করুন, ডাটা টগল করুন" ;;
        *"Broken pipe"*|*"broken pipe"*)
            print_info "স্ক্রিপ্ট রি-রান করুন" ;;
        *"Keyboard shortcut not working"*)
            print_info "XFCE > Keyboard > Application Shortcuts এ বাইন্ড করুন" ;;
        *"PulseAudio high CPU"*|*"pulseaudio.*cpu"*)
            print_info "daemon.conf এ real-time-scheduling=no করুন" ;;
        *"System logs filling"*|*"/var/log"*"full"*)
            print_info "Auto-fixing: logs ক্লিয়ার..."; rm -rf /var/log/* 2>/dev/null; fixed=1 ;;
        *"GDB"*"crash"*|*"gdb"*"ptrace"*)
            print_info "PRoot এ ptrace সীমিত" ;;
        *"wget URL error"*|*"wget.*url.*error"*)
            print_info "URL ডাবল কোটেশনে দিন" ;;
        *"Curl error 23"*|*"curl.*error 23"*)
            print_info "সেশন রিস্টার্ট দিন" ;;
        *"Browser audio missing"*)
            print_info "অডিও আউটপুট Default সেট করুন" ;;
        *"Custom theme fonts not loading"*|*"font.*cache"*"error"*)
            print_info "fc-cache -f -v দিন" ;;
        *"Git detached HEAD"*|*"detached HEAD"*)
            print_info "git checkout main দিন" ;;
        *"Cannot kill termux-x11"*)
            print_info "Force Stop করুন" ;;
        *"System info utility error"*|*"coreutils"*"error"*)
            print_info "Auto-fixing: coreutils ইনস্টল..."; apt install coreutils -y >/dev/null 2>&1; fixed=1 ;;
        *"Archive utility missing"*|*"7z"*"not found"*)
            print_info "Auto-fixing: p7zip ইনস্টল..."; apt install p7zip-full -y >/dev/null 2>&1; fixed=1 ;;
        *"Cannot install build dependencies"*|*"deb-src"*)
            print_info "sources.list এ deb-src আনকমেন্ট করুন" ;;
        *"Mouse scroll too fast"*)
            print_info "মাউস সেটিংসে স্পিড কমান" ;;
        *"Taskbar items disappeared"*)
            print_info "Panel Preferences > Items থেকে রি-অ্যাড করুন" ;;
        *"Sound muted"*|*"audio.*muted"*)
            print_info "pavucontrol দিয়ে আনমিউট করুন" ;;
        *"Missing libgl"*|*"libGL"*"not found"*|*"libgl.so"*)
            print_info "Auto-fixing: mesa-glx ইনস্টল..."; apt install libgl1-mesa-glx -y >/dev/null 2>&1; fixed=1 ;;
        *"Custom font broke"*|*"termux.*font"*)
            print_info ".termux/font.ttf ডিলিট করুন" ;;
        *"Screen update slow"*|*"display.*slow"*)
            print_info "Connection Type পরিবর্তন করুন" ;;
        *"PRoot info dump"*|*"proot.*dump"*)
            print_info "RAM ক্লিয়ার করে সেশন রিস্টার্ট দিন" ;;
        *"Repository public key missing"*|*"public key"*"missing"*)
            print_info "সাইনিং কি ইমপোর্ট করুন" ;;
        *"software-properties-common"*"missing"*|*"add-apt-repository"*"not found"*)
            print_info "Auto-fixing: software-properties ইনস্টল..."; apt install software-properties-common -y >/dev/null 2>&1; fixed=1 ;;
        *"Everything crashed"*|*"completely broken"*)
            print_info "টার্মাক্স ডেটা ক্লিয়ার করে টুল আবার রান করুন" ;;
        *"Apt-get command not found"*|*"apt-get"*"not found"*)
            print_info "apt-get এর বদলে apt ব্যবহার করুন" ;;
        *"Cannot find manual pages"*|*"man"*"not found"*)
            print_info "Auto-fixing: man-db ইনস্টল..."; apt install man-db -y >/dev/null 2>&1; fixed=1 ;;
        *"Tar"*"failure status"*)
            print_warning "স্টোরেজ শেষ হয়ে থাকতে পারে" ;;
        *"Gtk critical"*"source ID"*|*"GLib-CRITICAL"*)
            print_info "নন-ফ্যাটাল error, উপেক্ষা করুন" ;;
        *"Nano syntax coloring"*|*"nano.*syntax"*)
            print_info "/etc/nanorc এ include আনকমেন্ট করুন" ;;
        *"PulseAudio state files"*|*"pulse.*state.*corrupt"*)
            print_info "Auto-fixing: pulse state ক্লিয়ার..."; rm -rf ~/.config/pulse 2>/dev/null; fixed=1 ;;
        *"alpine"*"apk"*|*"apk update"*"error"*)
            print_info "Alpine-based system এ apk update দিন" ;;
        *"Bash command completion"*|*"bash-completion"*"missing"*)
            print_info "Auto-fixing: bash-completion ইনস্টল..."; apt install bash-completion -y >/dev/null 2>&1; fixed=1 ;;
        *"/dev/shm missing"*|*"dev/shm"*"not"*)
            print_info "PRoot এ /dev/shm মাউন্ট থাকে না, স্বাভাবিক" ;;
        *"Host is down"*|*"host.*down"*)
            print_warning "নেটওয়ার্ক চেক করুন" ;;
        *"Locales"*"error"*|*"locale.*error"*|*"locale-gen"*)
            print_info "Auto-fixing: Locales কনফিগ..."; apt install locales -y >/dev/null 2>&1; locale-gen en_US.UTF-8 2>/dev/null; fixed=1 ;;
        *"Cannot open display :1"*)
            print_info "export DISPLAY=:0 দিন" ;;
        *"Python module pip missing"*|*"ensurepip"*)
            print_info "Auto-fixing: pip setup..."; python3 -m ensurepip --default-pip 2>/dev/null; fixed=1 ;;
        *"Cannot compile C++17"*)
            print_info "g++ latest version এ আপডেট করুন" ;;
        *"Git push asks username"*|*"credential"*"every time"*)
            print_info "git config --global credential.helper store দিন" ;;
        *"Cannot run visual studio server"*|*"code-server"*"error"*)
            print_info "code-server --auth none দিন" ;;
        *"Thunar volume manager"*|*"thunar-volman"*)
            print_info "Auto-fixing: thunar-volman ইনস্টল..."; apt install thunar-volman -y >/dev/null 2>&1; fixed=1 ;;
        *"Custom alias"*"disappearing"*)
            print_info "~/.bashrc তে স্থায়ীভাবে alias লিখুন" ;;
        *"Broken simlinks"*"/bin"*|*"broken symlink"*)
            print_info "Auto-fixing: termux-exec ইনস্টল..."; pkg install termux-exec -y >/dev/null 2>&1; fixed=1 ;;
        *"Missing libxcb"*|*"libxcb"*"not found"*)
            print_info "Auto-fixing: libxcb ইনস্টল..."; apt install libxcb1-dev -y >/dev/null 2>&1; fixed=1 ;;
        *"Android package"*"inside proot"*)
            print_info "লিনাক্সে Android APK ইনস্টল হয় না" ;;
        *"Cannot build wheels"*"cryptography"*)
            print_info "Auto-fixing: crypto deps ইনস্টল..."; apt install libssl-dev libffi-dev python3-dev -y >/dev/null 2>&1; fixed=1 ;;
        *"XFCE desktop icon overlapping"*)
            print_info "Right click > Arrange Desktop Icons দিন" ;;
        *"Sed"*"can't read"*"resolv"*)
            print_info "touch /etc/resolv.conf দিয়ে ফাইল তৈরি করুন" ;;
        *"Wget error 403"*|*"wget.*403"*|*"403 Forbidden"*)
            print_info "URL token expired, নতুন লিংক নিন" ;;
        *"Proot-distro"*"error"*|*"proot-distro"*"command"*"not"*)
            print_info "Auto-fixing: proot-distro ইনস্টল..."; pkg install proot-distro -y >/dev/null 2>&1; fixed=1 ;;
        *"Audio stream stuttering"*|*"audio.*stutter"*)
            print_info "ডিস্ক অপারেশন শেষ পর্যন্ত অপেক্ষা করুন" ;;
        *"Pip install permission denied"*|*"pip.*permission"*)
            print_info "pip install --user [package] ব্যবহার করুন" ;;
        *"Input/output error"*|*"I/O error"*)
            print_warning "ফোন রিবুট দিন" ;;
        *"Gnome terminal"*"factory"*)
            print_info "dbus-launch gnome-terminal দিন" ;;
        *"Display settings change crash"*)
            print_info "X11 সেটিংস থেকে resolution লক করুন" ;;
        *"module-native-protocol-tcp"*"load failed"*)
            print_info "PulseAudio config বানান চেক করুন" ;;
        *"Gedit"*"/storage"*)
            print_info "termux-setup-storage চেক করুন" ;;
        *"Git clone"*"already exists"*|*"destination path"*"already exists"*)
            print_info "rm -rf [folder] দিয়ে পুরনো ডেটা মুছুন" ;;
        *"Package 'code' has no installation candidate"*)
            print_info "Microsoft official Linux repo যোগ করুন" ;;
        *"node-gyp"*"error"*|*"node-gyp"*"fail"*)
            print_info "Auto-fixing: node-gyp deps..."; apt install make python3 g++ -y >/dev/null 2>&1; fixed=1 ;;
        *"Sound pitch"*"high"*)
            print_info "daemon.conf এ default-sample-rate = 44100 করুন" ;;
        *"wallpaper"*"stretch"*)
            print_info "Wallpaper Style > Scaled/Zoomed সিলেক্ট করুন" ;;
        *"Dynamic linker error"*|*"dynamic link"*"error"*)
            print_info "Auto-fixing: pkg upgrade..."; pkg upgrade >/dev/null 2>&1; fixed=1 ;;
        *"D-Bus"*"warning"*"xfce"*|*"dbus"*"error"*"xfce"*)
            print_info "Auto-fixing: dbus-x11 ইনস্টল..."; apt install dbus-x11 -y >/dev/null 2>&1; fixed=1 ;;
        *"Firefox"*"secure connection"*|*"firefox.*ssl"*)
            print_info "উবুন্টুর Time ও Date ফিক্স করুন" ;;
        *"sshd"*"missing"*|*"sshd"*"not found"*)
            print_info "Auto-fixing: openssh ইনস্টল..."; apt install openssh-server -y >/dev/null 2>&1; fixed=1 ;;
        *"X11 forwarding"*"display"*)
            print_info "export DISPLAY=localhost:0.0 দিন" ;;
        *"architecture aarch64 mismatch"*|*"wrong.*architecture"*)
            print_info "ভুল architecture ইমেজ ডাউনলোড হয়েছে" ;;
        *"Custom fonts cache"*|*"fc-cache"*"error"*)
            print_info "Auto-fixing: font cache rebuild..."; fc-cache -r 2>/dev/null; fixed=1 ;;
        *"Nano"*"parse configuration"*|*"nanorc"*"error"*)
            print_info "~/.nanorc ফাইল এডিট/ডিলিট করুন" ;;
        *"Package manager"*"loop"*|*"configure.*loop"*)
            print_info "Auto-fixing: dpkg configure..."; dpkg --configure -a 2>/dev/null; fixed=1 ;;
        *"Chromium"*"sandbox error"*"PRoot"*)
            print_info "--no-sandbox ফ্ল্যাগ দিন" ;;
        *"Cannot run bash script via sh"*)
            print_info "bash [script] দিয়ে রান দিন" ;;
        *"Android UI freezing"*"termux-x11"*)
            print_info "Game Turbo/Battery Saver অফ করুন" ;;
        *"Pulseaudio daemon already running"*)
            print_info "Auto-fixing: PA restart..."; pulseaudio -k 2>/dev/null; pulseaudio --start 2>/dev/null; fixed=1 ;;
        *"Touch interaction delay"*)
            print_info "X11 Settings > Input latency কমান" ;;
        *"Rootfs"*"checksum mismatch"*)
            print_warning "ডাউনলোড incomplete, আবার নামান" ;;
        *"Apt-key"*"deprecated"*)
            print_info "/etc/apt/trusted.gpg.d/ এ keys রাখুন" ;;
        *"Vim color schemes"*|*"vim.*colorscheme"*)
            print_info "Auto-fixing: vim-runtime..."; apt install vim-runtime -y >/dev/null 2>&1; fixed=1 ;;
        *"Git default branch"*)
            print_info "git config --global init.defaultBranch main" ;;
        *"Missing libsecret"*|*"libsecret"*"not found"*)
            print_info "Auto-fixing: libsecret ইনস্টল..."; apt install libsecret-1-0 -y >/dev/null 2>&1; fixed=1 ;;
        *"Audio"*"HDMI"*)
            print_info "HDMI/Bluetooth audio সেটিংস চেঞ্জ করুন" ;;
        *"Cannot install snapcraft"*)
            print_info "Snap চলে না, apt ব্যবহার করুন" ;;
        *"Screen casting black"*)
            print_info "Display mirroring অ্যাপ ব্যবহার করুন" ;;
        *"ping"*"not found"*|*"ping"*"command not found"*)
            print_info "Auto-fixing: iputils-ping ইনস্টল..."; apt install iputils-ping -y >/dev/null 2>&1; fixed=1 ;;
        *"netstat"*"not found"*|*"Cannot run netstat"*)
            print_info "Auto-fixing: net-tools ইনস্টল..."; apt install net-tools -y >/dev/null 2>&1; fixed=1 ;;
        *"XFCE"*"panel item lock"*)
            print_info "Panel Settings > Lock Panel আনচেক করুন" ;;
        *"Tar"*"Cannot write"*"No space"*)
            print_warning "মিনিমাম ১০ GB ফ্রি স্পেস রাখুন" ;;
        *"Dpkg database corruption"*|*"dpkg.*database"*"corrupt"*)
            print_info "/var/lib/dpkg/backup থেকে রিস্টোর করুন" ;;
        *"python"*"dev headers"*|*"Python.h"*"not found"*)
            print_info "Auto-fixing: python3-dev ইনস্টল..."; apt install python3-dev -y >/dev/null 2>&1; fixed=1 ;;
        *"Firefox"*"widevine"*|*"DRM"*"limited"*)
            print_info "ARM এ Firefox DRM সীমিত" ;;
        *"Clipboard"*"gone"*|*"clipboard.*lost"*)
            print_info "ক্লিপবোর্ড ম্যানেজার ব্যবহার করুন" ;;
        *"Audio distortion"*"game"*)
            print_info "গেম Audio Settings থেকে buffer বাড়ান" ;;
        *"Python"*"wheel"*"fail"*|*"build wheel"*"fail"*)
            print_info "Auto-fixing: build deps..."; apt install build-essential python3-dev -y >/dev/null 2>&1; fixed=1 ;;
        *"Storage directory link broken"*)
            print_info "Auto-fixing: storage re-setup..."; termux-setup-storage 2>/dev/null; fixed=1 ;;
        *"Cannot run vscode as root"*)
            print_info "code --user-data-dir='~/.vscode' --no-sandbox দিন" ;;
        *"Dbus service"*"failed"*)
            print_info "dbus-launch দিয়ে সেশন স্টার্ট করুন" ;;
        *"Proot dynamic link"*"warning"*)
            print_info "PRoot এর সাধারণ আচরণ, error নয়" ;;
        *"Wget"*"error 503"*|*"wget.*503"*)
            print_info "সার্ভার busy, পরে চেষ্টা করুন" ;;
        *"Tar"*"memory exhaustion"*)
            print_info "মেমোরি ক্লিয়ার করে ফ্রেশ সেশনে extract করুন" ;;
        *"File creation time"*|*"timezone"*"wrong"*)
            print_info "dpkg-reconfigure tzdata দিন" ;;
        *"Application menu"*"blank"*)
            print_info "অ্যাপ সম্পূর্ণ install হয়েছে কিনা চেক করুন" ;;
        *"Package configure loop"*|*"apt.*loop"*)
            print_info "Auto-fixing: apt clean+update..."; apt clean 2>/dev/null; apt update >/dev/null 2>&1; fixed=1 ;;
        *"Terminal font too small"*)
            print_info "দুই আঙুল দিয়ে pinch zoom করুন" ;;
        *"Audio stream"*"dead"*)
            print_info "টার্মাক্স রিস্টার্ট দিন ও pulseaudio --start চালান" ;;
        *"BadMatch"*"display"*)
            print_info "Termux:X11 latest GitHub release নামান" ;;
        *"double tap not working"*)
            print_info "X11 Input preference চেঞ্জ করুন" ;;
        *"ssh"*"host key verification"*|*"Host key verification failed"*)
            print_info "Auto-fixing: SSH key add..."; mkdir -p ~/.ssh; ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts 2>/dev/null; fixed=1 ;;
        *"root"*"password"*"reset"*)
            print_info "Enter চাপুন বা passwd root দিন" ;;
        *"Missing libXrender"*|*"libXrender"*"not found"*)
            print_info "Auto-fixing: libxrender ইনস্টল..."; apt install libxrender1 -y >/dev/null 2>&1; fixed=1 ;;
        *"Software property"*"failed"*)
            print_info "python3-software-properties ইনস্টল করুন" ;;
        *"Audio"*"foreground"*|*"audio.*background.*stop"*)
            print_info "টার্মাক্স ব্যাটারি অপটিমাইজেশন অফ করুন" ;;
        *"server certificate verification failed"*|*"GIT_SSL"*)
            print_info "Auto-fixing: SSL skip..."; export GIT_SSL_NO_VERIFY=true; fixed=1 ;;
        *"Cannot open display :0.0"*)
            print_info "export DISPLAY=:0 দিন" ;;
        *"Nano"*"cannot open"*"writing"*)
            print_info "ফাইল permission চেক করুন" ;;
        *"python3-pip"*|*"pip3"*"not found"*)
            print_info "Auto-fixing: pip3 ইনস্টল..."; apt install python3-pip -y >/dev/null 2>&1; fixed=1 ;;
        *"VS Code terminal"*"missing characters"*)
            print_info "VS Code Terminal Font পরিবর্তন করুন" ;;
        *"xfce4-whiskermenu"*|*"whiskermenu"*"not found"*)
            print_info "Auto-fixing: whiskermenu ইনস্টল..."; apt install xfce4-whiskermenu-plugin -y >/dev/null 2>&1; fixed=1 ;;
        *"File extraction aborted"*|*"extraction.*abort"*)
            print_info "ফোনের স্ক্রিন অন রাখুন" ;;
        *"Gtk widget warnings"*|*"GtkWidget"*"warning"*)
            print_info "কসমেটিক ইস্যু, সিস্টেম ঠিক আছে" ;;
        *"Cannot run systemctl"*|*"systemctl"*"not"*|*"systemd"*"not"*)
            print_info "PRoot এ systemctl চলে না, ম্যানুয়ালি সার্ভিস চালান" ;;
        *"Mouse pointer drifts"*)
            print_info "X11 Mouse sensitivity টিউন করুন" ;;
        *"Full system freeze"*|*"system.*freeze"*)
            print_info "Force Stop করে ফ্রেশ বুট দিন" ;;
        *"Udroid"*"login"*"directory"*)
            print_info "udroid engine রিসেট করুন" ;;
        *"Chromium core dump"*)
            print_info "--disable-namespace-sandbox ফ্ল্যাগ যোগ করুন" ;;
        *"Missing build system tools"*|*"automake"*"not found"*)
            print_info "Auto-fixing: build tools ইনস্টল..."; apt install automake autoconf libtool -y >/dev/null 2>&1; fixed=1 ;;
        *"Audio device busy"*)
            print_info "অন্য মিউজিক/গেম অ্যাপ বন্ধ করুন" ;;
        *"Firefox"*"hardware"*"error"*)
            print_info "Firefox Hardware Acceleration অফ করুন" ;;
        *"Local font"*"cache"*|*"font cache miss"*)
            print_info "Auto-fixing: font cache rebuild..."; fc-cache -f 2>/dev/null; fixed=1 ;;
        *"Bash syntax error"*"brackets"*)
            print_info "স্ক্রিপ্ট কোডিং চেক করুন" ;;
        *"X11"*"crashes"*"rotates"*|*"rotation.*crash"*)
            print_info "X11 Display Orientation লক করুন" ;;
        *"pip install"*"requirements"*)
            print_info "pip install -r requirements.txt দিন" ;;
        *"Repository mirrors dead"*)
            print_info "sources.list এডিট করে official repo বসান" ;;
        *"Storage folder"*"not updating"*)
            print_info "F5 চেপে ফাইল ম্যানেজার রিফ্রেশ করুন" ;;
        *"Libssl version mismatch"*|*"libssl.*mismatch"*)
            print_info "Auto-fixing: libssl reinstall..."; apt install --reinstall libssl-dev -y >/dev/null 2>&1; fixed=1 ;;
        *"Text selection"*"touch broken"*)
            print_info "X11 Selection mode মাউস ইমুলেশন করুন" ;;
        *"PulseAudio client protocol"*)
            print_info "PulseAudio client config ডিলিট করুন" ;;
        *"Dynamic linker cache"*"corrupt"*)
            print_info "ldconfig রান করুন রুট হিসেবে" ;;
        *"File sharing"*"Android"*"Ubuntu"*)
            print_info "~/storage/shared পাথ ব্যবহার করুন" ;;
        *"Git branch merge error"*|*"merge.*error"*)
            print_info "git merge --abort দিন" ;;
        *"node-sass"*"error"*)
            print_info "dart-sass ব্যবহার করুন" ;;
        *"XFCE panel clock"*)
            print_info "Panel Clock > Properties > Custom Format দিন" ;;
        *"Directory ownership wrong"*)
            print_info "Auto-fixing: ownership fix..."; chown -R root:root /root 2>/dev/null; fixed=1 ;;
        *"setuptools"*"old"*|*"pip.*version"*"old"*)
            print_info "Auto-fixing: pip upgrade..."; pip install --upgrade pip 2>/dev/null; fixed=1 ;;
        *"Wget certificate invalid"*)
            print_info "wget --no-check-certificate [URL] দিন" ;;
        *"Ubuntu"*"repository sync"*|*"repo.*sync"*)
            print_info "Auto-fixing: apt clean+update..."; apt clean 2>/dev/null; apt update >/dev/null 2>&1; fixed=1 ;;
        *"Audio volume"*"reset"*)
            print_info "pavucontrol দিয়ে volume ফিক্স করুন" ;;
        *"Mouse wheel"*"direction"*"wrong"*)
            print_info "Natural Scrolling টগল করুন" ;;
        *"Process stuck"*"background"*|*"process.*stuck"*)
            print_info "ps aux দিয়ে PID খুজে kill -9 PID দিন" ;;
        *"Git pull conflict"*|*"pull.*conflict"*)
            print_info "git stash && git pull দিন" ;;
        *"Display server socket"*|*"X11-unix"*"error"*)
            print_info "Auto-fixing: socket clear..."; rm -rf /tmp/.X11-unix 2>/dev/null; fixed=1 ;;
        *"Udroid"*"rootfs corrupt"*)
            print_info "সিস্টেম ডিলিট করে রি-ইনস্টল দিন" ;;
        *"Vim syntax"*"off"*)
            print_info "Vim এ :syntax on দিন" ;;
        *"pip"*"numpy"*"fail"*)
            print_info "Auto-fixing: numpy ইনস্টল..."; apt install python3-numpy -y >/dev/null 2>&1; fixed=1 ;;
        *"Audio"*"hum"*"noise"*)
            print_info "PulseAudio buffer tuning পরিবর্তন করুন" ;;
        *"Cannot start window manager"*)
            print_info "xfwm4 & দিন" ;;
        *"Storage link"*"permission denied"*)
            print_info "Settings > Apps > Termux > Permissions > File access দিন" ;;
        *"Firefox profile"*"locked"*)
            print_info "Auto-fixing: Firefox lock remove..."; rm -rf ~/.mozilla/firefox/*.default/lock 2>/dev/null; fixed=1 ;;
        *"Display output frozen"*)
            print_info "Display রিস্টার্ট করুন" ;;
        *"Touch"*"offset"*|*"click"*"wrong place"*)
            print_info "X11 Aspect Ratio Stretch থেকে Fit করুন" ;;
        *"Gtk theme icons missing"*|*"icon theme"*"missing"*)
            print_info "Auto-fixing: icon theme ইনস্টল..."; apt install gnome-icon-theme -y >/dev/null 2>&1; fixed=1 ;;
        *"Command"*"loops"*"bash"*|*"infinite.*loop"*)
            print_info "Ctrl+C চাপুন" ;;
        *"Android kills termux"*|*"termux.*killed"*)
            print_info "Battery Settings > Termux > No Restrictions দিন" ;;
        *"Curl error 35"*|*"curl.*error 35"*)
            print_info "Auto-fixing: CA update..."; pkg update ca-certificates -y >/dev/null 2>&1; fixed=1 ;;
        *"Cannot setup language"*|*"LANG"*"error"*)
            print_info "Auto-fixing: LANG set..."; export LANG=en_US.UTF-8; fixed=1 ;;
        *"Broken simlink"*"storage"*|*"storage.*symlink"*)
            print_info "Auto-fixing: storage relink..."; rm -f ~/storage 2>/dev/null; termux-setup-storage 2>/dev/null; fixed=1 ;;
        *"Thunar"*"network shares"*)
            print_info "Auto-fixing: gvfs-backends ইনস্টল..."; apt install gvfs-backends -y >/dev/null 2>&1; fixed=1 ;;
        *"Git commit identity"*|*"git.*identity"*)
            print_info "git config --global user.email ও user.name সেট করুন" ;;
        *"Chromium webgl"*|*"webgl.*context"*)
            print_info "Chromium flags এ WebGL force enable করুন" ;;
        *"Sound pitch slow"*|*"audio.*robotic"*)
            print_info "PulseAudio sample rate ফিক্স করুন" ;;
        *"System UI freeze"*"resolution"*)
            print_info "X11 অ্যাপ ক্লিয়ার করে আবার চালু করুন" ;;
        *"Repository structure invalid"*)
            print_info "Auto-fixing: apt clean+update..."; apt clean 2>/dev/null; apt update >/dev/null 2>&1; fixed=1 ;;
        *"Package configure execution"*|*"configure.*execution.*error"*)
            print_info "Auto-fixing: dpkg configure..."; dpkg --configure -a 2>/dev/null; fixed=1 ;;
        *"Ssh tunnel"*"authorization"*|*"xauth"*"error"*)
            print_info "xauth প্যাকেজ ইনস্টল করুন" ;;
        *"Archive expansion interrupted"*)
            print_info "মেমোরি ফ্রি করে আবার ট্রাই করুন" ;;
        *"Cannot change wallpaper"*"GNOME"*)
            print_info "gnome-tweaks ব্যবহার করুন" ;;
        *"XFCE whisker menu"*"broken"*)
            print_info "Whisker menu Remove করে আবার Add করুন" ;;
        *"Audio stream lost"*"phone call"*)
            print_info "ফোন কল শেষে pulseaudio restart দিন" ;;
        *"shell commands"*"loop"*|*"ubuntu.*loop"*)
            print_info "exit দিয়ে ফ্রেশ login দিন" ;;
        *"Apt lock frontend"*"active"*)
            print_info "Auto-fixing: lock remove..."; rm -f /var/lib/dpkg/lock-frontend 2>/dev/null; fixed=1 ;;
        *"Curl error 56"*|*"curl.*error 56"*)
            print_info "নেটওয়ার্ক স্টেবল রাখুন" ;;
        *"Mouse secondary click"*"menu"*)
            print_info "X11 Touch control settings চেঞ্জ করুন" ;;
        *"Missing libXft"*|*"libXft"*"not found"*)
            print_info "Auto-fixing: libxft-dev ইনস্টল..."; apt install libxft-dev -y >/dev/null 2>&1; fixed=1 ;;
        *"rootfs"*"format unknown"*)
            print_warning "ফাইল পুনরায় ডাউনলোড দিন" ;;
        *"Gtk"*"fallback theme"*|*"gtk.*fallback"*)
            print_info "থিম প্যাক ইনস্টল করুন" ;;
        *"Sound settings"*"mixer"*"missing"*|*"pulseaudio-plugin"*)
            print_info "Auto-fixing: PA plugin ইনস্টল..."; apt install xfce4-pulseaudio-plugin -y >/dev/null 2>&1; fixed=1 ;;
        *"pip"*"markup"*"safe"*|*"MarkupSafe"*"fail"*)
            print_info "Auto-fixing: setuptools upgrade..."; python3 -m pip install --upgrade setuptools 2>/dev/null; fixed=1 ;;
        *"Domain name server"*"fail"*|*"dns.*lookup.*fail"*)
            print_info "Auto-fixing: DNS add..."; echo "nameserver 1.1.1.1" >> /etc/resolv.conf 2>/dev/null; fixed=1 ;;
        *"Packages cache"*"overflow"*|*"cache.*overflow"*)
            print_info "Auto-fixing: apt clean..."; apt clean 2>/dev/null; fixed=1 ;;
        *"Pulseaudio"*"cookie"*"sync"*)
            print_info "Auto-fixing: cookie reset..."; rm -f ~/.config/pulse/cookie 2>/dev/null; pulseaudio --kill 2>/dev/null; pulseaudio --start 2>/dev/null; fixed=1 ;;
        *"Chromium"*"extensions crashed"*)
            print_info "Extension cache ডিলিট করুন" ;;
        *"GitHub"*"rate limit"*|*"API rate limit"*)
            print_info "১৫-২০ মিনিট অপেক্ষা করুন" ;;
        *"LC_ALL"*"missing"*|*"locale.*LC_ALL"*)
            print_info "Auto-fixing: LC_ALL set..."; export LC_ALL=en_US.UTF-8; fixed=1 ;;
        *"Thunar"*"loading"*"slow"*)
            print_info "Preview generation অফ করুন" ;;
        *"Git"*"rebase"*"fatal"*)
            print_info "git rebase --abort দিন" ;;
        *"Chromium"*"hardware acceleration"*|*"chromium.*accel"*)
            print_info "Hardware Acceleration অফ করুন" ;;
        *"Audio volume booster"*|*"volume.*boost"*)
            print_info "Volume 100% এর উপরে boost করবেন না" ;;
        *"Display server timeout"*|*"display.*timeout"*)
            print_info "X11 প্রসেস kill করে নতুন করে চালু করুন" ;;
        *"Curl error 28"*|*"curl.*error 28"*|*"operation timed out"*)
            print_warning "নেটওয়ার্ক স্পিড চেক করুন" ;;
        *"lxde-core"*|*"Missing"*"lxde"*)
            print_info "Auto-fixing: lxde-core ইনস্টল..."; apt install lxde-core -y >/dev/null 2>&1; fixed=1 ;;
        *"Broken keys"*"apt"*)
            print_info "Auto-fixing: keys refresh..."; apt-key adv --refresh-keys 2>/dev/null; fixed=1 ;;
        *"Gtk applications crashing"*"PRoot"*)
            print_info "export DISPLAY=:0 চেক করুন" ;;
        *"Java"*"out of memory"*|*"OutOfMemory"*)
            print_info "java -Xmx512M দিয়ে memory limit সেট করুন" ;;
        *"/var/run/dbus"*"missing"*|*"dbus.*directory"*)
            print_info "Auto-fixing: dbus dir create..."; mkdir -p /var/run/dbus 2>/dev/null; fixed=1 ;;
        *"Script"*"denied"*"sdcard"*)
            print_info "স্ক্রিপ্ট internal memory তে রাখুন" ;;
        *"PRoot signal 11"*|*"proot.*signal"*)
            print_info "Termux latest version ব্যবহার করুন" ;;
        *"keyboard"*"mapping"*"wrong"*)
            print_info "XFCE Keyboard Layout > Generic 105-key US সেট করুন" ;;
        *"PulseAudio"*"memory leak"*|*"pulseaudio.*memory"*)
            print_info "PulseAudio session restart করুন" ;;
        *"/var/log"*"space"*|*"log"*"space"*)
            print_info "Auto-fixing: logs clear..."; rm -rf /var/log/* 2>/dev/null; fixed=1 ;;
        *"Debugger"*"hook"*|*"ptrace.*limit"*)
            print_info "PRoot এ ptrace সীমিত" ;;
        *"Wget"*"directory"*"error"*)
            print_info "wget -r ফ্ল্যাগ দিন" ;;
        *"Curl"*"pipe"*"failure"*)
            print_info "ফ্রেশ terminal ওপেন করুন" ;;
        *"Audio stream channels"*|*"channels.*wrong"*)
            print_info "daemon.conf এ stereo 2.0 সেট করুন" ;;
        *"Git checkout"*"tracking"*)
            print_info "Auto-fixing: git fetch..."; git fetch origin 2>/dev/null; fixed=1 ;;
        *"Cannot kill"*"x11 server"*)
            print_info "নোটিফিকেশন থেকে Exit চাপুন" ;;
        *"Tar compression"*"missing"*|*"bzip2"*"not found"*)
            print_info "Auto-fixing: compression tools..."; apt install bzip2 p7zip -y >/dev/null 2>&1; fixed=1 ;;
        *"Package"*"triggers fail"*)
            print_info "Auto-fixing: apt upgrade..."; apt update >/dev/null 2>&1; apt upgrade -y >/dev/null 2>&1; fixed=1 ;;
        *"Missing"*"libGL.so"*|*"libGL"*"shared"*)
            print_info "Auto-fixing: libGL ইনস্টল..."; apt install libgl1-mesa-glx -y >/dev/null 2>&1; fixed=1 ;;
        *"PRoot"*"core fault"*|*"proot.*fault"*)
            print_info "RAM ক্লিয়ার করে সেশন রিস্টার্ট দিন" ;;
        *"python"*"software"*"properties"*)
            print_info "Auto-fixing: software-properties ইনস্টল..."; apt install python3-software-properties -y >/dev/null 2>&1; fixed=1 ;;
        *"Git submodule"*"failed"*)
            print_info "git submodule update --init --recursive দিন" ;;
        *"locale.*unset"*|*"Locale unset"*)
            print_info "Auto-fixing: locale set..."; export LC_ALL=en_US.UTF-8; export LANG=en_US.UTF-8; fixed=1 ;;
        *"Thunar trash"*|*"thunar.*trash"*)
            print_info "Auto-fixing: gvfs ইনস্টল..."; apt install gvfs -y >/dev/null 2>&1; fixed=1 ;;
        *"local changes"*"would be overwritten"*)
            print_info "git stash বা git reset --hard দিন" ;;
        *"VS Code"*"workspace trust"*)
            print_info "Trust Workspace অন করুন" ;;
        *"Sound volume"*"jumping"*|*"volume.*random"*)
            print_info "flat-volumes = no সেট করুন" ;;
        *"apt"*"list"*"corrupted"*|*"package.*index.*corrupt"*)
            print_info "Auto-fixing: lists rebuild..."; rm -rf /var/lib/apt/lists/* 2>/dev/null; apt update >/dev/null 2>&1; fixed=1 ;;
        *"VS Code server"*"hanging"*|*"vscode.*server"*)
            print_info "Auto-fixing: node kill..."; killall -9 node 2>/dev/null; fixed=1 ;;
        *"debian-archive-keyring"*|*"Missing"*"keyring"*)
            print_info "Auto-fixing: keyring ইনস্টল..."; apt install debian-archive-keyring -y >/dev/null 2>&1; fixed=1 ;;
        *"pip"*"pillow"*|*"Pillow"*"build"*)
            print_info "Auto-fixing: Pillow deps..."; apt install libjpeg-dev zlib1g-dev -y >/dev/null 2>&1; fixed=1 ;;
        *"Chromium profile"*"locked"*|*"Singleton"*)
            print_info "Auto-fixing: Chromium lock clear..."; rm -rf ~/.config/chromium/Singleton* 2>/dev/null; fixed=1 ;;
        *"Python"*"wheel"*"lxml"*|*"lxml"*"build"*)
            print_info "Auto-fixing: lxml deps..."; apt install libxml2-dev libxslt1-dev -y >/dev/null 2>&1; fixed=1 ;;
        *"Package repository"*"corrupt"*|*"repo.*corrupt"*)
            print_info "Auto-fixing: apt clean..."; apt clean 2>/dev/null; fixed=1 ;;
        *"Missing system libraries"*"compilation"*|*"libtool"*"missing"*)
            print_info "Auto-fixing: build tools ইনস্টল..."; apt install libtool m4 pkg-config -y >/dev/null 2>&1; fixed=1 ;;
        *"xfce4-pulseaudio-plugin"*)
            print_info "Auto-fixing: PA plugin..."; apt install xfce4-pulseaudio-plugin -y >/dev/null 2>&1; fixed=1 ;;
        *"Display refresh"*"low"*|*"refresh rate"*"low"*)
            print_info "X11 সেটিংসে refresh rate ম্যাচ করান" ;;
        *"Full application stack crash"*|*"stack.*crash"*)
            print_info "ওয়ান-ক্লিক টুল দিয়ে ফ্রেশ রিস্টার্ট নিন" ;;
        *"Chromium"*"flickering"*)
            print_info "chromium --disable-gpu-rasterization দিন" ;;
        *"app launcher"*"desktop file"*"invalid"*|*"launcher.*invalid"*)
            print_info ".desktop ফাইলের Exec path validate করুন" ;;
        *"Full system crash loop"*|*"crash.*loop"*)
            print_info "টার্মাক্স cache reset করুন" ;;
        *"Curl error 52"*|*"empty reply"*)
            print_info "সার্ভার/নেটওয়ার্ক চেক করুন" ;;
        *"Missing"*"build-essential"*)
            print_info "Auto-fixing: build-essential ইনস্টল..."; apt install build-essential -y >/dev/null 2>&1; fixed=1 ;;
        *"Chromium"*"page crash"*|*"chromium.*crash"*)
            print_info "chromium --disable-gpu দিন" ;;
        *"Desktop launcher"*"parse error"*)
            print_info ".desktop ফাইলের Exec বানান চেক করুন" ;;
        *"Complete environment"*"freeze"*|*"environment.*freeze"*)
            print_info "ওয়ান-ক্লিক টুল ব্যবহার করুন" ;;
        *"GitHub"*"branch missing"*|*"branch.*not found"*)
            print_info "branch নাম সঠিকভাবে দিন" ;;
        *"pulseaudio"*"network"*"reset"*)
            print_info "PulseAudio রিসেট দিন" ;;
        *"Storage mount"*"duplicate"*)
            print_info "Termux Force Stop করে আবার ওপেন করুন" ;;
        *"Git"*"reflog"*"invalid"*)
            print_info "git reflog expire --all দিন" ;;
        *"Chromium"*"flash"*|*"hardware decode"*)
            print_info "Hardware decoding flag অফ করুন" ;;
        *"PulseAudio"*"tcp"*"auth"*|*"auth.*mismatch"*)
            print_info "Auto-fixing: PA cookie clear..."; rm -f ~/.config/pulse/cookie 2>/dev/null; fixed=1 ;;
        *"Mouse tracking"*"breaks"*)
            print_info "Mouse Tracking অফ রাখুন" ;;
        *"Download link"*"404"*|*"link.*404"*)
            print_info "URL আপডেট করুন" ;;
        *"Display server"*"locked"*|*"display.*locked"*)
            print_info "পুরনো সেশন ক্লিয়ার করুন" ;;
        *"Package lists"*"out of sync"*|*"list.*sync"*)
            print_info "Auto-fixing: apt update..."; apt update >/dev/null 2>&1; fixed=1 ;;
        *"Touch screen click"*"delayed"*)
            print_info "X11 Touch delay zero করুন" ;;
        *"File decompression"*"unknown"*)
            print_warning "ফাইল রি-ডাউনলোড দিন" ;;
        *"Git"*"push"*"error"*|*"push.*rejected"*)
            print_info "git pull করে তারপর push দিন" ;;
        *"Screen projection"*"broken"*)
            print_info "Resolution ম্যাচ করান" ;;
        *"Sound mixer"*"disabled"*)
            print_info "PulseAudio daemon চালু আছে কিনা চেক করুন" ;;
        *"environment paths missing"*|*"PATH"*"missing"*)
            print_info "echo \$PATH দিয়ে চেক করুন" ;;
        *"Network hostname"*"timed out"*)
            print_info "DNS (8.8.8.8) resolv.conf এ যোগ করুন" ;;
        *"Udroid"*"engine"*"fault"*)
            print_info "GitHub থেকে script রি-ডাউনলোড দিন" ;;
        *)
            # No known pattern matched
            return 1
            ;;
    esac

    if [ "$fixed" -eq 1 ]; then
        AUTO_FIX_COUNT=$((AUTO_FIX_COUNT + 1))
        print_success "Auto-fix #${AUTO_FIX_COUNT} সফলভাবে প্রয়োগ হয়েছে!"
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

        echo -e "  ${YELLOW}[AUTO-FIX]${RESET} কমান্ড ব্যর্থ, সমাধান খোজা হচ্ছে..."

        if auto_fix_error "$output"; then
            retry_count=$((retry_count + 1))
            echo -e "  ${CYAN}[RETRY]${RESET} পুনরায় চেষ্টা (${retry_count}/${max_retries})..."
            sleep 1
        else
            [ -n "$output" ] && echo "$output"
            return $exit_code
        fi
    done

    [ -n "$output" ] && echo "$output"
    print_warning "সর্বোচ্চ ${max_retries} বার চেষ্টা করা হয়েছে"
    return $exit_code
}

# ============================================================
# Download Progress Display
# Shows storage info, speed, percentage, and ETA
# ============================================================
show_download_info() {
    local total_size_mb="$1"
    local description="$2"
    local free_storage=$(get_free_storage_mb)

    echo ""
    echo -e "  ${BLUE}╔══════════════════════════════════════════════════════════════╗${RESET}"
    echo -e "  ${BLUE}║${RESET}  ${WHITE}${BOLD}📦 Download Info${RESET}                                          ${BLUE}║${RESET}"
    echo -e "  ${BLUE}╠══════════════════════════════════════════════════════════════╣${RESET}"
    echo -e "  ${BLUE}║${RESET}  ${CYAN}📋 Package:${RESET}   ${WHITE}${description}${RESET}$(printf '%*s' $((35 - ${#description})) '')${BLUE}║${RESET}"
    echo -e "  ${BLUE}║${RESET}  ${CYAN}💾 Size:${RESET}      ${GREEN}~${total_size_mb} MB${RESET}                                    ${BLUE}║${RESET}"
    echo -e "  ${BLUE}║${RESET}  ${CYAN}📱 Free:${RESET}      ${GREEN}${free_storage} MB${RESET}                                   ${BLUE}║${RESET}"
    echo -e "  ${BLUE}║${RESET}  ${CYAN}📊 Required:${RESET}  ${YELLOW}~$((total_size_mb * 3)) MB${RESET} (with extraction)            ${BLUE}║${RESET}"
    echo -e "  ${BLUE}╚══════════════════════════════════════════════════════════════╝${RESET}"
    echo ""

    if [ -n "$free_storage" ] && [ "$free_storage" -lt $((total_size_mb * 3)) ] 2>/dev/null; then
        print_warning "স্টোরেজ কম! কমপক্ষে $((total_size_mb * 3)) MB দরকার"
        print_warning "বর্তমানে মাত্র ${free_storage} MB খালি আছে"
        echo ""
        return 1
    fi
    return 0
}

download_with_progress() {
    local url="$1"
    local output_file="$2"
    local description="$3"

    echo -e "  ${CYAN}[DOWNLOAD]${RESET} ${description} ডাউনলোড শুরু হচ্ছে..."
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
        print_error "curl বা wget কোনোটাই নেই!"
        run_with_fix "pkg install curl -y"
        curl -L --progress-bar -o "$output_file" "$url"
    fi

    if [ $? -eq 0 ] && [ -f "$output_file" ]; then
        local file_size=$(du -m "$output_file" 2>/dev/null | cut -f1)
        print_success "ডাউনলোড সম্পন্ন! (${file_size} MB)"
        return 0
    else
        print_error "ডাউনলোড ব্যর্থ হয়েছে"
        auto_fix_error "Connection timed out"
        return 1
    fi
}

# ============================================================
# Pip-Style Progress Bar
# Shows download/install progress like pip does:
#   Downloading package-name.tar.gz (3.3 MB)
#      ━━━━━━━━━━━━━━━━━━━━ 3.3/3.3 MB 1.6 MB/s 0:00:01
#   Installing collected packages: package-name
# ============================================================
pip_style_progress() {
    local cmd="$1"
    local package_name="$2"
    local estimated_size_mb="$3"
    local bar_width=20
    local start_time=$(date +%s)

    # Print the "Downloading" header line
    echo -e "  Downloading ${package_name} (${estimated_size_mb} MB)"

    # Run the command in the background
    eval "$cmd" >/dev/null 2>&1 &
    local cmd_pid=$!

    local progress=0
    local speed="0.0"
    local elapsed_seconds=0

    # Animate progress bar while command runs
    while kill -0 "$cmd_pid" 2>/dev/null; do
        local current_time=$(date +%s)
        elapsed_seconds=$((current_time - start_time))

        # Simulate progress based on elapsed time and estimated size
        # Assume average speed ~1.5 MB/s for estimation
        if [ "$elapsed_seconds" -gt 0 ]; then
            local estimated_downloaded=$(echo "$elapsed_seconds 1.5" | awk '{printf "%.1f", $1 * $2}')
            local estimated_downloaded_int=$(echo "$estimated_downloaded" | awk '{printf "%d", $1}')
            local estimated_size_int=$(echo "$estimated_size_mb" | awk '{printf "%d", $1}')

            if [ "$estimated_downloaded_int" -ge "$estimated_size_int" ]; then
                # Cap at 95% until command actually finishes
                progress=95
                estimated_downloaded=$(echo "$estimated_size_mb" | awk '{printf "%.1f", $1 * 0.95}')
            else
                progress=$((estimated_downloaded_int * 100 / estimated_size_int))
            fi

            speed=$(echo "$estimated_downloaded $elapsed_seconds" | awk '{if($2>0) printf "%.1f", $1/$2; else printf "0.0"}')
        fi

        # Calculate filled/unfilled bar portions
        local filled=$((progress * bar_width / 100))
        local unfilled=$((bar_width - filled))

        # Build the progress bar string with green filled and grey unfilled
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

        # Format elapsed time as M:SS
        local mins=$((elapsed_seconds / 60))
        local secs=$((elapsed_seconds % 60))
        local time_str=$(printf "%d:%02d:%02d" 0 $mins $secs)

        # Current downloaded size estimation
        local current_mb=$(echo "$estimated_size_mb $progress" | awk '{printf "%.1f", $1 * $2 / 100}')

        # Print the progress bar (pip style)
        printf "\r   \033[1;32m%s\033[0m\033[2m%s\033[0m %s/%s MB %s MB/s %s" \
            "$bar_filled" "$bar_unfilled" "$current_mb" "$estimated_size_mb" "$speed" "$time_str"

        sleep 0.5
    done

    # Wait for the command to finish and get exit code
    wait "$cmd_pid"
    local exit_code=$?

    # Show completed progress bar (100%)
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

    # Full bar (all green)
    local full_bar=""
    local i=0
    while [ $i -lt $bar_width ]; do
        full_bar="${full_bar}━"
        i=$((i + 1))
    done

    printf "\r   \033[1;32m%s\033[0m %s/%s MB %s MB/s %s\n" \
        "$full_bar" "$estimated_size_mb" "$estimated_size_mb" "$speed" "$time_str"

    # Print the "Installing" footer line
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
        echo -e "  ${GREEN}╔══════════════════════════════════════════════════════════════╗${RESET}"
        echo -e "  ${GREEN}║${RESET}  ${WHITE}${BOLD}🔧 Auto-Fix Summary${RESET}                                      ${GREEN}║${RESET}"
        echo -e "  ${GREEN}╠══════════════════════════════════════════════════════════════╣${RESET}"
        echo -e "  ${GREEN}║${RESET}  ✅ মোট ${GREEN}${BOLD}${AUTO_FIX_COUNT}${RESET}টি সমস্যা স্বয়ংক্রিয়ভাবে সমাধান হয়েছে!     ${GREEN}║${RESET}"
        echo -e "  ${GREEN}╚══════════════════════════════════════════════════════════════╝${RESET}"
        echo ""
    fi
}


# ============================================================
# Ask User for Personalized Command Name
# ============================================================
ask_user_command_name() {
    clear
    echo ""
    echo -e "  ${CYAN}╔══════════════════════════════════════════════════════════════╗${RESET}"
    echo -e "  ${CYAN}║${RESET}                                                            ${CYAN}║${RESET}"
    echo -e "  ${CYAN}║${RESET}     ${YELLOW}👋${RESET} ${WHITE}${BOLD}Welcome! আপনার নাম দিন${RESET}                             ${CYAN}║${RESET}"
    echo -e "  ${CYAN}║${RESET}                                                            ${CYAN}║${RESET}"
    echo -e "  ${CYAN}╠══════════════════════════════════════════════════════════════╣${RESET}"
    echo -e "  ${CYAN}║${RESET}                                                            ${CYAN}║${RESET}"
    echo -e "  ${CYAN}║${RESET}  ${WHITE}আপনার নাম অনুযায়ী command তৈরি হবে।${RESET}                  ${CYAN}║${RESET}"
    echo -e "  ${CYAN}║${RESET}                                                            ${CYAN}║${RESET}"
    echo -e "  ${CYAN}║${RESET}  ${DIM}উদাহরণ: নাম${RESET} ${GREEN}'sujon'${RESET} ${DIM}হলে command হবে:${RESET}                ${CYAN}║${RESET}"
    echo -e "  ${CYAN}║${RESET}     ${GREEN}▶ start-sujon${RESET}   ${DIM}(Ubuntu চালু)${RESET}                     ${CYAN}║${RESET}"
    echo -e "  ${CYAN}║${RESET}     ${RED}■ stop-sujon${RESET}    ${DIM}(Ubuntu বন্ধ)${RESET}                      ${CYAN}║${RESET}"
    echo -e "  ${CYAN}║${RESET}                                                            ${CYAN}║${RESET}"
    echo -e "  ${CYAN}╚══════════════════════════════════════════════════════════════╝${RESET}"
    echo ""
    echo -ne "  ${YELLOW}  ✏️  আপনার নাম লিখুন: ${RESET}"
    read user_cmd_name

    # Remove spaces and special characters, convert to lowercase
    user_cmd_name=$(echo "$user_cmd_name" | tr '[:upper:]' '[:lower:]' | tr -cd 'a-z0-9_-')

    if [ -z "$user_cmd_name" ]; then
        user_cmd_name="ubuntu"
        print_warning "কোনো নাম দেওয়া হয়নি, ডিফল্ট 'ubuntu' ব্যবহার হবে।"
    else
        echo ""
        print_success "স্বাগতম, ${GREEN}${BOLD}${user_cmd_name}${RESET}!"
        echo -e "  ${BLUE}  🎯 ${RESET}আপনার command হবে: ${GREEN}${BOLD}start-${user_cmd_name}${RESET}"
    fi
    echo ""

    # Set global variable for use throughout the session
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
    echo -e "  ${MAGENTA}╔══════════════════════════════════════════════════════════════╗${RESET}"
    echo -e "  ${MAGENTA}║${RESET}                                                            ${MAGENTA}║${RESET}"
    echo -e "  ${MAGENTA}║${RESET}     ${MAGENTA}🛠️ ${RESET} ${WHITE}${BOLD}CUSTOM SUPER-FIX SETUP${RESET}                              ${MAGENTA}║${RESET}"
    echo -e "  ${MAGENTA}║${RESET}                                                            ${MAGENTA}║${RESET}"
    echo -e "  ${MAGENTA}╠══════════════════════════════════════════════════════════════╣${RESET}"
    echo -e "  ${MAGENTA}║${RESET}                                                            ${MAGENTA}║${RESET}"
    echo -e "  ${MAGENTA}║${RESET}  ${WHITE}এটি udroid method ব্যবহার করে Ubuntu ইনস্টল করবে।${RESET}      ${MAGENTA}║${RESET}"
    echo -e "  ${MAGENTA}║${RESET}  ${WHITE}সব প্রয়োজনীয় packages অটো ইনস্টল হবে।${RESET}                ${MAGENTA}║${RESET}"
    echo -e "  ${MAGENTA}║${RESET}                                                            ${MAGENTA}║${RESET}"
    echo -e "  ${MAGENTA}║${RESET}  ${DIM}Features: X11 + Audio + Desktop Environment${RESET}             ${MAGENTA}║${RESET}"
    echo -e "  ${MAGENTA}║${RESET}                                                            ${MAGENTA}║${RESET}"
    echo -e "  ${MAGENTA}╚══════════════════════════════════════════════════════════════╝${RESET}"
    echo ""
    echo -ne "  ${YELLOW}  ❓ ${WHITE}ইনস্টল শুরু করবেন? ${RESET}[${GREEN}y${RESET}/${RED}N${RESET}]: "
    read confirm
    
    if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
        print_info "Installation cancelled."
        press_enter
        return
    fi
    
    clear
    show_banner
    echo -e "  ${CYAN}${BOLD}  📥 Step 1/4: Updating and upgrading packages...${RESET}"
    print_separator
    pip_style_progress "pkg update && pkg upgrade -y" "termux-packages" "50"
    if [ $? -ne 0 ]; then
        print_error "Failed to update packages."
        press_enter
        return
    fi
    print_success "Packages updated successfully."
    echo ""
    
    echo -e "  ${CYAN}${BOLD}  📥 Step 2/4: Installing x11-repo and termux-x11-nightly...${RESET}"
    print_separator
    pip_style_progress "pkg install x11-repo -y && pkg install termux-x11-nightly -y" "termux-x11-nightly" "200"
    if [ $? -ne 0 ]; then
        print_error "Failed to install x11 packages."
        press_enter
        return
    fi
    print_success "X11 packages installed successfully."
    echo ""
    
    echo -e "  ${CYAN}${BOLD}  📥 Step 3/4: Installing proot and pulseaudio...${RESET}"
    print_separator
    pip_style_progress "pkg install proot pulseaudio -y" "proot-pulseaudio" "80"
    if [ $? -ne 0 ]; then
        print_error "Failed to install proot/pulseaudio."
        press_enter
        return
    fi
    print_success "Proot and PulseAudio installed successfully."
    echo ""
    
    echo -e "  ${CYAN}${BOLD}  📥 Step 4/4: Running udroid installer...${RESET}"
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
    
    # Use personalized command name from startup
    local cmd_name="$PERSONALIZED_CMD_NAME"
    
    # Create start shortcut command
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
    
    # Create stop shortcut command
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
    echo -e "  ${GREEN}╔══════════════════════════════════════════════════════════════╗${RESET}"
    echo -e "  ${GREEN}║${RESET}                                                            ${GREEN}║${RESET}"
    echo -e "  ${GREEN}║${RESET}     ${GREEN}${BOLD}🎉  Installation Complete!  🎉${RESET}                         ${GREEN}║${RESET}"
    echo -e "  ${GREEN}║${RESET}                                                            ${GREEN}║${RESET}"
    echo -e "  ${GREEN}╠══════════════════════════════════════════════════════════════╣${RESET}"
    echo -e "  ${GREEN}║${RESET}                                                            ${GREEN}║${RESET}"
    echo -e "  ${GREEN}║${RESET}  ${CYAN}▶${RESET} ${WHITE}START Ubuntu:${RESET}   ${GREEN}${BOLD}start-${cmd_name}${RESET}$(printf '%*s' $((26 - ${#cmd_name})) '')${GREEN}║${RESET}"
    echo -e "  ${GREEN}║${RESET}  ${RED}■${RESET} ${WHITE}STOP Ubuntu:${RESET}    ${RED}${BOLD}stop-${cmd_name}${RESET}$(printf '%*s' $((27 - ${#cmd_name})) '')${GREEN}║${RESET}"
    echo -e "  ${GREEN}║${RESET}                                                            ${GREEN}║${RESET}"
    echo -e "  ${GREEN}║${RESET}  ${YELLOW}💡${RESET} ${DIM}এখন থেকে শুধু এই command দিলেই চলবে!${RESET}               ${GREEN}║${RESET}"
    echo -e "  ${GREEN}║${RESET}  ${YELLOW}💡${RESET} ${DIM}আর এই tool এ আসতে হবে না।${RESET}                        ${GREEN}║${RESET}"
    echo -e "  ${GREEN}║${RESET}                                                            ${GREEN}║${RESET}"
    echo -e "  ${GREEN}╚══════════════════════════════════════════════════════════════╝${RESET}"
    echo ""
    press_enter
}

# ============================================================
# Version 2: Official Repo Version
# ============================================================
install_official() {
    clear
    show_banner
    echo -e "  ${BLUE}╔══════════════════════════════════════════════════════════════╗${RESET}"
    echo -e "  ${BLUE}║${RESET}                                                            ${BLUE}║${RESET}"
    echo -e "  ${BLUE}║${RESET}     ${BLUE}📦${RESET} ${WHITE}${BOLD}OFFICIAL REPO VERSION${RESET}                                ${BLUE}║${RESET}"
    echo -e "  ${BLUE}║${RESET}                                                            ${BLUE}║${RESET}"
    echo -e "  ${BLUE}╠══════════════════════════════════════════════════════════════╣${RESET}"
    echo -e "  ${BLUE}║${RESET}                                                            ${BLUE}║${RESET}"
    echo -e "  ${BLUE}║${RESET}  ${WHITE}Official proot-distro method ব্যবহার করে ইনস্টল${RESET}         ${BLUE}║${RESET}"
    echo -e "  ${BLUE}║${RESET}                                                            ${BLUE}║${RESET}"
    echo -e "  ${BLUE}╠══════════════════════════════════════════════════════════════╣${RESET}"
    echo -e "  ${BLUE}║${RESET}                                                            ${BLUE}║${RESET}"
    echo -e "  ${BLUE}║${RESET}  ${CYAN}📋 Ubuntu Version নির্বাচন করুন:${RESET}                        ${BLUE}║${RESET}"
    echo -e "  ${BLUE}║${RESET}                                                            ${BLUE}║${RESET}"
    echo -e "  ${BLUE}║${RESET}   ${GREEN}[01]${RESET} ${GREEN}🐧${RESET} ${WHITE}Ubuntu 20.04 LTS${RESET} ${DIM}(Focal Fossa)${RESET}              ${BLUE}║${RESET}"
    echo -e "  ${BLUE}║${RESET}   ${YELLOW}[02]${RESET} ${YELLOW}🐧${RESET} ${WHITE}Ubuntu 22.04 LTS${RESET} ${DIM}(Jammy Jellyfish)${RESET}          ${BLUE}║${RESET}"
    echo -e "  ${BLUE}║${RESET}   ${CYAN}[03]${RESET} ${CYAN}🐧${RESET} ${WHITE}Ubuntu 24.04 LTS${RESET} ${DIM}(Noble Numbat)${RESET}             ${BLUE}║${RESET}"
    echo -e "  ${BLUE}║${RESET}                                                            ${BLUE}║${RESET}"
    echo -e "  ${BLUE}╠══════════════════════════════════════════════════════════════╣${RESET}"
    echo -e "  ${BLUE}║${RESET}                                                            ${BLUE}║${RESET}"
    echo -e "  ${BLUE}║${RESET}   ${RED}[00]${RESET} ${RED}🔙${RESET} ${WHITE}Back to Install Menu${RESET}                            ${BLUE}║${RESET}"
    echo -e "  ${BLUE}║${RESET}                                                            ${BLUE}║${RESET}"
    echo -e "  ${BLUE}╚══════════════════════════════════════════════════════════════╝${RESET}"
    show_footer
    echo ""
    echo -ne "  ${YELLOW}  👉 Option নির্বাচন করুন ${RESET}[${CYAN}00-03${RESET}]: "
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
    echo -e "  ${BLUE}${BOLD}  📥 Installing Ubuntu ${version_name}...${RESET}"
    print_separator
    echo ""
    
    # Install proot-distro if not installed
    print_info "Ensuring proot-distro is installed..."
    pip_style_progress "pkg update -y && pkg install proot-distro -y" "proot-distro" "30"
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
    pip_style_progress "proot-distro install \"$ubuntu_version\"" "ubuntu-rootfs-${ubuntu_version}" "1200"
    if [ $? -ne 0 ]; then
        print_error "Failed to install Ubuntu ${version_name}."
        print_warning "The version might already be installed or an error occurred."
        press_enter
        return
    fi
    
    echo ""
    print_success "Ubuntu ${version_name} installed successfully!"
    echo ""
    
    # Use personalized command name from startup
    local cmd_name="$PERSONALIZED_CMD_NAME"
    
    # Create start shortcut command
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
    echo -e "  ${GREEN}╔══════════════════════════════════════════════════════════════╗${RESET}"
    echo -e "  ${GREEN}║${RESET}                                                            ${GREEN}║${RESET}"
    echo -e "  ${GREEN}║${RESET}     ${GREEN}${BOLD}🎉  Installation Complete!  🎉${RESET}                         ${GREEN}║${RESET}"
    echo -e "  ${GREEN}║${RESET}                                                            ${GREEN}║${RESET}"
    echo -e "  ${GREEN}╠══════════════════════════════════════════════════════════════╣${RESET}"
    echo -e "  ${GREEN}║${RESET}                                                            ${GREEN}║${RESET}"
    echo -e "  ${GREEN}║${RESET}  ${CYAN}▶${RESET} ${WHITE}START Ubuntu:${RESET}   ${GREEN}${BOLD}start-${cmd_name}${RESET}$(printf '%*s' $((26 - ${#cmd_name})) '')${GREEN}║${RESET}"
    echo -e "  ${GREEN}║${RESET}                                                            ${GREEN}║${RESET}"
    echo -e "  ${GREEN}║${RESET}  ${YELLOW}💡${RESET} ${DIM}এখন থেকে শুধু এই command দিলেই চলবে!${RESET}               ${GREEN}║${RESET}"
    echo -e "  ${GREEN}║${RESET}  ${YELLOW}💡${RESET} ${DIM}আর এই tool এ আসতে হবে না।${RESET}                        ${GREEN}║${RESET}"
    echo -e "  ${GREEN}║${RESET}                                                            ${GREEN}║${RESET}"
    echo -e "  ${GREEN}╚══════════════════════════════════════════════════════════════╝${RESET}"
    echo ""
    press_enter
}

# ============================================================
# Version 3: AI Smart Auto-Detect
# ============================================================
install_smart() {
    clear
    show_banner
    echo -e "  ${GREEN}╔══════════════════════════════════════════════════════════════╗${RESET}"
    echo -e "  ${GREEN}║${RESET}                                                            ${GREEN}║${RESET}"
    echo -e "  ${GREEN}║${RESET}     ${GREEN}🤖${RESET} ${WHITE}${BOLD}AI SMART AUTO-DETECT${RESET}                                 ${GREEN}║${RESET}"
    echo -e "  ${GREEN}║${RESET}                                                            ${GREEN}║${RESET}"
    echo -e "  ${GREEN}╠══════════════════════════════════════════════════════════════╣${RESET}"
    echo -e "  ${GREEN}║${RESET}                                                            ${GREEN}║${RESET}"
    echo -e "  ${GREEN}║${RESET}  ${WHITE}আপনার ডিভাইস স্ক্যান করা হচ্ছে...${RESET}                     ${GREEN}║${RESET}"
    echo -e "  ${GREEN}║${RESET}                                                            ${GREEN}║${RESET}"
    echo -e "  ${GREEN}╚══════════════════════════════════════════════════════════════╝${RESET}"
    echo ""
    
    # Get device info
    local ram_mb=$(get_ram_mb)
    local cpu_arch=$(get_cpu_arch)
    local free_storage=$(get_free_storage_mb)
    
    echo -e "  ${CYAN}╔══════════════════════════════════════════════════════════════╗${RESET}"
    echo -e "  ${CYAN}║${RESET}                                                            ${CYAN}║${RESET}"
    echo -e "  ${CYAN}║${RESET}     ${CYAN}📊${RESET} ${WHITE}${BOLD}Device Information${RESET}                                    ${CYAN}║${RESET}"
    echo -e "  ${CYAN}║${RESET}                                                            ${CYAN}║${RESET}"
    echo -e "  ${CYAN}╠══════════════════════════════════════════════════════════════╣${RESET}"
    echo -e "  ${CYAN}║${RESET}                                                            ${CYAN}║${RESET}"
    echo -e "  ${CYAN}║${RESET}  ${WHITE}💾 RAM:${RESET}           ${GREEN}${BOLD}${ram_mb} MB${RESET}                                ${CYAN}║${RESET}"
    echo -e "  ${CYAN}║${RESET}  ${WHITE}⚙️  CPU Arch:${RESET}      ${GREEN}${BOLD}${cpu_arch}${RESET}                              ${CYAN}║${RESET}"
    echo -e "  ${CYAN}║${RESET}  ${WHITE}📱 Free Storage:${RESET}  ${GREEN}${BOLD}${free_storage} MB${RESET}                           ${CYAN}║${RESET}"
    echo -e "  ${CYAN}║${RESET}                                                            ${CYAN}║${RESET}"
    echo -e "  ${CYAN}╚══════════════════════════════════════════════════════════════╝${RESET}"
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
    echo -e "  ${YELLOW}╔══════════════════════════════════════════════════════════════╗${RESET}"
    echo -e "  ${YELLOW}║${RESET}  ${YELLOW}🎯${RESET} ${WHITE}${BOLD}Recommendation:${RESET} ${GREEN}${reason}${RESET}$(printf '%*s' $((32 - ${#reason})) '')${YELLOW}║${RESET}"
    echo -e "  ${YELLOW}╚══════════════════════════════════════════════════════════════╝${RESET}"
    echo ""
    echo -ne "  ${YELLOW}  ❓ ${WHITE}Recommended installation শুরু করবেন? ${RESET}[${GREEN}y${RESET}/${RED}N${RESET}]: "
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
        
        # Fix stuck processes
        killall -9 termux-x11 2>/dev/null
        rm -rf /tmp/.X11-unix 2>/dev/null
        rm -rf /tmp/.X0-lock 2>/dev/null
        
        export LD_PRELOAD=/system/lib64/libskcodec.so
        pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1 2>/dev/null
        
        print_success "Ubuntu installed successfully via udroid!"
        echo ""
        
        # Use personalized command name from startup
        local cmd_name="$PERSONALIZED_CMD_NAME"
        
        # Create start shortcut command
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
        
        # Create stop shortcut command
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
        echo -e "  ${GREEN}╔══════════════════════════════════════════════════════════════╗${RESET}"
        echo -e "  ${GREEN}║${RESET}                                                            ${GREEN}║${RESET}"
        echo -e "  ${GREEN}║${RESET}     ${GREEN}${BOLD}🎉  Installation Complete!  🎉${RESET}                         ${GREEN}║${RESET}"
        echo -e "  ${GREEN}║${RESET}                                                            ${GREEN}║${RESET}"
        echo -e "  ${GREEN}╠══════════════════════════════════════════════════════════════╣${RESET}"
        echo -e "  ${GREEN}║${RESET}                                                            ${GREEN}║${RESET}"
        echo -e "  ${GREEN}║${RESET}  ${CYAN}▶${RESET} ${WHITE}START:${RESET}  ${GREEN}${BOLD}start-${cmd_name}${RESET}$(printf '%*s' $((33 - ${#cmd_name})) '')${GREEN}║${RESET}"
        echo -e "  ${GREEN}║${RESET}  ${RED}■${RESET} ${WHITE}STOP:${RESET}   ${RED}${BOLD}stop-${cmd_name}${RESET}$(printf '%*s' $((34 - ${#cmd_name})) '')${GREEN}║${RESET}"
        echo -e "  ${GREEN}║${RESET}                                                            ${GREEN}║${RESET}"
        echo -e "  ${GREEN}║${RESET}  ${YELLOW}💡${RESET} ${DIM}এখন থেকে শুধু এই command দিলেই চলবে!${RESET}               ${GREEN}║${RESET}"
        echo -e "  ${GREEN}║${RESET}  ${YELLOW}💡${RESET} ${DIM}আর এই tool এ আসতে হবে না।${RESET}                        ${GREEN}║${RESET}"
        echo -e "  ${GREEN}║${RESET}                                                            ${GREEN}║${RESET}"
        echo -e "  ${GREEN}╚══════════════════════════════════════════════════════════════╝${RESET}"
        echo ""
    else
        print_info "Installing Ubuntu ${version_name} via proot-distro..."
        print_separator
        echo ""
        
        pip_style_progress "pkg update -y && pkg install proot-distro -y" "proot-distro" "30"
        pip_style_progress "proot-distro install \"$ubuntu_version\"" "ubuntu-rootfs-${ubuntu_version}" "1200"
        
        if [ $? -ne 0 ]; then
            print_error "Installation failed."
            press_enter
            return
        fi
        
        print_success "Ubuntu ${version_name} installed successfully!"
        echo ""
        
        # Use personalized command name from startup
        local cmd_name="$PERSONALIZED_CMD_NAME"
        
        # Create start shortcut command
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
        echo -e "  ${GREEN}╔══════════════════════════════════════════════════════════════╗${RESET}"
        echo -e "  ${GREEN}║${RESET}                                                            ${GREEN}║${RESET}"
        echo -e "  ${GREEN}║${RESET}     ${GREEN}${BOLD}🎉  Installation Complete!  🎉${RESET}                         ${GREEN}║${RESET}"
        echo -e "  ${GREEN}║${RESET}                                                            ${GREEN}║${RESET}"
        echo -e "  ${GREEN}╠══════════════════════════════════════════════════════════════╣${RESET}"
        echo -e "  ${GREEN}║${RESET}                                                            ${GREEN}║${RESET}"
        echo -e "  ${GREEN}║${RESET}  ${CYAN}▶${RESET} ${WHITE}START:${RESET}  ${GREEN}${BOLD}start-${cmd_name}${RESET}$(printf '%*s' $((33 - ${#cmd_name})) '')${GREEN}║${RESET}"
        echo -e "  ${GREEN}║${RESET}                                                            ${GREEN}║${RESET}"
        echo -e "  ${GREEN}║${RESET}  ${YELLOW}💡${RESET} ${DIM}এখন থেকে শুধু এই command দিলেই চলবে!${RESET}               ${GREEN}║${RESET}"
        echo -e "  ${GREEN}║${RESET}  ${YELLOW}💡${RESET} ${DIM}আর এই tool এ আসতে হবে না।${RESET}                        ${GREEN}║${RESET}"
        echo -e "  ${GREEN}║${RESET}                                                            ${GREEN}║${RESET}"
        echo -e "  ${GREEN}╚══════════════════════════════════════════════════════════════╝${RESET}"
        echo ""
    fi
    
    press_enter
}

# ============================================================
# Start Ubuntu
# ============================================================
start_ubuntu() {
    show_banner
    echo -e "  ${YELLOW}╔══════════════════════════════════════════════════════════════╗${RESET}"
    echo -e "  ${YELLOW}║${RESET}                                                            ${YELLOW}║${RESET}"
    echo -e "  ${YELLOW}║${RESET}      ${YELLOW}🚀${RESET} ${WHITE}${BOLD}S T A R T   U B U N T U${RESET}                            ${YELLOW}║${RESET}"
    echo -e "  ${YELLOW}║${RESET}                                                            ${YELLOW}║${RESET}"
    echo -e "  ${YELLOW}╠══════════════════════════════════════════════════════════════╣${RESET}"
    echo -e "  ${YELLOW}║${RESET}                                                            ${YELLOW}║${RESET}"
    echo -e "  ${YELLOW}║${RESET}  ${CYAN}💡 TIP:${RESET} ${WHITE}সরাসরি terminal এ এই commands ব্যবহার করুন:${RESET}     ${YELLOW}║${RESET}"
    echo -e "  ${YELLOW}║${RESET}     ${GREEN}▶ start-${PERSONALIZED_CMD_NAME}${RESET}$(printf '%*s' $((36 - ${#PERSONALIZED_CMD_NAME})) '')${DIM}(Ubuntu চালু)${RESET}   ${YELLOW}║${RESET}"
    echo -e "  ${YELLOW}║${RESET}     ${RED}■ stop-${PERSONALIZED_CMD_NAME}${RESET}$(printf '%*s' $((37 - ${#PERSONALIZED_CMD_NAME})) '')${DIM}(Ubuntu বন্ধ)${RESET}    ${YELLOW}║${RESET}"
    echo -e "  ${YELLOW}║${RESET}                                                            ${YELLOW}║${RESET}"
    echo -e "  ${YELLOW}╠══════════════════════════════════════════════════════════════╣${RESET}"
    echo -e "  ${YELLOW}║${RESET}                                                            ${YELLOW}║${RESET}"
    echo -e "  ${YELLOW}║${RESET}   ${GREEN}[01]${RESET} ${GREEN}🐧${RESET} ${WHITE}${BOLD}Start via proot-distro (Official)${RESET}               ${YELLOW}║${RESET}"
    echo -e "  ${YELLOW}║${RESET}                                                            ${YELLOW}║${RESET}"
    echo -e "  ${YELLOW}║${RESET}   ${MAGENTA}[02]${RESET} ${MAGENTA}⚡${RESET} ${WHITE}${BOLD}Start via udroid${RESET}                                 ${YELLOW}║${RESET}"
    echo -e "  ${YELLOW}║${RESET}                                                            ${YELLOW}║${RESET}"
    echo -e "  ${YELLOW}╠══════════════════════════════════════════════════════════════╣${RESET}"
    echo -e "  ${YELLOW}║${RESET}                                                            ${YELLOW}║${RESET}"
    echo -e "  ${YELLOW}║${RESET}   ${RED}[00]${RESET} ${RED}🔙${RESET} ${WHITE}Back to Main Menu${RESET}                                ${YELLOW}║${RESET}"
    echo -e "  ${YELLOW}║${RESET}                                                            ${YELLOW}║${RESET}"
    echo -e "  ${YELLOW}╚══════════════════════════════════════════════════════════════╝${RESET}"
    show_footer
    echo ""
    echo -ne "  ${YELLOW}  👉 Option নির্বাচন করুন ${RESET}[${CYAN}00-02${RESET}]: "
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
            echo -ne "  ${YELLOW}  ✏️  Enter distro name to login (e.g., ubuntu): ${RESET}"
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
                print_info "Please install using 'Custom Super-Fix Setup' option first."
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
    echo -e "  ${RED}╔══════════════════════════════════════════════════════════════╗${RESET}"
    echo -e "  ${RED}║${RESET}                                                            ${RED}║${RESET}"
    echo -e "  ${RED}║${RESET}      ${RED}🗑️ ${RESET} ${WHITE}${BOLD}U N I N S T A L L   U B U N T U${RESET}                   ${RED}║${RESET}"
    echo -e "  ${RED}║${RESET}                                                            ${RED}║${RESET}"
    echo -e "  ${RED}╠══════════════════════════════════════════════════════════════╣${RESET}"
    echo -e "  ${RED}║${RESET}                                                            ${RED}║${RESET}"
    echo -e "  ${RED}║${RESET}   ${YELLOW}[01]${RESET} ${YELLOW}⚡${RESET} ${WHITE}${BOLD}Uninstall proot-distro Ubuntu${RESET}                   ${RED}║${RESET}"
    echo -e "  ${RED}║${RESET}                                                            ${RED}║${RESET}"
    echo -e "  ${RED}║${RESET}   ${MAGENTA}[02]${RESET} ${MAGENTA}🔧${RESET} ${WHITE}${BOLD}Uninstall udroid Ubuntu${RESET}                         ${RED}║${RESET}"
    echo -e "  ${RED}║${RESET}                                                            ${RED}║${RESET}"
    echo -e "  ${RED}║${RESET}   ${RED}[03]${RESET} ${RED}💣${RESET} ${WHITE}${BOLD}Uninstall ALL (Complete cleanup)${RESET}                ${RED}║${RESET}"
    echo -e "  ${RED}║${RESET}                                                            ${RED}║${RESET}"
    echo -e "  ${RED}╠══════════════════════════════════════════════════════════════╣${RESET}"
    echo -e "  ${RED}║${RESET}                                                            ${RED}║${RESET}"
    echo -e "  ${RED}║${RESET}   ${CYAN}[00]${RESET} ${CYAN}🔙${RESET} ${WHITE}Back to Main Menu${RESET}                                ${RED}║${RESET}"
    echo -e "  ${RED}║${RESET}                                                            ${RED}║${RESET}"
    echo -e "  ${RED}╚══════════════════════════════════════════════════════════════╝${RESET}"
    show_footer
    echo ""
    echo -ne "  ${YELLOW}  👉 Option নির্বাচন করুন ${RESET}[${CYAN}00-03${RESET}]: "
    read uninstall_choice
    
    case $uninstall_choice in
        1|01)
            echo ""
            print_info "Available Ubuntu installations:"
            print_separator
            proot-distro list 2>/dev/null | grep -i ubuntu
            echo ""
            echo -ne "  ${YELLOW}  ✏️  Enter distro name to remove (e.g., ubuntu): ${RESET}"
            read distro_name
            if [ -n "$distro_name" ]; then
                echo ""
                echo -ne "  ${RED}  ⚠️  Are you sure you want to remove '$distro_name'? [y/N]: ${RESET}"
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
        2|02)
            echo ""
            echo -ne "  ${RED}  ⚠️  Are you sure you want to remove udroid Ubuntu? [y/N]: ${RESET}"
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
        3|03)
            echo ""
            print_warning "This will remove ALL Ubuntu installations!"
            echo -ne "  ${RED}  💣 Are you absolutely sure? [y/N]: ${RESET}"
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
        echo -e "  ${GREEN}╔══════════════════════════════════════════════════════════════╗${RESET}"
        echo -e "  ${GREEN}║${RESET}                                                            ${GREEN}║${RESET}"
        echo -e "  ${GREEN}║${RESET}      ${GREEN}📦${RESET} ${WHITE}${BOLD}I N S T A L L   U B U N T U${RESET}                        ${GREEN}║${RESET}"
        echo -e "  ${GREEN}║${RESET}                                                            ${GREEN}║${RESET}"
        echo -e "  ${GREEN}╠══════════════════════════════════════════════════════════════╣${RESET}"
        echo -e "  ${GREEN}║${RESET}                                                            ${GREEN}║${RESET}"
        echo -e "  ${GREEN}║${RESET}   ${MAGENTA}[01]${RESET} ${MAGENTA}🛠️ ${RESET} ${WHITE}${BOLD}Custom Super-Fix Setup${RESET}                          ${GREEN}║${RESET}"
        echo -e "  ${GREEN}║${RESET}        ${DIM}Quick setup with X11 and audio support${RESET}              ${GREEN}║${RESET}"
        echo -e "  ${GREEN}║${RESET}                                                            ${GREEN}║${RESET}"
        echo -e "  ${GREEN}║${RESET}   ${BLUE}[02]${RESET} ${BLUE}📦${RESET} ${WHITE}${BOLD}Official Repo Version${RESET}                           ${GREEN}║${RESET}"
        echo -e "  ${GREEN}║${RESET}        ${DIM}Choose from Ubuntu 20.04, 22.04, or 24.04${RESET}          ${GREEN}║${RESET}"
        echo -e "  ${GREEN}║${RESET}                                                            ${GREEN}║${RESET}"
        echo -e "  ${GREEN}║${RESET}   ${CYAN}[03]${RESET} ${CYAN}🤖${RESET} ${WHITE}${BOLD}AI Smart Auto-Detect${RESET}                            ${GREEN}║${RESET}"
        echo -e "  ${GREEN}║${RESET}        ${DIM}Automatically selects best version for device${RESET}       ${GREEN}║${RESET}"
        echo -e "  ${GREEN}║${RESET}                                                            ${GREEN}║${RESET}"
        echo -e "  ${GREEN}╠══════════════════════════════════════════════════════════════╣${RESET}"
        echo -e "  ${GREEN}║${RESET}                                                            ${GREEN}║${RESET}"
        echo -e "  ${GREEN}║${RESET}   ${RED}[00]${RESET} ${RED}🔙${RESET} ${WHITE}Back to Main Menu${RESET}                                ${GREEN}║${RESET}"
        echo -e "  ${GREEN}║${RESET}                                                            ${GREEN}║${RESET}"
        echo -e "  ${GREEN}╚══════════════════════════════════════════════════════════════╝${RESET}"
        show_footer
        echo ""
        echo -ne "  ${YELLOW}  👉 Option নির্বাচন করুন ${RESET}[${CYAN}00-03${RESET}]: "
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
        echo -e "  ${CYAN}╔══════════════════════════════════════════════════════════════╗${RESET}"
        echo -e "  ${CYAN}║${RESET}                                                            ${CYAN}║${RESET}"
        echo -e "  ${CYAN}║${RESET}          ${WHITE}${BOLD}M  A  I  N     M  E  N  U${RESET}                       ${CYAN}║${RESET}"
        echo -e "  ${CYAN}║${RESET}                                                            ${CYAN}║${RESET}"
        echo -e "  ${CYAN}╠══════════════════════════════════════════════════════════════╣${RESET}"
        echo -e "  ${CYAN}║${RESET}                                                            ${CYAN}║${RESET}"
        echo -e "  ${CYAN}║${RESET}   ${GREEN}[01]${RESET} ${GREEN}📦${RESET} ${WHITE}${BOLD}Install Ubuntu${RESET}                                  ${CYAN}║${RESET}"
        echo -e "  ${CYAN}║${RESET}        ${DIM}Install Ubuntu with multiple methods${RESET}                ${CYAN}║${RESET}"
        echo -e "  ${CYAN}║${RESET}                                                            ${CYAN}║${RESET}"
        echo -e "  ${CYAN}║${RESET}   ${YELLOW}[02]${RESET} ${YELLOW}🚀${RESET} ${WHITE}${BOLD}Start Ubuntu${RESET}                                    ${CYAN}║${RESET}"
        echo -e "  ${CYAN}║${RESET}        ${DIM}Launch installed Ubuntu environment${RESET}                 ${CYAN}║${RESET}"
        echo -e "  ${CYAN}║${RESET}                                                            ${CYAN}║${RESET}"
        echo -e "  ${CYAN}║${RESET}   ${RED}[03]${RESET} ${RED}🗑️ ${RESET} ${WHITE}${BOLD}Uninstall Ubuntu${RESET}                                 ${CYAN}║${RESET}"
        echo -e "  ${CYAN}║${RESET}        ${DIM}Remove Ubuntu installations${RESET}                        ${CYAN}║${RESET}"
        echo -e "  ${CYAN}║${RESET}                                                            ${CYAN}║${RESET}"
        echo -e "  ${CYAN}╠══════════════════════════════════════════════════════════════╣${RESET}"
        echo -e "  ${CYAN}║${RESET}                                                            ${CYAN}║${RESET}"
        echo -e "  ${CYAN}║${RESET}   ${MAGENTA}[00]${RESET} ${MAGENTA}🚪${RESET} ${WHITE}Exit${RESET}                                            ${CYAN}║${RESET}"
        echo -e "  ${CYAN}║${RESET}                                                            ${CYAN}║${RESET}"
        echo -e "  ${CYAN}╚══════════════════════════════════════════════════════════════╝${RESET}"
        show_footer
        echo ""
        echo -ne "  ${YELLOW}  👉 Option নির্বাচন করুন ${RESET}[${CYAN}00-03${RESET}]: "
        read main_choice
        
        case $main_choice in
            1|01) install_menu ;;
            2|02) start_ubuntu ;;
            3|03) uninstall_ubuntu ;;
            0|00)
                clear
                echo ""
                echo -e "  ${GREEN}╔══════════════════════════════════════════════════════════════╗${RESET}"
                echo -e "  ${GREEN}║${RESET}                                                            ${GREEN}║${RESET}"
                echo -e "  ${GREEN}║${RESET}   ${GREEN}✅${RESET} ${WHITE}${BOLD}Thank you for using Termux Ubuntu Installer!${RESET}          ${GREEN}║${RESET}"
                echo -e "  ${GREEN}║${RESET}   ${CYAN}👋${RESET} ${WHITE}Goodbye! Happy Linux-ing!${RESET}                              ${GREEN}║${RESET}"
                echo -e "  ${GREEN}║${RESET}                                                            ${GREEN}║${RESET}"
                echo -e "  ${GREEN}╚══════════════════════════════════════════════════════════════╝${RESET}"
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
