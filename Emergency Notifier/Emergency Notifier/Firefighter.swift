//
//  Main Page Firefighter.swift
//  Emergency Notifier
//
//  Created by Ayman Omarsaalah on 02/01/2022.
//

import SwiftUI

struct Home_Firefighter: View {
    
    @State var menuOpened: Bool
    let toggleMenu: () -> Void
    @State var onCall = false
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 25 ){
            
            Toggle(isOn: $onCall) {
                Text("On Call").background(onCall ? Color.green : Color.red).padding(.top, 50)
                
                
            } .padding(.top, 50)
            
            
            // Create Emergency button
            Button( action: {
                
                print("Hhello")
                
            }, label:{
                Text("Report an emergency")
                    .underline()
                    .padding(.vertical, 15)
                    .padding(.horizontal, 10)
                    .foregroundColor(Color.blue)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                
            })
            
            
            // Recent Emergencies
            
            Button(action:{
                print("test")
            },label: {
                Text("Previous emergencies")
                    .underline()
                    .padding(.vertical, 15)
                    .padding(.horizontal, 10)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                
            })
            
            
            // Settings
            
            Button(action: {
                self.toggleMenu()
                self.menuOpened.toggle()
                
            },label: {
                Image(systemName: "list.bullet")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .padding(.vertical, 15)
                    .padding(.horizontal, 10)
                
            })
            
            Spacer()
            Spacer()
        }
        
    }
}

struct Main_Page_Firefighter: View {
    @State var menuOpened = false
    
    
    // body
    
    var body: some View {
        ZStack{
            
        if !menuOpened{
        
        
        NavigationView{
            
            Home_Firefighter(menuOpened:self.menuOpened, toggleMenu: self.toggleMenu ).navigationTitle("Home")
        
        } // close navi

            } // Close if
            
    
        
            SideMenu(employee: adnan, currentPage: "Home", width: UIScreen.main.bounds.width/1.5, menuOpened: self.menuOpened, toggleMenu: self.toggleMenu)
    
        } // close zstack
    } // close body
    
    
    
    // Methods
    
    func toggleMenu() -> Void{
        self.menuOpened.toggle()
    }
}


struct Main_Page_Firefighter_Previews: PreviewProvider {
    static var previews: some View {
        Main_Page_Firefighter()
    }
}
