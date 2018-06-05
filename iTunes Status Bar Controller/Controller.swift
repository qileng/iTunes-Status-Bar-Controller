//
//  Controller.swift
//  iTunes Status Bar Controller
//
//  Created by Qihao Leng on 6/4/18.
//

import Cocoa

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
	
	
	static func isPlaying() -> Bool {
		let command = "tell application \"iTunes\" \n player state \n end tell"
		var error: NSDictionary?
		let result: String?
		result = NSAppleScript(source: command)!.executeAndReturnError(&error).stringValue
		return iTunesEPlS.playing.rawValue == result!.toUTF8()
	}
	
	static func isPaused() -> Bool {
		let command = "tell application \"iTunes\" \n player state \n end tell"
		var error: NSDictionary?
		let result: String?
		result = NSAppleScript(source: command)!.executeAndReturnError(&error).stringValue
		return iTunesEPlS.paused.rawValue == result!.toUTF8()
	}
}

extension String {
	
	func toUTF8() -> AEKeyword {
		var result = 0 as UInt32
		for char in Array(self.utf8) {
			result = result << 8 + UInt32(char)
		}
		
		return UInt32(result)
	}
}

