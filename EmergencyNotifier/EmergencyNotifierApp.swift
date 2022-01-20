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
    
    
    var body: some Scene{
        withAnimation{
        WindowGroup{
                
            if loggedin.employeeType == "Operational Manager"{
                withAnimation{
                    
                    MainPage_OperationalManager(loggedin: $loggedin).animation(Animation.easeIn(duration: 1), value: loggedin)
                        .transition(.opacity)
                }
                }else if loggedin.employeeType == "Team Head"{
                    
                    MainPage_TeamHead(loggedin: $loggedin).animation(Animation.easeIn(duration: 1), value: loggedin)
                        .transition(.opacity)
                    
                }else if loggedin.employeeType == "Fire Fighter" || loggedin.employeeType == "Coordinator"{
                    
                    MainPage_FireFighter(loggedin: $loggedin).animation(Animation.easeIn(duration: 1), value: loggedin)
                        .transition(.opacity)

                }else if loggedin.employeeType == "Supervisor"{

                    withAnimation{
                    MainPage_Supervisor(loggedin: $loggedin).animation(Animation.easeIn(duration: 1), value: loggedin)
                        .transition(.opacity)
                    }}
                    
                    

            else{
              LogIn_Main(loggedin: $loggedin).animation(Animation.easeIn(duration: 1), value: loggedin)
                    .transition(.opacity)
            }
            
            
        }}
    }
}
	
