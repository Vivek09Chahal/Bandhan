//
//  ProfilePhotoView.swift
//  Bandhan
//
//  Created by Vivek on 7/3/25.
//

import SwiftUI

struct ProfilePhotoView: View {
    
    var width: Double?
    var height: Double?
    var pic: String
    
    var body: some View {
        AsyncImage(url: URL(string: pic)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width/(width ?? 1), height: UIScreen.main.bounds.height/(height ?? 1))
                .clipShape(RoundedRectangle(cornerRadius: 20))
        } placeholder: {
            Color.gray.opacity(0.3)
                .frame(height: UIScreen.main.bounds.height / 2)
        }
    }
}
