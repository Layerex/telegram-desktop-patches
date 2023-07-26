# https://github.com/archlinux/svntogit-community/blob/packages/telegram-desktop/trunk/PKGBUILD
pkgname=telegram-desktop-patched
pkgver=4.8.9
pkgrel=1
pkgdesc='Telegram Desktop client with some anti-features (sponsored messages, saving restrictions and other) disabled.'
arch=('x86_64')
url="https://github.com/Layerex/telegram-desktop-patches"
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
    "0002-Disable-saving-restrictions.patch"
    "0003-Disable-invite-peeking-restrictions.patch"
    "0004-Disable-accounts-limit.patch"
)
sha256sums=(
    "3448d879afdc7c5c06d2b0f9cabe339b08093cb25f380a3e398d32daa96a9c36"
    "5f47426d882b6544d2cbb536a9fcc3ed13b6b7d035b713ccd8375d12536d71fe"
    "836d7bb45d0a6555d10097f2d1dcf1f367ae7112a7194886565aaa05f56d1b88"
    "331d1b3a5f139da14556eb83da6498d0f94a8b16aeadc53f496c0cda72b3ebb2"
    "d397e41b9c1eec716a1b08906acc732052cc9d4c5d3007cc5c9d910ab03c6ee8"
)

prepare() {
    cd tdesktop-$pkgver-full
    patch --forward --strip=1 -i "${srcdir}/0001-Disable-sponsored-messages.patch"
    patch --forward --strip=1 -i "${srcdir}/0002-Disable-saving-restrictions.patch"
    patch --forward --strip=1 -i "${srcdir}/0003-Disable-invite-peeking-restrictions.patch"
    patch --forward --strip=1 -i "${srcdir}/0004-Disable-accounts-limit.patch"
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
