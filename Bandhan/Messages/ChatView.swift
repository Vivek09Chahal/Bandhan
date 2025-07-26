//
//  ChatView.swift
//  Bandhan
//
//  Created by Vivek on 7/23/25.
//

import SwiftUI

struct ChatView: View {
    var body: some View {
        VStack{
            ScrollView{
                HeaderView()
                Text("Hello, World!")
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    ChatView()
        .environmentObject(HomeViewModel())
        .environmentObject(ObjectManagers())
        .environmentObject(ActivityViewModel())
}
