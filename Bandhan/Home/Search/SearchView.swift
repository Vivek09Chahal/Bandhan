//
//  SearchView.swift
//  Bandhan
//
//  Created by Vivek on 7/12/25.
//

import SwiftUI

struct searchView: View {
    
    @State var searchVM: [ProfilesData] = HomeViewModel().allProfiles
    @State var searchText: String = ""
    
    var body: some View {
        GeometryReader{ proxy in
            HStack{
                searchBar(proxy: proxy)
                .padding()
                
                if !searchText.isEmpty {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .onTapGesture {
                            searchText = ""
                        }
                        .padding(.trailing)
                }
            }
        }
    }
}

#Preview {
    searchView()
}

extension searchView{
    
    func searchBar(proxy: GeometryProxy) -> some View{
        ZStack(alignment: .leading){
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.gray.opacity(0.5))
                .frame(width: proxy.size.width/(searchText.isEmpty ? 1.1 : 1.29) , height: 50)
            HStack{
                Image(systemName: "magnifyingglass")
                    .padding(.leading)
                TextField("Search", text: $searchText)
                
            }
        }
    }
    
}
