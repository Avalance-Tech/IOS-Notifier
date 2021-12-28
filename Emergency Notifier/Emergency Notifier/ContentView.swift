//
//  ContentView.swift
//  Emergency Notifier
//
//  Created by Adnan Odimah on 18/12/2021.
//

import SwiftUI

struct MenuItem: Identifiable{
    var id = UUID()
    let text: String
}

struct News: Identifiable{
    var id = UUID()
    let news: String
    let date: String
}

struct MenuContents: View{
    
    let items : [MenuItem] = [
        MenuItem(text: "Home"),
        MenuItem(text: "Settings"),
        MenuItem(text: "Notifications"),
        MenuItem(text: "Help / Support")
    ]
    
    // Body
    var body: some View{
    
        ZStack{
            Color(UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1))
            VStack(alignment: .leading, spacing: 40) {
                ForEach(items) {item in
                    HStack{
                        Text(item.text)
                            .font(.system(size:22))
                            .bold()
                            .multilineTextAlignment(.leading)
                            .foregroundColor(Color.white)
                            .opacity(0.9)
                    }.padding(.leading, 20).padding(.top, 25)
                    Divider()
                }
                Spacer()

            VStack(alignment: .center, spacing: 5){
                Image("Avala_logo").resizable().aspectRatio(contentMode: .fit).frame(width: 50, height: 50)                            .foregroundColor(Color.white)
                Text("Emergency Notifier\nMade by Avalanche Tech").padding(.bottom, 20).opacity(0.8).multilineTextAlignment(.center)                            .foregroundColor(Color.white)
            } .padding(.leading, 25)
            } .padding(.vertical, 50)
        }
        
    }
    
}


struct SideMenu: View
{
    // Properties
    let width: CGFloat
    let menuOpened: Bool
    let toggleMenu: () -> Void
    @State var show = false
    @Environment (\.colorScheme) var colorScheme
    
    // Body
    var body: some View
    {
        ZStack
        {
            // Dimmed Background
            
            GeometryReader{ _ in
                EmptyView()
            }   .background(colorScheme == .dark ? Color.black.opacity(0.95) : Color.gray.opacity(0.90))
                .opacity(self.menuOpened ? 1 : 0)
                .animation(Animation.easeIn(duration:0.3).delay(0.2), value: menuOpened)
                .onTapGesture { self.toggleMenu() }
            
            // Menu Content
            HStack{
                MenuContents()
                    .frame(width: width)
                    .offset(x: menuOpened ? 0 : -width)
                    .ignoresSafeArea()
                    .animation(.default, value: menuOpened)
                	
                Spacer()
                
            }
        }//.animation(Animation.easeIn(duration: 0.5 ).delay(0.2), value: menuOpened)

    }
}



struct HomePage: View
{

    @State var on_call: Bool
    @State var menuOpened = false
    var branch: String = "Al Ain"
    let recentNews = [
    News(news: "Add a way to fetch news from the database", date: "20/12/2021"),
    News(news: "News 2", date: "06/12/2021")
    ]
    
    // Body
    var body: some View
        {

ZStack                                                           // Zstack
        {
if !menuOpened
        {
    
    VStack(alignment: .center, spacing: 100)
    {                           // Vstack - Big Vstack for the entire page
                
        HStack(alignment: .center, spacing: 15.0) // 96 to center
                    {                                            // Top Hstack - Top horizontal stack for menu and title
                
            Button
                        {
            
                    
                    self.menuOpened.toggle()
            
                    
                        }
                label:
                        {
                            Image(systemName: "list.bullet")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .scaledToFit()
                    
                        }
                    
            Text("Home")
                            .font(.largeTitle)
                            .multilineTextAlignment(.center)
                
                        Spacer()
                    
                    }                                            // Close top Hstack

                                .padding(.leading, 40)
                                .padding(.top, 60)
        Divider().offset(y:-80)

        HStack
                    {
                        Spacer()
                
                        Toggle("On Call", isOn: $on_call)
                            .padding(.horizontal, 100.0)
                            .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                
                        Spacer()
                    }.offset(y:-120)

            
        VStack(spacing: 10)
                    {                                              // VStack - Bottom recent news tab
                
            Text("Recent News from " + branch)
                            .font(.title).underline()
                        
    ForEach(recentNews){item in
                    
        HStack(alignment: .center)
                        {                                          // Hstack - for news
                    
                            Text(String(item.news))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 10.0)
                              //  .frame(width: 150, height: 50)
                                .font(.body)
                                .font(.system(size: 4))
                                .onTapGesture {
                                    	
                                }
                            
                            Spacer()
                            
                            Text(String(item.date))
                                .font(.body)
                                .font(.system(size: 5))
                                .multilineTextAlignment(.trailing)
                        }                                          // Close HStack - for news
        }
                    }.offset(y: -160)                                              // Close VStack - news
                        Spacer()
                               .edgesIgnoringSafeArea(.all)         // Close VStack}
        }                                                          // Close ZStack
        }                                                          // Close IF statement
            SideMenu(width: UIScreen.main.bounds.width/1.5, menuOpened: menuOpened, toggleMenu: toggleMenu)
        }
    }                                                              // Close Body
    
    // Methods
    
    func toggleMenu()
    
   {
       menuOpened.toggle()
    
   }

    
    
}                                                                       //Close home Struct

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomePage(on_call: false)
    }
}
