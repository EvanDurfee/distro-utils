# https://just.systems

install:
    sudo cp ./bin/flatpak-sync /usr/libexec/flatpak-sync
    sudo cp ./units/system/flatpak-sync-install.service /usr/lib/systemd/system/flatpak-sync-install.service

uninstall:
    sudo rm -f /usr/libexec/flatpak-sync
    sudo rm -f /usr/lib/systemd/system/flatpak-sync-install.service
