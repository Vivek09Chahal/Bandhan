//
//  MembershipView.swift
//  Bandhan
//
//  Created by Vivek on 7/5/25.
//

import SwiftUI

enum MembershipType: String, CaseIterable {
    
    case selfService
    case assisted
    
    @ViewBuilder
    func view() -> some View {
        switch self {
        case .selfService:
            Plans()
        case .assisted:
            AssistedView()
        }
    }
}

enum MembershipPlans: String, CaseIterable {
    case proLite, pro, proMax
    
    func selectedPlan(membershipPlan: MembershipPlans) -> String{
        switch self {
        case .proLite:
            return "Pro Lite"
        case .pro:
            return "Pro"
        case .proMax:
            return "Pro Max"
        }
    }
    
    func getPlanVariables(selectedPlan: MembershipPlans) -> PlanVariables {
        switch self {
        case .proLite:
            return PlanVariables(
                ifSelected: selectedPlan == .proLite,
                title: "Pro Lite",
                islimitedCalls: true,
                isAdvanceSearch: false,
                superInterest: 5,
                spotlight: 0,
                contactViews: 10
            )
        case .pro:
            return PlanVariables(
                ifSelected: selectedPlan == .pro,
                title: "Pro",
                islimitedCalls: true,
                isAdvanceSearch: true,
                superInterest: 15,
                spotlight: 5,
                contactViews: 50
            )
        case .proMax:
            return PlanVariables(
                ifSelected: selectedPlan == .proMax,
                title: "Pro Max",
                islimitedCalls: true,
                isAdvanceSearch: true,
                superInterest: 50,
                spotlight: 20,
                contactViews: 100
            )
        }
    }
}


struct MembershipView: View {
    
    @State private var membershipType: MembershipType = .selfService
    
    var body: some View {
        VStack{
            HStack{
                Text("Upgrade Membership")
                    .font(.title2)
                Spacer()
                Text("Need Help?")
                    .foregroundStyle(.red)
            }
            Divider()
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(Color(UIColor.systemGray6))
                    .frame(height: 50)
//                HStack(spacing: 0) {
                    // All filter option
//                    FilterButton(title: "Self-Service", isSelected: membershipType == .selfService, action: {
//                        membershipType = .selfService
//                    })
//                    
//                    // Handpicked filter option
//                    FilterButton(title: "Assisted", isSelected: membershipType == .assisted, action:    {
//                        //action
//                        membershipType = .assisted
//                    })
//                }
            }
            membershipType.view()
            Spacer()
        }
        .padding()
    }
}

#Preview {
    MembershipView()
}


struct Plans: View {
    
    @State var selectedMembershipPlan: MembershipPlans = .proLite
    
    var body: some View {
        VStack {
            HStack(alignment: .bottom) {
                
                VStack(alignment: .leading, spacing: 19) {
                    Text("Calls & Contact Sharing")
                    Text("Advanced Search")
                    Text("Super Interest")
                    Text("Spotlight")
                    Text("Contact Views")
                }
                .font(.footnote)
                
                ForEach(MembershipPlans.allCases, id: \.self) { plan in
                    Button(action: {
                        selectedMembershipPlan = plan
                    }) {
                        PlanBar(pv: plan.getPlanVariables(selectedPlan: selectedMembershipPlan))
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            
            HStack{
                monthsOfPlan()
            }
            
            Button {
                //
            } label: {
                Text("Get Premium")
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.pink.opacity(0.7))
                    .cornerRadius(10)
                    .padding(.vertical)
            }
            
            Text("Recurring payment, cancel anytime")
                .foregroundStyle(.gray)
        }
        .padding()
    }
}

struct PlanVariables{
    var ifSelected: Bool
    var title: String
    var islimitedCalls: Bool
    var isAdvanceSearch: Bool
    var superInterest: Int
    var spotlight: Int
    var contactViews: Int
}

struct PlanBar: View {
    
    var pv: PlanVariables
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(pv.ifSelected ? Color.pink.opacity(0.1) : Color.clear)
            .stroke(pv.ifSelected ? Color.pink.opacity(0.5) : Color.gray.opacity(0.3))
            .frame(width: 70, height: 250)
            .overlay {
                VStack(spacing: 23) {
                    Text(pv.title)
                    
                    Image(systemName: pv.ifSelected ? "record.circle" : "circle")
                        .foregroundColor(pv.ifSelected ? .pink : .primary)
                    
                    Image(systemName: pv.islimitedCalls ? "checkmark" : "xmark")
                        .foregroundColor(pv.islimitedCalls ? .green : .primary)
                    
                    Image(systemName: pv.isAdvanceSearch ? "checkmark" : "xmark")
                        .foregroundColor(pv.isAdvanceSearch ? .green : .primary)
                    
                    Text("\(pv.superInterest)")
                    
                    Text("\(pv.spotlight)")
                    
                    Text("\(pv.contactViews)")
                }
                .font(.footnote)
            }
    }
}

struct monthsOfPlan: View {
    @State private var selectedPlan: Int = 0
    
    let plans = [
        PricingPlan(duration: "1 month", price: "Rs. 601", originalPrice: "Rs. 1,304"),
        PricingPlan(duration: "3 month", price: "Rs. 1,503", originalPrice: "Rs. 3,415"),
        PricingPlan(duration: "Till Marriage", price: "Rs. 4,587", originalPrice: "Rs. 10,429")
    ]
    
    var body: some View {
        HStack(spacing: 15) {
            ForEach(0..<plans.count, id: \.self) { index in
                VStack(spacing: 5) {
                    HStack{
                        VStack(alignment: .leading, spacing: 2) {
                            Text(plans[index].duration)
                                .font(.caption)
                                .foregroundColor(.primary)
                            
                            Text(plans[index].price)
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(.primary)
                            
                            Text(plans[index].originalPrice)
                                .font(.caption2)
                                .foregroundColor(.secondary)
                                .strikethrough()
                        }
                        Image(systemName: selectedPlan == index ? "record.circle" : "circle")
                            .foregroundStyle(selectedPlan == index ? .pink.opacity(0.5) : .primary)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                .onTapGesture {
                    selectedPlan = index
                }
            }
        }
        .padding(.vertical, 10)
    }
}

struct PricingPlan {
    let duration: String
    let price: String
    let originalPrice: String
}

struct AssistedView: View {
    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: "person.2.fill")
                .font(.system(size: 60))
                .foregroundColor(.accentColor)
            
            VStack(spacing: 15) {
                Text("Personal Matchmaking")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text("Get personalized assistance from our relationship experts")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            
            VStack(alignment: .leading, spacing: 15) {
                FeatureRow(icon: "checkmark.circle.fill", text: "Dedicated relationship manager")
                FeatureRow(icon: "checkmark.circle.fill", text: "Personalized profile optimization")
                FeatureRow(icon: "checkmark.circle.fill", text: "Curated match recommendations")
                FeatureRow(icon: "checkmark.circle.fill", text: "24/7 customer support")
                FeatureRow(icon: "checkmark.circle.fill", text: "Success coaching sessions")
            }
            
            Button(action: {
                // Handle contact action
                print("Contact team tapped")
            }) {
                Text("Contact Our Team")
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.pink.opacity(0.7))
                    .cornerRadius(10)
                    .padding(.vertical)
            }
            
            Spacer()
        }
        .padding()
    }
}

struct FeatureRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.green)
                .font(.system(size: 16))
            
            Text(text)
                .font(.body)
            
            Spacer()
        }
    }
}
