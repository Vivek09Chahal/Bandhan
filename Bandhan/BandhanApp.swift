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
    
    @State private var dataFetch = DataFetch()
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            Tabs()
                .environment(dataFetch)
        }
        .modelContainer(sharedModelContainer)
    }
}
