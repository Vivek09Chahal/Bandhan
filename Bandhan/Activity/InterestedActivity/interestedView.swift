//
//  interestedView.swift
//  Bandhan
//
//  Created by Vivek on 7/18/25.
//

import SwiftUI

struct ReceivedView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "tray.and.arrow.down")
                .font(.system(size: 50))
                .foregroundColor(.blue)
            
            Text("Received Interests")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("You have no received interests yet")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

struct AcceptedView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "checkmark.circle")
                .font(.system(size: 50))
                .foregroundColor(.green)
            
            Text("Accepted Interests")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("You have no accepted interests yet")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

struct SentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "paperplane")
                .font(.system(size: 50))
                .foregroundColor(.orange)
            
            Text("Sent Interests")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("You have not sent any interests yet")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}
