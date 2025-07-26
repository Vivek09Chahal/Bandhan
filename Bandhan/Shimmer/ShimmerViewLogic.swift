//
//  ShimmerView.swift
//  Bandhan
//
//  Created by Vivek on 7/20/25.
//

import SwiftUI

struct ShimmerView<Content: View>: View {
    let content: Content
    let speed: Double
    let color: Color
    let angle: Double
    let animateOpacity: Bool
    let animateScale: Bool
    @State var move = false
    
    init(
        speed: Double = 1.5,
        color: Color = .gray,
        angle: Double = 0,
        animateOpacity: Bool = false,
        animateScale: Bool = false,
        @ViewBuilder content: () -> Content
    ) {
        self.speed = speed
        self.color = color
        self.angle = angle
        self.animateOpacity = animateOpacity
        self.animateScale = animateScale
        self.content = content()
    }
    
    var body: some View {
        content
            .overlay {
                GeometryReader { proxy in
                    let gradient = LinearGradient(
                        gradient: Gradient(colors: [color.opacity(0), color.opacity(0.5), color.opacity(0)]),
                        startPoint: .leading, endPoint: .trailing
                    )
                    Rectangle()
                        .fill(gradient)
                        .rotationEffect(Angle(degrees: angle))
                        .frame(width: proxy.size.width/2.5, height: proxy.size.height*2)
                        .offset(x: move ? proxy.size.width * 1.1 : -proxy.size.width * 1.4, y: -proxy.size.height / 2)
                        .animation(.linear(duration: speed).repeatForever(autoreverses: false), value: move)
                        .onAppear{
                            DispatchQueue.main.asyncAfter(deadline: .now()+0.3){
                                move = true
                            }
                        }
                }
            }
            .mask(content)
            .scaleEffect(animateScale ? (move ? 1: 0.95) : 1)
            .opacity(0.5)
            .animation(
                (animateOpacity || animateScale) ?
                    .linear(duration: 1).repeatForever(autoreverses: true) : nil,
                value: move
            )
    }
}
