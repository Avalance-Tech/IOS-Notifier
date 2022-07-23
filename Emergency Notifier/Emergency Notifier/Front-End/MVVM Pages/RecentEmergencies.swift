import SwiftUI
import Firebase
import MapKit


struct WhenClickedEmployee: View{
    
    var employee: Employee
    var replied: String
    
    var body: some View{
        
        HStack{
            
            Text(employee.name)
            
            Text(employee.branch)
            
            Text(employee.employeeType)
            
            
            switch replied{
            case "arrived":
                Image("checkmark.circle.fill")
            case "accepted":
                Text("ETA")
            case "rejected":
                Text("Reason")
            case "not replied":
                Text("Not replied")
                
            default:
                Text("ERROR")
            }
            
        }
    }
    
    
}


struct EditEmergency: View{ 
    
    var emergency: Emergency
    
    @EnvironmentObject var vm: dataViewModel
    
    @State var nETitle: String = ""
    
    @State var dragDown = false
    
    @State var nEDetails: String = ""
    
    @State var nELocation = GeoPoint(latitude: 0, longitude: 0)
    @State var nEMP = GeoPoint(latitude: 0, longitude: 0)
    
    @State var nEUrgency = 1
    
    @State var casualties = 0
    @State var injuries = 0
    
    @State var activeState = true
    
    private enum Field: Int, CaseIterable {
        case emergencyTitle, emergencyDetails
    }
    
    @FocusState private var focusedField: Field?
    
    
    var body: some View{
        ZStack{
            
            if dragDown{
                
                VStack{
                    Text("Emergency Editted")
                        .frame(width: UIScreen.main.bounds.width, height: 100, alignment: .bottom)
                        .padding(.bottom, 35)
                        .background(Color.green.opacity(1))
                        .cornerRadius(20)
                        .foregroundColor(Color.white)
                        .animation(Animation.easeInOut, value: !dragDown)
                        .transition(AnyTransition.move(edge: .top))
                    
                    
                    Spacer()
                }
                .animation(Animation.easeInOut, value: !dragDown)
                .transition(AnyTransition.move(edge: .top))
                .ignoresSafeArea()
            }
            VStack(spacing: 10){
                
                
                TextField("Emergency Details", text: $nETitle)
                    .foregroundColor(Color.white)
                    .padding(.all, 8)
                    .background(Color.gray.opacity(6))
                    .cornerRadius(10)
                
                
                ScrollView {
                    VStack{
                        TextEditor(text: $nEDetails)
                            .focused($focusedField, equals: .emergencyDetails)
                            .cornerRadius(10)
                            .frame(minHeight: 100
                            )
                    }
                }.frame(height: 100)
                    .cornerRadius(10)
                    .border(.black)
                    
                
                if focusedField != nil{
                    Button{
                        focusedField = nil
                    } label:{
                        Image(systemName: "chevron.up")
                            .resizable()
                            .frame(width: 30, height: 15, alignment: .center)
                        
                    }}
                
                
                Stepper("Casualties: \(casualties)", value: $casualties).multilineTextAlignment(.center)
                    .onChange(of: casualties) { newValue in
                        if casualties < 0{
                            casualties = 0
                        }
                    }
                
                Stepper("Injuries: \(injuries)", value: $injuries).multilineTextAlignment(.center)
                    .onChange(of: injuries) { newValue in
                        if injuries < 0{
                            injuries = 0
                        }
                    }
                
                
                Toggle("Active", isOn: $activeState)
                
                
                HStack(spacing: 40){
                    
                    Button {
                        // open location tab
                    } label: {
                        Text("Location")
                        Image(systemName: "location.circle")
                    }
                    
                    Button {
                        // open Meeting location tab
                    } label: {
                        Text("Meeting Point")
                        Image(systemName: "location.fill")
                    }
                }
                .padding(.horizontal, 0)
                
                
                
                Stepper("Urgency: \(nEUrgency)", value: $nEUrgency)
                
                
                Spacer()
                Text("Edit")
                    .bold()
                    .foregroundColor(Color.blue)
                    .onTapGesture {
                        
                        vm.updateEmergency(emergency: Emergency(id: emergency.id, title: nETitle, details: nEDetails, branch: emergency.branch, injuries: injuries, casualties: casualties, location: nELocation, meetingPoint: nEMP, urgency: nEUrgency, time: emergency.time, replies: emergency.replies, arrived: emergency.arrived, active: activeState))
                        
                        withAnimation{
                            dragDown = true}
                        
                        Timer.scheduledTimer(withTimeInterval: 2.3, repeats: false) { _ in
                            
                            withAnimation {
                                dragDown = false
                            }
                        }
                    }
                
                
                // Edit Emergency
                
                
                
                
            }.padding(.horizontal, 5)
        }.onAppear {
            nEUrgency = emergency.urgency
            nETitle = emergency.title
            nEDetails = emergency.details
            casualties = emergency.casualties
            injuries = emergency.injuries
            activeState = emergency.active
        }
    }
    
}

