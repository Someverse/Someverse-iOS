//
//  someverseApp.swift
//  someverse
//
//  Created by 권우석 on 11/26/25.
//

import SwiftUI
import CoreData

@main
struct someverseApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
