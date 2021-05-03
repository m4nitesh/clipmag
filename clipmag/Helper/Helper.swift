//
//  Helper.swift
//  clipmag
//
//  Created by Nitesh Kumar on 28/04/21.
//

import Foundation
import Cocoa
import SwiftUI

func getImage(bundleId: String) -> NSImage? {
    if let path = NSWorkspace.shared.absolutePathForApplication(withBundleIdentifier: bundleId) {
        var fImage: NSImage? = cache.object(forKey: path as NSString)
        if fImage == nil {
            fImage = NSWorkspace.shared.icon(forFile: path)
            cache.setObject(fImage!, forKey: path as NSString)
        }
        return fImage
    }
    return nil
}
