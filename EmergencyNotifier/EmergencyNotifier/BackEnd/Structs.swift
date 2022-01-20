import SwiftUI
import Firebase

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
    }  else if branch == "Umm Al-Quwain"{
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






let notLoggedIn = Employee(id: 0, name: "", number: "", status: false, branch: "", employeeType: "")





/*
 
 REQUESTS
 
 for each emergency have 3 lists ( 1 for amount of people called ) (1 for amount of people who have responded) (1 for amount of people who have arrived)
 direct chain of command goes 1 up and 1 down
 
 
 
 
 
 
 */





class VM_DB: ObservableObject{
    @Published var allEmployees = [Employee]()
    @Published var allEmergencies = [Emergency]()
    
    
    
    @Published var typeS = true
    @Published var search = ""
    @Published var sort = "Status"
    @Published var filters = [String]()
    
    var shownEmployees: [Employee]{
            var emp: [Employee] = []
            
            emp = doSort(list: allEmployees,  sort: sort, type: typeS)
            
            
            if search != ""{
                return emp.filter({$0.name.lowercased().contains(search.lowercased() )})
            }
            
            return emp
        }
    
    let db = Firestore.firestore()
    
    func getData(){
        
        var newList = [Employee]()
        
        db.collection("Employees").getDocuments { snapshot, error in
            
            if error == nil {
                if let snapshot = snapshot{
                    DispatchQueue.main.async {
                        
                        for doc in snapshot.documents{
                            
                            let eID = doc["E ID"] as? Int ?? 0
                            let pwd = doc["Password"] as? String ?? ""
                            let name = doc["Name"] as? String ?? ""
                            let num = doc["Number"] as? String ?? ""
                            let sts = doc["Status"] as? Bool ?? false
                            let brc = doc["Branch"] as? String ?? ""
                            let etype = doc["Type"] as? String ?? ""
                            
                            newList.append(Employee(id: eID, password: pwd, name: name, number: num, status: sts, branch: brc, employeeType: etype, docID: doc.documentID))
                            
                            self.allEmployees = newList
                            
                            
                        }
    
                    }
                    
                }
                
            }else{
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
    
    
    func addEmergency(){
        
    }
    
    
      
    func doSort(list: Array<Employee>, sort: String, type: Bool) -> [Employee]{
        
        // if type true then desc else asc
        
        var newList: [Employee] = []
        
        if sort == "Name"{
            if type{
                newList = list.sorted(by: {$0.name < $1.name})
            }
            else{
                newList = list.sorted(by: {$0.name > $1.name})
            }
            
        }else if sort == "Id"{
            if type{
                newList = list.sorted(by: {$0.id < $1.id})
            }
            else{
                newList = list.sorted(by: {$0.id > $1.id})
            }
        }else if sort == "Status"{
            if type{
                newList = list.sorted(by: { user1, user2 in
                    return user1.status
                })
            }
            else{
                newList = list.sorted(by: {user1, user2 in
                    return !user1.status
                })
            }
        }else if sort == "Branch"{
            if type{
                newList = list.sorted(by: {  $0.branch < $1.branch  })
            }
            else{
                newList = list.sorted(by: { $0.branch > $1.branch
                })
            }
        }else if sort == "Role"{
            if type{
                newList = list.sorted(by: {  $0.employeeType < $1.employeeType  })
            }
            else{
                newList = list.sorted(by: { $0.employeeType > $1.employeeType
                })
            }
        }
        
        
        return newList}
    
    
    
    
    init(){
        
        getData()
        
    }
    
}







struct Employee: Identifiable, Equatable{
    
    let id: Int
    
    var password: String = "password"  // Encrypt later
    
    
    var name: String
    var number: String  // Used for login
    var status: Bool
    
    var branch: String
    
    var employeeType: String
    
    var docID: String?
    
    static func == (lhs: Employee, rhs: Employee) -> Bool{
        
        return lhs.id == rhs.id
        
    }
}





struct Emergency: Identifiable{  // to be logged later
    
    var id = UUID()
    var details: String
    var location: String
    var meetingPoint: String
    var urgency: Int // 1 - 5 scale
    let time : String
    var employeesCalled: Array<Employee>
    var branch: String // = Employee.branch
    
    var replied: Dictionary<Bool, Array<Employee>> = [:]
    var checkedIn: Dictionary<UIImage, Employee> = [:]
    var images: Dictionary<UIImage, Employee> = [:]
    
}


