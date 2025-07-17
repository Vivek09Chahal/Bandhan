////
////  UserProfileView.swift
////  Bandhan
////
////  Created by Vivek on 7/1/25.
////

import SwiftUI

struct UserProfileView: View {
    
    @EnvironmentObject var userVM: UserViewModel
    @Namespace private var imageNamespace
    @State private var scrollOffset: CGFloat = 0

    let fullSize: CGFloat = UIScreen.main.bounds.height/2
    let minSize: CGFloat = 180

    var body: some View {
        VStack{
            headerView
            ScrollView {
                VStack {
                    GeometryReader { geo in
                        Color.clear
                            .preference(
                                key: ScrollOffsetPreferenceKey.self,
                                value: geo.frame(in: .named("scrollView")).minY
                            )
                    }

                    
                    Group{
                        VStack{
                            Text("Hi")
                        }
                    }
                }
            }
            .coordinateSpace(name: "scrollView")
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                withAnimation(.easeInOut(duration: 0.2)) {
                    scrollOffset = value
                }
            }
        }
        .ignoresSafeArea()
    }

    private var headerView: some View {
        let shrinkAmount = min(max(-scrollOffset / 200, 0), 1)
        let size = fullSize - (fullSize - minSize) * shrinkAmount
        let cornerRadius = shrinkAmount * (size / 2)

        return AsyncImage(url: URL(string: userVM.userData!.profilePicture.first!)) { img in
            img
                .resizable()
                .scaledToFill()
                .frame(width: size, height: size)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
                .matchedGeometryEffect(id: "profileImage", in: imageNamespace)
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(Color.white, lineWidth: 2)
                )
                .shadow(radius: 10)
                .padding(.top, 55)
        } placeholder: {
            Text("No Image")
        }
    }
}

private struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct UserProfileView_Preview: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            UserProfileView()
        }
        .environmentObject(dev.profileVM)
    }
}