struct WhenClicked: View{ 
    
    @EnvironmentObject var vm: dataViewModel
    
    @State var selectedEmployeeIDs = Set<Int>()

    @Environment(\.dismiss) private var dismiss
    
    var selectedEmployees: [Employee]{
        var employees: [Employee] = []
        for employee in vm.allEmployees {
            if selectedEmployeeIDs.contains(employee.id){
                employees.append(employee)
            }
        }
        return employees}

    var emergency: Emergency
    @State var employeePopUp = false
    @State var forwardPopUp = false
    
    struct showSelectedEmployee: View{

        let employee: Employee
        
        @Binding var selectedItems: Set<Int>
        
        var isSelected: Bool{
            
            selectedItems.contains(employee.id)
            
        }
        
        
        
        var body: some View{
            
            HStack(spacing: 7){
                
                Text(String(employee.id))
                    .frame(width: 45, height: 30, alignment: .leading)
                    .padding(.leading, 3)
                
                Divider()
                
                Text(String(employee.name).capitalized(with: .current))
                    .frame(width:140, height: 30, alignment: .leading)
                
                
                Image(employee.status ? "checkmark.circle.fill" : "circle.slash")
                    .frame(width:23, height: 30, alignment: .leading)
                
                Divider()
                
                Text(branchInitials(branch: employee.branch))
                    .frame(width:40, height: 30, alignment: .leading)
                
                Divider()
                
                Text(typeInitial(type: employee.employeeType))
                    .font(.system(size: 15,weight: .light))
                    .frame(width: 32, height: 30)
                
                Divider()
                
                if self.isSelected{
                    Image(systemName:"checkmark")
                        .foregroundColor(Color.blue)
                        .frame(width: 20, height: 30)
                }else{
                    Text("").frame(width: 20, height: 30)
                }
                
                
            }
            .onTapGesture {
                if self.isSelected{
                    self.selectedItems.remove(self.employee.id)
                } else{
                    self.selectedItems.insert(self.employee.id)
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: 70, alignment: .leading)
            .border(Color.gray.opacity(self.isSelected ? 1 : 0.3))
            .shadow(color: Color.black.opacity(self.isSelected ? 0.4 : 0), radius: 2, x: 2, y: 2)

        }
    }
    
