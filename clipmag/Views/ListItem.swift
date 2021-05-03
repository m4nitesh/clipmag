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
