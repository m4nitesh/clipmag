//
//  ClipList.swift
//  clipmag
//
//  Created by Nitesh Kumar on 25/04/21.
//

import SwiftUI

let cache = NSCache<NSString,NSImage>();

@available(macOS 11.0, *)
struct ClipList: View {
    
    @State var selectedRowEvent: ArrowEvent = ArrowEvent(selectedRow: 0, isDown: true)
    @State var hoverRow: Int = -1;
    var clipboard: Clipboard = Clipboard()
    
    @Binding var searchText: String
    @FetchRequest var clips: FetchedResults<Task>
    @AppStorage("darkModeEnabled") private var darkModeKey = false
        
    var body: some View {
        GeometryReader { metrics in
            HStack(spacing: 0) {
                ScrollViewReader { scrollView in
                    ScrollView{
                        VStack(spacing: 0) {
                            ForEach(Array(zip(clips.indices, clips)), id: \.1.hashId) { index, clipItem in
                                if let clipText = clipItem.content {
                                    let isSelected: Bool = (selectedRowEvent.selectedRow == index) ? true : false
                                    ListItem(isSelected: isSelected, hoverRow: $hoverRow, selectedRowEvent: $selectedRowEvent, type: clipItem.type, index: index, clipText: clipText)
                                }
                            }
                        }
                        .padding(.leading, 8)
                        .padding(.trailing, 16)
                        .padding(.top, 4)
                    }
                    .onChange(of: selectedRowEvent, perform: { some in
                        hoverRow = -1
                        let scrollToRow: Int = selectedRowEvent.isDown ? selectedRowEvent.selectedRow + 1 : selectedRowEvent.selectedRow - 1
                        if (scrollToRow < clips.count && scrollToRow >= 0 && !selectedRowEvent.disabled) {
                            scrollView.scrollTo(clips[scrollToRow].hashId)
                        }
                    })
                    
                }
                .frame(width: metrics.size.width * 0.52)
                
                
                VStack(alignment: .trailing) {
                    ZStack(alignment: Alignment(horizontal: .leading, vertical: .top), content: {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(darkModeKey ? Color.black.opacity(0.1) : Color.white.opacity(0.5))
                            .padding(EdgeInsets(top: 4, leading: 0, bottom: 8, trailing: 8))
                        
                        
                        HStack {
                            Text(selectedRowEvent.selectedRow < clips.count ? clips[selectedRowEvent.selectedRow].content ?? "" : "")
                                .font(Font.system(size: 11, weight: .regular))
                                .foregroundColor(darkModeKey ? Color.white : Color.black)
                        }.padding(16)
                        
                    })
                    
                }
                .frame(width: metrics.size.width * 0.48)
            }
            
            KeyboardView(clips: clips, selectedRowEvent: $selectedRowEvent)
            
        }
        .onChange(of: searchText, perform: { _ in
            selectedRowEvent.selectedRow = 0
        })
        .onReceive(NotificationCenter.default.publisher(for: NSApplication.willResignActiveNotification)) { _ in
            selectedRowEvent.selectedRow = 0
            searchText = ""
        }
    }
}

