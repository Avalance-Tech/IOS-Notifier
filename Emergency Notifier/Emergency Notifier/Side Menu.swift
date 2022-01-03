//
//  Side Menu.swift
//  Emergency Notifier
//
//  Created by Adnan Odimah on 01/01/2022.
//

import SwiftUI




struct MenuContents: View{
    
    let currentPage: String
    let employee: Employee
    
    var items: [MenuItem] = [// Creates a list for the items in the side menu
        MenuItem(text: "Home"),
        MenuItem(text: "Settings"),
        MenuItem(text: "Help / Support")
    ]

    // Body
    var body: some View{
        ZStack{
            Color(UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)) // Color of the side Menu #Grey
            VStack(alignment: .leading, spacing: 30) {
                
                Text("Logged in as \(employee.name)")
                    .underline()
                    .padding(.all,-20)
                    .offset(x: 35, y: 20)
                    .foregroundColor(Color.white.opacity(0.8))
                
                
                
                ForEach(items) {item in   // Loops through the items in the list
                    HStack{
                        
                        Button {
                            
                            print("switch to \(item.text)")
                            
                        } label: {
                            Text(item.text)   // Creates a Text field for the item
                                .font(.system(size:22))
                                .bold()
                                .multilineTextAlignment(.leading)
                                .foregroundColor(Color.white)
                                .opacity(0.9)
                                .disabled(item.text == self.currentPage ? true : false)
                                
                        }


                        
                        
                    }.padding(.leading, 20).padding(.top, 25)
                    Divider().foregroundColor(.green)
                        .font(.system(size: 20, weight: .bold))// Adds a divider between them  (outside the HStack so it is horizontal)
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
    let employee: Employee
    let currentPage: String
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
                MenuContents(currentPage: currentPage, employee: employee)
                    .frame(width: width)  // sets its frame
                    .offset(x: menuOpened ? 0 : -width) // makes it only take up a certain amount of the screen (/1.5)
                    .ignoresSafeArea()   // ignores safe area (such as notch etc.)
                    .animation(.default, value: menuOpened)  // makes it have the default animation
                    
                Spacer()  // spacer to ensure that they are moved to the top
                    
            }
        }
    }
}

struct sidemenu_Previews: PreviewProvider {
    
    static var previews: some View {
    
        SideMenu(employee: adnan, currentPage: "Home", width: UIScreen.main.bounds.width/1.5, menuOpened: true) {
            print("test")
        }
    
    }
}
