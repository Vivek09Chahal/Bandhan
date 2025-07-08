//
//  ActivityView.swift
//  Bandhan
//
//  Created by Vivek on 7/2/25.
//

import SwiftUI

struct ActivityView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Binding var showUserProfile: Bool
    @Namespace var activityAnimation
    @State private var selectedTab: ActityCaseIters = .reveived
    
    var body: some View {
        VStack(alignment: .leading) {
            HeaderView(title: "Matches", showUserProfile: $showUserProfile)
                .padding(.horizontal)
            Divider()
            
            // Activity Numbers Section
            HStack(spacing: 15) {
                activityNumbers(text: "Profile Visit", color: .indigo, number: 12)
                activityNumbers(text: "Shortlisted", color: .yellow, number: 5)
                activityNumbers(text: "Contact Views", color: .blue, number: 8)
            }
            HStack{
                Text("Interests")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                Text("View All")
                    .fontWeight(.bold)
                    .foregroundStyle(.red)
            }
            .padding(.horizontal)
            
            ScrollViewReader { proxy in
                tabSwitcher(proxy: proxy)
                    .padding(.horizontal)
                    .padding(.top)
                ScrollView(.vertical, showsIndicators: false) {
                    selectedTab.activityContent()
                }
            }
            
            Spacer()
        }
        .background(Color(UIColor.systemGray6).opacity(0.4))
    }
}

extension ActivityView {
    
    func activityNumbers(text: String, color: Color, number: Int) -> some View {
        VStack(alignment: .center) {
            Text("\(number)")
                .font(.title2)
                .fontWeight(.bold)
                .padding()
                .background {
                    Circle()
                        .foregroundStyle(color.opacity(0.2))
                }
                .padding(.bottom, 5)
            
            Text(text)
                .font(.caption)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(colorScheme == .dark ? Color.black : Color.white)
                .shadow(radius: 2)
        }
        .frame(width: UIScreen.main.bounds.width/3.3, height: 120)
    }
    
    func tabSwitcher(proxy: ScrollViewProxy) -> some View {
        HStack {
            ForEach(ActityCaseIters.allCases, id: \.self) { tab in
                VStack {
                    Text(tab.actitityTitle)
                        .font(.subheadline)
                        .foregroundColor(selectedTab == tab ? .primary : .gray)
                        .padding(7)
                        .background{
                            if selectedTab == tab {
                                Capsule()
                                    .fill(Color.pink.opacity(0.2))
                                    .matchedGeometryEffect(id: "Capsule", in: activityAnimation)
                            } else {
                                Capsule()
                                    .stroke(Color.gray, lineWidth: 1)
                            }
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

#Preview {
    ActivityView(showUserProfile: .constant(true))
}
