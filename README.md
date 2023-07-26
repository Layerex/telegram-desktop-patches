# telegram-desktop-patches

Patches disabling some anti-features of [Telegram Desktop](https://desktop.telegram.org/).

## Installation

### Arch Linux

```sh
makepkg -si
```

### Other systems

Download source code of Telegram Desktop and run commands from prepare(), build() and package() in PKGBUILD manually.

## Patches

### 0001-Disable-sponsored-messages.patch

### 0002-Disable-saving-restrictions.patch

Enables saving media, selecting and copying messages in channels, which disallow doing so.

### 0003-Disable-invite-peeking-restrictions.patch

Disables restrictions for viewing and exporting private chats and channels you didn't join but are able to view.

### 0004-Disable-accounts-limit.patch

## Contributing

Feel free to contibute patches and means of packaging and installation.

## Credits

[telegram-desktop-no-ads-pkgbuild](https://github.com/vehlwn/telegram-desktop-no-ads-pkgbuild)
