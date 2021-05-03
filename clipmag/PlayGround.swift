//
//  ContentView.swift
//  clipmag
//
//  Created by Nitesh Kumar on 14/04/21.
//
import SwiftUI
import Cocoa
import Swift

@available(OSX 11.0, *)


struct DiscontentView: View {
    @State var selectedRow: Int = 0
        @State var isEditing: Bool = false
        @State var text: String = ""
//        private var clips: FetchedResults<Task>
        
        var body: some View {
            HStack {
                ScrollView {
                    ScrollViewReader { scroll in
                        VStack(spacing: 0) {
                            Text("")
                                .shadow(radius: 8.0)
                        }
                    }
                }
            }
            .padding(10)
            .background(Color(.gray))
            .cornerRadius(12)
            .padding(.vertical, 10)
        }
}

import CoreData

struct Test {
    let task: Task
}


@available(OSX 11.0, *)
struct DiscontentView_Previews: PreviewProvider {
    static var previews: some View {
        DiscontentView()
    }
}
