//
//  AppDelegate.swift
//  iTunes Status Bar Controller
//
//  Created by Qihao Leng on 6/4/18.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSMenuDelegate {
	
	var statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
	var myController: iTunesController?
	
	func applicationDidFinishLaunching(_ aNotification: Notification) {
		// Insert code here to initialize your application
		myController = iTunesController(&statusItem, self)
//		statusItem.menu!.items[0].target = myController
//		statusItem.menu!.items[0].action = #selector(myController.setPlayPause)
//		print(myController.isPlaying())
//		print(myController.isPaused())
	}

	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
	}

	@objc func setPlayPause() {
		let command = "tell application \"iTunes\" \n playpause \n end tell"
		var error: NSDictionary?
		NSAppleScript(source: command)!.executeAndReturnError(&error)
	}
	
	@objc func playNext() {
		let command = "tell application \"iTunes\" \n next track \n end tell"
		var error: NSDictionary?
		NSAppleScript(source: command)!.executeAndReturnError(&error)
	}
	
	@objc func backTrack() {
		let command = "tell application \"iTunes\" \n back track \n end tell"
		var error: NSDictionary?
		NSAppleScript(source: command)!.executeAndReturnError(&error)
	}
	
	@objc func playPrevious() {
		let command = "tell application \"iTunes\" \n previous track \n end tell"
		var error: NSDictionary?
		NSAppleScript(source: command)!.executeAndReturnError(&error)
	}
	
	override func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
		return true
	}
	
	func menuWillOpen(_ menu: NSMenu) {
		myController!.update(menu)
	}
}

