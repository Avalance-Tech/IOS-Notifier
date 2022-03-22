//
//  Main Page Firefighter.swift
//  Emergency Notifier
//
//  Created by Ayman Omarsaalah on 02/01/2022.
//

import SwiftUI

struct Main_FireFighter: View {
    
    @StateObject var vm = VM_DB()
    
    @Binding var loggedin: Employee
    @State var status = false
    
    var body: some View {
        
        VStack(spacing: 25 ){
            
            TopMenu(loggedin: $loggedin, vm: vm)
            
            Spacer()
            
            onCall(status: $status)
            
            // Recent Emergencies
            recentEmergencies
            
            Spacer()
            Spacer()
            
            BottomMenu
            
        }.onChange(of: status) { __ in
            loggedin.status = status
            vm.updateEmployee(employee: loggedin)
        }
        .onAppear(perform: {status = loggedin.status})
    }
}


extension Main_FireFighter{
    
    var reportEmergency: some View{
        
        NavigationLink(destination: {
            
            Create_Emergency(vm: vm)
            
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
            
            Recent_Emergencies(loggedin: $loggedin, vm: vm)
            
        },label: {
            Text("Previous emergencies")
                .underline()
                .padding(.vertical, 15)
                .padding(.horizontal, 10)
                .font(.system(size: 20, design: .rounded))
            
        })

    }
    
}