# Diceware

A simple tool to generate Diceware ([XKCD-style][xkcd]) passwords, written in Swift.

> Diceware **automatically connects to the Internet** to fetch a word list unless one is already cached, or a local file is specified on the command line. See "Word lists" below for more information.

## Usage

```
diceware
diceware word-count [wordlist-file-or-URL]

diceware --help
```

Defaults   |
-----------|-------------------------------
# of words | 5
Word list  | [EFF large wordlist][wordlist]

## Compilation

Simply run `make`. There are no dependencies other than the Foundation framework that comes with Swift.

## Randomness

Diceware uses `/dev/random` to generate your password. This is then converted to a range from 1 to 6 using Swift's `Int.random(in: using:)` method (using a straight modulus would skew the distribution).

## Word lists

It **automatically downloads** and caches the wordlist provided. If no wordlist is given, it defaults to [the EFF's large wordlist][wordlist].

The download only happens if the wordlist isn't already cached from the last run; this will be once per wordlist, unless you clear your caches.

Wordlists are cached in `~/Library/Caches/diceware` on OS X, and `~/.cache/diceware` on other systems.

[wordlist]: https://www.eff.org/files/2016/07/18/eff_large_wordlist.txt
[xkcd]: https://xkcd.com/936/
