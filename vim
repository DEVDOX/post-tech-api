# System Info:
1.  `uname -a`:

        Linux localhost 5.6.2-gentoo-x86_64 #7 SMP Sat Apr 4 20:02:36 JST 2020 x86_64 AMD Ryzen 7 1700X Eight-Core Processor AuthenticAMD GNU/Linux

2.  `lsb_release`:

    `lsb_release` not found.

3.  `/etc/lsb-release`:

    `/etc/lsb-release` not found.

4.  `/etc/os-release`:

        NAME=Gentoo
        ID=gentoo
        PRETTY_NAME="Gentoo/Linux"
        ANSI_COLOR="1;32"
        HOME_URL="https://www.gentoo.org/"
        SUPPORT_URL="https://www.gentoo.org/support/"
        BUG_REPORT_URL="https://bugs.gentoo.org/"

5.  Desktop Environment:

    Cannot determine desktop environment.

6.  Bash Version:

        BASH_VERSION='5.0.16(1)-release'

# Environment:
1.  DISPLAY:

        DISPLAY=':0'

2.  Keyboard Layout:

    1.  `setxkbmap`:

        `setxkbmap` not found.

    2.  `xprop`:

            _XKB_RULES_NAMES(STRING) = "evdev", "pc105", "jp", "", ""

3.  Locale:

    1.  All locale:

            C
            C.utf8
            POSIX
            en_US
            en_US.iso88591
            en_US.utf8
            ja_JP.utf8

    2.  Current locale:

            LANG=ja_JP.UTF-8
            LC_CTYPE="ja_JP.UTF-8"
            LC_NUMERIC="ja_JP.UTF-8"
            LC_TIME="ja_JP.UTF-8"
            LC_COLLATE="ja_JP.UTF-8"
            LC_MONETARY="ja_JP.UTF-8"
            LC_MESSAGES=en_US.UTF-8
            LC_PAPER="ja_JP.UTF-8"
            LC_NAME="ja_JP.UTF-8"
            LC_ADDRESS="ja_JP.UTF-8"
            LC_TELEPHONE="ja_JP.UTF-8"
            LC_MEASUREMENT="ja_JP.UTF-8"
            LC_IDENTIFICATION="ja_JP.UTF-8"
            LC_ALL=

4.  Directories:

    1.  Home:

            /home/maruchan

    2.  `${XDG_CONFIG_HOME}`:

        Environment variable `XDG_CONFIG_HOME` is not set.

        Current value of `XDG_CONFIG_HOME` is `~/.config` (`/home/maruchan/.config`).

    3.  Fcitx Settings Directory:

        Current fcitx settings directory is `~/.config/fcitx` (`/home/maruchan/.config/fcitx`).

5.  Current user:

    The script is run as maruchan (1000).

# Fcitx State:
1.  executable:

    Found fcitx at `/usr/bin/fcitx`.

2.  version:

    Fcitx version: `4.2.9.5`

3.  process:

    Found 1 fcitx process:

          12050 fcitx-config-gt

4.  `fcitx-remote`:

    **Cannot connect to fcitx correctly.**

5.  DBus interface:

    Using `dbus-send` to check dbus.

    **Cannot find DBus name `org.fcitx.Fcitx` owner.**

    **Cannot find pid of DBus name `org.fcitx.Fcitx` owner.**

# Fcitx Configure UI:
1.  Config Tool Wrapper:

    Found fcitx-configtool at `/usr/bin/fcitx-configtool`.

2.  Config GUI for gtk2:

    **Config GUI for gtk2 not found.**

3.  Config GUI for gtk3:

    Found `fcitx-config-gtk3` at `/usr/bin/fcitx-config-gtk3`.

4.  Config GUI for kde:

    **`kcmshell4` not found.**

