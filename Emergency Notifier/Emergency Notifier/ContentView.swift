//
//  ContentView.swift
//  Emergency Notifier
//
//  Created by Adnan Odimah on 18/12/2021.
//

import SwiftUI


// Utility Structures (for our use)

protocol branch{
    
}

struct MenuItem: Identifiable{
    var id = UUID()
    let text: String
}

struct News: Identifiable{
    var id = UUID()
    let news: String
    let date: String
}

struct Employee{
    let name: String
    
    var number: String
    var status: Bool
    var branch: Branch
    var employeeType: String
    
    init(name: String, number: String, status: Bool, branch: Branch, employeeType: String){
        self.name = name
        self.number = number
        self.status = status
        self.branch = branch
        self.employeeType = employeeType
    }
    
    mutating func togglestatus(){ self.status.toggle() }
    
    func retname() -> String{
        return self.name
    }
    func retnumber() -> String{
        self.number
    }
    func retstatus() -> Bool{
        return self.status
    }
    func retbranch() -> Branch{
        self.branch
    }
}

struct Branch{
    var employees: Array<Employee>
    let name: String
    var news: Array<News>
    
}

struct Emergency{
    let details: String
    let location: String
    let urgency: Int // 1 - 5 scale
    let time : String
    
    
}

// Not Done

struct NotDone: View{

    
    var body: some View{
        ZStack{
    
            Text("Coming Soon")
    
        }
    }
}



// Leaders View

struct LeaderMain: View{
    
// Properties
    
    //static var employee: Employee = Employee(name: "adnan", number: "07405074600", status: false, branch: "al ain", employeeType: "employee")
    
    let name: String = "adnan" //employee.name
    var number: String = "012905" //employee.number
    var branch: String = "al ain"   //employee.branch.name
     
    @State var on_call: Bool = false // employee.status  // requests an on call variable
    
    @State var menuOpened: Bool = false
    
// Leader Properties
    
    @State var emergencyDetails = " "
    @State var emergencyLocation = " "
    
    
    
// Body
    var body: some View{
        ZStack{
        
            
            VStack{ // VStack for the page's actual aspects
                
                
            HStack(alignment: .center){
                
                // Top HStack - Top horizontal stack for menu and title
                    
                Button{ self.menuOpened.toggle() } // Creates a button that toggles the side menu
                    label:{
                                Image(systemName: "list.bullet")  // Makes the button an image
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .scaledToFit()
                    }.padding(.horizontal, 20)

                Text("Page Title")
                    .padding(.horizontal,10)
                    .font(.largeTitle)
                        
                        Spacer()
                
            }.padding(.vertical, 50)
                    .padding(.leading, 35)
            
                
                
                VStack{ // Emergency information fields
                    
                    HStack(spacing: 10){
                        Text("Emergency Details")
                        
                 //       TextField(<#T##titleKey: LocalizedStringKey##LocalizedStringKey#>, text: <#T##Binding<String>#>, prompt: <#T##Text?#>)
                        
                        }
                    
                    
                    
                }
            
        
                
                
                
            Spacer()
                
            } // Close Vstack for page's aspects
    
        
        } // Close Zstack
 
    
    }// cloes Body
    
// Methods
    
    
} // Close Leader Main




















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
                .animation(.easeInOut(duration:0.3).delay(0.2), value: menuOpened)  // Animation
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
    static var employee: Employee = Employee(name: "adnan", number: "07405074600", status: false, branch: Branch(employees: [], name: <#T##String#>, news: <#T##Array<News>#>), employeeType: "employee")
    
    let name: String = "adnan" //employee.name
    var number: String = "012905" //employee.number
    var branch: String = "al ain"   //employee.branch.name
     
    @State var on_call: Bool = false // employee.status  // requests an on call variable
    
    
    @State var menuOpened = false

    
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
                            .background(on_call ? Color.green.opacity(0.2): Color.red.opacity(0.2))
                
                        Spacer()  // spacer used to center on call toggle

                    }
                    .offset(y:-120)

            
        VStack(spacing: 10){  // VStack - Bottom / recent news section
                
            Text("Recent News from " + branch)
                            .font(.title).underline()
                        
            ForEach(recentNews){item in  // loops through the recent news list 
                HStack(alignment: .center){  // Hstack - for each news article in the following format (*news - *date)
                    
                            Text(String(item.news))  // *news
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 10.0)
                                .font(.system(size: 10))
                                .onTapGesture {}     // make it exapnd to a pop up when tapped
                            
                            Spacer()      
                            
                            Text(String(item.date))  // *date
                                .font(.system(size: 10))
                                .multilineTextAlignment(.trailing)

                        }                                          // Close HStack - for each news article

        }  // closes for loop

                    }
                    .offset(y: -160)                                              // Close VStack - news section
         
                        Spacer()  //moves it up from the buttom
                    
                               .edgesIgnoringSafeArea(.all)
                            }         // Closes VStack for the entire page

        }                                                          // Close IF statement for menu opened
        
    // if u add an if statement the animation no longer works
            SideMenu(width: UIScreen.main.bounds.width/1.5, menuOpened: menuOpened, toggleMenu: toggleMenu)
        }                                                          // Closes all the ZStack 
    }                                                              // Close Body
    
    // Methods
    
    func toggleMenu(){menuOpened.toggle()} // makes toggleMenu a singular method (for sideMenu)

    
    
}                                                                       //Close home page Struct



/*

PREVIEW

    OPTIONS:
- HomePage
- SideMenu
- SettingsPage

*/


/*
 
 
 Branches available:
 1) um al quwain
 2) sharjah
 3) ajman
 4) ras al khaimah
 5) fujairah
 
 
 */


struct ContentView_Previews: PreviewProvider {
    static var employeetype = "employee"
    
    
    
    static var previews: some View {
        if String(self.employeetype).lowercased() == "leader"{
            
            LeaderMain()
            
        }
        else if String(self.employeetype).lowercased() == "employee"{
            
        HomePage() // previews the home page
            
        }
    }
}

