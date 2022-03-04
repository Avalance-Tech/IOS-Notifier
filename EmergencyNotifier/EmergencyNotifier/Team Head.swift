//
//  Main Page.swift
//  Emergency Notifier
//
//  Created by Adnan Odimah on 02/01/2022.
//

import SwiftUI



// Home page for team head

struct Main_TeamHead: View{
    
    @StateObject var vm = VM_DB()
    
    @State var showingAssignPopUp = false
    @State var reason = ""
    
    @Binding var loggedin: Employee
    
    var body: some View{
        
        VStack{
            
            TopMenu(loggedin: $loggedin)
            
            Spacer()
            
            onCall(status: $loggedin.status)
            
            
            // Create Emergency button
            createEmergency
            
            
            
            // Create account Button
            accountsLink
            
            
            
            // Assign Acting Team Head button
            
            actingLink
            
            
            
            // Recent Emergencies
            
            recentsEmergency
            
            
            Spacer()
            Spacer()
            
            BottomMenu
        }.onChange(of: loggedin.status) { __ in
            vm.updateEmployee(employee: loggedin)
        }
    }
}







// MARK: Components

extension Main_TeamHead{
    
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
    
    
    
    var recentsEmergency: some View{
        NavigationLink{
            
            Recent_Emergencies(loggedin: $loggedin)
            
        } label: {
            Text("Previous emergencies")
                .underline()
                .padding(.vertical, 15)
                .padding(.horizontal, 10)
                .font(.system(size: 20, design: .rounded))
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
    
    
    
    var actingLink: some View{
        Button(action: {
            
            showingAssignPopUp = true
            
        }, label:{
            
            Text("Assign Team Head")
                .underline()
                .padding(.vertical, 15)
                .padding(.horizontal, 10)
                .foregroundColor(Color.blue)
                .font(.system(size: 20, design: .rounded))
            
        }).popover(isPresented: $showingAssignPopUp) {
            
            assignActingPopOver
            
        }
    }
    
    var assignActingPopOver: some View{
        
        VStack{
            Spacer()
            
            Text("Are you sure you would like to assign  as the Acting Team Head")
            TextField("Reason", text: $reason)
            HStack(spacing: 30){
                Button {
                    
                    // set acting team head
                    
                } label: {
                    Text("Yes")
                        .padding(.all, 8)
                        .foregroundColor(Color.red)
                        .border(Color.blue.opacity(0.8))
                }
                
                
                Button{
                    showingAssignPopUp = false
                }
            label: {
                Text("No")
                
                    .padding(.all, 8)
                    .foregroundColor(Color.green)
                    .border(Color.blue.opacity(0.8))
            }
            }
            Spacer()
        }
    }
    
}
