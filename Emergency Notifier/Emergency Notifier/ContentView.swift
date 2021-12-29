//
//  ContentView.swift
//  Emergency Notifier
//
//  Created by Adnan Odimah on 18/12/2021.
//

import SwiftUI


// Utility Structures (for our use)

struct MenuItem: Identifiable{
    var id = UUID()
    let text: String
}

struct News: Identifiable{
    var id = UUID()
    let news: String
    let date: String
}


// Side Menu

    // Contents

struct MenuContents: View{
    
    let items : [MenuItem] = [  // Creates a list for the items in the side menu
        MenuItem(text: "Home"),
        MenuItem(text: "Settings"),
        MenuItem(text: "Notifications"),
        MenuItem(text: "Help / Support")
    ]
    
    // Body
    var body: some View{
    
        ZStack{
            Color(UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)) // Color of the side Menu #Grey
            VStack(alignment: .leading, spacing: 40) { 
                ForEach(items) {item in   // Loops through the items in the list
                    HStack{
                        Text(item.text)   // Creates a Text field for the item
                            .font(.system(size:22))
                            .bold()
                            .multilineTextAlignment(.leading)
                            .foregroundColor(Color.white)
                            .opacity(0.9)
                    }.padding(.leading, 20).padding(.top, 25)
                    Divider()  // Adds a divider between them  (outside the HStack so it is horizontal)
                }
                Spacer()  // Moves it to the top 

            VStack(alignment: .center, spacing: 5){
                Image("Avala_logo")  // Avalanche Logo in side Menu
                    .resizable()
                    .aspectRatio(contentMode: .fit) 
                    .frame(width: 50, height: 50)                            
                    .foregroundColor(Color.white)
                
                Text("Emergency Notifier\nMade by Avalanche Tech") // Text Field for the App title
                    .padding(.bottom, 20)
                    .opacity(0.8)
                    .multilineTextAlignment(.center)                            
                    .foregroundColor(Color.white)

                
            } .padding(.leading, 25)
            } .padding(.vertical, 50)
        }
        
    }
    
}

    // Actual Side Menu

struct SideMenu: View
{
    // Properties
    let width: CGFloat
    let menuOpened: Bool
    let toggleMenu: () -> Void

    @Environment (\.colorScheme) var colorScheme // Checks its mode (dark / light)
    
    // Body
    var body: some View
    {
        ZStack 
        {
            // Dimmed Background
            
            GeometryReader{ _ in  // fills the rest of the screen with a geometric shape
                EmptyView()  // makes it an empty view
            }   
                .background(colorScheme == .dark ? Color.black.opacity(0.95) : Color.gray.opacity(0.90))  // sets its background to black if its in dark mode and gray if it isnt
                .opacity(self.menuOpened ? 1 : 0)  // makes it invisible when the menu is not closed (bool ? (when true):(when false) )
                .animation(Animation.easeIn(duration:0.3).delay(0.2), value: menuOpened)  // Animation
                .onTapGesture { self.toggleMenu() }  // makes the menu close when pressed on
            
            // Menu Content
            HStack{
                MenuContents()
                    .frame(width: width)  // sets its frame
                    .offset(x: menuOpened ? 0 : -width) // makes it only take up a certain amount of the screen (/1.5)
                    .ignoresSafeArea()   // ignores safe area (such as notch etc.)
                    .animation(.default, value: menuOpened)  // makes it have the default animation
                	
                Spacer()  // spacer to ensure that they are moved to the top
                
            }
        }
    }
}

// Settings Page

struct SettingsPage: View{

    // Properties


    // Body
    var body: some View{

        Text("Hello")

    }



}


// Main page

struct HomePage: View
{

    @State var on_call: Bool  // requests an on call variable
    @State var menuOpened = false 
    var branch: String = "Al Ain"  // edit out = "Al Ain" when database is created 
    let recentNews = [ 
    News(news: "Add a way to fetch news from the database", date: "20/12/2021"),
    News(news: "News 2", date: "06/12/2021")
    ]  // make it requested ( set up database code (make it a computable variable ))
    

    // Body
    var body: some View{

    ZStack{
    if !menuOpened{ // Only shows the view Components when the menu is not opened
    
    VStack(alignment: .center, spacing: 100){                           // VStack - Big Vstack for the entire page
        HStack(alignment: .center, spacing: 15.0){                                            // Top HStack - Top horizontal stack for menu and title
                
            Button{ self.menuOpened.toggle() } // Creates a button that toggles the side menu
                label:{
                            Image(systemName: "list.bullet")  // Makes the button an image
                                .resizable() 
                                .frame(width: 20, height: 20)
                                .scaledToFit()
                        }
                    
            Text("Home") // Page title
                            .font(.largeTitle)
                            .multilineTextAlignment(.center)
                
            Spacer()    // adds space to the right 

    }   // Close top Hstack (for title and menu button)

                                .padding(.leading, 40)
                                .padding(.top, 60)
        Divider().offset(y:-80)

        HStack{ // Adds a horizontal Stack for the On call toggle      
                        Spacer()
                
                        Toggle("On Call", isOn: $on_call)  // makes the oncall toggle
                            .padding(.horizontal, 100.0)
                            .font(.title2)
                
                        Spacer()  // spacer used

                    }
                    .offset(y:-120)

            
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
        if menuOpened{
            SideMenu(width: UIScreen.main.bounds.width/1.5, menuOpened: menuOpened, toggleMenu: toggleMenu)
        }
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
