//
//  Supervisor.swift
//  EmergencyNotifier
//
//  Created by Adnan Odimah on 09/01/2022.
//

import SwiftUI

struct Main_Supervisor: View{
    
    @Binding var loggedin: Employee
    
    var body: some View{
        
        VStack{
            TopMenu(loggedin: $loggedin)
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
            NavigationLink{
            
                MainAccountsMenu()
                
            }label:{
                Text("Create/edit/delete an account")
                
                    .underline()
                    .padding(.vertical, 15)
                    .padding(.horizontal, 10)
                    .foregroundColor(Color.blue)
                    .font(.system(size: 20, design: .rounded))
                
            }
            
            // Assign Acting Team Head button
            Button( action: {
                
                print("Hello")
                
            }, label:{
                Text("Assign Supervisor")
                    .underline()
                    .padding(.vertical, 15)
                    .padding(.horizontal, 10)
                    .foregroundColor(Color.blue)
                    .font(.system(size: 20, design: .rounded))
            })
            
            
            // Recent Emergencies
            
            NavigationLink{
                
                Recent_Emergencies()
                
            }label:{
                Text("Recent Emergencies")
                
                    .underline()
                    .padding(.vertical, 15)
                    .padding(.horizontal, 10)
                    .foregroundColor(Color.blue)
                    .font(.system(size: 20, design: .rounded))
                
            }
        
            
            Spacer()
            
            BottomMenu
        
        }
    }
}


// MAIN PAGE


struct MainPage_Supervisor: View {
    // Properties
    
    @Binding var loggedin: Employee
    
    
    // body
    
    var body: some View {
        ZStack{
                
                
                NavigationView{
                    
                    Main_Supervisor(loggedin: $loggedin).navigationTitle("Emergency Link")
                    
                } // close navi
                
            
        } // close zstack
    } // close body
    
    
    
    // Methods
    
}


/*

struct Main_Page_Previews: PreviewProvider {
    static var previews: some View {
        MainPage_Supervisor()
    }
}
*/
