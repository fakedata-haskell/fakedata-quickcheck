OPTIMIZATION=-O0
build: 
	cabal new-build all -j --ghc-options $(OPTIMIZATION)

haddock:
	cabal new-haddock all

haddock-hackage:
	cabal new-haddock all --haddock-for-hackage --haddock-option=--hyperlinked-source
	echo "the hackage ui doesn't accept the default format, use command instead"
	cabal upload -d --publish ./dist-newstyle/*-docs.tar.gz

hpack:
	nix-shell ./nix/hpack-shell.nix --run "make update-cabal"

ghcid: clean hpack etags
	nix-shell --run "ghcid -s \"import Main\" -c \"cabal new-repl\" -T \"main\" test:unit"

ghci:
	nix-shell --run "cabal new-repl test:unit"

etags:
	nix-shell --run "hasktags  -e ./src"

update-cabal:
	hpack --force ./

enter:
	nix-shell --cores 0 -j 8 --pure

RUN=""
run-in-shell:
	nix-shell --cores 0 -j 8 --run "$(RUN)"

clean:
	rm -fR dist dist-*

.PHONY: test

sdist:
	make run-in-shell RUN="cabal sdist"

run_:
	cabal new-run exe --ghc-options $(OPTIMIZATION) -- \
	    # whatever option to haskell program

run:
	nix-shell --run "make run_"

brittany_:
	$(shell set -x; for i in `fd hs`; do hlint --refactor --refactor-options=-i $$i; brittany --write-mode=inplace $$i; done)

brittany:
	nix-shell ./nix/travis-shell.nix --run "make brittany_"
