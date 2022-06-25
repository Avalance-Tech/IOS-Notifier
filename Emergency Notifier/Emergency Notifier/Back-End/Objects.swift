import Foundation
import Firebase
import SwiftUI

class Employee: Identifiable, Equatable, Hashable{
	/* 
	Employee
	Employee Id, Password Hash, Name, Phone Number, Status (bool), Branch, EmployeeType, docID (firebase)
	*/
    
    init(id: Int, password: String, name: String, status: Bool, branch: String, employeeType: String, docID: String?){
        self.id = id
        self.password = password
        self.name = name
        self.status = status
        self.branch = branch
        self.employeeType = employeeType
        self.docID = docID
    }
    
    var id: Int
    var password: String = "password"  // TODO:  Encrypt password
    var name: String
    var status: Bool
    var branch: String
    var employeeType: String
    var docID: String? 
    
    static func == (lhs: Employee, rhs: Employee) -> Bool{   // function to make it equatable
        return lhs.id == rhs.id
    }
	
    func statusToggle(){
        self.status.toggle()
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(id)
        hasher.combine(docID)
    }
}



struct ImageType: Identifiable{
    
    let id = UUID()
    var imageURL: String
}



struct Emergency: Identifiable{ 
	
	/* Emergency struct
	ID, Details, Location, MeetingPoint, Urgency (1 - 5), Time, Employees called [employee], branch, active (bool), replied (dict(employee.id, (bool, eta, time))), arrived (list of employees), images, injuries, casualties
	*/
	
	var id: String? // for database
    

	//Details about the emergency
	var title: String
	var details: String

    var branch: String
    
    var injuries: Int
    var casualties: Int


	// Location of emergency and the meeting point
	var location: GeoPoint
	var meetingPoint: GeoPoint

	//How urgent it is
	var urgency: Int // 1 - 5


	// Time of accident
	let time: Date
	
	
	// Called employees
	var replies: Dictionary<Employee, (String /* Replied */, Date/* ETA */)>
	var arrived: Array<Employee> = []
	
    var active: Bool = true
    
	/*


    var imageURLs: [String] = [] // URLS
    

    var imageURL: [ImageType]{
        var list: [ImageType] = []
        for url in imageURLs{
            list.append(ImageType(imageURL: url))
        }
        return list
    }
    */ // TODO: Add images for gallery (emergency)
}


struct filterModel: Identifiable{
	var id = UUID()
	var type: String /* Branch, Name, Status etc. */
	var filterRules: String
}


class dataViewModel: ObservableObject{
	/*

	Model View ViewModel

 View - UI
 Model - Data Point
 ViewModel - manages the data for a view

	Used for data and infromation stored on the database
	*/

    
    @AppStorage("ID") var currentUserID: Int?
    @AppStorage("Password") var currentUserPassword: String?

    @Published var login_id = ""
    @Published var login_password = ""
	
    @Published var failed = false
    @Published var loggingIn = false

    @Published var allEmployees = [Employee]()
    @Published var allEmergencies = [Emergency]()
    
    @Published var ascending = true

    var search = ""
    @Published var sort = "Status"
    
	@Published var filters = [filterModel]()
    
    let db = Firestore.firestore()
    
    @Published var account: Employee =  Employee(id: -1, password: "", name: "", status: false, branch: "", employeeType: "", docID: "")

	init()
	{
		getData()
        filterEmployees()
	}
    



    var shownEmployees: [Employee]{

        var emp: [Employee] = []
        
        emp = doFilter(list: allEmployees, filters: filters, employee: account)
        emp = doSort(list: emp, Asc: ascending, sort: sort)


        if search != ""{

            return emp.filter({$0.name.lowercased().contains(search.lowercased())})

        }
        
        return emp
    }
    
}