    var body: some View{
        ZStack{
            VStack(spacing: 10){
                if vm.account.employeeType == "Team Head" || vm.account.employeeType == "Acting Team Head" || vm.account.employeeType == "Operational Manager" || vm.account.employeeType == "Acting Operational Manager"{
                    topBar
                }
                
                HStack(alignment: .center, spacing: 10){Text("Title:"); Text("\(emergency.title)")
                    .font(Font.headline)}
                
                
                HStack(){
                    Text("Details:\n\(emergency.details)")
                        .multilineTextAlignment(.leading)
                        .frame(width: UIScreen.main.bounds.width)
                        .frame(maxHeight: 200)
                        .padding(.horizontal, 10)
                }.padding(.horizontal, 20)
                
                
                Divider()
                
                HStack(spacing: 30){
                    Text("location")
                    Text("meeting point")
                }
                
                HStack(spacing: 30){
                    Text("Urgency: \(emergency.urgency)")
                    Text("Branch: \(emergency.branch)")}
                //  Text("\(emergency.imageURL)")
                
                
                Text("Time:  \(emergency.time)")
                
                HStack{
                    ScrollView{
                        ForEach(Array(emergency.replies.keys)){ employee in
                            
                            NavigationLink {
                                WhenClickedEmployee(employee: employee, replied: checkReply(employee: employee))
                                
                            } label: {
                                
                                HStack{
                                    Text(employee.name).frame(width: 140, height: 30, alignment: .leading)
                                    Text(String(employee.id)).frame(width: 50, height: 30, alignment: .center)
                                    Text(typeInitial(type: employee.employeeType)).frame(width: 40, height: 30, alignment: .center)
                                    Text(checkReply(employee: employee)).frame(width: 90, height: 30, alignment: .leading)
                                    
                                }
                            }
                            
                            
                        }
                    }
                }
                
            }
        }
    }
    
    
    func checkReply(employee: Employee) -> String{
        if emergency.arrived.contains(employee){
            return "arrived"
        }
        return emergency.replies[employee]?.0 ?? "Error"
    }
    
}

struct GalleryWithEmergencies: View{
    
    @EnvironmentObject var vm: dataViewModel
    @Binding var loggedin: Employee
    
    let columns: [GridItem] = [
        GridItem(),
        GridItem(),
    ]
    
    @State var showingEmergency = false
    
    var body: some View{
        ZStack{
            VStack{
                
                
                
                ScrollView{
                    
                    LazyVGrid(columns: columns) {
                        
                        ForEach(vm.allEmergencies){ emergency in
                            NavigationLink{
                                
                                WhenClicked(emergency: emergency)
                                
                            } label: {
                                ZStack{
                                    
                                    Image("Avala_logo")
                                        .resizable()
                                    
                                    HStack{
                                        
                                        
                                        Spacer()
                                        Text(emergency.details)
                                            .foregroundColor(Color.white.opacity(1))
                                            .background(Color.gray.opacity(0.8))
                                            .cornerRadius(10)
                                        Spacer()
                                    }
                                    
                                }
                            }.frame(height: 250, alignment: .center)
                        }
                    }
                    
                }
            }
        }
    }
}

struct ListWithEmergencies: View{
    
    @EnvironmentObject var vm: dataViewModel
    @Binding var loggedin: Employee
    
    
    
    var body: some View{
        
        VStack{
            HStack{
                VStack{
                    Text("Location").frame(height: 20, alignment: .center)
                    
                    Text("Meeting Point").frame(height: 20)
                        .font(.system(size: 14))
                }
                .frame(width:105, alignment: .center)
                
                
                Divider().frame(height: 50)
                
                Text("Details").frame(width: 160, height: 50, alignment: .center)
                
                Divider().frame(height: 50)
                
                VStack(alignment: .leading){
                    Text("Requested").frame(width: 100,height: 1)
                    Divider().frame(width: 100, height:1)
                    Text("Accepted").frame(width:100, height: 1)
                    Divider().frame(width: 100, height: 1)
                    Text("Arrived").frame(width:100, height:1)
                }
                
                
            }
            
            Divider()
            
            ScrollView{
                
                ForEach(vm.allEmergencies){
                    emergency in
                    
                    
                    HStack{
                        
                        VStack{
                            
                            Button {
                                
                                
                                // Open location
                                
                                
                            } label: {
                                Text("Location").frame(width: 105, height: 40, alignment: .center)
                            }
                            
                            
                            Button {
                                
                                
                                //Open location
                                
                                
                            } label: {
                                Text("M.P.").frame(width: 105, height: 40, alignment: .center)
                                
                            }
                            
                            
                        }.frame(width: 105, height: 80, alignment: .center)
                        
                        NavigationLink {
                            WhenClicked(emergency: emergency)
                        } label: {
                            
                            Divider().frame(height:70)
                            
                            
                            Text(emergency.details).frame(width: 160, height: 80, alignment: .top)
                                .multilineTextAlignment(.center)
                            
                            
                            Divider().frame(height:70)
                            
                            VStack(alignment: .leading){
                                
                                Text(String(emergency.replies.count)).frame(width: 100,height: 5)
                                
                                Divider().frame(width: 100, height:1)
                                
                                //        Text(String(emergency.replies[true]!.count)).frame(width:100, height: 5)
                                
                                Divider().frame(width: 100, height: 1)
                                
                                Text(String(emergency.arrived.count)).frame(width:100, height:5)
                            }
                            
                            
                            
                            
                        }
                    }
                    Divider()
                }
            }
        }
    }
}




struct Recent_Emergencies: View {
    @EnvironmentObject var vm: dataViewModel
    
