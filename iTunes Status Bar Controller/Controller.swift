//
//  Controller.swift
//  iTunes Status Bar Controller
//
//  Created by Qihao Leng on 6/4/18.
//

import Foundation
import Cocoa
import ScriptingBridge

extension NSStatusItem {
		
	func setUp() {
		let menu =  NSMenu(title: "iTunes Controller")
		menu.addItem(NSMenuItem(title: "Play", action: nil, keyEquivalent: String()))
		menu.addItem(NSMenuItem(title: "Pause", action: nil, keyEquivalent: String()))
		self.menu = menu
		self.image = #imageLiteral(resourceName: "iTunes")
	}
}

class iTunesController {
	
	let iTunes: iTunesApplication
	
	init() {
		iTunes = SBApplication(bundleIdentifier: "com.apple.iTunes")! as iTunesApplication
	}
	
	func isRunning() -> Bool {
		print(iTunes.isRunning)
		return iTunes.isRunning
	}
	
	func isPlaying() -> Bool {
		print(String(Int(iTunes.playerState!.rawValue), radix:16))
		return (iTunes.playerState! == .playing)
	}
}

