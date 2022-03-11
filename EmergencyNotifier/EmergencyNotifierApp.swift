//
//  EmergencyNotifierApp.swift
//  EmergencyNotifier
//
//  Created by Adnan Odimah on 04/01/2022.
//

import SwiftUI
import Firebase

@main
struct EmergencyNotifierApp: App {
    
    init(){ FirebaseApp.configure() }
    
    @State public var loggedin = notLoggedIn
    @StateObject public var VM = VM_DB()
    
    var body: some Scene{
            
            WindowGroup{
                NavigationView{
                
                switch loggedin.employeeType{
                case "Operational Manager":
                    Main_OperationalManager(vm: VM, loggedin: $loggedin).navigationBarHidden(true)
                    
                case "Team Head":
                    Main_TeamHead(vm: VM, loggedin: $loggedin).navigationBarHidden(true)
                    
                case "Deputy Team Head", "Supervisor":
                    Main_Supervisor(VM: VM, loggedin: $loggedin).navigationBarHidden(true)
                     
                case "Assistant Supervisor", "Fire Fighter", "Coordinator":
                    Main_FireFighter(loggedin: $loggedin).navigationBarHidden(true)
                    
                default:
                    Main_LogIn(loggedin: $loggedin).navigationBarHidden(true)
                }
                
                }
            }
    }
}


