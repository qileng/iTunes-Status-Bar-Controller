//
//  AppDelegate.swift
//  iTunes Status Bar Controller
//
//  Created by Qihao Leng on 6/4/18.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

	let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
	
	func applicationDidFinishLaunching(_ aNotification: Notification) {
		// Insert code here to initialize your application
		statusItem.setUp()
		print(iTunesController.isPlaying())
		print(iTunesController.isPaused())
	}

	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
	}


}

