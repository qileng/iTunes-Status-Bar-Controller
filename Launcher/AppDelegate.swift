//
//  AppDelegate.swift
//  Launcher
//
//  Created by Qihao Leng on 6/5/18.
//

import Cocoa

extension Notification.Name {
	static let killLauncher = Notification.Name("killLauncher")
}

@NSApplicationMain
class AppDelegate: NSObject {
	
	@objc func terminate() {
		NSApp.terminate(nil)
	}
}

extension AppDelegate: NSApplicationDelegate {
	
	func applicationDidFinishLaunching(_ aNotification: Notification) {
		
		let mainAppIdentifier = "Q.L..iTunes-Status-Bar-Controller"
		let runningApps = NSWorkspace.shared.runningApplications
		let isRunning = !runningApps.filter { $0.bundleIdentifier == mainAppIdentifier }.isEmpty
		
		if !isRunning {
			DistributedNotificationCenter.default().addObserver(self,
																selector: #selector(self.terminate),
																name: .killLauncher,
																object: mainAppIdentifier)
			
			let path = Bundle.main.bundlePath as NSString
			var components = path.pathComponents
			components.removeLast()
			components.removeLast()
			components.removeLast()
			components.append("MacOS")
			components.append("iTunes Status Bar Controller") //main app name
			
			let newPath = NSString.path(withComponents: components)
			print(newPath)
			
			NSWorkspace.shared.launchApplication(newPath)
		}
		else {
			self.terminate()
		}
	}
}

