dnl procedures
dnl remove_last_newline(STRING)
define(`remove_last_newline', `substr(`$1', 0, decr(len(`$1')))')dnl
dnl format_lines(LINES,LINE_START,LINE_END,LINE_PREFIX)
define(`format_lines', `$2patsubst(remove_last_newline(`$1'), `
', `$3
$4$2')$3')dnl
dnl defines
define(`patches',`esyscmd(`printf "%s\n" *.patch')')dnl
define(`hashes', `patsubst(esyscmd(`sha512sum *.patch'), `  .*', `')')dnl
define(`PATCH_FILENAMES',format_lines(patches,`"',`"',`        '))dnl
define(`PATCH_HASHES',format_lines(hashes,`"',`"',`            '))dnl
define(`PATCH_COMMANDS',format_lines(patches,`patch --forward --strip=1 -i "${srcdir}/',`"',`    '))dnl
dnl undefines
undefine(`remove_last_newline')dnl
undefine(`format_lines')dnl
undefine(`patches')dnl
undefine(`hashes')dnl
dnl template
# https://gitlab.archlinux.org/archlinux/packaging/packages/telegram-desktop/-/blob/main/PKGBUILD
pkgname=telegram-desktop-patched
pkgver=4.14.9
pkgrel=1
pkgdesc='Telegram Desktop client with some anti-features (sponsored messages, saving restrictions and other) disabled.'
arch=('x86_64')
url="https://github.com/Layerex/telegram-desktop-patches"
license=('GPL3')
depends=('hunspell' 'ffmpeg' 'hicolor-icon-theme' 'lz4' 'minizip' 'openal' 'ttf-opensans'
         'qt6-imageformats' 'qt6-svg' 'qt6-wayland' 'xxhash'
         'rnnoise' 'pipewire' 'libxtst' 'libxrandr' 'libxcomposite' 'abseil-cpp' 'libdispatch'
         'openssl' 'protobuf' 'glib2' 'libsigc++-3.0' 'glibmm-2.68')
makedepends=('cmake' 'git' 'ninja' 'python' 'range-v3' 'tl-expected' 'microsoft-gsl' 'meson'
             'extra-cmake-modules' 'wayland-protocols' 'plasma-wayland-protocols' 'libtg_owt'
             'gobject-introspection' 'boost' 'fmt' 'mm-common' 'perl-xml-parser')
optdepends=('webkit2gtk: embedded browser features'
            'xdg-desktop-portal: desktop integration')
conflicts=("telegram-desktop")
source=("https://github.com/telegramdesktop/tdesktop/releases/download/v${pkgver}/tdesktop-${pkgver}-full.tar.gz"
        PATCH_FILENAMES)
sha512sums=('802ec7eeef75ac97934cb0437c24dab62670f7029a1a5e44866cd77d39d7b572b79106c0b73bd742786548db938c49ba2e559123963ef0201adaa279b4cf9fa4'
            PATCH_HASHES)

prepare() {
    cd tdesktop-$pkgver-full
    PATCH_COMMANDS
}

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
