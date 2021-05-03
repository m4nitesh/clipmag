//
//  FocusTextField.swift
//  clipmag
//
//  Created by Nitesh Kumar on 20/04/21.
//
import SwiftUI
import Cocoa

class FocusAwareTextField: NSTextField {
    var onFocusChange: (Bool) -> Void = { _ in }
    override func becomeFirstResponder() -> Bool {
        let textView = window?.fieldEditor(true, for: nil) as? NSTextView
        onFocusChange(true)
        return super.becomeFirstResponder()
    }
}


struct BorderlessTextField: NSViewRepresentable {
    let placeholder: String
    @Binding var text: String
    @Binding var isFocus: Bool
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    func makeNSView(context: Context) -> NSTextField {
        let textField = FocusAwareTextField()
        textField.becomeFirstResponder()
        return textField
    }
    func updateNSView(_ nsView: NSTextField, context: Context) {
        nsView.stringValue = text
    }
    class Coordinator: NSObject, NSTextFieldDelegate {
        let parent: BorderlessTextField
        init(_ textField: BorderlessTextField) {
            self.parent = textField
        }
        func controlTextDidEndEditing(_ obj: Notification) {
            self.parent.isFocus = false
        }
        func controlTextDidChange(_ obj: Notification) {
            guard let textField = obj.object as? NSTextField else { return }
            self.parent.text = textField.stringValue
        }
    }
}
