//
//  BandhanApp.swift
//  Bandhan
//
//  Created by Vivek on 6/13/25.
//

import SwiftUI
import SwiftData

@main
struct BandhanApp: App {
    
    @StateObject private var vm = HomeViewModel()
    @StateObject private var userVM = UserViewModel()
    
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            Item.self,
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()

    var body: some Scene {
        WindowGroup {
            Tabs()
                .environmentObject(vm)
                .environmentObject(userVM)
        }
//        .modelContainer(sharedModelContainer)
    }
}
