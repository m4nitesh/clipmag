//
//  DetailView.swift
//  clipmag
//
//  Created by Nitesh Kumar on 28/04/21.
//

import SwiftUI

//let cache = NSCache<NSString,NSImage>();

struct DetailView: View {
    var selectedText: String
    @State var increaseSize: CGFloat = 1
    var body: some View {
        return VStack() {
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .top), content: {
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.white.opacity(1))
                    .padding(EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4))
                    .shadow(color: .red,radius: 12)
                
                HStack {
                    Text("Hello Good world")
                        .lineLimit(1)
                        .scaleEffect(increaseSize)
                        .font(Font.system(size: 15, weight: .light))
                        .foregroundColor(Color.white)
                    if let image = getImage(bundleId: "com.google.Chrome") {
                        
                        Image(nsImage: image)
                            .resizable()
                            .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            
                    }

                }.padding(16)
                .scaleEffect(increaseSize)
                .background(Color.init(hex: "#7C6FB4"))
                .cornerRadius(6)
                .animation(.default)
                .onHover(perform: { hovering in
                    if (hovering) {
                        increaseSize = 1.05
                    }else {
                        increaseSize = 1.0
                    }
                })
            })
        }
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(selectedText: "hello")
    }
}
