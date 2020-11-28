.PHONY: install log status

install:
	sudo ./scripts/install.sh

status:
	sudo systemctl status m3db

log:
	sudo journalctl -u m3dbnode -f
