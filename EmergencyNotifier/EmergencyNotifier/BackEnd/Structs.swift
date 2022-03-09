import SwiftUI
import Firebase
import MapKit
import simd

/// WITH DATABSE


let notLoggedIn = Employee(id: 0, password: "", name: "", number: "", status: false, branch: "", employeeType: "", docID: ".")

class Employee: Identifiable, Equatable{
    
    init(id: Int, password: String, name: String, number: String, status: Bool, branch: String, employeeType: String, docID: String?){
        self.id = id
        self.password = password
        self.name = name
        self.number = number
        self.status = status
        self.branch = branch
        self.employeeType = employeeType
        self.docID = docID
    }
    
    let id: Int
    
    var password: String = "password"  // Encrypt later
    
    var docID: String?
    
    var name: String
    var number: String  // Used for login
    var status: Bool
    
    var branch: String
    
    var employeeType: String
    
    static func == (lhs: Employee, rhs: Employee) -> Bool{
        
        return lhs.id == rhs.id
        
    }
    func statusToggle(){
        self.status.toggle()
    }
}


struct ImageType: Identifiable{
    
    let id = UUID()
    var imageURL: String
    
}

struct Emergency: Identifiable{  // to be logged later
    
    var id: String?
    
    var details: String
    var location: GeoPoint
    var meetingPoint: GeoPoint
    var urgency: Int // 1 - 5 scale
    let time : Date
    var employeesCalled: Array<Employee>
    var branch: String // = Employee.branch
    var active: Bool
    
    
    var replied: Dictionary<Bool, Array<Employee.ID>> = [:]
    var arrived: [Employee.ID]
    
    var imageURLs: [String]
    
    var imageURL: [ImageType]{
        var list: [ImageType] = []
        for url in imageURLs{
            list.append(ImageType(imageURL: url))
        }
        return list
    }
    
    var injuries: Int
    var casualties: Int
    
}

func branchInitial(branch: String)  -> String{
    
    if branch == "Ras Al Khaimah"{
        return "RAK"
    }  else if branch == "Umm Al-Quwain"{
        return "UAQ"
    } else if branch == "Sharjah"{
        return "SHJ"
    } else if branch == "Ajman"{
        return "AJM"
    } else if branch == "Fujairah"{
        return "FUJ"
    } else if branch == "Abu Dhabi"{
        return "AD"
    } else if branch == "Dubai"{
        return "DXB"
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
    } else if emptype == "Coordinator"{
        return "C.O."
    }
    else{
        return "Error"
    }
    
}

/*
 
 REQUESTS
 
 for each emergency have 3 lists ( 1 for amount of people called ) (1 for amount of people who have responded) (1 for amount of people who have arrived)
 direct chain of command goes 1 up and 1 down
 
 
 */
struct filterModel: Identifiable{
    var id = UUID()
    var type: String
    var filter: String
}


class VM_DB: ObservableObject{
    
  //  var empl: Employee
    
    @Published var allEmployees = [Employee]()
    @Published var allEmergencies = [Emergency]()
    
    
    
    @Published var typeS = true
    @Published var search = ""
    @Published var sort = "Status"
    @Published var filters = [filterModel]()
    @Published var employee = notLoggedIn
    
    var shownEmployees: [Employee]{
        var emp: [Employee] = []
        
        emp = doSortFilter(list: allEmployees,  sort: sort, type: typeS, filters: filters/*, emp: empl*/)
        
        if search != ""{
            return emp.filter({$0.name.lowercased().contains(search.lowercased() )})
        }
        
        return emp
    }
    
    let db = Firestore.firestore()
    
    init(){
        
        getData()
        
    }
    
}



