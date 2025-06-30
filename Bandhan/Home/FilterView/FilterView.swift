//
//  FilterView.swift
//  Bandhan
//
//  Created by Vivek on 6/30/25.
//

import SwiftUI

struct FilterView: View {
    enum FilterOption {
        case all, handpicked
    }
    
    @State private var selectedFilter: FilterOption = .all
    
    var body: some View {
        NavigationStack{
            HStack{
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(Color(UIColor.systemGray6))
                        .frame(height: 50)
                    
                    HStack(spacing: 0) {
                        // All filter option
                        FilterButton(
                            title: "All",
                            isSelected: selectedFilter == .all,
                            action: { selectedFilter = .all }
                        )
                        
                        // Handpicked filter option
                        FilterButton(
                            title: "Handpicked",
                            icon: "diamond.fill",
                            isSelected: selectedFilter == .handpicked,
                            action: { selectedFilter = .handpicked }
                        )
                    }
                }
                .animation(.linear(duration: 0.2), value: selectedFilter)
                
                Image(systemName: "line.3.horizontal.decrease.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding()
            }
        }
    }
}

/// A reusable button component for filter options
struct FilterButton: View {
    let title: String
    let icon: String?
    let isSelected: Bool
    let action: () -> Void
    
    init(title: String, icon: String? = nil, isSelected: Bool, action: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.isSelected = isSelected
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                if let icon = icon {  
                    Image(systemName: icon)
                        .font(.system(size: 14))
                }
                Text(title)
                    .fontWeight(.medium)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(isSelected ? Color(UIColor.systemBackground) : Color.clear)
                    .shadow(color: isSelected ? Color.black.opacity(0.05) : Color.clear, radius: 2, x: 0, y: 1)
            )
            .foregroundColor(isSelected ? .primary : .secondary)
        }
    }
}

#Preview {
    FilterView()
}