    @State var search = ""
    @State var viewType = "list"
    
    var body: some View {
        VStack{
            HStack{
                
                Spacer()
                
                Button(action: {
                    viewType = "photo"
                }, label: {
                    Image(systemName: "photo")
                        .resizable()
                        .frame(width: 35, height: 30, alignment: .center)
                        .offset(x:-20)
                    
                }).disabled(viewType == "photo" ? true : false)
                
                Button(action: {
                    viewType = "list"
                }, label: {
                    Image(systemName: "list.bullet")
                        .resizable()
                        .frame(width: 35, height: 25, alignment: .center)
                        .offset(x: -20)
                    
                }).padding(.trailing, 10)
                    .disabled(viewType == "list" ? true : false)
            }
            if viewType == "list"{
                ListWithEmergencies(loggedin: $vm.account)
            }
            else if viewType == "photo"{
                GalleryWithEmergencies(loggedin: $vm.account)
            }
        }.onAppear{ vm.getData() }
    }
}





//MARK: When Clicked Aspects
extension WhenClicked{
    
    
    var topBar: some View{
        
        HStack{
            
            Button {
                
                forwardPopUp = true
                
            } label: {
                Image(systemName: "paperplane").resizable().frame(width: 30, height: 30, alignment: .center)
            }.padding()
            
            
            
            Spacer()
            
            
            NavigationLink{
                
                EditEmergency(emergency: emergency, nEDetails: emergency.details, nELocation: emergency.location, nEMP: emergency.meetingPoint, nEUrgency: emergency.urgency, casualties: emergency.casualties, injuries: emergency.injuries)
                //Edit Emergency
            }label: {
                Text("Edit").frame(width: 40, height: 30, alignment: .trailing)
                Image(systemName: "pencil").resizable()
                    .frame(width: 30, height: 30, alignment: .center)
                    .padding()
            }
        }.popover(isPresented: $forwardPopUp) {
            VStack{
            
            Text("Forward To")
                
                ScrollView{
                    ForEach(vm.shownEmployees().filter({ Employee in
                        !emergency.replies.keys.contains(Employee)
                    })
                    ) { emp in
                        showSelectedEmployee(employee: emp, selectedItems: $selectedEmployeeIDs)
                    }
                }
                
                Button {
                    var newReplies = emergency.replies
                    
                    for employee in selectedEmployees{
                        newReplies[employee] = ("No Reply", Date())
                    }

                    let nEm = Emergency(id: emergency.id, title: emergency.title, details: emergency.details, branch: emergency.branch, injuries: emergency.injuries, casualties: emergency.casualties, location: emergency.location, meetingPoint: emergency.meetingPoint, urgency: emergency.urgency, time: emergency.time, replies: newReplies, arrived: emergency.arrived, active: emergency.active)

                    
                    vm.updateEmergency(emergency: nEm)
                    
                    forwardPopUp = false
                    
                    dismiss()
                    dismiss()
                } label: {
                    Text("Forward")
                }
            
            }
        }
        
    }
    
    
    
}
