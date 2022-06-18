import hashing


func branchInitials(branch: String) -> String {

	/* returns the initials of a branch*/

	switch branch {

	case "Ras Al Khaimah":
		return "RAK"

    case "Umm Al-Quwain":
        return "UAQ"

    case: "Sharjah":
        return "SHJ"

    case: "Ajman":
        return "AJM"

    case: "Fujairah":
        return "FUJ"

    case: "Abu Dhabi":
        return "AD"

    case: "Dubai":
        return "DXB"

	default:
		return "Error"

	}
}

func typeInitial(type: String) -> {

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

    case "Coordinator"::
        return "C.O."
    
    default:
        return "Error"
	}
}

extension dataViewModel // Functions used for Model View ViewModel
{
    func getData(){
        self.getEmployees()
        self.getEmergencies()
    }
    
    
    func getEmployees(){
        var newList = [Employee]()
        db.collection("Employees").getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot{
                    
                    for doc in snapshot.documents{
                        
                        let eID = doc["E ID"] as? Int ?? 0
                        let pwd = doc["Password"] as? String ?? ""
                        let name = doc["Name"] as? String ?? ""
                        let sts = doc["Status"] as? Bool ?? false
                        let brc = doc["Branch"] as? String ?? ""
                        let etype = doc["Type"] as? String ?? ""
                        
                        newList.append(Employee(id: eID, password: pwd, name: name, number: num, status: sts, branch: brc, employeeType: etype, docID: doc.documentID))
                        
                        
                        
                        
                    }
                    
                    self.allEmployees = newList
                    
                }
                
            }else{
                // error handle
            }
        }
    }
    
    
    func getEmergencies(){
        var newList = [Emergency]()
        db.collection("Emergencies").getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot{
                    DispatchQueue.main.async {
                        
                        for doc in snapshot.documents{
                            let details = doc["Details"] as? String ?? ""
                            let location = doc["Location"] as? GeoPoint ?? GeoPoint(latitude: 0, longitude: 0)
                            let meetingPoint = doc["Meeting Point"] as? GeoPoint ?? GeoPoint(latitude: 0, longitude: 0)
                            let calledID = doc["Employees Called"] as? [Int] ?? []
                            let declined = doc["Rejected"] as? [Employee.ID] ?? []
                            let accepted = doc["Accepted"] as? [Employee.ID] ?? []
                            let arrived = doc["Arrived"] as? [Employee.ID] ?? []
                            let branch = doc["Branch"] as? String ?? ""
                            let urgency = doc["Urgency"] as? Int ?? 0
                            let timestamp = doc["Time"] as? Timestamp ?? Timestamp()
                            let time = timestamp.dateValue()
                            let imageURLs = doc["Image URL"] as? [String] ?? []
                            let casualties = doc["Casualties"] as? Int ?? 0
                            let injuries = doc["Injuries"] as? Int ?? 0
                            let active = doc["Active"] as? Bool ?? false
                            
                            let repliedDict: Dictionary<Bool, [Employee.ID]> = [false: declined, true: accepted]
                            
                            var called: [Employee]{
                                var list: [Employee] = []
                                for id in calledID{
                                    for employee in self.allEmployees{
                                        if employee.id == id{
                                            list.append(employee)
                                        }
                                    }
                                }
                                return list
                            }
                            
                            newList.append(Emergency(id: doc.documentID, details: details, location: location, meetingPoint: meetingPoint, urgency: urgency, time: time, employeesCalled: called, branch: branch, active: active, replied: repliedDict, arrived: arrived, imageURLs: imageURLs, injuries: injuries, casualties: casualties))
                        }
                        
                        self.allEmergencies = newList
                    }
                }
                
            }
            
            else{
                // error handle
            }
        }
    }
    
    
    func addEmployee(name: String, id: Int, number: String?, branch: String, employeeType: String){
        
        
        db.collection("Employees").addDocument(data: ["E ID": id,  "Name": name, "Number": number == nil ? "" : number!, "Branch": branch, "Type": employeeType, "Password": "password", "Status": false]) { error in
            if error == nil{
                
                self.getData()
                
            }
            else{
                //
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
                document?.reference.updateData(["E ID": employee.id,  "Name": employee.name, "Number": employee.number, "Branch": employee.branch, "Type": employee.employeeType, "Password": employee.password, "Status": employee.status])
                self.getData()
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
                    "Details": emergency.details,
                    "Location": emergency.location,
                    "Meeting Point": emergency.meetingPoint,
                    "Urgency": emergency.urgency,
                    //       "Accepted": emergency.replied[true],
                    //    "Arrived": emergency.arrived,
                    "Injuries": emergency.injuries,
                    "Casualties": emergency.casualties,
                    "Active": emergency.active
                ])
                self.getData()
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
    
    
    func addEmergency(details: String, called: [Employee], time: Date, urgency: Int, location: GeoPoint, meetingPoint: GeoPoint, injuries: Int, casualties: Int){
        
        var calledID: [Int]{
            var x: [Int] = []
            for emp in called{
                x.append(emp.id)
            }
            return x
        }
        
        db.collection("Emergencies").addDocument(data: [
            "Details": details,
            "Employees Called": calledID,
            "Time": time,
            "Location": location,
            "Meeting Point": meetingPoint,
            "Urgency": urgency,
            "Accepted": [],
            "Arrived": [],
            "Image URL": [],
            "Injuries": injuries,
            "Casualties": casualties,
            "Active": true
        ]) { error in
            if error == nil{
                
                self.getData()
                
            }
            else{
                //
            }
        }
        
        
        
        
        
    }
    
    
    
    func doSortFilter(list: Array<Employee>, sort: String, type: Bool, filters: [filterModel]/*, emp: Employee*/) -> [Employee]{
        
        // if type true then desc else asc
        
        var BranchEmps: [Employee] = []
        var EmpTypes: [Employee] = []
        var EmpStatus: [Employee] = []
        
        var newList: [Employee] = []
        
        if !filters.isEmpty{
            
            for fil in filters{
                switch fil.type{
                    
                case "Branch":
                    
                    BranchEmps.append(contentsOf: list.filter({ Employee in
                        Employee.branch == fil.filter
                    }))
                    
                    
                    
                case "Employee Type":
                    
                    EmpTypes.append(contentsOf: list.filter({ Employee in
                        Employee.employeeType == fil.filter
                    }))
                    
                    
                    
                case "Status":
                    switch fil.filter{
                        
                    case "Available":
                        
                        EmpStatus.append(contentsOf: list.filter({Employee in
                            Employee.status == true
                        }))
                        
                    default:
                        
                        EmpStatus.append(contentsOf: list.filter({Employee in
                            Employee.status == false
                        }))
                        
                    }
                    
                default: break
                    
                }
                
            }
        }
        
        if EmpTypes.isEmpty{
            EmpTypes = list
        }
        
        if EmpStatus.isEmpty{
            EmpStatus = list
        }
        if BranchEmps.isEmpty{
            BranchEmps = list
        }
        
        newList = BranchEmps.filter({ Employee in
            EmpStatus.contains(Employee) && EmpTypes.contains(Employee)
        })
        
        if filters.isEmpty{
            newList = list
        }
        
        if sort == "Name"{
            if type{
                newList = newList.sorted(by: {$0.name < $1.name})
            }
            else{
                
                newList = newList.sorted(by: {$0.name > $1.name})
            }
            
        }else if sort == "Id"{
            if type{
                newList = newList.sorted(by: {$0.id < $1.id})
            }
            else{
                newList = newList.sorted(by: {$0.id > $1.id})
            }
        }else if sort == "Status"{
            if type{
                newList = newList.sorted(by: { user1, user2 in
                    return user1.status
                })
            }
            else{
                newList = newList.sorted(by: {user1, user2 in
                    return !user1.status
                })
            }
        }else if sort == "Branch"{
            if type{
                newList = newList.sorted(by: {  $0.branch < $1.branch  })
            }
            else{
                newList = newList.sorted(by: { $0.branch > $1.branch
                })
            }
        }else if sort == "Role"{
            if type{
                newList = newList.sorted(by: {  $0.employeeType < $1.employeeType  })
            }
            else{
                newList = newList.sorted(by: { $0.employeeType > $1.employeeType
                })
            }
        }
        
        
        return newList}
    
}