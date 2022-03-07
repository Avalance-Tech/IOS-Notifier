//
//  Supervisor.swift
//  EmergencyNotifier
//
//  Created by Adnan Odimah on 09/01/2022.
//

import SwiftUI

struct Main_Supervisor: View{
    
    @StateObject var vm = VM_DB()
    
    @Binding var loggedin: Employee
    @State var status = false
    @State var showPopOver = true
    
    var body: some View{
        VStack{
            
            TopMenu(loggedin: $loggedin)
            
            Spacer()
            
            onCall(status: $status)
            
            // Create account Button
            accountsLink
            
            // Assign Acting Team Head button
            if loggedin.employeeType == "Supervisor"{
            assignActing
            }
            
            // Recent Emergencies
            recentEmergencies
            
            
            Spacer()
            
            BottomMenu
            
        }.onChange(of: status) { __ in
            loggedin.status = status
            vm.updateEmployee(employee: loggedin)
        }
        .onAppear(perform: {status = loggedin.status})
    }
    
}







//MARK: Content
extension Main_Supervisor{
    
    var recentEmergencies: some View{
        
        NavigationLink{
            
            Recent_Emergencies(loggedin: $loggedin)
            
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
