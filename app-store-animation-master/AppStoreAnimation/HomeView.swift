//
//  HomeView.swift
//  AppStoreAnimation
//
//  Created by Ashish Singh on 13/12/20.
//

import SwiftUI

struct HomeView: View {
    @State var places = placeData
    @State var active = false
    @State var activeIndex = -1
    @State var activeView = CGSize.zero
    
    init() {
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        ZStack {

            ScrollView(showsIndicators: false) {
                VStack(spacing: 30) {
                    Text("Varanasi")
                        .font(.largeTitle).bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 30)
                        .padding(.top, 30)
                        .blur(radius: active ? 20 : 0)
                    
                    ForEach(places.indices, id: \.self) { index in
                        GeometryReader { geometry in
                            ThumbnailView(
                                show: self.$places[index].show,
                                course: self.places[index],
                                active: self.$active,
                                index: index,
                                activeIndex: self.$activeIndex,
                                activeView: self.$activeView
                            )
                            .offset(y: self.places[index].show ? -geometry.frame(in: .global).minY : 0)
                            .opacity(self.activeIndex != index && self.active ? 0 : 1)
                            .scaleEffect(self.activeIndex != index && self.active ? 0.5 : 1)
                            .offset(x: self.activeIndex != index && self.active ? screen.width : 0)
                        }
                        .frame(height: 280)
                        .frame(maxWidth: self.places[index].show ? .infinity : screen.width - 60)
                        .zIndex(self.places[index].show ? 1 : 0)
                    }
                }
                .frame(width: screen.width)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            }
            .statusBar(hidden: active ? true : false)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct ThumbnailView: View {
    @Binding var show: Bool
    var course: Places
    @Binding var active: Bool
    var index: Int
    @Binding var activeIndex: Int
    @Binding var activeView: CGSize
    
    var body: some View {
        ZStack(alignment: .top) {
            
            VStack {
                Image(uiImage: course.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            .frame(width: show ? screen.width : screen.width - 60, height: show ? 460 : 280)
            .background(Color(course.color))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color(course.color).opacity(0.3), radius: 20, x: 0, y: 20)
            .onTapGesture {
                self.show.toggle()
                self.active.toggle()
                if self.show {
                    self.activeIndex = self.index
                } else {
                    self.activeIndex = -1
                }
            }
            if show {
                DetailView(place: course, show: $show, active: $active, activeIndex: $activeIndex)
                    .background(Color.white)
                    .animation(nil)
                
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: "xmark")
                            .frame(width: 36, height: 36)
                            .foregroundColor(.white)
                            .background(Color.black)
                            .clipShape(Circle())
                    }
                    Spacer()
                }
                .onTapGesture {
                    self.show = false
                    self.active = false
                    self.activeIndex = -1
                }
                .offset(x: -16, y: 16)
                .transition(.move(edge: .top))
                .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0))
               
            }
        }
        .frame(height: show ? screen.height : 280)
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .edgesIgnoringSafeArea(.all)
    }
}

struct Places: Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
    var image: UIImage
    var color: UIColor
    var show: Bool
}

var placeData = [
    Places(title: "Dashashwamedh Ghat is the main ghat in Varanasi on the Ganga River in Uttar Pradesh. It is located close to Vishwanath Temple and is probably the most spectacular ghat. Two Hindu legends are associated with it: according to one, Brahma created it to welcome Shiva, and in another, Brahma sacrificed ten horses during Dasa-Ashwamedha yajna performed here.", subtitle: "The present ghat was built by Peshwa Balaji Baji Rao in the year 1748. A few decades later, Ahilyabahi Holkar, the Queen of Indore rebuilt the ghat in the year 1774.[1] Close to the ghat, overlooking the Ganga lies the Jantar Mantar, an observatory built by Maharaja Jai Singh of Jaipur in the year 1737.", image: #imageLiteral(resourceName: "DashashwamedhGhat"), color: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), show: false),
    Places(title: "Ganga Aarti (ritual of offering prayer to the Ganges river) is held daily at dusk. Several priests perform this ritual by carrying deepam and moving it up and down in a rhythmic tune of bhajans.[2] Special aartis are held on Tuesdays and on religious festivals.", subtitle: "The Ganga Aarti starts soon after sunset and lasts for about 45 minutes. In summer the Aarti begins at about 7pm due to late sunsets and in winter it starts at around 6pm. Hundreds of people gather at the ghat every evening to watch the event.", image: #imageLiteral(resourceName: "ganga2"), color: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), show: false),
    Places(title: "Kashi Vishwanath Temple is one of the most famous Hindu temples dedicated to Lord Shiva. It is located in Vishwanath Gali[1] of Varanasi, Uttar Pradesh, India. The Temple stands on the western bank of the holy river Ganga, and is one of the twelve Jyotirlingas, or Jyotirlingams, the holiest of Shiva Temples. The main deity is known by the names Shri Vishwanath and Vishweshwara (IAST: Vishveshvara) literally meaning Lord of the Universe. Varanasi city was called Kushi in ancient times, and hence the temple is popularly called Kashi Vishwanath Temple. The etymology of the name Vishveshvara is Vishva: Universe, Ishvara: lord, one who has dominion.", subtitle: "The Temple has been referred to in Hindu scriptures for a very long time as a central part of worship in the Shaiva Philosophy. It has been destroyed and re-constructed a number of times in history. The last structure was demolished by Aurangzeb, the sixth Mughal emperor who constructed the Gyanvapi Mosque on its site.[2] The current structure was built on an adjacent site by the Maratha ruler, Ahilya Bai Holkar of Indore in 1780.[3]", image: #imageLiteral(resourceName: "kashiVishwanath2"), color: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), show: false)
]

let screen = UIScreen.main.bounds
