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
    
    @AppStorage("ID") var currentUserID: Int?
    @AppStorage("Password") var currentUserPassword: String?

    @StateObject var vm = dataViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
            switch vm.account.employeeType{
       /*       case "Operational Manager":
             */
                case "Team Head":
                    TeamHead().navigationBarHidden(true)
           /*     case "Deputy Team Head", "Supervisor":
         */
                case "Assistant Supervisor", "Fire Fighter", "Coordinator":
                    FireFighter().navigationBarHidden(true)

                default:
                    login_page().navigationBarHidden(true)

                }
                
                }
            .environmentObject(vm)
        }
    }
}
