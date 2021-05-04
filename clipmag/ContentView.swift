
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

import MbSwiftUIFirstResponder

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
        return Container(searchText: $searchText, clips: FetchRequest(
            fetchRequest: fetchRequestN
        ))
    }
}

@available(macOS 11.0, *)
struct ContentView: View {
    
    @State var searchText: String = ""
    @AppStorage("darkModeEnabled") private var darkModeKey = false
    
    @State var firstResponder: FirstResponders? = FirstResponders.searchText
    
    
    
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
                            .firstResponder(id: FirstResponders.searchText, firstResponder: $firstResponder, resignableUserOperations : .escKey)
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
    
    enum FirstResponders: Int {
            case searchText
            case email
            case notes
        }
}




//@available(macOS 11.0, *)
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

