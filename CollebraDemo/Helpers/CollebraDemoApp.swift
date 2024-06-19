//
//  CollebraDemoApp.swift
//  CollebraDemo
//
//  Created by Manoj Kumar on 19/06/24.
//

import SwiftUI

@main
struct CollebraDemoApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var appCoordinator = AppCoordinator()

    var body: some Scene {
        WindowGroup {
            Group {
                if appCoordinator.isAuthenticated {
                    NotesView()
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                } else {
                    Text("Authenticating...") // You could replace this with a custom loading or error view
                        .onAppear {
                            appCoordinator.start()
                        }
                }
            }
        }
    }
}
