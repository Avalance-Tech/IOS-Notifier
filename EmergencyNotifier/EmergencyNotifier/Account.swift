//
//  Account.swift
//  EmergencyNotifier
//
//  Created by Adnan Odimah on 18/01/2022.
//

import SwiftUI

struct Account: View {
    @Binding var loggedIn: Employee
    
    
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
        }
        
        
    }
}