//MARK: VM FUNCTIONS
extension VM_DB{
    
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
                        let num = doc["Number"] as? String ?? ""
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



//MARK: VM VIEWS
extension VM_DB{
    
    
    
    
    
    
    var filtersView: some View{
        ZStack{
            
            VStack(spacing: 10){
                
                
                HStack{
                    
                    Spacer()
                    
                    
                    Menu("Status") {
                        
                        if !filters.contains(where: { filterModel in
                            filterModel.filter == "Available"}){
                            Button { self.filters.append(filterModel(type: "Status", filter: "Available")) } label: { Text("Available") }
                        }
                        
                        if !filters.contains(where: { filterModel in
                            filterModel.filter == "Unavailable"}){
                            Button { self.filters.append(filterModel(type: "Status", filter: "Unavailable")) } label: { Text("Unavailable") }
                        }
                        
                    }.frame(width: 180, height: 30, alignment: .center)
                    
                    Spacer()
                    
                    
                    Menu("Branch") {
                        
                        if !filters.contains(where: { filterModel in
                            filterModel.filter == "Dubai"}){
                            Button { self.filters.append(filterModel(type: "Branch", filter: "Dubai")) } label: { Text("Dubai") }}
                        
                        if !filters.contains(where: { filterModel in
                            filterModel.filter == "Abu Dhabi"}){
                            Button { self.filters.append(filterModel(type: "Branch", filter: "Abu Dhabi")) } label: { Text("Abu Dhabi") }}
                        
                        if !filters.contains(where: { filterModel in
                            filterModel.filter == "Fujairah"}){
                            Button { self.filters.append(filterModel(type: "Branch", filter: "Fujairah")) } label: { Text("Fujairah") }}
                        
                        if !filters.contains(where: { filterModel in
                            filterModel.filter == "Umm Al-Quwain"}){
                            Button { self.filters.append(filterModel(type: "Branch", filter: "Umm Al-Quwain")) } label: { Text("Umm Al-Quwain") }}
                        
                        if !filters.contains(where: { filterModel in
                            filterModel.filter == "Ras AL Khaimah"}){
                            Button { self.filters.append(filterModel(type: "Branch", filter: "Ras Al Khaimah")) } label: { Text("Ras Al Khaimah") }}
                        
                        if !filters.contains(where: { filterModel in
                            filterModel.filter == "Sharjah"}){
                            Button { self.filters.append(filterModel(type: "Branch", filter: "Sharjah")) } label: { Text("Sharjah") }}
                        
                        if !filters.contains(where: { filterModel in
                            filterModel.filter == "Ajman"}){
                            Button { self.filters.append(filterModel(type: "Branch", filter: "Ajman")) } label: { Text("Ajman") }}
                        
                    }.frame(width: 180, height: 30, alignment: .center)
                    
                    Spacer()
                }
                HStack{
                    Spacer()
                    
                    Menu("Employee Type") {
                        
                        if !filters.contains(where: { filterModel in
                            filterModel.filter == "Fire Fighter"}){
                            Button { self.filters.append(filterModel(type: "Employee Type", filter: "Fire Fighter")) } label: { Text("Fire Fighter") }}
                        
                        if !filters.contains(where: { filterModel in
                            filterModel.filter == "Assistant Supervisor"}){
                            Button { self.filters.append(filterModel(type: "Employee Type", filter: "Assistant Supervisor")) } label: { Text("Assistant Supervisor") }}
                        
                        if !filters.contains(where: { filterModel in
                            filterModel.filter == "Supervisor"}){
                            Button { self.filters.append(filterModel(type: "Employee Type", filter: "Supervisor")) } label: { Text("Supervisor") }}
                        
                        if !filters.contains(where: { filterModel in
                            filterModel.filter == "Deputy Team Head"}){
                            Button { self.filters.append(filterModel(type: "Employee Type", filter: "Deputy Team Head")) } label: { Text("Deputy Team Head") }}
                        
                        if !filters.contains(where: { filterModel in
                            filterModel.filter == "Team Head"}){
                            Button { self.filters.append(filterModel(type: "Employee Type", filter: "Team Head")) } label: { Text("Team Head") }}
                        
                    }.frame(width: 180, height: 30, alignment: .center)
                                                            
                    Spacer()
                    
                }
                
                Divider()
                ScrollView(.horizontal){
                    if filters.isEmpty{
                        VStack(alignment: .center){
                            Text("No filters Selected").padding(.horizontal, 20)
                        }
                    }
                    
                    else if !filters.isEmpty{
                        HStack(spacing: 0){
                            ForEach(filters) { filter in
                                
                                Text(filter.filter)
                                    .padding([.leading, .top, .bottom], 10)
                                    .padding(.trailing, 25)
                                    .background(Color.gray.opacity(0.3))
                                    .cornerRadius(30)
                                Image(systemName: "xmark")
                                    .offset(x: -20)
                                    .onTapGesture {
                                        self.filters.removeAll { filterModel in
                                            filterModel.filter == filter.filter
                                        }
                                    }
                            }
                        }.padding(.leading, 10)
                    }
                    
                }
                
            }
        }
    }
    
    var sortview: some View{
        
        VStack{
            
            Button {
                
                self.sort = "Name"
                self.typeS.toggle()
                
            } label: {
                HStack{
                    
                    Text("Name")
                    Image(systemName: typeS && sort == "Name" ? "chevron.down" : "chevron.up")
                    
                }
            }
            
            Button {
                
                self.sort = "Id"
                self.typeS.toggle()
                
            } label: {
                HStack{
                    
                    Text("Employee ID")
                    Image(systemName: typeS && sort == "Id" ? "chevron.down" : "chevron.up")
                    
                }}
            
            Button {
                
                self.sort = "Status"
                self.typeS.toggle()
                
            } label: {
                HStack{
                    
                    Text("Status")
                    Image(systemName: typeS && sort == "Status" ? "chevron.down" : "chevron.up")
                    
                }
            }
            
            Button{
                self.sort = "Branch"
                self.typeS.toggle()
            } label: {
                HStack{
                    Text("Branch")
                    Image(systemName: typeS && sort == "Branch" ? "chevron.down" : "chevron.up")
                }
            }
            
            Button{
                self.sort = "Role"
                self.typeS.toggle()
            } label: {
                HStack{
                    Text("Employee Type")
                    Image(systemName: typeS && sort == "Role" ? "chevron.down" : "chevron.up")
                }
            }
        }
    }
}


