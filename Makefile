#
# Makefile for diceware
# vim:set fo=tcqr:
#
# This is free and unencumbered software released into the public domain.
# See COPYING.md for more information.
#

diceware: *.swift
	swiftc -g -lncurses -o diceware *.swift

clean:
	rm -f diceware
	rm -rf *.dSYM/
