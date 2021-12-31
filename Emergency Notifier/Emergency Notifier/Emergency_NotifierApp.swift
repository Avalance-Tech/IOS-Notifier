//
//  Emergency_NotifierApp.swift
//  Emergency Notifier
//
//  Created by Adnan Odimah on 18/12/2021.
//

import SwiftUI

@main
struct Emergency_NotifierApp: App {
    static var employeetype = "employee"
    
    var body: some Scene {
        WindowGroup {
            if String(Emergency_NotifierApp.employeetype).lowercased() == "leader"{
                
                LeaderMain()
                
            }
            else if String(Emergency_NotifierApp.employeetype).lowercased() == "employee"{
                
                HomePage() // previews the home page
                
            }
            else if String(Emergency_NotifierApp.employeetype).lowercased() == "admin"{
                
                NotDone()
                // Admin Page
                
            }

             else{
                
                NotDone()
                //login page

            }
        }
    }
}
