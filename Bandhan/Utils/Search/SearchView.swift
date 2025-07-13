//
//  SearchView.swift
//  Bandhan
//
//  Created by Vivek on 7/12/25.
//

import SwiftUI

struct searchView: View {
    
    @State var text: String = ""
    
    var body: some View {
        GeometryReader{ proxy in
            ZStack(alignment: .leading){
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.gray.opacity(0.9))
                    .frame(width: proxy.size.width/1.1 , height: 50)
                HStack{
                    Image(systemName: "magnifyingglass")
                        .padding(.leading)
                    TextField("Search", text: $text)
                        .foregroundColor(.gray)
                }
            }
            .padding()
        }
    }
}

#Preview {
    searchView()
}
