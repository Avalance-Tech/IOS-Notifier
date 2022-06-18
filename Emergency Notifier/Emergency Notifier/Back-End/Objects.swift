

class Employee: Identifiable, Equatable{   
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
    
    let id: Int
    var password: String = "password"  // TODO:  Encrypt later
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
}



struct ImageType: Identifiable{
    
    let id = UUID()
    var imageURL: String
}



struct Emergency: Identifiable{ 
	
	/* Emergency struct
	ID, Details, Location, MeetingPoint, Urgency (1 - 5), Time, Employees called [employee], branch, active (bool), replied (dict(employee.id, (bool, eta, time))), arrived (list of employees), images, injuries, casualties
	*/
	
	var docID: String? // for database


	//Details about the emergency
	var title: String
	var details: String

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
	var replies: Dictionary<Employee: (String /* Replied */, Date/* ETA */)>
	var arrived: Array<Employee> = []
	

	/*


    var imageURLs: [String] = [] // URLS
    

    var imageURL: [ImageType]{
        var list: [ImageType] = []
        for url in imageURLs{
            list.append(ImageType(imageURL: url))
        }
        return list
    }
    */ // TODO: Add images for gallery
}


struct filterModel: Identifiable{
	var id = UUID()
	var type: String
	var filter: String
}


class dataViewModel: ObservableObject{
	/*

	Model View ViewModel

 View - UI
 Model - Data Point
 ViewModel - manages the data for a view

	Used for data and infromation stored on the database
	*/
	

    @Published var allEmployees = [Employee]()
    @Published var allEmergencies = [Emergency]()
    
    @Published var Ascending = true

    @Published var search = ""
    @Published var sort = "Status"
    
	@Published var filters = [filterModel]()
    
    let db = Firestore.firestore()

	shownEmployees: [Employee] = []

	init(account: Employee)
	{
		self.account = account
		filterEmployees()
		getData()
	}


    var shownEmployees: [Employee]{
        var emp: [Employee] = []
        
        emp = doSortFilter(list: allEmployees,  sort: sort, type: typeS, filters: filters/*, emp: empl*/)
        
        if search != ""{
            return emp.filter({$0.name.lowercased().contains(search.lowercased() )})
        }
        
        return emp
    }
    
}