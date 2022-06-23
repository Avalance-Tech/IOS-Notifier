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
    
    @StateObject var vm = dataViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
            switch vm.account.employeeType{
       /*         case "Operational Manager":
                    
                case "Team Head":
                    
                case "Deputy Team Head", "Supervisor":
         */
                case "Assistant Supervisor", "Fire Fighter", "Coordinator":
                    Main_FireFighter(vm: vm).navigationBarHidden(true)
                default:
                    login_page(vm: vm).body.navigationBarHidden(true)
                }
                
                }.environmentObject(vm)
        }
    }
}
