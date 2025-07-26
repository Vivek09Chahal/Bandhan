//
//  ActionButton.swift
//  Bandhan
//
//  Created by Vivek on 7/2/25.
//

import SwiftUI

struct ActionButton: View {
    
    var id: String
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var activityVM: ActivityViewModel
    @EnvironmentObject var tabManager: ObjectManagers
    
    var body: some View {
        NavigationStack{
            HStack{
                
                action(title: "Interested", imageName: "bolt.heart", imgColor: .white)
                Spacer()
                action(title: isShortlisted ? "Shortlisted" : "Shortlist", imageName: isShortlisted ? "star.fill" : "star", imgColor: isShortlisted ? .yellow : .white)
                    .onTapGesture {
                        if isShortlisted {
                            activityVM.removeFromShortlist(id)
                        } else {
                            activityVM.addToShortlist(id)
                            tabManager.toastManager = true
                        }
                    }
                Spacer()
                action(title: "Chat", imageName: "message", imgColor: .white)
                    .onTapGesture {
                        tabManager.selectedTab = 2
                    }
            }
        }
    }
}

extension ActionButton {
    
    private var isShortlisted: Bool {
        activityVM.shortlistedProfilesID.contains(id)
    }
    
    func action(title: String, imageName: String, imgColor: Color) -> some View {
        VStack{
            HStack{
                Image(systemName: imageName)
                    .frame(width: 30, height: 25)
                    .foregroundColor(imgColor)
                    .padding()
                    .background{
                        Circle().fill(Color.red.opacity(0.5))
                    }
            }
            Text(title)
                .font(.caption2)
        }
        .padding(.trailing)
        .foregroundStyle(.white)
    }
}
#Preview {
    ActionButton(id: "U1121")
        .environmentObject(HomeViewModel())
        .environmentObject(ActivityViewModel())
}
