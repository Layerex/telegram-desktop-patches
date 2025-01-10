dnl procedures
dnl remove_last_newline(STRING)
define(`remove_last_newline', `substr(`$1', 0, decr(len(`$1')))')dnl
dnl format_lines(LINES,LINE_START,LINE_END,LINE_PREFIX)
define(`format_lines', `$2patsubst(remove_last_newline(`$1'), `
', `$3
$4$2')$3')dnl
dnl defines
define(`sum_cmd_output', `esyscmd(`sha512sum *.patch')')dnl
define(`patches',`patsubst(sum_cmd_output, `.*  ', `')')dnl
define(`hashes', `patsubst(sum_cmd_output, `  .*', `')')dnl
define(`PATCH_FILENAMES',format_lines(patches,`"',`"',`        '))dnl
define(`PATCH_HASHES',format_lines(hashes,`"',`"',`            '))dnl
define(`PATCH_COMMANDS',format_lines(patches,`patch --forward --strip=1 --input "${srcdir}/',`"',`    '))dnl
dnl undefines
undefine(`remove_last_newline')dnl
undefine(`format_lines')dnl
undefine(`sum_cmd_output')dnl
undefine(`patches')dnl
undefine(`hashes')dnl
dnl template
pkgname=telegram-desktop-patched
pkgdesc='Telegram Desktop client with some anti-features (sponsored messages, saving restrictions and other) disabled.'
url="https://github.com/Layerex/telegram-desktop-patches"
conflicts=("telegram-desktop")
provides=("telegram-desktop")
pkgrel=1

prepare() {
    cd tdesktop-$pkgver-full
    PATCH_COMMANDS
}
# To bump Telegram version, selectively paste upstream PKGBUILD below, retaining PATCH_FILENAMES and PATCH_HASHES
# https://gitlab.archlinux.org/archlinux/packaging/packages/telegram-desktop/-/blob/main/PKGBUILD
# Make sure you are modifying PKGBUILD.m4, not PKGBUILD, or your changes will be overwritten by make
pkgver=5.10.3
arch=('x86_64')
license=('GPL3')
depends=('hunspell' 'ffmpeg' 'hicolor-icon-theme' 'lz4' 'minizip' 'openal'
         'qt6-imageformats' 'qt6-svg' 'qt6-wayland' 'xxhash' 'ada'
         'rnnoise' 'pipewire' 'libxtst' 'libxrandr' 'libxcomposite' 'libxdamage' 'abseil-cpp' 'libdispatch'
         'openssl' 'protobuf' 'glib2' 'libsigc++-3.0' 'kcoreaddons' 'openh264')
makedepends=('cmake' 'git' 'ninja' 'python' 'range-v3' 'tl-expected' 'microsoft-gsl' 'meson'
             'extra-cmake-modules' 'wayland-protocols' 'plasma-wayland-protocols' 'libtg_owt'
             'gobject-introspection' 'boost' 'fmt' 'mm-common' 'perl-xml-parser' 'python-packaging'
             'glib2-devel')
optdepends=('webkit2gtk: embedded browser features'
            'xdg-desktop-portal: desktop integration')
source=("https://github.com/telegramdesktop/tdesktop/releases/download/v${pkgver}/tdesktop-${pkgver}-full.tar.gz"
        PATCH_FILENAMES)
sha512sums=('02a5db9b53309bd859aa7aa3400d8fc35873bb49f34395541c6d0ebfc41d90dc406844489d6f22afc5ea9d11bb3625c7715cb6de56f428e0957dfaae3c495431'
            PATCH_HASHES)

build() {
    CXXFLAGS+=' -ffat-lto-objects'

    cmake -B build -S tdesktop-$pkgver-full -G Ninja \
        -DCMAKE_VERBOSE_MAKEFILE=ON \
        -DCMAKE_INSTALL_PREFIX="/usr" \
        -DCMAKE_BUILD_TYPE=Release \
        -DTDESKTOP_API_ID=611335 \
        -DTDESKTOP_API_HASH=d524b414d21f4d37f08684c1df41ac9c
    cmake --build build
}

package() {
    DESTDIR="$pkgdir" cmake --install build
}
