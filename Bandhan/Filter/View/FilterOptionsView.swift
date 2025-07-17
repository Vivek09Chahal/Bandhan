//
//  FilterOptionsView.swift
//  Bandhan
//
//  Created by Vivek on 7/16/25.
//

import SwiftUI

struct FilterOptionsView: View {
    
    @ObservedObject var filterViewModel: FilterViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            FilterOptions(filterViewModel: filterViewModel)
                .navigationTitle("Filters")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Done") {
                            dismiss()
                        }
                    }
                }
        }
    }
}

#Preview {
    FilterOptionsView(filterViewModel: FilterViewModel())
}
