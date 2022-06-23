// import hashing

import Foundation
import Firebase


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
        
    default:
        return "Error"
        
    }
}

func typeInitial(type: String) -> String {
    
    /* returns the initials of a typeInitial */
    
    switch type{
        
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
        do{
            try self.getEmployees()
            try self.getEmergencies()
        } catch {
            print(error)
        }
        
    }
    
    func filterEmployees(){  // Ensures the user only sees the right employees
        // TODO:
    }
    
    
    func getEmployees() throws {
        var employeeList: [Employee] = []
        db.collection("Employees").getDocuments { snapshot, error in
            if error != nil{
                
                print("Error fetching data | \(String(describing: error))")
                
            }
            if let snapshot = snapshot{
                DispatchQueue.main.async{
                    for emp in snapshot.documents{
                        
                        let eID = emp["Employee ID"] as? Int ?? -1
                        let password = emp["Password"] as? String ?? ""
                        let name = emp["Name"] as? String ?? ""
                        let status = emp["Status"] as? Bool ?? false
                        let branch = emp["Branch"] as? String ?? ""
                        let employeeType = emp["Type"] as? String ?? ""
                        
                        let employee = Employee(id: eID, password: password, name: name, status: status, branch: branch, employeeType: employeeType, docID: emp.documentID)
                        
                        employeeList.append(employee)
                        
                    }
                    
                    self.allEmployees = employeeList
                }
            }
        }
    }
    
    func getEmergencies() throws {
        var emergencyList: [Emergency] = []
        db.collection("Emergencies").getDocuments { snapshot, error in
            if error != nil {
                
                print("Error fetching data \(String(describing: error))")
                
            }
            if let snapshot = snapshot {
                DispatchQueue.main.async{ [self] in
                    
                    for emergencyDoc in snapshot.documents{ // loops through the documents and creates an emergencyDoc instance for it
                        
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
                        //imageURLs: imageURLs,  FIXME:
                        
                        emergencyList.append(emergency)
                        
                    }
                    
                    self.allEmergencies = emergencyList
                }
            }
        }
    }
    
    
    func addEmployee(name: String, id: Int, branch: String, employeeType: String){
        
        
        db.collection("Employees").addDocument(data: ["Employee ID": id,  "Name": name, "Branch": branch, "Type": employeeType, "Password": "password", "Status": false]) { error in
            if error == nil{
                
                self.getData()
                
            }
            else{
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
                self.getData()
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
            "Titles": title,
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
            if error == nil{
                
                self.getData()
                
            }
            else{
                print(error as Any)
            }
        }
    }
    
    func updateEmergency(emergency: Emergency){
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
                    
                    "Urgency": emergency.urgency,
                    
                    "Injuries": emergency.injuries,
                    "Casualties": emergency.casualties,
                    
                    "Active": emergency.active,
                    
                    //  "Image URL": emergency.imageURLs FIXME:
                    
                ])
                { error in
                    if error == nil{
                        
                        self.getData()
                        
                    }
                    else{
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
            }
            else{
                self.getData()
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
                self.getData()
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
                returnedList = list.sorted(by: Asc ? {$0.branch > $1.branch} : {$0.branch < $1.branch})

            case "Role":
                returnedList = list.sorted(by: Asc ? {$0.employeeType > $1.employeeType} : {$0.employeeType < $1.employeeType})
            
            default:
                return list
            }
        
        return returnedList

    }

    func login(ID: Int, Password: String) -> Bool{
        guard let employee = self.allEmployees.filter({ employee in
            employee.id == ID && employee.password = Password
        })else{
            return false, true
        }

        self.account = employee
        return true, false
    }

}
