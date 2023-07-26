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
        "0001-Disable-sponsored-messages.patch"
        "0002-Disable-saving-restrictions.patch"
        "0003-Disable-invite-peeking-restrictions.patch"
        "0004-Disable-accounts-limit.patch")
sha512sums=('56c6a2f1733e4b0d87570541dcad03e6ebf13c461a748cda6136d85b2fb939d2245c41db0c212a70fa998ad73d0578df0381bfdcebc0fd352344a67134b6aad9'
    '6650e822de2529582d93291025500afb6a182a0c5a564f656f164d79d8765bb4ca9c9d16227148431cc71c2677923b9364e81bbd4ca4f07f68e36bb380fb9574'
    "d5898c0f12a90c39f277b874d9650b7e9ebea224f49e635c0c4275801d228a435b6b1ba0614ade1ade7eca63c4a4434779f056dd8950e2cb1c1ed9438adaa904"
    "b8d748c2323fd1092555604f8643577ae3f84e7d6babc0b4fec4509b27186827ad197f6f7cd5e7222a49b6b65557fd306c27701a0d1100289d32a825b615d793"
    "2c19b303ce77aa5b92dcbc46e61c0f45a5eb5fdb8810bd5f86a5d51acc4a79d6c41742d5197a0d72a6224e5f26855ab74ed35b5d085e8ba713cc9c87d8f54897"
    "cba09b95960960f5657b5482389deb75abad8f4200f4809943e1ca873c19cf4caa99ef79f0ff32ecb17337e1b375523e310bc5e8843d13c8b3a5dff705ca9218")

prepare() {
    cd tdesktop-$pkgver-full
    patch --forward --strip=1 -i "${srcdir}/0001-Disable-sponsored-messages.patch"
    patch --forward --strip=1 -i "${srcdir}/0002-Disable-saving-restrictions.patch"
    patch --forward --strip=1 -i "${srcdir}/0003-Disable-invite-peeking-restrictions.patch"
    patch --forward --strip=1 -i "${srcdir}/0004-Disable-accounts-limit.patch"
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
