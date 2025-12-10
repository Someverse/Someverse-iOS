//
//  SomeverseApp.swift
//  Someverse
//
//  Created by 권우석 on 11/26/25.
//

import SwiftUI
import CoreData

@main
struct SomeverseApp: App {
  let persistenceController = PersistenceController.shared
  
  var body: some Scene {
    WindowGroup {
      //      LoginView()
      MainTabView()
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
        .environment(\.socialLoginClient, .testValue)
        .environment(\.nicknameClient, .testValue)
    }
  }
}


