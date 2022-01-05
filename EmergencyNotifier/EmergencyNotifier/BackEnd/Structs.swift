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

var branches = [sharjah, ajman, fujairah, rak, uaq]








let adnan : Employee = Employee(employeeID: "9999", name: "adnan Odimah", number: "07405074600", status: false, branch: ajman, employeeType: "Operational Manager")

let ayman = Employee(employeeID:"102", name: "ayman", number: "0578432058", status: true, branch: rak, employeeType: "Fire Fighter")

let talal = Employee(employeeID: "230", name:"talal", number: "07520752", status: false, branch: uaq, employeeType: "Team Head")

let wassim = Employee(employeeID: "302", name: "wassim", number: "08540853085", status: true, branch: sharjah, employeeType: "Supervisor")











struct Employee: Identifiable{
    let id = UUID()
    
    let employeeID: String
    
    var password: String = "password"  // Encrypt later
    
    
    var name: String
    var number: String  // Used for login
    var status: Bool

    var branch: Branch
    
    var employeeType: String
}











struct Branch{
    let id = UUID()
    
    var employees: Array<Employee>
    var name: String
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
    
    var checkedIn: Dictionary<UIImage, Employee>
    
}


