//
//  DetailView.swift
//  AppStoreAnimation
//
//  Created by Ashish Singh on 13/12/20.
//

import SwiftUI

struct DetailView: View {
    var place: Places
    @Binding var show: Bool
    @Binding var active: Bool
    @Binding var activeIndex: Int
    
    
    var body: some View {
            VStack {
                VStack {
                    ZStack {
                        Image(uiImage: place.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        
                    }
                }
                .frame(width: screen.width, height: 400)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color(place.color).opacity(0.3), radius: 20, x: 0, y: 20)
                ScrollView { 
                VStack(alignment: .leading, spacing: 30.0) {
                    Text("About this place")
                        .font(.title).bold()
                    Text(place.title)
                    Text(place.subtitle)
                }
                .padding(30)
            }
            .edgesIgnoringSafeArea(.all)
        }
        .clipped()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(place: placeData[0], show: .constant(true), active: .constant(true), activeIndex: .constant(-1))
    }
}
