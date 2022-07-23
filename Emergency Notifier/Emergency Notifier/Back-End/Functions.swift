// import hashing

import Foundation
import Firebase
import UIKit

func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}

func branchInitials(branch: String) -> String {
    
    /* returns the initials of a branch*/
    
    switch branch {
        
    case "Ras Al Khaimah":
        return "RAK"
        
    case "Umm Al-Quwain":
        return "UAQ"
        
    case "Sharjah":
        return "SHJ"
        
    case "Ajman":
        return "AJM"
        
    case "Fujairah":
        return "FUJ"
        
    case "Abu Dhabi":
        return "AD"
        
    case "Dubai":
        return "DXB"
        
    case "All":
        return "N/A"
        
    default:
        return "Error"
        
    }
}

func typeInitial(type: String) -> String {
    
    /* returns the initials of a typeInitial */
    
    switch type{
    case "Acting Team Head":
        return "A.T.H."
        
    case "Acting Supervisor":
        return "A.S."
    
    case "Acting Operational Manager":
        return "A.O.M."
        
    case "Team Head":
        return "T.H."
        
    case "Fire Fighter":
        return "F.F."
        
    case "Supervisor":
        return "S.V."
        
    case "Operational Manager":
        return "O.M."
        
    case "Deputy Team Head":
        return "D.T.H"
        
    case "Assistant Supervisor":
        return "A.S."
        
    case "Coordinator":
        return "C.O."
        
    default:
        return "Error"
    }
}

extension dataViewModel { // Functions used for Model View ViewModel
    
    func getData(){  // Fetches data from the database
        if self.account.id == -1{
        if !self.autologin(){
            self.account.employeeType = "not logged in"
        }}
        self.getEmployees()
        self.getEmergencies()
    }
    
    func filterEmployees() -> [Employee]{  // Ensures the user only sees the right employees
        
        switch account.employeeType{
            
        case "Fire Fighter":
            return []
            
        case "Supervisor", "Acting Supervisor", "Deputy Team Head":
            return self.allEmployees.filter({
                ($0.branch == account.branch && ["Team Head", "Supervisor", "Assistant Supervisor", "Fire Fighter", "Acting Supervisor", "Acting Team Head"].contains($0.employeeType)) && $0.id != self.account.id
            })
            
        case "Team Head", "Acting Team Head":
            return self.allEmployees.filter({
                ($0.branch == self.account.branch || $0.employeeType == "Operational Manager" || $0.employeeType == "Acting Operational Manager") && $0.id != self.account.id
            })
            
        case "Operational Manager", "Acting Operational Manager":
            return self.allEmployees.filter({ $0.id != self.account.id })
            
        default:
            return []
            
        }
    }
    
    
    func getEmployees(){
        var empList: [Employee] = []
        
        db.collection("Employees").getDocuments { snapshot, error in
            if error != nil{
                print("Error occurred: \(String(describing: error))")
                return
            }
            if let snap = snapshot{
                for emp in snap.documents{
                    
                    let employee = Employee(
                        id: emp["Employee ID"] as! Int ,
                        password: emp["Password"] as! String,
                        name: emp["Name"] as! String,
                        status: emp["Status"] as! Bool,
                        branch: emp["Branch"] as! String,
                        employeeType: emp["Type"] as! String,
                        docID: emp.documentID)
                    
                    empList.append(employee)
                }
                self.allEmployees = empList
            }
        }
        
    }
    
