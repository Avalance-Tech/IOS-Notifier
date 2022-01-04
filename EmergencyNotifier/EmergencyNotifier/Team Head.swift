//
//  Main Page.swift
//  Emergency Notifier
//
//  Created by Adnan Odimah on 02/01/2022.
//

import SwiftUI

// FOR TEAM HEAD





// Home page for team head

struct Home_TeamHead: View{
    
    
    
    var body: some View{
        
        VStack{
            TopMenu
            
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
                Text("Assign Team Head")
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
        
            
            Spacer()
            Spacer()
            BottomMenu
        }
    }
}


// MAIN PAGE


struct MainPage_TeamHead: View {
    // Properties
    
    @State var menuOpened = false
    
    
    // body
    
    var body: some View {
        ZStack{
                
                
                NavigationView{
                    
                    Home_TeamHead().navigationTitle("Home")
                    
                } // close navi
                
            
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
