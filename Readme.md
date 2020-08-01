[![https://jappieklooster.nl](https://img.shields.io/badge/blog-jappieklooster.nl-lightgrey)](https://jappieklooster.nl/tag/haskell.html)
[![Jappiejappie](https://img.shields.io/badge/twitch.tv-jappiejappie-purple?logo=twitch)](https://www.twitch.tv/jappiejappie)
[![Jappiejappie](https://img.shields.io/badge/youtube-jappieklooster-red?logo=youtube)](https://www.youtube.com/channel/UCQxmXSQEYyCeBC6urMWRPVw)
[![Build status](https://img.shields.io/travis/jappeace/haskell-template-project)](https://travis-ci.org/jappeace/haskell-template-project/builds/)
[![Jappiejappie](https://img.shields.io/badge/discord-jappiejappie-black?logo=discord)](https://discord.gg/Hp4agqy)

# Haskell project template

Using cabal within a nix shell.
If you like nix this is a good way of doing haskell dev.

similar to: https://github.com/monadfix/nix-cabal
except this has a makefile and ghcid.
We also make aggressive use of [pinning](https://nixos.wiki/wiki/FAQ/Pinning_Nixpkgs)
to have consistency.

Comes with:
+ [GHCID](https://jappieklooster.nl/ghcid-for-multi-package-projects.html)
+ a nix shell, meaning somewhat platform independence.
  + which is pinned by default
+ A couple of handy make commands.
+ Starting haskell files, assuming we put practically all code in library
+ Working HSpec, The detection macro will pickup any file ending with Spec.hs
