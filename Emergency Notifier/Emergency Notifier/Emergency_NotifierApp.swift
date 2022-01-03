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
        
            Main_Page_Firefighter()
            
        }
    }
}
