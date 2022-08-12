//
//  MenuView.swift
//  FullFledgeAnimation
//
//  Created by Ashish Singh on 30/01/21.
//

import SwiftUI
import AVKit
import AVFoundation


struct MenuView: View {
    
    @State var options = optionData
    @State var showEntry = false
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack {
                OnLoopPlayer()
                    .offset(y: self.showEntry ? 0 : -250)
                    .frame(width: screen.width - 50, height: screen.height - 350, alignment: .center)
                    .animation(.spring(response: 1.6, dampingFraction: 0.30, blendDuration: 1.0))
                    .cornerRadius(20)
                    .opacity(self.options[0].show || self.options[2].show  ? 0.0 : 1.0)
                    .animation(.easeInOut(duration: 1.0))
                    .onAppear {
                        self.showEntry = true
                    }
                Spacer()
            }
            VStack{
                Spacer()
                VStack {
                    HStack {
                        ZStack {
                            if self.options[0].showDetail {
                                QuickPlayDetailView()
                                    .offset(x: self.options[0].showDetail ? 80 : 0, y: self.options[0].showDetail ? 100 : 0 )
                                    .frame(width: self.options[0].showDetail ? screen.width : 0.0 , height:self.options[0].showDetail ? screen.height : 0.0)
                                    .opacity(self.options[0].showDetail ? 1.0 : 0.0)
                            } else {
                                OptionView(show: self.$options[0].show, option: self.options[0], showDetail: self.$options[0].showDetail)
                                    .frame(width: self.options[0].show ? screen.width : 150, height: self.options[0].show ? screen.height : 150)
                                    .background(LinearGradient(gradient: Gradient(colors: [self.options[0].imageColor.opacity(0.5),self.options[0].imageColor.opacity(1.0) ]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                                    .rotationEffect(self.options[0].show ? .degrees(360) : .zero)
                                    .opacity(self.options[0].show ? 0.0 : 1.0)
                                    .offset(x: self.options[2].show ? -100 : 0)
                                    .animation(.easeInOut(duration: 1.2))
                            }
                        }
                        
                        OptionView(show: self.$options[1].show, option: self.options[1], showDetail: self.$options[1].showDetail)
                            .frame(width: 150, height: 150)
                            .background(LinearGradient(gradient: Gradient(colors: [self.options[1].imageColor.opacity(0.5),self.options[1].imageColor.opacity(1.0) ]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                            .offset(x: self.options[2].show ? 100 : 0)
                            .offset(x: self.options[0].show ? 100 : 0)
                            .animation(.easeInOut(duration: 1.2))
                    }
                    HStack {
                        ZStack {
                            TournamentDetailView()
                                .frame(width: self.options[2].showDetail ? screen.width : 0.0 , height:self.options[2].showDetail ? screen.height : 0.0)
                                .offset(x: 79, y: -80)
                                .opacity(self.options[2].showDetail ? 1.0 : 0.0)
                            
                            OptionView(show: self.$options[2].show, option: self.options[2], showDetail: self.$options[2].showDetail)
                                .frame(width: self.options[2].show ? screen.width : 150, height: self.options[2].show ? screen.height + 200 : 150)
                                .background(self.options[2].show ? LinearGradient(gradient: Gradient(colors: [Color.clear,Color.clear ]), startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(gradient: Gradient(colors: [self.options[2].imageColor.opacity(0.5),self.options[2].imageColor.opacity(1.0) ]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                                .opacity(self.options[2].show ? 0.0 : 1.0)
                                .animation(.easeInOut(duration: 1.2))
                            
                        }
                        OptionView(show: self.$options[3].show, option: self.options[3], showDetail: self.$options[3].showDetail)
                            .frame(width: 150, height: 150)
                            .background(LinearGradient(gradient: Gradient(colors: [self.options[3].imageColor.opacity(0.5),self.options[3].imageColor.opacity(1.0) ]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                            .offset(x: self.options[2].show ? 200 : 0)
                            .animation(.easeInOut(duration: 1.2))
                    }
                    .offset(y: self.options[0].show ? 100 : 0)
                }
            }
            .padding(.bottom, self.options[2].show ? 0 : 50)
            
        }
        
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

struct OptionView: View {
    @Binding var show: Bool
    var option: Options
    @Binding var showDetail: Bool
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading, spacing: 2) {
                Text(option.title)
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(Color.white)
                
                
                
                option.imageColor
                    .frame(width: 20, height: 3)
                    .cornerRadius(3)
                
            }
            
            Text(option.subtitle)
                .font(.system(size: 20, weight: .heavy))
                .foregroundColor(Color.white)
            
            Image(systemName: option.image)
                .font(.system(size: 40, weight: .light))
                .imageScale(.large)
                .frame(width: 50, height: 50)
                .foregroundColor(.white)
            
            
        }
        
        
        .onTapGesture {
            self.show.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.21) {
                self.showDetail = true
            }
        }
        
    }
    
}

struct Options: Identifiable {
    var id = UUID()
    let title: String
    let subtitle: String
    let image: String
    let imageColor: Color
    var show: Bool
    var showDetail: Bool
    
}

var optionData = [
    Options(title: "NEW", subtitle: "Quick Play", image: "play", imageColor: Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)), show: false, showDetail: false),
    Options(title: "MONTH OF JANUARY", subtitle: "Events", image: "calendar", imageColor: Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)), show: false, showDetail: false),
    Options(title: "SEASON 3", subtitle: "Tournament", image: "gamecontroller", imageColor: Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)), show: false, showDetail: false),
    Options(title: "PLAY WITH FRIENDS", subtitle: "Rivals", image: "person.2", imageColor: Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)), show: false, showDetail: false)
]

let screen = UIScreen.main.bounds
