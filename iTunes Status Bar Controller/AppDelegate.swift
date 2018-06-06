//
//  AppDelegate.swift
//  iTunes Status Bar Controller
//
//  Created by Qihao Leng on 6/4/18.
//

import Cocoa
import ServiceManagement

extension Notification.Name {
	static let killLauncher = Notification.Name("killLauncher")
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSMenuDelegate {
	
	var statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
	var myController: iTunesController?
	
	func applicationDidFinishLaunching(_ aNotification: Notification) {
		// Insert code here to initialize your application
		// Kill launcher
		let launcherAppId = "Q.L..Launcher"
		var runningApps = NSWorkspace.shared.runningApplications
		var isRunning = !runningApps.filter { $0.bundleIdentifier == launcherAppId }.isEmpty
		
		SMLoginItemSetEnabled(launcherAppId as CFString, true)
		
		if isRunning {
			DistributedNotificationCenter.default().post(name: .killLauncher,
														 object: Bundle.main.bundleIdentifier!)
		}
		myController = iTunesController()
		// Detect iTunes
		let iTunesAppId = "com.apple.iTunes"
		runningApps = NSWorkspace.shared.runningApplications
		isRunning = !runningApps.filter { $0.bundleIdentifier == iTunesAppId }.isEmpty
		print(isRunning)
		
		if isRunning {
			myController!.setUp(&statusItem, self)
		} else {
			myController!.setUpEmpty(&statusItem, self)
		}
		
//		statusItem.menu!.items[0].target = myController
//		statusItem.menu!.items[0].action = #selector(myController.setPlayPause)
//		print(myController.isPlaying())
//		print(myController.isPaused())
	}

	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
		print("terminated")
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
		if !myController!.isPreviouslyRunning {
			let launcherAppId = "com.apple.iTunes"
			let runningApps = NSWorkspace.shared.runningApplications
			let isRunning = !runningApps.filter { $0.bundleIdentifier == launcherAppId }.isEmpty
			
			if isRunning {
				myController?.setUp(&statusItem, self)
			}
		} else {
			myController!.update(menu)
		}
	}
}

