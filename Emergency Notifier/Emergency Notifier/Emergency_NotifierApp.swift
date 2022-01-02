//
//  Emergency_NotifierApp.swift
//  Emergency Notifier
//
//  Created by Adnan Odimah on 18/12/2021.
//

import SwiftUI

@main
struct Emergency_NotifierApp: App {
    static var employeetype = adnan.employeeType
    
    var body: some Scene {
        WindowGroup {
            if String(Emergency_NotifierApp.employeetype).lowercased() == "leader"{
                
                LeaderMain(employee: adnan)
                
            }
            else if String(Emergency_NotifierApp.employeetype).lowercased() == "employee"{
                
                HomePage(employee: adnan) // previews the home page
                
            }
            else if String(Emergency_NotifierApp.employeetype).lowercased() == "admin"{
                
                Admin_Menu()
                // Admin Page
                
            }
            else if String(Emergency_NotifierApp.employeetype) == "team head"{
                MainPage_TeamHead()
            }

             else{
                
                NotDone()
                //login page

            }
        }
    }
}
