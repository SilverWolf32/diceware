//
// String+escFormat.swift
// diceware
//
// Created by ArgentWolf (SilverWolf32) on 2019-04-17
//
// Format a String using escape sequences
//
// vim:set list noet fo=tcqr:
//

extension String {
	
	func underlined() -> String {
		return "\u{1B}[4m" + self + "\u{1B}[24m"
	}
	
}
