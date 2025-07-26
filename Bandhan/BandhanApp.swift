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
    @StateObject private var activityVM = ActivityViewModel()
    @StateObject private var objectVM = ObjectManagers()
    
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
            ZStack(alignment: .bottom){
                Tabs()
                    .environmentObject(vm)
                    .environmentObject(userVM)
                    .environmentObject(activityVM)
                    .environmentObject(objectVM)
                    .onAppear {
                        activityVM.homeVM = vm
                    }
                
                if objectVM.toastManager {
                    toastView
                        .offset(y: -70)
                }
            }
        }
    }
}

extension BandhanApp {
    var toastView : some View {
        ToastView(message: "Profile ShortListed")
            .transition(.move(edge: .bottom).combined(with: .opacity))
            .animation(.spring(response: 0.6, dampingFraction: 0.8), value: objectVM.toastManager)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    objectVM.toastManager = false
                }
            }
    }
}