    func getEmergencies(){
        var emergencyList: [Emergency] = []
        
        db.collection("Emergencies").getDocuments { snapshot, error in
            
            if error != nil{ print("error occured \(String(describing: error))"); return}
            
            if let snapshot = snapshot{
                for emergencyDoc in snapshot.documents{
                    
                    let title = emergencyDoc["Title"] as? String ?? ""
                    let details = emergencyDoc["Details"] as? String ?? ""
                    
                    let location = emergencyDoc["Location"] as? GeoPoint ?? GeoPoint(latitude: 0, longitude: 0)
                    let meetingPoint = emergencyDoc["Meeting Point"] as? GeoPoint ?? GeoPoint(latitude: 0, longitude: 0)
                    
                    let employeesCalled = emergencyDoc["Employees Called"] as? [Employee.ID] ?? []
                    let declined = emergencyDoc["Declined"] as? [Employee.ID] ?? []
                    let accepted = emergencyDoc["Accepted"] as? [Employee.ID] ?? []
                    
                    let arrived = emergencyDoc["Arrived"] as? [Employee.ID] ?? []
                    
                    let branch = emergencyDoc["Branch"] as? String ?? ""
                    
                    let urgency = emergencyDoc["Urgency"] as? Int ?? 0
                    
                    let timestamp = emergencyDoc["Time"] as? Timestamp ?? Timestamp(date: Date())
                    let time = timestamp.dateValue()
                    
                    //let imageURLs = emergencyDoc["Image URL"] as? [String] ?? [] FIXME:
                    
                    let casualties = emergencyDoc["Casualties"] as? Int ?? 0
                    let injuries = emergencyDoc["Injuries"] as? Int ?? 0
                    
                    let active = emergencyDoc["Active"] as? Bool ?? false
                    
                    let answered = Array(Set(accepted + declined + arrived))
                    
                    
                    var repliedDict: Dictionary<Employee, (String, Date)>{ // Checks to see who has replied
                        var replies: [Employee: (String, Date)] = [:]
                        for employeeID in employeesCalled{
                            
                            if let employee = self.allEmployees.first(where: {$0.id == employeeID}){
                                
                                if !(answered.contains(where: {$0 == employee.id})){
                                    
                                    replies[employee] = ("No Reply", Date())
                                    
                                }
                                
                                else if (declined.contains(where: {$0 == employee.id})){
                                    
                                    replies[employee] = ("Declined", Date())
                                    
                                }
                                
                                else if (accepted.contains(where: {$0 == employee.id})){
                                    
                                    replies[employee] = ("Accepted", Date())
                                    
                                }
                            }
                        }
                        return replies
                        
                    }
                    
                    var arrivedList: [Employee] {
                        var list: [Employee] = []
                        for employeeID in arrived{
                            if let emp = self.allEmployees.first(where: {$0.id == employeeID }){
                                list.append(emp)
                            }
                        }
                        return list
                    }
                    
                    let emergency = Emergency(
                        id: emergencyDoc.documentID,
                        title: title,
                        details: details,
                        branch: branch,
                        injuries: injuries,
                        casualties: casualties,
                        location: location,
                        meetingPoint: meetingPoint,
                        urgency: urgency,
                        time: time,
                        replies: repliedDict,
                        arrived: arrivedList,
                        active: active)
                    
                    emergencyList.append(emergency)
                }
                
                self.allEmergencies = emergencyList
            }
        }}
    
    
    
    func addEmployee(name: String, id: Int, branch: String, employeeType: String){
        
        
        db.collection("Employees").addDocument(data: ["Employee ID": id,  "Name": name, "Branch": branch, "Type": employeeType, "Password": "password", "Status": false]) { error in
            if error != nil{
                print(error as Any)
            }
        }
        
    }
    
    func updateEmployee(employee: Employee){
        
        let updated = db.collection("Employees").document(employee.docID ?? "")
        
        updated.getDocument { (document, err) in
            
            if let err = err {
                print(err)
            }
            else {
                document?.reference.updateData(["Employee ID": employee.id,  "Name": employee.name, "Branch": employee.branch, "Type": employee.employeeType, "Password": employee.password, "Status": employee.status])
            }
            
        }
        
    }
    
    func addEmergency(title: String, details: String, called: [Employee], time: Date, urgency: Int, location: GeoPoint, meetingPoint: GeoPoint, injuries: Int, casualties: Int, branch: String){
        
        var calledID: [Int]{
            var ids: [Int] = []
            for emp in called{
                ids.append(emp.id)
            }
            return ids
        }
        
        db.collection("Emergencies").addDocument(data: [
            "Title": title,
            "Details": details,
            
            "Location": location,
            "Meeting Point": meetingPoint,
            
            "Time": time,
            "Urgency": urgency,
            
            "Employees Called": calledID,
            "Accepted": [],
            "Arrived": [],
            "Declined": [],
            
            "Branch": branch,
            
            // "Image URL": [], FIXME:
            "Injuries": injuries,
            "Casualties": casualties,
            "Active": true
        ]) { error in
            if error != nil{
                print(error as Any)
            }
        }
    }
    
    func updateEmergency(emergency: Emergency){
        if emergency.id == ""{
            print("error, documentID not found")
            return
        }
        let updated = db.collection("Emergencies").document(emergency.id ?? "")
        
        updated.getDocument { (document, err) in
            
            if let err = err {
                print(err)
            }
            else{
                
                
                document?.reference.updateData([

                    "Title": emergency.title,
                    "Details": emergency.details,
                    
                    "Location": emergency.location,
                    "Meeting Point": emergency.meetingPoint,
                    
                    "Accepted": Array((emergency.replies.filter({ $0.value.0 == "Accepted"})).keys.map{ $0.id }),
                    "Arrived": emergency.arrived,
                    "Declined": Array((emergency.replies.filter({ $0.value.0 == "Declined"})).keys.map{ $0.id }),
                    
                    "Employees Called": Array( emergency.replies.keys.map({ Employee in
                        Employee.id
                    }) ),
                    
                    "Urgency": emergency.urgency,
                    
                    "Injuries": emergency.injuries,
                    "Casualties": emergency.casualties,
                    
                    "Active": emergency.active,
                    
                    //  "Image URL": emergency.imageURLs FIXME:
                    
                ])
                { error in
                    if error != nil{
                        print(error as Any)
                    }
                }
            }
        }
    }
    
    
    func deleteEmployee(employee: Employee){
        db.collection("Employees").document(employee.docID ?? "").delete(){
            err in
            if let err = err {
                print("Error removing document \(err)")
            } else{
                self.allEmployees.removeAll { Employee in
                    Employee == employee
                }
            }
        }
    }
    
