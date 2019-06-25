//
// String+escFormat.swift
// diceware
//
// Created by ArgentWolf (SilverWolf32) on 2019-04-17
//
// Format a String using escape sequences
//
// This is free and unencumbered software released into the public domain.
// See COPYING.md for more information.
//
// vim:set list noet fo=tcqr:
//

extension String {
	
	func underlined() -> String {
		return "\u{1B}[4m" + self + "\u{1B}[24m"
	}
	
}
