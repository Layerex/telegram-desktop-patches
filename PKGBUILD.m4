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
define(`PATCH_HASHES',format_lines(hashes,`"',`"',`    '))dnl
define(`PATCH_COMMANDS',format_lines(patches,`patch --forward --strip=1 -i "${srcdir}/',`"',`    '))dnl
dnl undefines
undefine(`remove_last_newline')dnl
undefine(`format_lines')dnl
undefine(`patches')dnl
undefine(`hashes')dnl
dnl template
# https://gitlab.archlinux.org/archlinux/packaging/packages/telegram-desktop/-/blob/main/PKGBUILD
pkgname=telegram-desktop-patched
pkgver=4.8.9
pkgrel=1
pkgdesc='Telegram Desktop client with some anti-features (sponsored messages, saving restrictions and other) disabled.'
arch=('x86_64')
url="https://github.com/Layerex/telegram-desktop-patches"
license=('GPL3')
depends=('hunspell' 'ffmpeg' 'hicolor-icon-theme' 'lz4' 'minizip' 'openal' 'ttf-opensans'
         'qt6-imageformats' 'qt6-svg' 'qt6-wayland' 'xxhash'
         'rnnoise' 'pipewire' 'libxtst' 'libxrandr' 'jemalloc' 'abseil-cpp' 'libdispatch'
         'openssl' 'protobuf' 'glib2' 'libsigc++-3.0')
makedepends=('cmake' 'git' 'ninja' 'python' 'range-v3' 'tl-expected' 'microsoft-gsl' 'meson'
             'extra-cmake-modules' 'wayland-protocols' 'plasma-wayland-protocols' 'libtg_owt'
             'gobject-introspection' 'boost' 'fmt' 'mm-common' 'perl-xml-parser' 'libsigc++-3.0')
optdepends=('webkit2gtk: embedded browser features'
            'xdg-desktop-portal: desktop integration')
conflicts=("telegram-desktop")
source=("https://github.com/telegramdesktop/tdesktop/releases/download/v${pkgver}/tdesktop-${pkgver}-full.tar.gz"
        https://download.gnome.org/sources/glibmm/2.77/glibmm-2.77.0.tar.xz
        PATCH_FILENAMES)
sha512sums=('56c6a2f1733e4b0d87570541dcad03e6ebf13c461a748cda6136d85b2fb939d2245c41db0c212a70fa998ad73d0578df0381bfdcebc0fd352344a67134b6aad9'
    '6650e822de2529582d93291025500afb6a182a0c5a564f656f164d79d8765bb4ca9c9d16227148431cc71c2677923b9364e81bbd4ca4f07f68e36bb380fb9574'
    PATCH_HASHES)

prepare() {
    cd tdesktop-$pkgver-full
    PATCH_COMMANDS
}

build() {
    CXXFLAGS+=' -ffat-lto-objects'

    # Telegram currently needs unstable glibmm so we bundle it in as static libs.
    # This isn't great but what can you do.
    meson setup -D maintainer-mode=true --default-library static --prefix "$srcdir/glibmm" glibmm-2.77.0 glibmm-build
    meson compile -C glibmm-build
    meson install -C glibmm-build

    export PKG_CONFIG_PATH="$srcdir"/glibmm/usr/local/lib/pkgconfig
    cmake -B build -S tdesktop-$pkgver-full -G Ninja \
        -DCMAKE_VERBOSE_MAKEFILE=ON \
        -DCMAKE_INSTALL_PREFIX="/usr" \
        -DCMAKE_PREFIX_PATH="$srcdir/glibmm" \
        -DCMAKE_BUILD_TYPE=Release \
        -DTDESKTOP_API_ID=611335 \
        -DTDESKTOP_API_HASH=d524b414d21f4d37f08684c1df41ac9c
    cmake --build build
}

package() {
    DESTDIR="$pkgdir" cmake --install build
}
