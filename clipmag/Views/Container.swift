//
//  ClipList.swift
//  clipmag
//
//  Created by Nitesh Kumar on 25/04/21.
//

import SwiftUI

let cache = NSCache<NSString,NSImage>();

@available(macOS 12.0, *)
struct Container: View {
    
    @State var selectedRowEvent: ArrowEvent = ArrowEvent(selectedRow: 0, isDown: true)
    @State var hoverRow: Int = -1;
    var clipboard: Clipboard = Clipboard()
    
    @Binding var searchText: String
    var clips: FetchedResults<HistoryItem>
    @AppStorage("darkModeEnabled") private var darkModeKey = false
    
    var body: some View {
        if clips.count == 0 {
            VStack {
                Spacer()
                Image("empty_view").resizable().frame(width: 164, height: 164, alignment: .center)
                Text("No Results Found!!").font(Font.system(size: 22, weight: .regular))
                Spacer()
            }
        } else {
            KeyboardView(clips: clips, selectedRowEvent: $selectedRowEvent)
            GeometryReader { metrics in
                HStack(spacing: 0) {
                    ScrollViewReader { scrollView in
                        ScrollView{
                            VStack(spacing: 0) {
                                ForEach(Array(zip(clips.indices, clips)), id: \.1.hashId) { index, clipItem in
                                    let clipText = clipItem.stringData
                                    let isSelected: Bool = (selectedRowEvent.selectedRow == index) ? true : false
                                    ListItem(isSelected: isSelected, hoverRow: $hoverRow, selectedRowEvent: $selectedRowEvent, type: clipItem.applicationId, index: index, clipText: clipText ?? "")
                                    
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
                                if selectedRowEvent.applicationRestart {
                                    scrollView.scrollTo(clips[scrollToRow].hashId, anchor: .bottom)
                                } else {
                                    scrollView.scrollTo(clips[scrollToRow].hashId)
                                }
                                
                            }
                        })
                        
                    }
                    .frame(width: metrics.size.width * 0.52)
                    
                    if selectedRowEvent.selectedRow < clips.count {
                        DetailView(
                            historyItem: clips[selectedRowEvent.selectedRow],
                            detailedText: clips[selectedRowEvent.selectedRow].stringData ?? "",
                            applicationImage: getImage(bundleId: clips[selectedRowEvent.selectedRow].applicationId ?? ""),
                            darkModeKey: darkModeKey)
                            .frame(width: metrics.size.width * 0.48)
                    }
                }
            }
            .onChange(of: searchText, perform: { _ in
                selectedRowEvent.selectedRow = 0
            })
            .onReceive(NotificationCenter.default.publisher(for: NSApplication.willResignActiveNotification)) { _ in
                selectedRowEvent = ArrowEvent(selectedRow: 0, isDown: true, applicationRestart: true)
                searchText = ""
            }
        }
    }
}
