//
//  Main Page Firefighter.swift
//  Emergency Notifier
//
//  Created by Ayman Omarsaalah on 02/01/2022.
//

import SwiftUI

struct Main_FireFighter: View {
    
    @Binding var loggedin: Employee
    
    var body: some View {
        
        VStack(spacing: 25 ){
            
            TopMenu(loggedin: $loggedin)
            
            Spacer()
            
            onCall(loggedin: $loggedin)
            
            // Recent Emergencies
            recentEmergencies
            
            Spacer()
            Spacer()
            
            BottomMenu
            
        }
    }
}



extension Main_FireFighter{
    
    var reportEmergency: some View{
        
        NavigationLink(destination: {
            
            Create_Emergency()
            
        }, label: {
            Text("Report an emergency")
                .underline()
                .padding(.vertical, 15)
                .padding(.horizontal, 10)
                .foregroundColor(Color.blue)
                .font(.system(size: 20, design: .rounded))
            
        })
        
    }
    
    
    var recentEmergencies: some View{
        
        NavigationLink(destination:{
            
            Recent_Emergencies()
            
        },label: {
            Text("Previous emergencies")
                .underline()
                .padding(.vertical, 15)
                .padding(.horizontal, 10)
                .font(.system(size: 20, design: .rounded))
            
        })

    }
    
}
