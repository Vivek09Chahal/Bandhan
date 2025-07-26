//
//  ProfileCardShimmerView.swift
//  Bandhan
//
//  Created by Vivek on 7/21/25.
//

import SwiftUI

struct ProfileCardShimmerView: View {
    
    var body: some View {
        VStack{
            ShimmerView(speed: 2, color: .white, animateOpacity: true) {
                // Placeholder content that mimics the actual profile card
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.gray.opacity(0.8))
                    
                    VStack(alignment: .leading) {
                        HStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray.opacity(0.9))
                                .frame(width: 120, height: 20)
                            Spacer()
                            Circle()
                                .fill(Color.gray.opacity(0.9))
                                .frame(width: 20, height: 20)
                        }
                        .padding()
                        Spacer()
                        VStack(alignment: .leading, spacing: 8) {
                            TextShimmer()
                            TextShimmer()
                            TextShimmer()
                            TextShimmer()
                        }
                        .padding()
                    }
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width/1.1, height: UIScreen.main.bounds.height/1.7)
    }
}
