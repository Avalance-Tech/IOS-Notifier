//
//  EmergencyNotifierApp.swift
//  EmergencyNotifier
//
//  Created by Adnan Odimah on 04/01/2022.
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
struct EmergencyNotifierApp: App {
    var body: some Scene {
        WindowGroup {
            
            Main_OperationalManager()
        
        }
    }
}
