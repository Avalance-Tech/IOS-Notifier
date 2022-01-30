//
//  Account.swift
//  EmergencyNotifier
//
//  Created by Adnan Odimah on 18/01/2022.
//

import SwiftUI

struct Account: View {
    @Binding var loggedIn: Employee
    
    @StateObject var vm = VM_DB()
    
    @State var currentPassword = ""
    @State var newPassword = ""
    @State var newPassword2 = ""
    
    @State var AlertContent = ""
    
    @State var showPop = false
    
    var check: Bool {
        if newPassword == "" || newPassword2 == "" || currentPassword == ""{
            return false
        }
        return true
    }
    
    var body: some View {
       
        VStack(spacing: 20){
        
            NavigationLink{
                
            }
        label: {
            
            Image(systemName: "person.circle.fill").resizable().frame(width: 100, height: 100, alignment: .center).padding()
            
            }
            
            HStack{
            Text(loggedIn.name)
            Image(systemName: "pencil")
            }
                
            
            Button {
                showPop = true
            } label: {
                Text("Change Password").underline()
            }.padding()

            

            
            Button {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                loggedIn = notLoggedIn
                }
            } label: {
                Text("Log Out").underline()
            }.padding()
        }.popover(isPresented: $showPop) {
            changePassword
        }
        
        
    }
}

extension Account{
    
    var changePassword: some View{
        VStack(spacing: 15){
            
            Text(AlertContent)
            
            HStack{
                

                
                SecureField("Current", text: $currentPassword)
                    .padding(.all, 15)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                
            }
            
            HStack{
                
                SecureField("New Password", text: $newPassword)
                    .padding(.all, 15)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
            }
            HStack{
                
                SecureField("Re-Enter New Password", text: $newPassword2)
                    .padding(.all, 15)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                
            }
            
            HStack{
                Button {
                    
                    if currentPassword != loggedIn.password{
                        
                        AlertContent = "Incorrect Password"
                        
                    }
                    else if newPassword != newPassword2{
                        
                        AlertContent = "The Passwords you have entered do not match"
                        
                    }
                    else{
                        
                        self.loggedIn.password = newPassword
                        vm.updateEmployee(employee: loggedIn)
                        AlertContent = "Password Changed"
                        
                        
                        
                        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) {_ in
                            showPop = false
                        }
                    
                    }
                    
                    
                    
                } label: {
                    Text("Change Password")
                        .padding(.all, 10)
                        .background(check ? Color.blue : Color.gray)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                }.disabled(check ? false : true)
            }
            
        }
        .padding(.all, 15)
        
    }
    
}
