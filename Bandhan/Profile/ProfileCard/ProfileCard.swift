//
//  ProfileCard.swift
//  Bandhan
//
//  Created by Vivek on 6/30/25.
//

import SwiftUI

struct ProfileCard: View {
    var body: some View {
        ZStack(){
            
            // MARK: - Image
            Image("profile")
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(
                    ZStack {
                        // Gradient overlay
                        LinearGradient(
                            colors: [.clear, .black],
                            startPoint: .center,
                            endPoint: .bottom
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                        // Border stroke
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(
                                LinearGradient(
                                    colors: [.red, .orange, .pink],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 2
                            )
                    }
                )
            
            // MARK: - top Section
            VStack(alignment: .leading){
                HStack{
                    // Compatibility
                    Group{
                        Image(systemName: "hand.thumbsup.fill")
                        Text("Most Compatible")
                    }
                    .font(.caption)
                    .padding(10)
                    .background{
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    
                    // No. of pics uploaded
                    Image(systemName: "photo.stack")
                    Text("4")
                }
                .foregroundStyle(.white)
                
                Spacer()
                
                // MARK: - Details
                VStack(alignment: .leading){
                    details(info1: "Moana", info2: "27") // name, age
                        .font(.title)
                    details(info1: "5,3", info2: "• Disney, Animation") // Height, Destination, Cast
                    details(info1: "Product Designer", info2: "• Earns $100k/yr")
                    details(info1: "B.Tech")
                    details(info1: "Profile Manager by Herself") // Profile Manager By Whom
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background{
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundStyle(LinearGradient(colors: [.red, .orange], startPoint: .leading, endPoint: .trailing).opacity(0.4))
                        }
                    
                    // Options
                    HStack{
                        action(title: "Message", imageName: "envelope.badge.person.crop.fill")
                        action(title: "Interested", imageName: "bolt.heart")
                        action(title: "Shortlist", imageName: "star")
                        action(title: "Chat", imageName: "message")
                    }
                }
                
            }
            .padding()
        }
        .frame(width: UIScreen.main.bounds.width/1.1, height: UIScreen.main.bounds.height/1.6)
    }
}

extension ProfileCard {
    
    // detail Section
    func details(info1: String, info2: String = "") -> some View {
        HStack{
            Text(info1)
            Text(info2)
        }
        .foregroundStyle(.white)
    }
    
    // action section
    func action(title: String, imageName: String) -> some View {
        Button {
            //
        } label: {
            VStack{
                HStack{
                    Image(systemName: imageName)
                        .frame(width: 30, height: 25)
                        .foregroundColor(.white)
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
}

#Preview {
    ProfileCard()
}
