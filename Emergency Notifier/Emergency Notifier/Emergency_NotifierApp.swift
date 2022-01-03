//
//  Emergency_NotifierApp.swift
//  Emergency Notifier
//
//  Created by Adnan Odimah on 18/12/2021.
//

import SwiftUI

struct main_debug: View{
    var body: some View{
        VStack(spacing: 40){
        
            NavigationLink {
                Main_OperationalManager()
            } label: {
                Text("Operational Manager Main")
            }

            NavigationLink {
                MainPage_TeamHead()
            } label: {
                Text("Team Head Main")
            }

            NavigationLink {
                Main_Page_Firefighter()
            } label: {
                Text("Fire Fighter Main")
            }

            // NavigationLink(destination: <#T##() -> _#>, label: <#T##() -> _#>)
            
            
        }
    }
}

@main
struct Emergency_NotifierApp: App {
    
    var body: some Scene {
        WindowGroup {
        
            Main_OperationalManager()
            
        }
    }
}
