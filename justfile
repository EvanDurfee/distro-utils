# https://just.systems

install:
    sudo cp ./bin/distrobox-auto /usr/libexec/distrobox-auto
    sudo cp ./units/user/distrobox-auto-{pull.service,pull.timer,assemble.service} /usr/lib/systemd/user/

uninstall:
    sudo rm -f /usr/libexec/distrobox-auto
    sudo rm -f /usr/lib/systemd/user/distrobox-auto-{pull.service,pull.timer,assemble.service}
