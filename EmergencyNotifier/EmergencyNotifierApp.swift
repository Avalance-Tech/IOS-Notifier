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
    
    init(){
        FirebaseApp.configure()
    }
    
    @State var loggedin = notLoggedIn
    
    var test: some View{
        
        print(" test updated ")
        if loggedin.employeeType == "Operational Manager"{
            
            return AnyView(MainPage_OperationalManager(loggedin: $loggedin)).animation(Animation.easeInOut(duration: 2), value: loggedin)
            
        }else if loggedin.employeeType == "Team Head"{
            
            return AnyView(MainPage_TeamHead(loggedin: $loggedin)).animation(Animation.easeInOut(duration: 2), value: loggedin)
            
        }else if loggedin.employeeType == "Fire Fighter" || loggedin.employeeType == "Coordinator"{
            
            return AnyView(MainPage_FireFighter(loggedin: $loggedin)).animation(Animation.easeInOut(duration: 2), value: loggedin)

        }else if loggedin.employeeType == "Supervisor"{

            return AnyView(MainPage_Supervisor(loggedin: $loggedin)).animation(Animation.easeInOut(duration: 2), value: loggedin)
            
            
        }

        return AnyView(LogIn_Main(loggedin: $loggedin)).animation(Animation.easeInOut(duration: 2), value: loggedin)
        
        
    }
    
    
    var body: some Scene{
        WindowGroup{
            
            test.animation(Animation.easeInOut(duration: 2), value: loggedin)
            
        }
    }
}
