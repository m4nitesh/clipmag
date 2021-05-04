//
//  ListItem.swift
//  clipmag
//
//  Created by Nitesh Kumar on 02/05/21.
//

import SwiftUI

struct ListItem: View {
    var isSelected: Bool
    @Binding var hoverRow: Int
    @Binding var selectedRowEvent: ArrowEvent
    var type: String?
    var index: Int
    var clipText: String
    
    @AppStorage("darkModeEnabled") private var darkModeKey = false
    
    var body: some View {
        let fColor = darkModeKey ? Color.init("DarkColor") :  Color.accentColor;
        
        let isUrl: Bool = isSelected ? checkIfStringIsUrl(str: clipText) : false
        
        return VStack(alignment: .leading) {
            HStack {
                if let image = getImage(bundleId: type ?? "" ) {
                    Image(nsImage: image)
                        .resizable()
                        .frame(width: 22, height: 22, alignment: .center)
                }
                
                Text(clipText)
                    .lineLimit(1)
                    .font(Font.system(size: 14))
                    .foregroundColor(isSelected ? Color.white : darkModeKey ? Color.white : Color.init(hex: "#161736"))
                Spacer()
            }
            if isUrl {
                Text("⌘+↩ to open link")
                    .font(Font.system(size: 10))
                    .foregroundColor(Color.white)
                    .background(Capsule().stroke(Color.white).frame(width: 120, height: 21, alignment: .center))
                    .padding(.bottom, 6)
                    .padding(.leading, 44)
                    .padding(.top, 3)
            }
            
        }
        .onTapGesture(perform: {
            selectedRowEvent = ArrowEvent(selectedRow: index, isDown: true, disabled: true)
        })
        .padding(EdgeInsets(top: 5, leading: 8, bottom: 5, trailing: 6))
        .onHover(perform: { _ in
            hoverRow = index
        })
        .background(isSelected ? fColor : hoverRow == index ? fColor.opacity(0.1) : Color.clear)
        .cornerRadius(4, antialiased: true)
        .shadow(radius: isSelected ? 0.0 : 0.0)
        
    }
}

struct ListItem_Previews: PreviewProvider {
    static var previews: some View {
        ListItem(isSelected: true, hoverRow: .constant(-1), selectedRowEvent: .constant(ArrowEvent(selectedRow: 0, isDown: true)), type: "com.google.Chrome", index: 0, clipText: "Hello World")
    }
}
