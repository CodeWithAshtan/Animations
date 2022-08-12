//
//  AnotherDetailView.swift
//  FullFledgeAnimation
//
//  Created by Ashish Singh on 03/02/21.
//

import SwiftUI

struct TournamentDetailView: View {
    // MARK:- variables
    let animationDuration: TimeInterval = 0.45
    let trackerRotation: Double = 2.585
    
    @State var isAnimating: Bool = false
    @State var taskDone: Bool = false
    
    @State var submitScale: CGFloat = 1
    @State private var showMenu = false
    
    // MARK:- views
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(Color.white)
                        .font(.system(size: 20, weight: .heavy))
                        .offset(y: 40)

                    Spacer()

                }
                .padding(.leading, 20)
                .onTapGesture {
                    self.showMenu.toggle()
                }
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: self.isAnimating ? 46 : 20, style: .circular)
                        .fill(Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)))
                        .frame(width: self.isAnimating ? 92 : 300, height: 92)
                        .scaleEffect(submitScale, anchor: .center)
                        .onTapGesture {
                            if (!self.isAnimating) {
                                HapticManager().makeSelectionFeedback()
                                toggleIsAnimating()
                                animateButton()
                                resetSubmit()
                                Timer.scheduledTimer(withTimeInterval:  trackerRotation * 0.95, repeats: false) { _ in
                                    self.taskDone.toggle()
                                }
                            }
                        }
                    if (self.isAnimating) {
                        RotatingCircle(trackerRotation: trackerRotation, timerInterval:  trackerRotation * 0.91)
                    }
                    Tick(scaleFactor: 0.4)
                        .trim(from: 0, to: self.taskDone ? 1 : 0)
                        .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round))
                        .foregroundColor(Color.black)
                        .frame(width: 16)
                        .offset(x: -4, y: 4)
                        .animation(.easeOut(duration: 0.35))
                    Text("Save Game")
                        .font(.system(size: 32, weight: .bold, design: .monospaced))
                        .foregroundColor(Color.white)
                        .opacity(self.isAnimating ? 0 : 1)
                        .animation(Animation.easeOut(duration: animationDuration))
                        .scaleEffect(self.isAnimating ? 0.7 : 1)
                        .animation(Animation.easeOut(duration: animationDuration))
                }
            }
            if showMenu {
                MenuView()
            }
        }
        
    }
    
    // MARK:- functions
    func animateButton() {
        expandButton()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
            expandButton()
        }
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
            expandButton()
        }    }
    
    func expandButton() {
        withAnimation(Animation.linear(duration: 0.5)) {
            self.submitScale = 1.35
        }
        withAnimation(Animation.linear(duration: 0.5).delay(0.5)) {
            self.submitScale = 1
        }
    }
    
    func resetSubmit() {
        Timer.scheduledTimer(withTimeInterval: trackerRotation * 0.95 + animationDuration * 3.5, repeats: false) { _ in
            toggleIsAnimating()
            self.taskDone.toggle()
        }
    }
    
    func toggleIsAnimating() {
        withAnimation(Animation.spring(response: animationDuration * 1.25, dampingFraction: 0.9, blendDuration: 1)){
            self.isAnimating.toggle()
        }
    }
   
}


struct RotatingCircle: View {
    
    // MARK:- variables
    @State var isAnimating: Bool = false
    @State var rotationAngle: Angle = .degrees(0)
    @State var circleScale: CGFloat = 0.5
    @State var xOffset: CGFloat = 30
    @State var yOffSet: CGFloat = 0
    @State var opacity: Double = 1
    
    let trackerRotation: Double
    let timerInterval: TimeInterval
    
    // MARK:- views
    var body: some View {
        Circle()
            .fill(Color.white)
            .frame(width: 40)
            .offset(x: xOffset, y: yOffSet)
            .rotationEffect(rotationAngle)
            .scaleEffect(circleScale)
            .opacity(opacity)
            .onAppear() {
                //                Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
                withAnimation(Animation.easeOut(duration: 0.2)) {
                    self.circleScale = 1
                    self.xOffset = 130
                }
                withAnimation(Animation.linear(duration: timerInterval)) {
                    self.rotationAngle = getRotationAngle()
                }
                Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: false) { _ in
                    withAnimation(Animation.easeOut(duration: 0.2)) {
                        self.circleScale = 0.25
                        self.xOffset = 60
                        self.yOffSet = -40
                    }
                }
                Timer.scheduledTimer(withTimeInterval: timerInterval + 0.05, repeats: false) { _ in
                    withAnimation(Animation.default) {
                        self.opacity = 0
                    }
                }
            }
        //            }
    }
    
    // MARK:- functions
    func getRotationAngle() -> Angle {
        return .degrees(360 * self.trackerRotation)
    }
}


struct Tick: Shape {
    let scaleFactor: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let cX = rect.midX + 4
        let cY = rect.midY - 3
        
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.move(to: CGPoint(x: cX - (42 * scaleFactor), y: cY - (4 * scaleFactor)))
        path.addLine(to: CGPoint(x: cX - (scaleFactor * 18), y: cY + (scaleFactor * 28)))
        path.addLine(to: CGPoint(x: cX + (scaleFactor * 40), y: cY - (scaleFactor * 36)))
        return path
    }
}
