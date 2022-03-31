
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

private let FETCH_LIMIT = 20

@available(macOS 12.0, *)
struct ListContainer: View {
    
    @Binding var searchText: String
    @FetchRequest var clips: FetchedResults<HistoryItem>
    
    var body: some View  {
        return Container(searchText: $searchText, clips: clips)
    }
}

private let SEARCH_TEXT = "Search here...."

@available(macOS 12.0, *)
struct ContentView: View {
    
    @State var searchText: String = ""
    @State var hintText: String = SEARCH_TEXT
    @AppStorage("darkModeEnabled") private var darkModeKey = false
    
    @State var firstResponder: FirstResponders? = FirstResponders.searchText
    
    func getClips(searchText: String) -> NSFetchRequest<HistoryItem> {
        let fetchRequestN: NSFetchRequest<HistoryItem> = HistoryItem.fetchRequest();
        fetchRequestN.entity = HistoryItem.entity()
        fetchRequestN.sortDescriptors = [NSSortDescriptor(keyPath: \HistoryItem.timestamp, ascending: false)]
        fetchRequestN.predicate = NSPredicate(format: "stringData like[c] %@", "*\(searchText)*" )
        fetchRequestN.fetchLimit = FETCH_LIMIT;
        return fetchRequestN

    }
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    ZStack (alignment: .leading){
                        RoundedRectangle(cornerRadius: 4)
                            .fill(darkModeKey ? Color.black.opacity(0.2) : Color.black.opacity(0.11))
                            .frame(height: 54)
                            .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                        Text(hintText)
                            .font(Font.system(size: 22, weight: .light))
                            .background(Color.clear)
                            .foregroundColor(darkModeKey ? Color.init(hex: "#9FAFC8") : Color.black.opacity(0.5))
                            .padding(.leading, 24)
                            .onChange(of: searchText, perform: { some in
                                if searchText != "" {
                                    hintText = ""
                                }else {
                                    hintText = SEARCH_TEXT
                                }
                            })


                        TextField("", text: $searchText)
//                            .firstResponder(id: FirstResponders.searchText, firstResponder: $firstResponder, resignableUserOperations : .escKey)
                            .textFieldStyle(PlainTextFieldStyle())
                            .font(Font.system(size: 22, weight: .light))
                            .foregroundColor(darkModeKey ? Color.white : Color.init(hex: "#17333F"))
                            .background(Color.clear)
                            .border(Color.black, width: 0)
                            .padding(.top, 8)
                            .padding(.leading, 24)
                            .padding(.bottom, 8)
                            .frame(height: 54, alignment: Alignment.leading)

                    }
                    Image("log_four")
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .center)
                }
                .padding(.trailing, 8)
                ListContainer(searchText: $searchText, clips: FetchRequest(
                    fetchRequest: getClips(searchText: searchText)
                ))
            }
            .background(darkModeKey ? Color.init(hex: "#161736").opacity(0.5) : Color.init(hex: "#F5F7FA").opacity(0.6))
        }
        .background(VisualEffectView(material: darkModeKey ? NSVisualEffectView.Material.dark : NSVisualEffectView.Material.light,
                                     blendingMode: NSVisualEffectView.BlendingMode.behindWindow))
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

