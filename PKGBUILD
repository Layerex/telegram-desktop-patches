# https://github.com/archlinux/svntogit-community/blob/packages/telegram-desktop/trunk/PKGBUILD
pkgname=telegram-desktop-no-ads
pkgver=4.0.0
pkgrel=1
pkgdesc='Patched Telegram Desktop client without ads'
arch=('x86_64')
url="https://desktop.telegram.org/"
license=('GPL3')
depends=('hunspell' 'ffmpeg4.4' 'hicolor-icon-theme' 'lz4' 'minizip' 'openal' 'ttf-opensans'
         'qt6-imageformats' 'qt6-svg' 'qt6-wayland' 'qt6-5compat' 'xxhash' 'glibmm'
         'rnnoise' 'pipewire' 'libxtst' 'libxrandr' 'jemalloc' 'abseil-cpp' 'libdispatch')
makedepends=('cmake' 'git' 'ninja' 'python' 'range-v3' 'tl-expected' 'microsoft-gsl' 'meson'
             'extra-cmake-modules' 'wayland-protocols' 'plasma-wayland-protocols' 'libtg_owt')
optdepends=('webkit2gtk: embedded browser features'
            'xdg-desktop-portal: desktop integration')
conflicts=("telegram-desktop")
source=(
    "https://github.com/telegramdesktop/tdesktop/releases/download/v${pkgver}/tdesktop-${pkgver}-full.tar.gz"
    "0001-Disable-sponsored-messages.patch"
    "fix-tgcalls-cstdint.patch"
)
sha256sums=(
    "f4ff20e1ac8ffdd4066d708f835fb1168c83bf4b74a20a52c9a31a0305e5a0c7"
    "5f47426d882b6544d2cbb536a9fcc3ed13b6b7d035b713ccd8375d12536d71fe"
    "b0e31e8084cc0f67bcb147fcf975a90c98c853bd64206691c857c769073a1485"
)

prepare() {
    cd tdesktop-$pkgver-full
    patch --forward --strip=1 -i "${srcdir}/fix-tgcalls-cstdint.patch" -d Telegram/ThirdParty/tgcalls
    patch --forward --strip=1 -i "${srcdir}/0001-Disable-sponsored-messages.patch"
}

build() {
    cd tdesktop-$pkgver-full
    export PKG_CONFIG_PATH='/usr/lib/ffmpeg4.4/pkgconfig'
    cmake \
        -B build \
        -G Ninja \
        -DCMAKE_INSTALL_PREFIX="/usr" \
        -DCMAKE_BUILD_TYPE=Release \
        -DTDESKTOP_API_ID=611335 \
        -DTDESKTOP_API_HASH=d524b414d21f4d37f08684c1df41ac9c
    sed -i "s|/usr/lib/libav|/usr/lib/ffmpeg4.4/libav|g" build/build.ninja
    sed -i "s|/usr/lib/libsw|/usr/lib/ffmpeg4.4/libsw|g" build/build.ninja
    sed -i "s|-lavcodec|/usr/lib/ffmpeg4.4/libavcodec.so|g" build/build.ninja
    sed -i "s|-lavformat|/usr/lib/ffmpeg4.4/libavformat.so|g" build/build.ninja
    sed -i "s|-lavutil|/usr/lib/ffmpeg4.4/libavutil.so|g" build/build.ninja
    sed -i "s|-lswscale|/usr/lib/ffmpeg4.4/libswscale.so|g" build/build.ninja
    sed -i "s|-lswresample|/usr/lib/ffmpeg4.4/libswresample.so|g" build/build.ninja
    cmake --build build --parallel $(($(nproc)+1))
}

package() {
    cd tdesktop-$pkgver-full
    DESTDIR="$pkgdir" cmake --install build
}
