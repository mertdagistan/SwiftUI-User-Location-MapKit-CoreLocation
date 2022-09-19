//
//  UserMapApp.swift
//  UserMap
//
//  Created by Mert on 20.09.2022.
//

import SwiftUI

@main
struct UserMapApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MapView()
                
        }
    }
}
