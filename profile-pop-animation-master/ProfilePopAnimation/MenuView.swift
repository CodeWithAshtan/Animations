//
//  MenuView.swift
//  ProfilePopAnimation
//
//  Created by Ashish Singh on 17/10/20.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 20) {
                HStack(alignment: .center, spacing: -20){
                    GridView(title: "NEW", subtitle: "Quick Play", image: "play", imageColor: Color(#colorLiteral(red: 0.9294117647, green: 0.5843137255, blue: 0.3058823529, alpha: 1)))
                    GridView(title: "MONTH OF JANUARY", subtitle: "Events", image: "calendar", imageColor: Color(#colorLiteral(red: 0.4196078431, green: 0.8039215686, blue: 0.9803921569, alpha: 1)))
                }
                HStack(alignment: .center, spacing: -20) {
                    GridView(title: "SEASON 3", subtitle: "Tournament", image: "gamecontroller", imageColor: Color(#colorLiteral(red: 0.9176470588, green: 0.2509803922, blue: 0.4, alpha: 1)))
                    GridView(title: "PLAY WITH FRIENDS", subtitle: "Rivals", image: "person.2", imageColor: Color(#colorLiteral(red: 0.4941176471, green: 0.3254901961, blue: 0.9607843137, alpha: 1)))
                }
                
            }
            .padding(.bottom, 20)
        }

    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

struct GridView: View {
    let title: String
    let subtitle: String
    let image: String
    let imageColor: Color
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(Color(#colorLiteral(red: 0.2156862745, green: 0.2784313725, blue: 0.6745098039, alpha: 1)))
                    
                    
                imageColor
                    .frame(width: 20, height: 3)
                    .cornerRadius(3)
                
            }
            
            Text(subtitle)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color(#colorLiteral(red: 0.1450980392, green: 0.2784313725, blue: 0.6901960784, alpha: 1)))
            
            Image(systemName: image)
                .font(.system(size: 40, weight: .light))
                .imageScale(.large)
                .frame(width: 50, height: 50)
                .foregroundColor(imageColor)
            
            
        }
        .frame(width: 150, height: 150)
        .background(Color(.white))
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
        .padding(.horizontal, 30)
    }
}
