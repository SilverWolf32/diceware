//
// main.swift
// diceware
//
// Created by ArgentWolf (SilverWolf32) on 2019-04-17
//
// vim:set list noet fo=tcqr:
//

import Foundation

var wordcount = 5
var list = "https://www.eff.org/files/2016/07/18/eff_large_wordlist.txt"

func printUsage() {
	print("""
	usage: \(CommandLine.arguments[0]) [\("word count".underlined())] [\("wordlist URL".underlined())]
	""")
}

// handle the arguments
if (CommandLine.arguments.count > 1) {
	if let tmpWordcount = Int(CommandLine.arguments[1]) {
		wordcount = tmpWordcount
	} else {
		printUsage()
		exit(1)
	}
}
if (CommandLine.arguments.count > 2) {
	list = CommandLine.arguments[2]
}

print("Word count: \(wordcount)")
print("List: \(list)")
