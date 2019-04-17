#
# Makefile for diceware
# vim:set fo=tcqr:
#

diceware: *.swift
	swiftc -g -lncurses -o diceware *.swift

clean:
	rm -f diceware
	rm -rf *.dSYM/
