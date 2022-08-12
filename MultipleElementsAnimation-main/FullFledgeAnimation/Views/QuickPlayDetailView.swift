//
//  DetailView.swift
//  FullFledgeAnimation
//
//  Created by Ashish Singh on 30/01/21.
//

import SwiftUI

struct QuickPlayDetailView: View {
    @State var scale: CGFloat = 1
    @State private var shouldAnimate = false
    @State private var expand = false
    @Namespace private var shapeTransition
    @State private var showMenu = false
    
    
   
    var body: some View {
        ZStack {
            Color.black
            
            VStack {
                
                HStack {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(Color.white)
                        .font(.system(size: 20, weight: .heavy))

                    Spacer()

                }
                .padding(.leading, 20)
                .onTapGesture {
                    self.showMenu.toggle()
                }
                
                HStack(alignment: .center, spacing: shouldAnimate ? 15 : 5) {
                            Capsule(style: .continuous)
                                .fill(Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)))
                                .frame(width: 10, height: 60)
                            Capsule(style: .continuous)
                                .fill(Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)).opacity(0.8))
                                .frame(width: 10, height: 30)
                            Capsule(style: .continuous)
                                .fill(Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)).opacity(0.7))
                                .frame(width: 10, height: 60)
                            Capsule(style: .continuous)
                                .fill(Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)).opacity(0.8))
                                .frame(width: 10, height: 30)
                            Capsule(style: .continuous)
                                .fill(Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)))
                                .frame(width: 10, height: 60)
                        }
                        .frame(width: shouldAnimate ? 150 : 100)
                        .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true))
                        .onAppear {
                            self.shouldAnimate = true
                        }
                
                VStack {
                    if shouldAnimate {
                 
                        // Rounded Rectangle
                        Spacer()
                        ZStack {
                            RoundedRectangle(cornerRadius: 20.0)
                                .matchedGeometryEffect(id: "circle", in: shapeTransition)
                                .frame(minWidth: 0, maxWidth: screen.width - 60, maxHeight: 50)
                                .padding()
                                .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                                .animation(Animation.easeInOut(duration: 1.5))
                                .onTapGesture {
                                    expand.toggle()
                                }
                            
                            Text("Play Now")
                                .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 50)
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)))
                            
                        }
                       
                 
                    } else {
                 Spacer()
                        // Circle
                        RoundedRectangle(cornerRadius: 50.0)
                            .matchedGeometryEffect(id: "circle", in: shapeTransition)
                            .frame(width: 100, height: 100)
                            .foregroundColor(Color(.systemOrange))
                            .animation(.easeIn)
                            .onTapGesture {
                                expand.toggle()
                            }
                 
                       
                    }
                }
                
               
                
            }
            .padding(.top, 60)
            .padding(.bottom, 60)
            
            if showMenu {
                MenuView()
//                    .offset(y: -80.0)
            }
        }
        
        
    }
    func drawCircle(in path: inout Path, at point: CGPoint, radius: CGFloat) {
            path.move(to: CGPoint(x: point.x + radius, y: point.y))
            path.addArc(center: point, radius: radius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: false)
        }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        QuickPlayDetailView()
    }
}

struct Example1PolygonShape: Shape {
    var sides: Double
    
    var animatableData: Double {
        get { return sides }
        set { sides = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        
        // hypotenuse
        let h = Double(min(rect.size.width, rect.size.height)) / 2.0
        
        // center
        let c = CGPoint(x: rect.size.width / 2.0, y: rect.size.height / 2.0)
        
        var path = Path()
        
        let extra: Int = Double(sides) != Double(Int(sides)) ? 1 : 0
        
        for i in 0..<Int(sides) + extra {
            let angle = (Double(i) * (360.0 / Double(sides))) * Double.pi / 180
            
            // Calculate vertex
            let pt = CGPoint(x: c.x + CGFloat(cos(angle) * h), y: c.y + CGFloat(sin(angle) * h))
            
            if i == 0 {
                path.move(to: pt) // move to first vertex
            } else {
                path.addLine(to: pt) // draw line to next vertex
            }
        }
        
        path.closeSubpath()
        
        return path
    }
}

extension View {
    func animate(using animation: Animation = Animation.easeInOut(duration: 2.0), _ action: @escaping () -> Void) -> some View {
        return onAppear {
            withAnimation(animation) {
                action()
            }
        }
    }
}

extension View {
    func animateForever(using animation: Animation = Animation.easeInOut(duration: 1), autoreverses: Bool = false, _ action: @escaping () -> Void) -> some View {
        let repeated = animation.repeatForever(autoreverses: autoreverses)
        
        return onAppear {
            withAnimation(repeated) {
                action()
            }
        }
    }
}
struct AnimatableGradient: AnimatableModifier {
    let from: [UIColor]
    let to: [UIColor]
    var pct: CGFloat = 0
    
    var animatableData: CGFloat {
        get { pct }
        set { pct = newValue }
    }
    
    func body(content: Content) -> some View {
        var gColors = [Color]()
        
        for i in 0..<from.count {
            gColors.append(colorMixer(c1: from[i], c2: to[i], pct: pct))
        }
        
        return RoundedRectangle(cornerRadius: 15)
            .fill(LinearGradient(gradient: Gradient(colors: gColors),
                                 startPoint: UnitPoint(x: 0, y: 0),
                                 endPoint: UnitPoint(x: 1, y: 1)))
            .frame(width: screen.width, height: screen.height)
            .edgesIgnoringSafeArea(.all)
    }
    
    // This is a very basic implementation of a color interpolation
    // between two values.
    func colorMixer(c1: UIColor, c2: UIColor, pct: CGFloat) -> Color {
        guard let cc1 = c1.cgColor.components else { return Color(c1) }
        guard let cc2 = c2.cgColor.components else { return Color(c1) }
        
        let r = (cc1[0] + (cc2[0] - cc1[0]) * pct)
        let g = (cc1[1] + (cc2[1] - cc1[1]) * pct)
        let b = (cc1[2] + (cc2[2] - cc1[2]) * pct)

        return Color(red: Double(r), green: Double(g), blue: Double(b))
    }
}
