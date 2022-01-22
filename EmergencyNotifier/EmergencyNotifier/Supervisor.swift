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
            
            onCall(loggedin: $loggedin)
            
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