    func deleteEmergency(emergency: Emergency){
        db.collection("Emergency").document(emergency.id ?? "").delete(){
            err in
            if let err = err {
                print("Error removing document \(err)")
            }
            else{
                self.allEmergencies.removeAll { Emergency in
                    Emergency == emergency
                }
            }
        }
    }
    
    func doFilter(list: Array<Employee>, filters: Array<filterModel>, employee: Employee) -> [Employee]{
        
        var filteredList: [Employee] = []
        
        for filter in filters{
            var filterArray: [Employee] = []
            switch filter.type{
                
            case "Branch":
                filterArray.append(contentsOf: list.filter({ Employee in
                    Employee.branch == filter.filterRules
                }))
                
            case "Employee Type":
                filterArray.append(contentsOf: list.filter({ Employee in
                    Employee.employeeType == filter.filterRules
                }))
                
            case "Status":
                
                switch filter.filterRules{
                    
                case "Available":
                    filterArray.append(contentsOf: list.filter({ Employee in
                        Employee.status == true
                    }))
                    
                default:
                    filterArray.append(contentsOf: list.filter({ Employee in
                        Employee.status == false
                    }))
                    
                }
            default:
                break
                
            }
            filteredList.append(contentsOf: filterArray)
        }
        
        if filters.isEmpty{
            filteredList = list
        }
        
        return Array(Set(filteredList))
        
    }
    
    
    func doSort(list: Array<Employee>, Asc: Bool, sort: String) -> [Employee]{
        
        var returnedList: [Employee] = []
        
        switch sort{
        case "Name":
            returnedList = list.sorted(by: Asc ? {$0.name > $1.name} : {$0.name < $1.name})
            
        case "Id":
            returnedList = list.sorted(by: Asc ? {$0.id > $1.id} : {$0.id < $1.id})
            
        case "Status":
            returnedList = list.sorted(by: Asc ? {user1, user2 in
                return user1.status
            } : {user1, user2 in
                return !user1.status
            })
            
        case "Branch":
            returnedList = list.sorted(by: Asc ? { $0.branch > $1.branch } : {$0.branch < $1.branch})
            
        case "Role":
            returnedList = list.sorted(by: Asc ? { $0.employeeType > $1.employeeType } : {$0.employeeType < $1.employeeType })
            
        default:
            return list
        }
        
        return returnedList
        
    }
    
    func logout(){
        currentUserID = nil
        currentUserPassword = nil
        
        self.account = Employee(id: -1, password: "", name: "", status: false, branch: "", employeeType: "not logged in", docID: "not logged in")
        loggingIn = false
        
    }
    
    func autologin() -> Bool{
        
        if self.currentUserPassword != "" && self.currentUserPassword != nil{
            db.collection("Employees").whereField("Employee ID", isEqualTo: self.currentUserID!)
                .getDocuments { snapshot, error in
                    if error != nil{
                        print("Error with autologin \(String(describing: error))")
                    }
                    else {
                        if let snapshot = snapshot{
                            let emp = snapshot.documents[0]
                            
                            let eID = emp["Employee ID"] as? Int ?? -1
                            let password = emp["Password"] as? String ?? ""
                            let name = emp["Name"] as? String ?? ""
                            let status = emp["Status"] as? Bool ?? false
                            let branch = emp["Branch"] as? String ?? ""
                            let employeeType = emp["Type"] as? String ?? ""
                            
                            let employee = Employee(id: eID, password: password, name: name, status: status, branch: branch, employeeType: employeeType, docID: emp.documentID)
                            
                            self.account = employee
                            self.loggingIn = true
                            self.failed = false
                        }
                    }
                }
            return true
        }
        return false
    }
    
    func login(ID: Int, Password: String) -> Employee{
        
        let employee = self.allEmployees.filter({ Employee in
            Employee.id == ID && Employee.password == Password })
        
        if employee == []{
            failed = true
            loggingIn = false
            return Employee(id: -1, password: "", name: "", status: false, branch: "", employeeType: "", docID: "not logged in")
        }
        
        loggingIn = true
        failed = false
        
        self.currentUserID = ID
        self.currentUserPassword = Password
        
        
        return employee[0]
        
    }
    
}
