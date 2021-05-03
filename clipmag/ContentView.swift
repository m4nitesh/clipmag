
//  ContentView.swift
//  clipmag
//
//  Created by Nitesh Kumar on 14/04/21.
//
import SwiftUI
import Swift
import Cocoa
import Foundation
import Combine
import Quartz
import HotKey

var FETCH_LIMIT = 20

@available(macOS 11.0, *)
struct ListContainer: View {
    
    @Binding var searchText: String
    
    var body: some View  {
        let fetchRequestN: NSFetchRequest<Task> = Task.fetchRequest();
        fetchRequestN.entity = Task.entity()
        fetchRequestN.sortDescriptors = [NSSortDescriptor(keyPath: \Task.timestamp, ascending: false)]
        fetchRequestN.predicate = NSPredicate(format: "content like[c] %@", "*\(searchText)*" )
        fetchRequestN.fetchLimit = FETCH_LIMIT;
        return ClipList(searchText: $searchText, clips: FetchRequest(
            fetchRequest: fetchRequestN
        ))
    }
}

@available(macOS 11.0, *)
struct ContentView: View {
    
    @State var searchText: String = ""
    @AppStorage("darkModeEnabled") private var darkModeKey = false
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    ZStack{
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color.gray.opacity(0.27))
                            .frame(height: 54)
                            .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                        TextField("Search...", text: $searchText)
                            .textFieldStyle(PlainTextFieldStyle())
                            .font(Font.system(size: 24, weight: .light))
                            .foregroundColor(darkModeKey ? Color.white : Color.init(hex: "#17333F"))
                            .background(Color.clear)
                            .border(Color.black, width: 0)
                            .padding(.top, 8)
                            .padding(.leading, 24)
                            .padding(.bottom, 8)
                            .frame(height: 54, alignment: Alignment.leading)

                    }
                    Image(darkModeKey ? "logo_sec" : "log_three")
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .center)
                }
                .padding(.trailing, 8)
                ListContainer(searchText: $searchText)
            }
            .background(darkModeKey ? Color.init(hex: "#101010").opacity(0.05) : Color.init(hex: "#F5F7FA").opacity(0.6))
        }
        .background(VisualEffectView(material: darkModeKey ? NSVisualEffectView.Material.dark : NSVisualEffectView.Material.light,
                                     blendingMode: NSVisualEffectView.BlendingMode.behindWindow))
        .frame(width: 700, height: 500, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .cornerRadius(6)
        
    }
}




@available(macOS 11.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