# Frontends setup:
## Xim:
1.  `${XMODIFIERS}`:

    **XMODIFIERS is not set**

    **Please set environment variable XMODIFIERS to "@im=fcitx" using the tool your distribution provides or add `export XMODIFIERS=@im=fcitx` to your `~/.xprofile`. See [Input Method Related Environment Variables: XMODIFIERS](http://fcitx-im.org/wiki/Input_method_related_environment_variables#XMODIFIERS).**
    Xim Server Name from Environment variable is fcitx.

2.  XIM_SERVERS on root window:

    **Cannot find xim_server on root window.**

## Qt:
1.  qt4 - `${QT4_IM_MODULE}`:

    **Please set environment variable QT_IM_MODULE to "fcitx" using the tool your distribution provides or add `export QT_IM_MODULE=fcitx` to your `~/.xprofile`. See [Input Method Related Environment Variables: QT_IM_MODULE](http://fcitx-im.org/wiki/Input_method_related_environment_variables#QT_IM_MODULE).**

2.  qt5 - `${QT_IM_MODULE}`:

    **Please set environment variable QT_IM_MODULE to "fcitx" using the tool your distribution provides or add `export QT_IM_MODULE=fcitx` to your `~/.xprofile`. See [Input Method Related Environment Variables: QT_IM_MODULE](http://fcitx-im.org/wiki/Input_method_related_environment_variables#QT_IM_MODULE).**

3.  Qt IM module files:

    Found fcitx qt module: `/usr/lib64/fcitx/qt/libfcitx-quickphrase-editor5.so`.
    Found fcitx im module for Qt5: `/usr/lib64/qt5/plugins/platforminputcontexts/libfcitxplatforminputcontextplugin.so`.
    **Cannot find fcitx input method module for Qt4.**

## Gtk:
1.  gtk - `${GTK_IM_MODULE}`:

    **Please set environment variable GTK_IM_MODULE to "fcitx" using the tool your distribution provides or add `export GTK_IM_MODULE=fcitx` to your `~/.xprofile`. See [Input Method Related Environment Variables: GTK_IM_MODULE](http://fcitx-im.org/wiki/Input_method_related_environment_variables#GTK_IM_MODULE).**

2.  `gtk-query-immodules`:

    1.  gtk 2:

        Found `gtk-query-immodules` for gtk `2.24.32` at `/usr/bin/gtk-query-immodules-2.0`.
        Version Line:

            # Created by /usr/bin/gtk-query-immodules-2.0 from gtk+-2.24.32

        **Failed to find fcitx in the output of `/usr/bin/gtk-query-immodules-2.0`**

        **Cannot find fcitx im module for gtk 2.**

    2.  gtk 3:

        Found `gtk-query-immodules` for gtk `3.24.16` at `/usr/bin/gtk-query-immodules-3.0`.
        Version Line:

            # Created by /usr/bin/gtk-query-immodules-3.0 from gtk+-3.24.16

        Found fcitx im modules for gtk `3.24.16`.

            "/usr/lib64/gtk-3.0/3.0.0/immodules/im-fcitx.so" 
            "fcitx" "Fcitx (Flexible Input Method Framework)" "fcitx" "/usr/share/locale" "ja:ko:zh:*" 

3.  Gtk IM module cache:

    1.  gtk 2:

        Found immodules cache for gtk `2.24.32` at `/usr/lib64/gtk-2.0/2.10.0/immodules.cache`.
        Version Line:

            # Created by /usr/bin/x86_64-pc-linux-gnu-gtk-query-immodules-2.0 from gtk+-2.24.32

        **Failed to find fcitx in immodule cache at `/usr/lib64/gtk-2.0/2.10.0/immodules.cache`**

        **Cannot find fcitx im module for gtk 2 in cache.**

    2.  gtk 3:

        Found immodules cache for gtk `3.24.16` at `/usr/lib64/gtk-3.0/3.0.0/immodules.cache`.
        Version Line:

            # Created by /usr/bin/x86_64-pc-linux-gnu-gtk-query-immodules-3.0 from gtk+-3.24.16

        Found fcitx im modules for gtk `3.24.16`.

            "/usr/lib64/gtk-3.0/3.0.0/immodules/im-fcitx.so" 
            "fcitx" "Fcitx (Flexible Input Method Framework)" "fcitx" "/usr/share/locale" "ja:ko:zh:*" 

4.  Gtk IM module files:

    1.  gtk 2:

        All found Gtk 2 immodule files exist.

    2.  gtk 3:

        All found Gtk 3 immodule files exist.

# Configuration:
## Fcitx Addons:
1.  Addon Config Dir:

    Found fcitx addon config directory: `/usr/share/fcitx/addon`.

2.  Addon List:

    1.  Found 27 enabled addons:

            fcitx-autoeng
            fcitx-chttrans
            fcitx-classic-ui
            fcitx-clipboard
            fcitx-dbus
            fcitx-freedesktop-notify
            fcitx-fullwidth-char
            fcitx-imselector
            fcitx-ipc
            fcitx-ipcportal
            fcitx-keyboard
            fcitx-kimpanel-ui
            fcitx-mozc
            fcitx-notificationitem
            fcitx-pinyin-enhance
            fcitx-pinyin
            fcitx-punc
            fcitx-quickphrase
            fcitx-remote
            fcitx-spell
            fcitx-table
            fcitx-unicode
            fcitx-vk
            fcitx-x11
            fcitx-xim
            fcitx-xkb
            fcitx-xkbdbus

    2.  Found 1 disabled addons:

            fcitx-qw

3.  Addon Libraries:

    All libraries for all addons are found.

4.  User Interface:

    Found 2 enabled user interface addons:

        fcitx-classic-ui
        fcitx-kimpanel-ui

## Input Methods:
1.  Found 0 enabled input methods:

2.  Default input methods:

    **You don't have any input methods enabled.**

# Log:
1.  `date`:

        2020年  4月  5日 日曜日 13:16:19 JST

2.  `~/.config/fcitx/log/`:

        total 4
        -rw-r--r-- 1 maruchan maruchan 665  4月  5 13:02 crash.log

3.  `~/.config/fcitx/log/crash.log`:

        =========================
        FCITX 4.2.9.5 -- Get Signal No.: 11
        Date: try "date -d @1586059373" if you are using GNU date ***
        ProcessID: 3535
        fcitx(+0x197f)[0x55f8e11c697f]
        /lib64/libc.so.6(+0x38a20)[0x7f8ae1ab9a20]
        /usr/lib64/libdbus-1.so.3(dbus_connection_send_with_reply+0x26)[0x7f8ae1469566]
        /usr/lib64/fcitx/fcitx-xkbdbus.so(+0x29c8)[0x7f8ae05ad9c8]
        /usr/lib64/libfcitx-core.so.0(FcitxModuleLoad+0x1d0)[0x7f8ae1ca9260]
        /usr/lib64/libfcitx-core.so.0(+0xb052)[0x7f8ae1c9b052]
        /usr/lib64/libfcitx-core.so.0(FcitxInstanceRun+0x5f)[0x7f8ae1c9badf]
        fcitx(+0x12bf)[0x55f8e11c62bf]
        /lib64/libc.so.6(__libc_start_main+0xeb)[0x7f8ae1aa4e1b]
        fcitx(+0x133a)[0x55f8e11c633a]

