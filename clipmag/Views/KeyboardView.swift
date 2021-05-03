//
//  SwiftUIView.swift
//  clipmag
//
//  Created by Nitesh Kumar on 26/04/21.
//

import SwiftUI

struct ArrowEvent: Equatable {
    var selectedRow: Int;
    var isDown: Bool
    var disabled: Bool = false;
}

struct KeyboardView: View {
    
    var clips: FetchedResults<Task>
    var clipboard: Clipboard = Clipboard()
    
    @Binding var selectedRowEvent: ArrowEvent

    
    var body: some View {
        if #available(OSX 11.0, *) {
            HStack {
                Button(".") {
                    if (selectedRowEvent.selectedRow < clips.count - 1) {
                        selectedRowEvent = ArrowEvent(selectedRow: selectedRowEvent.selectedRow + 1,isDown: true)
                    }
                }
                .frame(width: 0, height: 0)
                .opacity(0)
                .keyboardShortcut(.downArrow, modifiers: [])


                Button(".") {
                    if (selectedRowEvent.selectedRow >= 1) {
                        selectedRowEvent = ArrowEvent(selectedRow: selectedRowEvent.selectedRow - 1,isDown: false)
                    }
                }
                .frame(width: 0, height: 0)
                .opacity(0)
                .keyboardShortcut(.upArrow, modifiers: [])
                
                Button(".") {
                    clipboard.copy(clips[selectedRowEvent.selectedRow])
                }
                .frame(width: 0, height: 0)
                .opacity(0)
                .keyboardShortcut(.return, modifiers: [])
                
                
                Button(".") {
                    NSApp.hide(nil)
                }
                .frame(width: 0, height: 0)
                .opacity(0)
                .keyboardShortcut(.escape, modifiers: [])


            }

        }

    }
}

