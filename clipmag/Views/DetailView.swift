//
//  DetailView.swift
//  clipmag
//
//  Created by Nitesh Kumar on 28/04/21.
//

import SwiftUI

struct DetailView: View {
    var detailedText: String
    var applicationImage: NSImage!
    var darkModeKey: Bool
    var body: some View {
        VStack(alignment: .trailing) {
            
            let isColor = checkIfStringIsColor(str: detailedText)
            
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .top), content: {
                RoundedRectangle(cornerRadius: 6)
                    .fill(darkModeKey ? Color.black.opacity(0.1) : Color.white.opacity(0.5))
                    .padding(EdgeInsets(top: 4, leading: 0, bottom: 8, trailing: 8))
                
                if isColor {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color.init(hex: detailedText))
                        .padding(EdgeInsets(top: 4, leading: 0, bottom: 8, trailing: 8))
                }else {
                    VStack(alignment: .leading) {
                        ScrollView {
                            Text(detailedText)
                                .font(Font.system(size: 11, weight: .regular))
                                .foregroundColor(darkModeKey ? Color.white : Color.black)
                        }
                        Spacer()
                        HStack {
                            Spacer()
                            if let image = applicationImage {
                                Image(nsImage: image)
                                    .resizable()
                                    .frame(width: 32, height: 32, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            }
                        }
                        
                    }.padding(12)
                    
                }
            })
            
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(detailedText: "Nothing", applicationImage: getImage(bundleId: "com.google.Chrome"), darkModeKey: false)
    }
}
