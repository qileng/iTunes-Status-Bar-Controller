//
//  Controller.swift
//  iTunes Status Bar Controller
//
//  Created by Qihao Leng on 6/4/18.
//

import Cocoa
import AppKit

enum TrackPosition: String {
	case previous = "previous"
	case current = "current"
	case next = "next"
}

class iTunesController: NSObject, NSMenuDelegate {
	
	var isPreviouslyRunning: Bool = false
	
	override init() {
		super.init()
	}

	func setUp(_ s: inout NSStatusItem, _ a: AppDelegate) {
		self.isPreviouslyRunning = true
		let menu =  NSMenu(title: "iTunes Controller")
		let playPause = NSMenuItem(title: "Play/Pause", action: #selector(a.setPlayPause), keyEquivalent: String())
//		let nextTrackName = self.getTrackName(.next)
		let playNext = NSMenuItem(title: "Play Next", action: #selector(a.playNext), keyEquivalent: String())
		let currentTrack: NSMenuItem
		if !self.isStopped() {
			let currentTackName = self.getTrackName(.current)
			currentTrack = NSMenuItem(title: "Now Playing: " + currentTackName, action: nil, keyEquivalent: String())
		} else {
			currentTrack = NSMenuItem(title: "Player Stopped ", action: nil, keyEquivalent: String())
		}
		let backTrack = NSMenuItem(title: "Back Track", action: #selector(a.backTrack), keyEquivalent: String())
//		let previousTrackName = self.getTrackName(.previous)
		let playPrevious = NSMenuItem(title: "Play Previous", action: #selector(a.playPrevious), keyEquivalent: String())
		menu.addItem(currentTrack)
		menu.addItem(playPause)
		menu.addItem(playNext)
		menu.addItem(backTrack)
		menu.addItem(playPrevious)
		for item in menu.items {
			item.target = a
		}
		s.menu = menu
		s.menu!.autoenablesItems = true
		s.menu!.delegate = a
		s.image = #imageLiteral(resourceName: "iTunes")
	}
	
	func setUpEmpty(_ s: inout NSStatusItem, _ a: AppDelegate) {
		let menu =  NSMenu(title: "iTunes Controller")
		let notRunning = NSMenuItem(title: "iTunes not running", action: nil, keyEquivalent: String())
		
		menu.addItem(notRunning)
		
		s.menu = menu
		s.menu!.autoenablesItems = true
		s.menu!.delegate = a
		s.image = #imageLiteral(resourceName: "iTunes")
	}
	
	func update(_ menu: NSMenu) {		
		
		if !self.isStopped() {
			let currentTrackName = self.getTrackName(.current)
			//		let nextTrackName = self.getTrackName(.next)
			//		let previousTrackName = self.getTrackName(.previous)
			
			menu.items[0].title = "Now Playing: " + currentTrackName
			//		menu.items[2].title = "Play Next: " + nextTrackName
			//		menu.items[4].title = "Play Previous: " + previousTrackName
		} else {
			menu.items[0].title = "Player Stopped."
		}
	}
	
	func isPlaying() -> Bool {
		let command = "tell application \"iTunes\" \n player state \n end tell"
		var error: NSDictionary?
		let result: String?
		result = NSAppleScript(source: command)!.executeAndReturnError(&error).stringValue
		return iTunesEPlS.playing.rawValue == result!.toUTF8()
	}
	
	func isPaused() -> Bool {
		let command = "tell application \"iTunes\" \n player state \n end tell"
		var error: NSDictionary?
		let result: String?
		result = NSAppleScript(source: command)!.executeAndReturnError(&error).stringValue
		return iTunesEPlS.paused.rawValue == result!.toUTF8()
	}
	
	func isStopped() -> Bool {
		let command = "tell application \"iTunes\" \n player state \n end tell"
		var error: NSDictionary?
		let result: String?
		result = NSAppleScript(source: command)!.executeAndReturnError(&error).stringValue
		return iTunesEPlS.stopped.rawValue == result!.toUTF8()
	}
	
	func getTrackName(_ t: TrackPosition) -> String {
		var command = "tell application \"iTunes\" \n "
		command += t.rawValue
		command += " track's name \n end tell"
		var error: NSDictionary?
		let result: String?
		result = NSAppleScript(source: command)!.executeAndReturnError(&error).stringValue
		return result!
	}

//	@objc func setPlayPause() {
//		let command = "tell application \"iTunes\" \n playpause \n end tell"
//		var error: NSDictionary?
//		NSAppleScript(source: command)!.executeAndReturnError(&error)
//	}
//	
//	func menuDidClose(_ menu: NSMenu) {
//		self.update(menu)
//	}
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

