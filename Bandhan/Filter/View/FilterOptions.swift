//
//  FilterOptions.swift
//  Bandhan
//
//  Created by Vivek on 7/16/25.
//

import SwiftUI

struct FilterOptions: View {
    
    @ObservedObject var filterVM: FilterViewModel
    
    init(filterViewModel: FilterViewModel = FilterViewModel()) {
        self.filterVM = filterViewModel
    }
    
    var body: some View {
        HStack {
            // Left side - Categories
            filterCategories
            Divider()
            // Right side - Options for selected category
            filterToggle
        }
        .padding()
    }
}

#Preview {
    FilterOptions(filterViewModel: FilterViewModel())
}

extension FilterOptions {
    
    var filterCategories: some View {
        VStack(alignment: .leading) {
            Text("Categories")
                .font(.headline)
                .padding(.bottom, 8)
            
            ScrollView {
                ForEach(FilterCategory.allCases, id: \.self) { category in
                    Button(action: {
                        filterVM.selectCategory(category)
                    }) {
                        HStack {
                            Text(category.displayName)
                                .font(.footnote)
                                .foregroundColor(filterVM.selectedCategory == category ? .white : .primary)
                            Spacer()
                        }
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                        .background(
                            filterVM.selectedCategory == category ?
                            Color.blue : Color.clear
                        )
                        .cornerRadius(8)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .frame(width: 130)
    }
    
    var filterToggle: some View {
        VStack(alignment: .leading) {
            if let selectedCategory = filterVM.selectedCategory {
                Text(selectedCategory.displayName)
                    .font(.headline)
                    .padding(.bottom, 8)
                
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 8) {
                        ForEach(filterVM.getOptionsForCategory(selectedCategory), id: \.self) { option in
                            Button(action: {
                                filterVM.toggleOption(option)
                            }) {
                                HStack {
                                    Image(systemName: filterVM.isOptionSelected(option) ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(filterVM.isOptionSelected(option) ? .blue : .gray)
                                    
                                    Text(option)
                                        .font(.footnote)
                                        .foregroundColor(.primary)
                                    
                                    Spacer()
                                }
                                .padding(.vertical, 8)
                                .padding(.horizontal, 12)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(6)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
    
}
