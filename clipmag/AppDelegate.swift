//
//  AppDelegate.swift
//  clipmag
//
//  Created by Nitesh Kumar on 15/04/21.
//

import Cocoa
import SwiftUI
import HotKey


@available(macOS 11.0, *)
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    
    var statusBarItem: NSStatusItem!
    var panel: NSPanel!
    var hotKey: HotKey!
    var persistenceContainer = PersistenceController.shared
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        
        
        let contentView = MainContainerView()
        
        
        Clipboard().startListening();
        
        
        panel = NSPanel()
        panel?.contentView = NSHostingView(rootView: contentView)
        panel?.styleMask.insert(.nonactivatingPanel)
        panel?.center()
        panel?.isFloatingPanel = true
        panel?.backgroundColor = NSColor.clear
        panel?.hidesOnDeactivate = true
        panel?.isReleasedWhenClosed = false
        panel?.isMovableByWindowBackground = true
        panel?.level = .popUpMenu
        panel?.makeKeyAndOrderFront(nil)
        panel?.styleMask.remove(.titled)
        
        
        
        hotKey = HotKey(key: .space, modifiers: [.control])
        hotKey.keyDownHandler = {
            NSApp.activate(ignoringOtherApps: true)
        }
        setStatusBar()
    }
    
    private func setStatusBar() {
        let statusBar = NSStatusBar.system
        statusBarItem = statusBar.statusItem(
            withLength: NSStatusItem.squareLength)
        //        statusBarItem.button?.title = "🌯"
        statusBarItem.button?.image = NSImage(named: "log_three_gray")
        let statusBarMenu = NSMenu(title: "Cap Status Bar Menu")
        statusBarMenu.minimumWidth = 200
        statusBarItem.menu = statusBarMenu
        statusBarMenu.addItem(
            withTitle: "Toggle Cligmag  ",
            action: #selector(AppDelegate.toggleApp),
            keyEquivalent: "")
        
        statusBarMenu.addItem(
            withTitle: "© ClipMag 2021 Build: 1.01",
            action: nil,
            keyEquivalent: "")

        
        statusBarMenu.addItem(.separator())
        statusBarMenu.addItem(
            withTitle: UserDefaults.standard.bool(forKey: "darkModeEnabled") ? "Enable Light Mode" : "Enable Dark Mode",
            action: #selector(AppDelegate.darkMode),
            keyEquivalent: "")
        statusBarMenu.addItem(.separator())
        statusBarMenu.addItem(
            withTitle: "Quit",
            action: #selector(AppDelegate.quitApp),
            keyEquivalent: "")
        
        
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    @objc func quitApp() {
        NSApplication.shared.terminate(self)
    }
    
    @objc func darkMode() {
        let defaults = UserDefaults.standard
        let currentVal: Bool = UserDefaults.standard.bool(forKey: "darkModeEnabled")
        defaults.set(!currentVal, forKey: "darkModeEnabled")
        setStatusBar()
    }
    
    @objc func toggleApp() {
        NSApp.activate(ignoringOtherApps: true)
    }
    
}


extension NSTableView {
    open override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        backgroundColor = NSColor.clear
        enclosingScrollView!.drawsBackground = false
    }
}


