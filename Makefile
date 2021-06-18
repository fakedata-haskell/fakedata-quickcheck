.DEFAULT_GOAL = help

## Nix shell for lts18
shell-lts18:
	nix-shell --attr lts18 release.nix

## Nix shell for lts16
shell-lts16:
	nix-shell --attr lts16 release.nix

## Nix shell for lts14
shell-lts14:
	nix-shell --attr lts14 release.nix

## Enter nix-shell
shell:
	nix-shell --pure

## Test the project
test:
	stack --nix test

## Show help screen.
help:
	@echo "Please use \`make <target>' where <target> is one of\n"
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "%-30s %s\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)
