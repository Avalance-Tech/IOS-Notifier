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
    
    @State var loggedin = notLoggedIn
    
    var body: some Scene{
            
            WindowGroup{
                NavigationView{
                
                switch loggedin.employeeType{
                case "Operational Manager":
                    Main_OperationalManager(loggedin: $loggedin).navigationBarHidden(true)
                    
                case "Team Head":
                    Main_TeamHead(loggedin: $loggedin).navigationBarHidden(true)
                    
                case "Deputy Team Head":
                    Main_Supervisor(loggedin: $loggedin).navigationBarHidden(true)
                    
                case "Supervisor":
                    Main_Supervisor(loggedin: $loggedin).navigationBarHidden(true)
                    
                case "Assistant Supervisor":
                    Main_FireFighter(loggedin: $loggedin).navigationBarHidden(true)
                    
                case "Fire Fighter":
                    Main_FireFighter(loggedin: $loggedin).navigationBarHidden(true)
                    
                case "Coordinator":
                    Main_FireFighter(loggedin: $loggedin).navigationBarHidden(true)
                    
                default:
                    Main_LogIn(loggedin: $loggedin).navigationBarHidden(true)
                }
                
                }
            }
    }
}


