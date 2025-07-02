//
//  ActivityViewModel.swift
//  Bandhan
//
//  Created by Vivek on 7/2/25.
//

import Foundation
import SwiftUI

enum ActityCaseIters: String, CaseIterable, Hashable{
    
    case reveived, accepted, sent
    
    var actitityTitle: String{
        switch self {
            case .reveived:
            return "Received"
        case .accepted:
            return "Accepted"
        case .sent:
            return "Sent"
        }
    }
    
    var scrollID: String{
        return self.rawValue
    }
    
    @ViewBuilder func activityContent() -> some View {
        switch self {
        case .reveived:
            ReceivedView()
        case .accepted:
            AcceptedView()
        case .sent:
            SentView()
        }
    }
}


struct ReceivedView: View {
    var body: some View {
        Text("Received")
    }
}


struct AcceptedView: View {
    var body: some View {
        Text("Accepted")
    }
}


struct SentView: View {
    var body: some View {
        Text("Sent")
    }
}
