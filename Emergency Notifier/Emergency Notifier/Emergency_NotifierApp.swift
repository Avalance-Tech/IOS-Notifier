//
//  Emergency_NotifierApp.swift
//  Emergency Notifier
//
//  Created by Adnan Odimah on 15/06/2022.
//

import SwiftUI
import Firebase


@main
struct Emergency_NotifierApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            Create_Emergency()
        }
    }
}
