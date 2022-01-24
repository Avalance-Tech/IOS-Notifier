//
//  Supervisor.swift
//  EmergencyNotifier
//
//  Created by Adnan Odimah on 09/01/2022.
//

import SwiftUI

struct Main_Supervisor: View{
    
    @Binding var loggedin: Employee
    @State var showPopOver = true
    
    var body: some View{
        VStack{
            
            TopMenu(loggedin: $loggedin)
            
            Spacer()
            
            onCall(loggedin: $loggedin)
            
            // Create account Button
            accountsLink
            
            // Assign Acting Team Head button
            assignActing
            
            
            // Recent Emergencies
            recentEmergencies
            
            
            Spacer()
            
            BottomMenu
        }
    }
}







//MARK: Content
extension Main_Supervisor{
    
    var recentEmergencies: some View{
        
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
    
    }
    
    
    var assignActing: some View{
        
        Button( action: {

            self.showPopOver = true
            
        }, label:{
            Text("Assign Supervisor")
                .underline()
                .padding(.vertical, 15)
                .padding(.horizontal, 10)
                .foregroundColor(Color.blue)
                .font(.system(size: 20, design: .rounded))
        }).popover(isPresented: $showPopOver) {
            actingPopOver
        }
        
    }
    
    
    
    var actingPopOver: some View{
        
        VStack{
            Text("Test")
        }
        
    }
    
    
    var accountsLink: some View{
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
    
}
