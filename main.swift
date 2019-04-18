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
		fputs("(not a valid URL)\n", stderr)
		exit(1)
	}
}

// make it a file:// URL if it's a local path
if wordlistURL.scheme == nil {
	// fputs("Word list seems to be a local path, so making it a file URL\n", stderr)
	wordlistURL = URL(fileURLWithPath: wordlistURL.path)
}

// fputs("Word count: \(wordcount)\n", stderr)
// fputs("List: \(wordlistURL)\n", stderr)

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

do {
	var filename: String? = wordlistURL.lastPathComponent
	if filename! == "" {
		print("Couldn't get last path component, using domain instead")
		filename = wordlistURL.host
		guard filename != nil else {
			print("Couldn't get domain either!")
			print("Are you \("sure".underlined()) this is a valid URL?")
			exit(2)
		}
	}
	cachepath += filename!
}

var wordlistContents = ""
fputs("Checking for cached word list...", stderr)
if FileManager.default.fileExists(atPath: cachepath) {
	fputs("found\n", stderr)
	fputs("Using cached word list from \(cachepath)\n", stderr)
	do {
		wordlistContents = try String(contentsOfFile: cachepath)
	} catch let e {
		fputs("Error reading cached file! \(e.localizedDescription)\n", stderr)
		exit(2)
	}
} else {
	fputs("not found\n", stderr)
	fputs("Fetching word list from \(wordlistURL)...\n", stderr)
	
	// get the word list
	do {
		wordlistContents = try String(contentsOf: wordlistURL)
	} catch let e {
		fputs("Error fetching word list: \(e.localizedDescription)\n", stderr)
		exit(2)
	}
	fputs("Done!\n", stderr)
	
	// cache the word list
	fputs("Caching the word list for next time...\n", stderr)
	do {
		try wordlistContents.write(toFile: cachepath, atomically: true, encoding: .utf8)
	} catch let e {
		fputs("Error saving word list! \(e.localizedDescription)\n", stderr)
	}
	fputs("Saved word list to \(cachepath)\n", stderr)
}

// fputs("Word list contents: \n\(wordlistContents)\n", stderr)

////////////////////////////////////////

// find the number of dice
let lines = wordlistContents.components(separatedBy: "\n")
let firstID = lines[0].components(separatedBy: "\t")[0]
let nDice = firstID.count // number of digits = number of dice

// generate the word list
var generator = DevRandomGenerator()
var words: [String] = []
for _ in 0..<wordcount {
	// this would not limit to 1...6
	// let random6 = generator.next()
	
	// this is not uniform, DO NOT USE! It's just for testing whether % affects uniformity -- turns out, yes it does.
	// see https://crypto.stackexchange.com/questions/22767/does-using-modulo-affect-quality-of-randomness
	// let random6 = generator.next() % 7 + 1
	
	// print("\(random6)", terminator: " ")
	
	// get X random numbers to use for passwords
	var wordID = ""
	for _ in 0..<nDice {
		// 6-sided die
		let random6 = Int.random(in: 1...6, using: &generator)
		wordID += "\(random6)"
	}
	
	// get a random word
	let matchingLines = lines.filter {
		let components = $0.components(separatedBy: "\t")
		if components.count == 0 {
			return false // it's probably a blank line
		}
		return components[0] == wordID
	}
	// print(matchingWords)
	
	// there should be one, and only one, match
	if matchingLines.count == 0 {
		fputs("*** Couldn't find word #\(wordID)! ***\n", __stderrp)
		fputs("Your wordlist needs to have every possible sequence of \(nDice) numbers from 1 to 6.", stderr)
		exit(3)
	}
	let components = matchingLines[0].components(separatedBy: "\t")
	if components.count > 2 {
		// can't get the actual word out of it
		fputs("*** Couldn't find word on line #\(wordID)! ***\n", __stderrp)
		fputs("Your wordlist needs to have the format '\(String(repeating: "#", count: nDice)) <tab> <word>'\n", stderr)
		exit(3)
	}
	words.append(components[1])
}

// print out the words!
for i in 0..<words.count {
	print(words[i], terminator: "")
	if i != words.count - 1 { // not the last word
		print(" ", terminator: "")
	}
}
print("") // complete with a newline

