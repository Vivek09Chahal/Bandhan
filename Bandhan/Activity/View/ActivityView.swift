//
//  ActivityView.swift
//  Bandhan
//
//  Created by Vivek on 7/2/25.
//

import SwiftUI

struct ActivityView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Namespace var activityAnimation
    @State private var selectedInterest: ActivityCaseIters = .received
    @State var activityCases: ActivityCases? = nil
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading) {
                HeaderView()
                    .padding(.horizontal)
                Divider()
                numberActivity
                
                interestHeading
                profileStates
                
                Spacer()
            }
            .background(Color(UIColor.systemGray6).opacity(0.4))
            .navigationDestination(for: ActivityCases.self) { activityCase in
                activityCase.navigateView()
            }
        }
    }
}

extension ActivityView {
    
    var numberActivity: some View {
        HStack{
            ForEach(ActivityCases.allCases, id: \.self){ activityCase in
                NavigationLink(value: activityCase) {
                    activityCase.navigateViewItem()
                }
                .foregroundStyle(.primary)
            }
        }
    }
    
    var interestHeading: some View {
        HStack{
            Text("Interests")
                .font(.title)
                .fontWeight(.bold)
            Spacer()
        }
        .padding(.horizontal)
    }
    
    func tabSwitcher(proxy: ScrollViewProxy) -> some View {
        HStack {
            ForEach(ActivityCaseIters.allCases, id: \.self) { tab in
                VStack {
                    Text(tab.activityTitle)
                        .padding(5)
                        .font(.subheadline)
                        .foregroundColor(selectedInterest == tab ? .primary : .gray)
                        .padding(7)
                        .background{
                            if selectedInterest == tab {
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
                        selectedInterest = tab
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
    
    var profileStates: some View {
        ScrollViewReader { proxy in
            tabSwitcher(proxy: proxy)
                .padding(.horizontal)
                .padding(.top)
            ScrollView(.vertical, showsIndicators: false) {
                selectedInterest.activityContent()
            }
        }
    }
    
}

#Preview {
    ActivityView()
        .environmentObject(HeaderViewManager())
}
