//
//  EditorView.swift
//  clipmag
//
//  Created by Nitesh Kumar on 24/04/21.
//

import SwiftUI

struct ListView: View {
    var users: [String]
    var searchText: String
    var selectedRow: Int
    var body: some View {
        GeometryReader { metrics in
            HStack(spacing: 0) {
                List() {
                    ForEach(Array(users.enumerated()), id: \.offset) { index, user in
                        if (index > 10) {
                            HStack {
                                Text(user)
                                    .lineLimit(1)
                                    .font(Font.system(size: 15, weight: .regular))
                                    .foregroundColor(Color(selectedRow == index ? .white : .black))
                                Spacer()
                            }
                            .onTapGesture(perform: {
                                let pasteboard = NSPasteboard.general
                                pasteboard.declareTypes([NSPasteboard.PasteboardType.string], owner: nil)
                                pasteboard.setString(user, forType: NSPasteboard.PasteboardType.string)
//                                paste()
                            })
                            .padding(6)
                            .onHover(perform: { hovering in
//                                selectedRow = index
                            })
                            .background(Color(selectedRow == index ? .systemBlue : .clear))
                            .cornerRadius(3, antialiased: true)
                            
                        }

                    }
                }
                .listStyle(PlainListStyle())
                .padding(.leading, 6)
                
                VStack(alignment: .trailing) {
                    HStack {
//                                Text(pasteboardObservable
//                                        .pasteboard.pasteboardItems?.first?.string(forType: .string) ?? "")
                        Text(users[selectedRow])
                            .font(Font.system(size: 13, weight: .regular))
                        Spacer()
                    }
                    Spacer()
                }
                .frame(width: metrics.size.width * 0.50)
            }

        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(users: ["Hello There"], searchText: "", selectedRow: 0)
        
    }
}
