//
// DevRandomGenerator.swift
// diceware
//
// Created by ArgentWolf (SilverWolf32) on 2019-04-17
//
// Generates random numbers from /dev/random.
//
// vim:set list noet fo=tcqr:
//

import Foundation

class DevRandomGenerator: RandomNumberGenerator {
	
	private var filepointer: UnsafeMutablePointer<FILE>? = nil
	
	init() {
		// open /dev/random
		filepointer = fopen("/dev/random", "r")
	}
	deinit {
		// close the file
		fclose(filepointer)
		filepointer = nil
	}
	
	func next() -> UInt64 {
		// get a byte
		// /dev/random will block instead of just returning EOF, right?
		return UInt64(getc(filepointer))
	}
	
}
