//
//  Operational Manager.swift.swift
//  Emergency Notifier
//
//  Created by Adnan Odimah on 02/01/2022.
//

import SwiftUI

struct Home_OperationalManager: View{
    @State var menuOpened: Bool
    let toggleMenu: () -> Void
    
    var body: some View{
        
        VStack{
            
            
            Spacer()
            // Create Emergency button
            
            NavigationLink {
                
                Create_Emergency()
                
                }label:{
                Text("Report an emergency")
                    .underline()
                    .padding(.vertical, 15)
                    .padding(.horizontal, 10)
                    .foregroundColor(Color.blue)
                    .font(.system(size: 20, design: .rounded))
                }
            
            
            // Create account Button
        Button( action: {
            
        print("Hhello")
    
        }, label:{
        Text("Create/edit/delete an account")
        
            .underline()
            .padding(.vertical, 15)
            .padding(.horizontal, 10)
            .foregroundColor(Color.blue)
            .font(.system(size: 20, design: .rounded))
        
    })
            
            // Assign Acting Team Head button
        Button( action: {
            
            print("Hhello")
            
        }, label:{
            Text("Assign Operational Manager")
                .underline()
                .padding(.vertical, 15)
                .padding(.horizontal, 10)
                .foregroundColor(Color.blue)
                .font(.system(size: 20, design: .rounded))
        })
 
            
            // Recent Emergencies
            
            Button(action:{
                
                print("test")
                
            },label: {
                Text("Previous emergencies")
                    .underline()
                    .padding(.vertical, 15)
                    .padding(.horizontal, 10)
                    .font(.system(size: 20, design: .rounded))

            })

            
            // Side Menu
            
        Button(action: {
            self.toggleMenu()
            self.menuOpened.toggle()
            
        },label: {
            Image(systemName: "list.bullet")
                .font(.system(size: 30, design: .rounded))
                .padding(.vertical, 15)
                .padding(.horizontal, 10)
            
        })
            
            Spacer()
            Spacer()
        }
    }
}



struct Main_OperationalManager: View {
    @State var menuOpened: Bool = false

    var body: some View {
    
        ZStack{
            if !menuOpened{
                
                NavigationView{
                    
                    Home_OperationalManager(menuOpened: self.menuOpened, toggleMenu: self.toggleMenu).navigationTitle("Home")
                    
                }
                
                
            }
            
            SideMenu(width: UIScreen.main.bounds.width/1.5, menuOpened: self.menuOpened, toggleMenu: self.toggleMenu)
            
        }
    
    }
    
    
    func toggleMenu(){
        
        self.menuOpened.toggle()
    
    }
}

struct Operational_Manager_swift_Previews: PreviewProvider {
    static var previews: some View {
        Main_OperationalManager()
    }
}
