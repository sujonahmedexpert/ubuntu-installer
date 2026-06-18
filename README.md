# Ubuntu Installer for Termux

```
       ▄▄▄▄▄▄▄▄▄▄▄        ████████ ███████ ██████  ███╗   ███╗██╗   ██╗██╗  ██╗
    ▄█████████████████▄        ██    ██      ██   ██ ████╗ ████║██║   ██║╚██╗██╔╝
  ▄██▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀██▄      ██    █████   ██████  ██╔████╔██║██║   ██║ ╚███╔╝
  ███   ▄▄▄▄▄▄▄▄▄▄▄   ███     ██    ██      ██   ██ ██║╚██╔╝██║██║   ██║ ██╔██╗
  ██  ▄██████████████▄  ██     ██    ███████ ██   ██ ██║ ╚═╝ ██║╚██████╔╝██╔╝ ██╗
  ██  ███████████████▀  ██     ╚═╝   ╚══════╝╚═════╝ ╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝
  ██  ▀▀██████████▀▀   ██
  ███    ▀▀▀▀▀▀▀▀     ███      Ubuntu Installer v3.0
   ▀██▄             ▄██▀        Developed for Android/Termux Users
     ▀█████████████████▀
        ▀▀▀▀▀▀▀▀▀▀▀

  ══════════════════════════════════════════════════════════════
  ─[username@termux]─[~]
```

> **Termux Ubuntu Installer Tool v3.0** - A colorful, emoji-rich, menu-based Ubuntu installer for Android/Termux users with pixel-art banner and stylish box menus.

---

## Description / বিবরণ

**English:**  
Ubuntu Installer is a powerful, easy-to-use Bash tool that installs Ubuntu Linux on your Android device via Termux. It provides a beautiful colorful menu interface with multi-color pixel-art banners, stylish box-bordered menus, emoji icons, and multiple installation methods with smart device detection and full management capabilities (install, start, uninstall).

**বাংলা:**  
Ubuntu Installer হলো একটি শক্তিশালী ও সহজে ব্যবহারযোগ্য Bash টুল যা আপনার Android ডিভাইসে Termux-এর মাধ্যমে Ubuntu Linux ইনস্টল করে। এটি একটি সুন্দর রঙিন pixel-art ব্যানার, স্টাইলিশ বক্স-বর্ডার মেনু, ইমোজি আইকন সহ মেনু ইন্টারফেস প্রদান করে যার মধ্যে একাধিক ইনস্টলেশন পদ্ধতি, স্মার্ট ডিভাইস ডিটেকশন, এবং সম্পূর্ণ ব্যবস্থাপনা সুবিধা (ইনস্টল, স্টার্ট, আনইনস্টল) রয়েছে।

---

## New in v3.0 / v3.0 তে নতুন

Version 3.0 brings a complete UI/design overhaul:

| Feature | Description |
|---------|-------------|
| **Multi-color Pixel-Art Banner** | Ubuntu circle logo on the left + colorful "TERMUX" text on the right |
| **Stylish Box Menus** | ╔═══╗ ║ ╚═══╝ borders with ╠═══╣ separators |
| **Emoji Icons** | Every menu item has an icon: 🐧 🚀 📦 🤖 ⚡ 🔧 🗑️ 🔙 🚪 |
| **Zero-Padded Numbering** | [01], [02], [03], [00] format for all options |
| **Color-Coded Sections** | Error=Red, Success=Green, Warning=Yellow, Info=Cyan |
| **Clear Screen on Every Page** | No scrolling needed, clean view every time |
| **Personalized Username Display** | Shows ─[username@termux]─[~] below the banner |
| **Footer Separator** | Every page shows "Ubuntu Installer v3.0 | Termux | Android/Linux" |

---

## Features / বৈশিষ্ট্যসমূহ

### 3 Installation Methods / ৩টি ইনস্টল পদ্ধতি

| # | Method | Description |
|---|--------|-------------|
| 01 | **🛠️ Custom Super-Fix Setup** | Quick setup with X11 display server and PulseAudio support via udroid. Best for GUI desktop experience. |
| 02 | **📦 Official Repo Version** | Install from official proot-distro repository. Choose from Ubuntu 20.04, 22.04, or 24.04 LTS. |
| 03 | **🤖 AI Smart Auto-Detect** | Automatically analyzes your device (RAM, CPU, storage) and recommends the best Ubuntu version. |

### Other Features / অন্যান্য বৈশিষ্ট্য

