import SwiftUI

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

func branchInitial(branch: String)  -> String{
    
    if branch == "Ras Al-Khaimah"{
        return "RAK"
    }  else if branch == "Umm Al Quwain"{
        return "UAQ"
    } else if branch == "Sharjah"{
        return "SHJ"
    } else if branch == "Ajman"{
        return "AJM"
    } else if branch == "Fujairah"{
        return "FUJ"
    }
    
    return "Error"
    
}

func typeInitial(emptype: String) -> String{
    
    if emptype == "Team Head"{
            return "T.H."
    }
    else if emptype == "Fire Fighter"{
        return "F.F."
    }
    else if emptype == "Supervisor"{
        return "S.V."
    }
    else if emptype == "Operational Manager"{
        return "O.M."
    }
    else if emptype == "Deputy Team Head"{
        return "D.T.H"
    }
    else if emptype == "Assistant Supervisor"{
        return "A.S."
    }
    else{
        return "Error"
    }
    
}


var sharjah = Branch(employees: [], name: "Sharjah", emergencies: [])
var ajman = Branch(employees: [], name: "Ajman", emergencies: [])
var fujairah = Branch(employees: [], name: "Fujairah", emergencies: [])
var rak = Branch(employees: [], name: "Ras Al-Khaimah", emergencies: [])
var uaq = Branch(employees: [], name: "Umm Al Quwain", emergencies: [])

var branches = [sharjah, ajman, fujairah, rak, uaq]


var loggedin = talal
var operationalManager = adnan
	



let adnan : Employee = Employee(employeeID: "9999", name: "adnan Odimah", number: "07405074600", status: false, branch: ajman, employeeType: "Operational Manager")

let ayman = Employee(employeeID:"102", name: "ayman", number: "0578432058", status: true, branch: ajman, employeeType: "Fire Fighter")

let talal = Employee(employeeID: "230", name:"talal", number: "07520752", status: false, branch: ajman, employeeType: "Team Head")

let wassim = Employee(employeeID: "302", name: "wassim", number: "08540853085", status: true, branch: ajman, employeeType: "Supervisor")



/*
 
 REQUESTS
 
    for each emergency have 3 lists ( 1 for amount of people called ) (1 for amount of people who have responded) (1 for amount of people who have arrived)
    direct chain of command goes 1 up and 1 down
 
    
 
 
 
 
 */







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


var deputyTeamHead: Employee {
    for employee in loggedin.branch.employees{
                if employee.employeeType == "Deputy Team Head"{
                        return employee

        }
    }
    return loggedin
}







struct Emergency: Identifiable{  // to be logged later

    var id = UUID()
    var details: String
    var location: String
    var meetingPoint: String
    var urgency: Int // 1 - 5 scale
    let time : String
    var employeesCalled: Array<Employee>
    var branch: Branch // = Employee.branch

    var replied: Dictionary<Bool, Array<Employee>>
    var checkedIn: Dictionary<UIImage, Employee>
    
}


