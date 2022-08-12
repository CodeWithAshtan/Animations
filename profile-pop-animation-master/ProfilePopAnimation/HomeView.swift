//
//  HomeView.swift
//  ProfilePopAnimation
//
//  Created by Ashish Singh on 17/10/20.
//


import SwiftUI

struct HomeView: View {
    @Binding var showProfile: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("Game Zone")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                
                Spacer()
                
                AvatarView(showProfile: $showProfile)
            }
            .padding(.horizontal)
            .padding(.top, 30)
            
            Spacer()
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .background(Color(#colorLiteral(red: 0.06274509804, green: 0.2039215686, blue: 0.6235294118, alpha: 1)))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showProfile: .constant(false))
    }
}