- Multi-color pixel-art ASCII banner with Ubuntu circle logo
- Stylish menus with emoji icons and ═══ box borders (╔═══╗, ║, ╚═══╝)
- Zero-padded numbering [01], [02], [03], [00]
- Color-coded sections (error=red, success=green, warning=yellow, info=cyan)
- Clear screen on every page (no scrolling needed)
- Personalized username display ─[username@termux]─[~]
- Footer separator showing "Ubuntu Installer v3.0 | Termux | Android/Linux" on every page
- Start Ubuntu directly from the menu
- Uninstall Ubuntu (individual or all installations)
- Device specification detection (RAM, CPU, Storage)
- Automatic stuck process fixing
- Support for ARM64 and other architectures

---

## Requirements / প্রয়োজনীয়তা

| Requirement | Details |
|-------------|---------|
| **Device** | Android phone/tablet |
| **App** | [Termux](https://f-droid.org/en/packages/com.termux/) (F-Droid version recommended) |
| **Internet** | Active internet connection required for downloading Ubuntu |
| **Storage** | Minimum 2GB free space recommended |
| **Android** | Android 7.0 or higher |

---

## Installation / ইনস্টলেশন

### One Command Install / এক কমান্ডে ইনস্টল

Open Termux and run:

```bash
curl -fsSL https://raw.githubusercontent.com/sujonahmedexpert/ubuntu-installer/main/install.sh | bash
```

**বাংলা:** Termux ওপেন করুন এবং উপরের কমান্ডটি পেস্ট করে Enter চাপুন। টুলটি স্বয়ংক্রিয়ভাবে ডাউনলোড ও ইনস্টল হয়ে যাবে।

### Manual Install / ম্যানুয়াল ইনস্টল

```bash
pkg update && pkg upgrade -y
curl -fsSL https://raw.githubusercontent.com/sujonahmedexpert/ubuntu-installer/main/ubuntu-installer.sh -o $PREFIX/bin/ubuntu-installer
chmod +x $PREFIX/bin/ubuntu-installer
```

---

## Usage / ব্যবহার

After installation, run the tool:

```bash
ubuntu-installer
```

**বাংলা:** ইনস্টল করার পরে, `ubuntu-installer` লিখে Enter চাপুন। একটি সুন্দর মেনু আসবে যেখান থেকে আপনি সব কিছু করতে পারবেন।

You will see the main menu with these options:

```
╔══════════════════════════════════════════════════════════════╗
║          M  A  I  N     M  E  N  U                         ║
╠══════════════════════════════════════════════════════════════╣
║   [01] 📦 Install Ubuntu                                   ║
║   [02] 🚀 Start Ubuntu                                     ║
║   [03] 🗑️  Uninstall Ubuntu                                ║
╠══════════════════════════════════════════════════════════════╣
║   [00] 🚪 Exit                                             ║
╚══════════════════════════════════════════════════════════════╝
```

---

## How to Install Ubuntu / উবুন্টু কিভাবে ইনস্টল করবেন

### Method 1: Custom Super-Fix Setup / কাস্টম সুপার-ফিক্স সেটআপ

**English:**
1. Run `ubuntu-installer`
2. Select option `[01] Install Ubuntu`
3. Select option `[01] Custom Super-Fix Setup`
4. Confirm with `y`
5. Wait for automatic installation (updates packages, installs X11, proot, PulseAudio, and udroid)
6. Done! Start Ubuntu from the main menu.

**বাংলা:**
1. `ubuntu-installer` চালান
2. `[01] Install Ubuntu` সিলেক্ট করুন
3. `[01] Custom Super-Fix Setup` সিলেক্ট করুন
4. `y` দিয়ে কনফার্ম করুন
5. স্বয়ংক্রিয় ইনস্টলেশন সম্পন্ন হওয়ার জন্য অপেক্ষা করুন
6. সম্পন্ন! মেইন মেনু থেকে Ubuntu স্টার্ট করুন।

---

### Method 2: Official Repo Version / অফিসিয়াল রিপো ভার্সন

**English:**
1. Run `ubuntu-installer`
2. Select option `[01] Install Ubuntu`
3. Select option `[02] Official Repo Version`
4. Choose your Ubuntu version:
   - `[01]` Ubuntu 20.04 LTS (Focal Fossa) - Lightweight
   - `[02]` Ubuntu 22.04 LTS (Jammy Jellyfish) - Stable
   - `[03]` Ubuntu 24.04 LTS (Noble Numbat) - Latest
5. Wait for download and installation
6. Done! Start Ubuntu from the main menu.

**বাংলা:**
1. `ubuntu-installer` চালান
2. `[01] Install Ubuntu` সিলেক্ট করুন
3. `[02] Official Repo Version` সিলেক্ট করুন
4. আপনার পছন্দের Ubuntu ভার্সন বাছুন:
   - `[01]` Ubuntu 20.04 LTS - হালকা, কম RAM-এর জন্য ভালো
   - `[02]` Ubuntu 22.04 LTS - স্থিতিশীল, বেশিরভাগ ডিভাইসের জন্য
   - `[03]` Ubuntu 24.04 LTS - সর্বশেষ, ভালো ডিভাইসের জন্য
5. ডাউনলোড ও ইনস্টলেশন সম্পন্ন হওয়ার অপেক্ষা করুন
6. সম্পন্ন! মেইন মেনু থেকে Ubuntu স্টার্ট করুন।

---

### Method 3: AI Smart Auto-Detect / এআই স্মার্ট অটো-ডিটেক্ট

**English:**
1. Run `ubuntu-installer`
2. Select option `[01] Install Ubuntu`
3. Select option `[03] AI Smart Auto-Detect`
4. The tool will automatically detect your device's RAM, CPU, and storage
5. It will recommend the best Ubuntu version for your device
6. Confirm with `y` to proceed
7. Done! The best version is installed automatically.

**বাংলা:**
1. `ubuntu-installer` চালান
2. `[01] Install Ubuntu` সিলেক্ট করুন
3. `[03] AI Smart Auto-Detect` সিলেক্ট করুন
4. টুলটি স্বয়ংক্রিয়ভাবে আপনার ডিভাইসের RAM, CPU, এবং স্টোরেজ ডিটেক্ট করবে
5. আপনার ডিভাইসের জন্য সেরা Ubuntu ভার্সন রিকমেন্ড করবে
6. `y` দিয়ে কনফার্ম করুন
7. সম্পন্ন! সেরা ভার্সন স্বয়ংক্রিয়ভাবে ইনস্টল হয়ে যাবে।

---

## Starting Ubuntu / উবুন্টু চালু করা

After installation:
1. Run `ubuntu-installer`
2. Select `[02] Start Ubuntu`
3. Choose start method:
   - `[01]` Start via proot-distro (for Official Repo installs)
   - `[02]` Start via udroid (for Custom Super-Fix installs)

**বাংলা:**
ইনস্টলের পরে `ubuntu-installer` চালান এবং `[02] Start Ubuntu` সিলেক্ট করুন।

---

## Uninstall / আনইনস্টল

### Uninstall Ubuntu / উবুন্টু আনইনস্টল

1. Run `ubuntu-installer`
2. Select `[03] Uninstall Ubuntu`
3. Choose what to remove:
   - `[01]` Uninstall proot-distro Ubuntu
   - `[02]` Uninstall udroid Ubuntu
   - `[03]` Uninstall ALL (Complete cleanup)

### Uninstall the Tool / টুল আনইনস্টল

```bash
rm -f $PREFIX/bin/ubuntu-installer
```

**বাংলা:** উপরের কমান্ডটি চালালে টুলটি আনইনস্টল হয়ে যাবে।

---

## Screenshots / স্ক্রিনশট

The tool features a stunning redesigned terminal interface in v3.0:

- **Multi-color pixel-art banner** with the Ubuntu circle logo on the left and colorful "TERMUX" text on the right
- **Personalized header** showing ─[username@termux]─[~] below the banner
- **Stylish box-bordered menus** using ╔═══╗, ║, ╚═══╝ characters with ╠═══╣ separators
- **Emoji icons** on every menu item (📦, 🚀, 🗑️, 🛠️, 🤖, 🔙, 🚪)
- **Zero-padded numbers** [01], [02], [03], [00] for clean alignment
- **Color-coded feedback**: green for success, red for errors, yellow for warnings, cyan for info
- **Clear screen on every page** for a distraction-free experience
- **Footer separator** on every page showing version and platform info

---

## Troubleshooting / সমস্যা সমাধান

| Problem | Solution |
|---------|----------|
| `Permission denied` | Run `chmod +x $PREFIX/bin/ubuntu-installer` |
| `curl: not found` | Run `pkg install curl` |
| `proot-distro: not found` | Run `pkg install proot-distro` |
| Screen stuck | Close and reopen Termux |
| X11 issues | The tool automatically fixes stuck X11 processes |

---

## Author / লেখক

**sujonahmedexpert**

- GitHub: [github.com/sujonahmedexpert](https://github.com/sujonahmedexpert)

---

## License / লাইসেন্স

This project is licensed under the **MIT License**.

```
MIT License

Copyright (c) 2024 sujonahmedexpert

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## Contributing / অবদান

Contributions are welcome! Feel free to open issues or submit pull requests.

**বাংলা:** যেকোনো অবদান স্বাগত! Issue খুলুন অথবা Pull Request পাঠান।

---

## Support / সাপোর্ট

If you find this tool helpful, please give it a star on GitHub!

**বাংলা:** যদি এই টুলটি আপনার কাজে লাগে, তাহলে GitHub-এ একটি star দিন!
