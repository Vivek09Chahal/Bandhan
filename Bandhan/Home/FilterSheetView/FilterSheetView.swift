//
//  FilterSheetView.swift
//  Bandhan
//
//  Created by Vivek on 7/3/25.
//
//  This view presents a modal sheet with filtering options for user profiles
//  It contains a sidebar with filter categories and a main area showing available options
//

import SwiftUI

struct FilterSheetView: View {

    @Environment(\.dismiss) private var dismiss
    @State private var selectedCategory: FilterSheetViewModel? = .age
    @State private var viewModel = FilterViewModel()
    @Environment(DataFetch.self) var dataFetch
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // MARK: - Header Section
                Text("Filter Profiles")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding()
                
                Divider()
                
                HStack(spacing: 0) {
                    // MARK: - Left Sidebar (Filter Categories)
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 0) {
                            ForEach(FilterSheetViewModel.allCases) { category in
                                filterCategoryButton(category: category)
                            }
                        }
                    }
                    .frame(width: 120)
                    .background(Color(UIColor.systemGray6))
                    
                    Divider()
                    
                    // MARK: - Right Content Area (Filter Options)
                    ScrollView(.vertical, showsIndicators: false) {
                        if let category = selectedCategory {
                            // Display filter options in a grid layout
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150), spacing: 8)], spacing: 8) {
                                ForEach(viewModel.getOptionsForFilter(category), id: \.self) { option in
                                    filterOptionButton(option: option, category: category)
                                }
                            }
                            .padding()
                        } else {
                            // Fallback when no category is selected
                            Text("Select a category")
                                .foregroundColor(.secondary)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .padding()
                        }
                    }
                }
                
                Divider()
                
                // MARK: - Footer Section (Action Buttons)
                HStack {
                    // Reset button to clear all selected filters
                    Button("Reset") {
                        viewModel.resetFilters()
                    }
                    .buttonStyle(.bordered)
                    
                    Spacer()
                    
                    // Apply button to save selected filters and close the sheet
                    Button("Apply") {
                        viewModel.applyFilters()
                        dataFetch.applyFilters(viewModel)
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    // Close button
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
        .presentationDetents([.medium, .large])  // Allow sheet to be displayed at medium or large height
        .presentationDragIndicator(.visible)     // Show drag indicator at the top of the sheet
    }
    
    // MARK: - Helper Views
    
    /// Creates a button for a filter category in the sidebar
    /// - Parameter category: The filter category to display
    /// - Returns: A styled button view
    private func filterCategoryButton(category: FilterSheetViewModel) -> some View {
        Button {
            selectedCategory = category
        } label: {
            HStack {
                Text(category.displayName)
                    .font(.subheadline)
                    .fontWeight(selectedCategory == category ? .semibold : .regular)
                
                Spacer()
                
                // Show indicator dot if this category has active filters
                if viewModel.selectedFilters[category] != nil && !(viewModel.selectedFilters[category]?.isEmpty ?? true) {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 8, height: 8)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(selectedCategory == category ? Color(UIColor.systemBackground) : Color.clear)
        }
        .foregroundColor(selectedCategory == category ? .primary : .secondary)
    }
    
    /// Creates a selectable button for a filter option
    /// - Parameters:
    ///   - option: The text of the filter option
    ///   - category: The category this option belongs to
    /// - Returns: A styled button view with selection indicator
    private func filterOptionButton(option: String, category: FilterSheetViewModel) -> some View {
        Button {
            viewModel.toggleOption(option, for: category)
        } label: {
            HStack {
                Text(option)
                    .font(.subheadline)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                
                Spacer()
                
                // Show checkmark if option is selected
                if viewModel.isOptionSelected(option, for: category) {
                    Image(systemName: "checkmark")
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(viewModel.isOptionSelected(option, for: category) ? Color.blue : Color.secondary.opacity(0.3), lineWidth: 1)
            )
        }
    }
}

// MARK: - Preview
#Preview {
    FilterSheetView()
        .environment(DataFetch())
}
