//
//  ProfileInfoView.swift
//  Bandhan
//
//  Created by Vivek on 7/2/25.
//

import SwiftUI

struct ProfileInfoView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedTab: ProfileCaseIters = .about
    @Namespace var profileAnimation
    var profile: ProfilesData
    
    
    var body: some View {
        NavigationStack {
            VStack {
                ImageView(profile: profile)
                ZStack(alignment: .bottom){
                    ScrollViewReader { proxy in
                        tabSwitcher(proxy: proxy)
                            .padding(.horizontal)
                            .padding(.top)
                        ScrollView(.vertical, showsIndicators: false) {
                            selectedTab.tabContentView(profile: profile)
                        }
                    }
                    ActionButton()
                        .padding()
                        .background{
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(Color.actionColorSet)
                        }
                        .padding()
                }
            }
            .ignoresSafeArea()
        }
    }
}


#Preview {
    ProfileInfoView(profile: ProfilesData.sampleProfile)
}

extension ProfileInfoView {
    
    func tabSwitcher(proxy: ScrollViewProxy) -> some View {
        HStack {
            ForEach(ProfileCaseIters.allCases, id: \.self) { tab in
                VStack {
                    Text(tab.profileTabTitle)
                        .font(.subheadline)
                        .fontWeight(selectedTab == tab ? .semibold : .regular)
                        .foregroundColor(selectedTab == tab ? .primary : .gray)
                    if selectedTab == tab {
                        Capsule()
                            .fill(Color.blue)
                            .frame(height: 2)
                            .matchedGeometryEffect(id: "underline", in: profileAnimation)
                    } else {
                        Capsule()
                            .fill(Color.clear)
                            .frame(height: 2)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        selectedTab = tab
                        proxy.scrollTo(tab.scrollID, anchor: .top)
                    }
                }
                
                .frame(maxWidth: .infinity)
            }
        }
    }
}

struct ImageView: View {
    
    var profile: ProfilesData
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack(alignment: .bottom){
            AsyncImage(url: URL(string: profile.profilePicture)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: UIScreen.main.bounds.height / 2.3)
                    .clipped()
            } placeholder: {
                Color.gray.opacity(0.3)
                    .frame(height: UIScreen.main.bounds.height / 2)
            }
            .overlay(
                LinearGradient(
                    gradient: Gradient(colors: [.clear, .black.opacity(0.8)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            // MARK: - Basic Info Section
            VStack(alignment: .leading, spacing: 6) {
                HStack{
                    VStack(alignment: .leading) {
                        Text("\(profile.name), \(profile.age)")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("ID - \(profile.id)")
                            .font(.callout)
                    }
                    .padding(.vertical ,7)
                    Spacer()
                }
                
                Text("Profile managed by Parent")
                    .font(.callout)
                    .padding(.vertical)
                    .background{
                        Rectangle()
                            .foregroundStyle(LinearGradient(colors: [.orange, .clear], startPoint: .leading, endPoint: .trailing).opacity(0.4))
                            .frame(width: UIScreen.main.bounds.width/1.1, height: 30)
                            .offset(x: 65)
                    }
            }
            .foregroundStyle(.white)
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(){
                HStack{
                    Image(systemName: "photo.on.rectangle.angled")
                    Text("4")
                        .padding(.trailing)
                    Image(systemName: "ellipsis")
                        .rotationEffect(Angle(degrees: 90))
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.backward")
                        .padding(11)
                        .background{
                            Circle()
                                .foregroundStyle(.quinary)
                        }
                        .foregroundStyle(.white)
                }
            }
        }
    }
}
