//
//  TabView.swift
//  Bandhan
//
//  Created by Vivek on 6/30/25.
//

import SwiftUI

struct Tabs: View {
    var body: some View {
        TabView{
            Tab("Matches", systemImage: "square.stack.3d.up.fill"){
                HomeView()
            }
            
            Tab("Activity", systemImage: "clock.fill"){
                HomeView()
            }
            
            Tab("Messages", systemImage: "message.fill"){
                HomeView()
            }
            
            Tab("Premium", systemImage: "checkmark.seal.fill"){
                HomeView()
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    Tabs()
}
