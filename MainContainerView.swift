//
//  MainContainerView.swift
//  clipmag
//
//  Created by Nitesh Kumar on 24/04/21.
//

import SwiftUI

@available(macOS 12.0, *)
struct MainContainerView: View {
    private var persistenceContainer = PersistenceController.shared;
    @State var isHidden = false
    var body: some View {
        ContentView()
            .environment(\.managedObjectContext, persistenceContainer.container.viewContext)
            .frame(width: 700, height: 500, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .hidden(isHidden)
//            .onReceive(NotificationCenter.default.publisher(for: NSApplication.willResignActiveNotification)) { _ in
//                isHidden = true
//            }

    }
}

@available(macOS 12.0, *)
struct MainContainerView_Previews: PreviewProvider {
    static var previews: some View {
        MainContainerView()
    }
}
