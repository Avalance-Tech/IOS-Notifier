//
//  Operational Manager.swift.swift
//  Emergency Notifier
//
//  Created by Adnan Odimah on 02/01/2022.
//

import SwiftUI




struct Main_OperationalManager: View{
    
    @Binding var loggedin: Employee
    
    @State var showingAssignPopUp = false
    @State var reason = ""
    	
    var body: some View{
        
        VStack{
            
            TopMenu(loggedin: $loggedin)
            
            
            Spacer()
            
            
            onCall(loggedin: $loggedin)
            
            
            // Create Emergency button
            
            createEmergency

            
            
            // Create account Button

            createAccount
            
            
            
            // Assign Acting Team Head button

            assignActing
            
            
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





// MARK: Content

extension Main_OperationalManager{
    
    
    var createEmergency: some View{
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
    }
    
    
    var createAccount: some View{
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
    }
    
    
    var assignActing: some View{
        
        Button(action: {
            
            showingAssignPopUp = true
            
        }, label:{
            Text("Assign Operational Manager")
                .underline()
                .padding(.vertical, 15)
                .padding(.horizontal, 10)
                .foregroundColor(Color.blue)
                .font(.system(size: 20, design: .rounded))
        }).popover(isPresented: $showingAssignPopUp) {
                // add a selection from a list of team heads
            
                actingPopOver
            
        }
        
    }
    
    
    var actingPopOver: some View{
        Text("oof")
    }
    
    
    
    
}
