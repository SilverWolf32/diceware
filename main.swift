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
var wordlistURL = URL(string: "https://www.eff.org/files/2016/07/18/eff_large_wordlist.txt")!

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
	if let newList = URL(string: CommandLine.arguments[2]) {
		wordlistURL = newList
	} else {
		printUsage()
		print("(not a valid URL)")
		exit(1)
	}
}

print("Word count: \(wordcount)")
print("List: \(wordlistURL)")

////////////////////////////////////////

let homedir = FileManager.default.homeDirectoryForCurrentUser.path
var cachepath = ""
if FileManager.default.fileExists(atPath: homedir + "/Library/Caches") {
	// we're probably on a Mac, use ~/Library/Caches
	cachepath = homedir + "/Library/Caches/diceware/"
} else {
	// we're probably not on Mac, use ~/.cache instead
	cachepath = homedir + "/.cache/diceware/"
}

cachepath += wordlistURL.lastPathComponent

print("Checking for cached word list at \(cachepath)...", terminator: "")
if FileManager.default.fileExists(atPath: cachepath) {
	print("found")
	print("Using cached word list")
} else {
	print("not found")
	print("Fetching word list...")
}

