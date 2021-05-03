//
//  Configuration.swift
//  clipmag
//
//  Created by Nitesh Kumar on 25/04/21.
//

import Cocoa

extension UserDefaults {
    public struct Keys {
        static let enabledPasteboardTypes = "enabledPasteboardTypes"
        static let ignoredPasteboardTypes = "ignoredPasteboardTypes"
    }
    
    public struct Values {
      static let ignoredPasteboardTypes: [String] = []
    }
    
    @objc dynamic public var enabledPasteboardTypes: Set<NSPasteboard.PasteboardType> {
      get {
        let types = array(forKey: Keys.enabledPasteboardTypes) as? [String] ?? []
        return Set(types.map({ NSPasteboard.PasteboardType($0) }))
      }
      set { set(Array(newValue.map({ $0.rawValue })), forKey: Keys.enabledPasteboardTypes) }
    }
    
    public var ignoredPasteboardTypes: Set<String> {
      get { Set(array(forKey: Keys.ignoredPasteboardTypes) as? [String] ?? Values.ignoredPasteboardTypes) }
      set { set(Array(newValue), forKey: Keys.ignoredPasteboardTypes) }
    }


    
}
