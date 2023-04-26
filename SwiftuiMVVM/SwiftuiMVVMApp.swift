//
//  SwiftuiMVVMApp.swift
//  SwiftuiMVVM
//
//  Created by Bekhruz Hakmirzaev on 25/04/23.
//

import SwiftUI

@main
struct SwiftuiMVVMApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeScreen()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
