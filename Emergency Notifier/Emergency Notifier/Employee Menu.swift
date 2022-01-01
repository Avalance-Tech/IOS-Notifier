//
//  Employee Menu.swift
//  Emergency Notifier
//
//  Created by Adnan Odimah on 01/01/2022.
//

import SwiftUI





// Main page

struct HomePage: View
{
     
    @State var employee: Employee
    
    
   /* init(employee: Employee, status: Bool){
        self.employee = employee
        self.status = employee.status
    }*/

    
    public var status: Bool{
        return employee.status
    }
    
    @State var menuOpened = false
    
  //  let recentNews: Array<News> // Get requested news from self.branch.news

    // make it requested ( set up database code (make it a computable variable ))
    

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
                
        /*    Toggle("On Call", isOn: Binding<status>)  // makes the oncall toggle
                            .padding(.horizontal, 100.0)
                            .font(.title2)
                            .background(self.employee.status ? Color.green.opacity(0.2): Color.red.opacity(0.2))
                */
                        Spacer()  // spacer used to center on call toggle

                    }
                    .offset(y:-120)

            
      /*  VStack(spacing: 10){  // VStack - Bottom / recent news section
                
            
            
            
            
             
            
            
            
            
  /*
            
            Text("Recent News from " + "Branch Here" /*branch*/ )
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

               */
                    
                    
                    
                    
                    
                    
                    
                    
                        }                                          // Close HStack - for each news article

        }  // closes for loop

                    }
                    .offset(y: -160)                                              // Close VStack - news section    */
         
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
