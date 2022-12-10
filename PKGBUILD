# https://github.com/archlinux/svntogit-community/blob/packages/telegram-desktop/trunk/PKGBUILD
pkgname=telegram-desktop-no-ads
pkgver=4.4.1
pkgrel=2
pkgdesc='Patched Telegram Desktop client without ads'
arch=('x86_64')
url="https://desktop.telegram.org/"
license=('GPL3')
depends=('hunspell' 'ffmpeg' 'hicolor-icon-theme' 'lz4' 'minizip' 'openal' 'ttf-opensans'
         'qt6-imageformats' 'qt6-svg' 'qt6-wayland' 'qt6-5compat' 'xxhash' 'glibmm-2.68'
         'rnnoise' 'pipewire' 'libxtst' 'libxrandr' 'jemalloc' 'abseil-cpp' 'libdispatch'
         'openssl-1.1' 'protobuf')
makedepends=('cmake' 'git' 'ninja' 'python' 'range-v3' 'tl-expected' 'microsoft-gsl' 'meson'
             'extra-cmake-modules' 'wayland-protocols' 'plasma-wayland-protocols' 'libtg_owt')
optdepends=('webkit2gtk: embedded browser features'
            'xdg-desktop-portal: desktop integration')
conflicts=("telegram-desktop")
source=(
    "https://github.com/telegramdesktop/tdesktop/releases/download/v${pkgver}/tdesktop-${pkgver}-full.tar.gz"
    "0001-Disable-sponsored-messages.patch"
)
sha256sums=(
    "76981e32541c42b3212427e9abb4db2a6f55a14eaba31b3d7ad7d3d5ed8008b1"
    "5f47426d882b6544d2cbb536a9fcc3ed13b6b7d035b713ccd8375d12536d71fe"
)

prepare() {
    cd tdesktop-$pkgver-full
    patch --forward --strip=1 -i "${srcdir}/0001-Disable-sponsored-messages.patch"
}

build() {
    cd tdesktop-$pkgver-full
    cmake \
        -B build \
        -G Ninja \
        -DCMAKE_COLOR_DIAGNOSTICS=ON \
        -DCMAKE_INSTALL_PREFIX="/usr" \
        -DCMAKE_BUILD_TYPE=Release \
        -DTDESKTOP_API_ID=611335 \
        -DTDESKTOP_API_HASH=d524b414d21f4d37f08684c1df41ac9c
    cmake --build build --parallel $(nproc)
}

package() {
    cd tdesktop-$pkgver-full
    DESTDIR="$pkgdir" cmake --install build
}
