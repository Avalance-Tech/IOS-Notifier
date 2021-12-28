//
//  ContentView.swift
//  Emergency Notifier
//
//  Created by Adnan Odimah on 18/12/2021.
//

struct MenuItem: Identifiable{
    var id = UUID()
    let text: String
}

struct News{
    let news: String
    let date: Date
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
                        
                    }.padding(.leading, 20).padding(.top, 25)
                    Divider()
                }
                Spacer()

            VStack(alignment: .center, spacing: 5){
                Image("Avala_logo").resizable().aspectRatio(contentMode: .fit).frame(width: 50, height: 50)
                Text("Emergency Notifier\nMade by Avalanche Tech").padding(.bottom, 20).opacity(0.8).multilineTextAlignment(.center)
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
    
    
    // Body
    var body: some View
    {
        ZStack
        {
            // Dimmed Background
            
            GeometryReader{ _ in
                EmptyView()
            }   .background(Color.gray.opacity(0.15))
                .opacity(self.menuOpened ? 1 : 0)
                .onTapGesture { self.toggleMenu() }
            
            // Menu Content
            HStack{
                MenuContents()
                    .frame(width: width)
                    .offset(x: menuOpened ? 0 : -width)
                    .ignoresSafeArea()
                	
                Spacer()
                
            }
        }.animation(Animation.easeIn(duration: 2).delay(0.4), value: true)
    }
}



struct HomePage: View
{

    @State var on_call: Bool
    @State var menuOpened = false
    var branch: String = "Al Ain"
    let recentNews = [
    News(news: "Add a way to fetch news from the database", date: 2021-05-12),
    News(news: "News 2", date: 06/12/2021)
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
                
        HStack(alignment: .bottom, spacing: 100.0)
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
                
                        Spacer()
                    
                    }                                            // Close top Hstack
            
                                .padding(.leading, 40)
                                .padding(.top, 60)

                        Spacer()

        HStack
                    {
                        Spacer()
                
                        Toggle("On Call", isOn: $on_call)
                            .padding(.horizontal, 100.0)
                            .font(.title3)
                
                        Spacer()
                    }
            
                        Spacer()
            
        VStack
                    {                                              // VStack - Bottom recent news tab
                
            Text("Recent News from " + branch)
                                .font(.title2)
                
        ForEach(recentNews){item in
                        
                    
            HStack
                        {                                          // Hstack - for news
                        Spacer()
                    
                // add for statement which fetches recent news
                    
                            Text(String(item.news))
                                .frame(width: 150, height: 50)
                    
                            Text(String(item.date))
                    
                        Spacer()
                        }                                          // Close HStack - for news
        }
                    }                                              // Close VStack - news
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
