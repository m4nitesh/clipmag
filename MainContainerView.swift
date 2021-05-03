//
//  MainContainerView.swift
//  clipmag
//
//  Created by Nitesh Kumar on 24/04/21.
//

import SwiftUI

@available(macOS 11.0, *)
struct MainContainerView: View {
    private var persistenceContainer = PersistenceController.shared;
    var body: some View {
        ContentView()
            .environment(\.managedObjectContext, persistenceContainer.container.viewContext)
    }
}

@available(macOS 11.0, *)
struct MainContainerView_Previews: PreviewProvider {
    static var previews: some View {
        MainContainerView()
    }
}
