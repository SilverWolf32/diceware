# Diceware

A simple tool to generate Diceware ([XKCD-style][xkcd]) passwords, written in Swift.

> Diceware **automatically connects to the Internet** to fetch a word list unless one is already cached, or a local file is specified on the command line. See "Word lists" below for more information.

## Compilation

You'll need Swift. You can get it from https://swift.org, or by installing Xcode if you're on a Mac.

Then simply run `make`. There are no other dependencies.

## Usage

```
diceware
diceware word-count [wordlist-file-or-URL]

diceware --help
```

| Defaults   |                                |
|------------|--------------------------------|
| # of words | 5                              |
| Word list  | [EFF large wordlist][wordlist] |

## Randomness

Diceware uses `/dev/random` to generate your password. This is then converted to a range from 1 to 6 using Swift's `Int.random(in: using:)` method (using a straight modulus would skew the distribution).

## Word lists

The wordlist to use is **automatically downloaded** and cached. If no wordlist is given, it defaults to [the EFF's large wordlist][wordlist].

The download only happens if the wordlist isn't already cached from the last run; this will be once per wordlist, unless you clear your caches.

Wordlists are cached in `~/Library/Caches/diceware` on OS X, and `~/.cache/diceware` on other systems.

##### Preventing the initial download

To prevent the initial download, you can obtain the default wordlist from somewhere and put it in the cache folder ahead of time. You'll need to create the `diceware` folder to put it in. (Wordlist caches use the filename from the server or local file, or the domain name if there is no filename.)

[wordlist]: https://www.eff.org/files/2016/07/18/eff_large_wordlist.txt
[xkcd]: https://xkcd.com/936/
