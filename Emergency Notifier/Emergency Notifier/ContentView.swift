//
//  ContentView.swift
//  Emergency Notifier
//
//  Created by Adnan Odimah on 18/12/2021.
//

import SwiftUI

// Utility Structures (for our use)

// Dummy branch with admins and have that ignored when calling emergency



/// WITH DATABSE

/*
 
 1st step) Create the 5 Branches ( With one dummy ) - 6 total
 2nd step) Create an Admin in the dummy branch

 3rd step) On the creation of an employee; require branch, add to branch
 4th step) On the creation of an Emergency; add to branch, require array<employee>,  require branch
 - Create News with Emegrency.details, emergency.Branch, emergency.time
 
 On the creation of news;
 add to self.branch
 
 
 */
var sharjah = Branch(employees: [], name: "Sharjah", emergencies: [])
var ajman = Branch(employees: [], name: "Ajman", emergencies: [])
var fujairah = Branch(employees: [], name: "Fujairah", emergencies: [])
var rak = Branch(employees: [], name: "Ras Al-Khaimah", emergencies: [])
var uaq = Branch(employees: [], name: "Umm Al Quwain", emergencies: [])

let adnan : Employee = Employee(name: "adnan", number: "07405074600", status: false, branch: branches[1], employeeType: "team head")

let branches : [Branch] = [
    sharjah, ajman, fujairah, rak, uaq
]


struct MenuItem: Identifiable{
    var id = UUID()
    let text: String
}

struct Employee: Identifiable{
    let id = UUID()
    
    var password: String = "password"  // Encrypt later
    
    
    let name: String
    var number: String  // Used for login
    var status: Bool

    var branch: Branch
    
    var employeeType: String
    
    
}

struct Branch{
    let id = UUID()
    
    var employees: Array<Employee>
    let name: String
    var emergencies: Array<Emergency>
    
    
}

struct Emergency: Identifiable{  // to be logged later

    var id = UUID()
    var details: String
    var location: String
    var urgency: Int // 1 - 5 scale
    let time : String
    var employeesCalled: Array<Employee>
    var branch: Branch // = Employee.branch
    
}


// Not Done

struct NotDone: View{

    
    var body: some View{
        ZStack{
    
            Text("Coming Soon")
    
        }
    }
}


/*

PREVIEW

    OPTIONS:
- HomePage
- SideMenu
- SettingsPage

*/


/*
 
 
 Branches available:
 1) um al quwain
 2) sharjah
 3) ajman
 4) ras al khaimah
 5) fujairah
 
 
 */



