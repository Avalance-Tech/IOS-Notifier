//
//  Operational Manager.swift.swift
//  Emergency Notifier
//
//  Created by Adnan Odimah on 02/01/2022.
//

import SwiftUI




struct Main_OperationalManager: View{
    
    var vm: VM_DB
    
    @Binding var loggedin: Employee
    @State var status = false
    
    @State var showingAssignPopUp = false
    @State var reason = ""
    	
    var body: some View{
        
        VStack{
            
            TopMenu(loggedin: $loggedin)
            
            
            Spacer()
            
            
            onCall(status: $status)
            
            
            // Create Emergency button
            createEmergency

            
            // Create account Button
            createAccount
            
            
            // Assign Acting Team Head button
            assignActing
            
            
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
            
            MainAccountsMenu(vm: vm)
            
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

                actingPopOver
            
        }
        
    }
    
    
    var actingPopOver: some View{
        // add a selection from a list of team heads
        Text("oof")
        
    }
    
    
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
    
    
    
    
}
