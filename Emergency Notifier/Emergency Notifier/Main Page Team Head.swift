//
//  Main Page.swift
//  Emergency Notifier
//
//  Created by Adnan Odimah on 02/01/2022.
//

import SwiftUI

// FOR TEAM HEAD


struct Home_TeamHead: View{
    
    @State var menuOpened: Bool
    let toggleMenu: () -> Void
    
    var body: some View{
        
        VStack{
            
            
            Spacer()
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
            
            // Create account Button
        Button( action: {
            
        print("Hhello")
    
        }, label:{
        Text("Create/edit/delete an account")
        
            .underline()
            .padding(.vertical, 15)
            .padding(.horizontal, 10)
            .foregroundColor(Color.blue)
            .font(.system(size: 20, weight: .bold, design: .rounded))
        
    })
            
            // Assign Acting Team Head button
        Button( action: {
            
            print("Hhello")
        }, label:{
            Text("Assign Team Head")
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



struct MainPage_TeamHead: View {
    // Properties
    
    @State var menuOpened = false
    
    
    // body
    
    var body: some View {
        ZStack{
            
        if !menuOpened{
        
        
        NavigationView{
            
            Home_TeamHead(menuOpened:self.menuOpened, toggleMenu: self.toggleMenu ).navigationTitle("Home")
        
        } // close navi

            } // vlodr if
            
    
        
    SideMenu(width: UIScreen.main.bounds.width/1.5, menuOpened: self.menuOpened, toggleMenu: self.toggleMenu)
    
        } // close zstack
    } // close body
    
    
    
    // Methods
    
    func toggleMenu() -> Void{
        self.menuOpened.toggle()
    }
    
    }




struct Main_Page_Previews: PreviewProvider {
    static var previews: some View {
        MainPage_TeamHead()
    }
}
