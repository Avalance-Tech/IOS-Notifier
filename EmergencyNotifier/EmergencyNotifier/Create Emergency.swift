//
//  Create Emergency.swift
//  Emergency Notifier
//
//  Created by Adnan Odimah on 02/01/2022.
//

import SwiftUI


struct showSelectedEmergency: View{
    
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
            
            Text(branchInitial(branch: employee.branch.name))
                .frame(width:40, height: 30, alignment: .leading)
            
            Divider()
            
            Text(typeInitial(emptype: employee.employeeType))
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

struct SortsView: View{
    
    @Binding var sort: String
    @Binding var sortOrder: Bool
    
    
    var descendingImage = "chevron.down"
    var ascendingImage = "chevron.up"
    
    var body: some View{
        VStack{
            
            Button {
                
                sort = "Name"
                sortOrder.toggle()
                
            } label: {
                HStack{
                    
                    Text("Name")
                    Image(systemName: sortOrder && sort == "Name" ? "chevron.down" : "chevron.up")
                    
                }
            }
            
            Button {
                
                sort = "Id"
                sortOrder.toggle()
                
            } label: {
                HStack{
                    
                    Text("Employee ID")
                    Image(systemName: sortOrder && sort == "Id" ? "chevron.down" : "chevron.up")
                    
                }}
            
            Button {
                
                sort = "Status"
                sortOrder.toggle()
                
            } label: {
                HStack{
                    
                    Text("Status")
                    Image(systemName: sortOrder && sort == "Status" ? "chevron.down" : "chevron.up")
                    
                }
            }
            
            Button{
                sort = "Branch"
                sortOrder.toggle()
            } label: {
                HStack{
                    Text("Branch")
                    Image(systemName: sortOrder && sort == "Branch" ? "chevron.down" : "chevron.up")
                }
            }
            
            Button{
                sort = "Role"
                sortOrder.toggle()
            } label: {
                HStack{
                    Text("Employee Type")
                    Image(systemName: sortOrder && sort == "Role" ? "chevron.down" : "chevron.up")
                }
            }
            
            
        }
        
        
    }
}

struct FiltersView: View{
    @Binding var filters: [String]
    
    
    
    
    
    var body: some View{
        VStack{
            
            
            HStack{
                
                Spacer()
                
                Button{
                    
                    
                    if filters.contains("Status"){
                        filters.removeAll(where: {$0 == "Status"})
                    }else{
                        filters.append("Status")
                    }
                    
                    
                } label: {
                    Text("Status")
                    if filters.contains("Status"){ Image(systemName: "checkmark")}
                }.frame(width: 180, height: 5, alignment: .center)
                
                Spacer()
                
                Button{
                    
                    if filters.contains("Branch"){
                        filters.removeAll(where: {$0 == "Branch"})
                    }else{
                        filters.append("Branch")
                    }
                    
                } label: {
                    Text("Branch")
                    if filters.contains("Branch"){Image(systemName: "checkmark")}
                    
                }.frame(width: 180, height: 5, alignment: .center)
                
                Spacer()
                
            }
            HStack{
                
                Spacer()
                
                Button{
                    
                    if filters.contains("Employee Type"){
                        filters.removeAll(where: {$0 == "Employee Type"})
                    }else{
                        filters.append("Employee Type")
                    }
                    
                } label: {
                    Text("Employee Type")
                    if filters.contains("Employee Type"){Image(systemName: "checkmark")}
                    
                    
                }.frame(width: 180, height: 5, alignment: .center)
                
                Spacer()
                
                Button{
                    
                    if filters.contains("Selected"){
                        filters.removeAll(where: {$0 == "Selected"})
                    }else{
                        filters.append("Selected")
                    }
                    
                } label: {
                    Text("Selected")
                    if filters.contains("Selected"){Image(systemName: "checkmark")}
                    
                }.frame(width: 180, height: 5, alignment: .center)
                Spacer()
            }.padding(.top, 20)
        }
        Divider()
        ScrollView(.horizontal){
            HStack{
                
                
                
            }
            
        }
    }
    
    
}



struct Create_Emergency: View {
    
    // Sort / filter employees shown
    
    var allEmployeesShown: Array<Employee>{
        return [adnan, talal, wassim, ayman]
    }
    
    @State var filters: [String] = []
    
    var shownEmployees: [Employee]{
        var emp: [Employee] = []
        
        emp = doSort(list: allEmployeesShown,  sort: sort, type: typeS)
        
        
        if search != ""{
            return emp.filter({$0.name.contains(search.lowercased())})
        }
        
        return emp
    }
    
    @State var typeS = true
    @State var search = ""
    @State var sort = "Status"
    
    @State var showFilters = false
    @State var showSorts = false
    
    // Emergency Properties
    
    @State var emergencyDetails: String = ""
    @State var emergencyLocation: String = ""
    @State var meetingPoint: String = ""
    @State var emergencyUrgency = 1
    @State var emergencyDate: Date = Date()
    
    
    
    
    @State var selectedEmployeesID = Set<Int>()
    
    var selectedEmployees: [Employee]{
        
        var employees: [Employee] = []
        
        for employee in shownEmployees {
            
            if selectedEmployeesID.contains(employee.id){
                
                employees.append(employee)
                
            }
            
        }
        
        return employees
        
    }
    
    var body: some View {
        
        VStack(spacing: 15){
            
            if !showSorts && !showFilters{
                // Emergency Details
                HStack(spacing: 10){
                    Text("Details")
                    TextField(" Emergency Details", text: $emergencyDetails)
                        .background(Color.gray.opacity(0.1).cornerRadius(10))
                    
                }
                .padding(.horizontal, 10)
                
                //Emergency Location
                HStack(spacing: 10){
                    Text("Location")
                    TextField("Emergency Location", text: $emergencyLocation)
                        .background(Color.gray.opacity(0.1).cornerRadius(10))
                }
                .padding(.horizontal, 10)
                
                
                //Meeting point Location
                HStack(spacing: 10){
                    Text("Meeting Location")
                    TextField("Meeting Point Location", text: $meetingPoint)
                        .background(Color.gray.opacity(0.1).cornerRadius(10))
                }
                .padding(.horizontal, 10)
                
                
                HStack(spacing: 10){
                    Stepper(value: $emergencyUrgency, in: 1...5) {
                        Text("Urgency:")
                        Text(String(emergencyUrgency))
                    }
                }
                .padding(.horizontal, 10)
                
                HStack(spacing: 10){
                    
                    DatePicker(selection: $emergencyDate, label: { Text("Time") })
                    
                }
                .padding(.horizontal, 10)
                
            }
            
            else if showSorts{
                
                SortsView(sort: $sort, sortOrder: $typeS)
                
            } else if showFilters{
                
                FiltersView(filters: $filters)
                
            }
            
            
            Divider().onTapGesture {
                // scroll to the top
            }
            
            ScrollView{
                
                HStack{
                    
                    
                    Search_Preset(search: $search)
                    
                    Spacer()
                    
                    Button {
                        showFilters.toggle()
                        showSorts = false
                        
                    } label: {
                        Text("Filter")
                    }
                    
                    
                    Button {
                        showSorts.toggle()
                        showFilters = false
                    } label: {
                        Text("Sort")
                    }.padding(.trailing, 5)
                    
                    
                }.offset(x:-6)
                    .frame(width: UIScreen.main.bounds.width + 10)
                
                ForEach(shownEmployees) {Employee in
                    
                    showSelectedEmergency(employee: Employee, selectedItems: $selectedEmployeesID)
                    
                }
            }
            
            Divider()
            
            // Submit Button
            HStack{
                Spacer()
                Button(action: {
                    
                    
                    print(emergencyDetails)
                    print(emergencyDate)
                    print(emergencyLocation)
                    print(meetingPoint)
                    print(emergencyUrgency)
                    
                    print(selectedEmployees)
                    
                    
                }, label:
                        {
                    Text("Submit")
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .foregroundColor(.black)
                        .background(RoundedRectangle(cornerRadius: 5))
                    
                    
                }
                )
                
                
            }.padding(.all, 5)
        }
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
                newList = list.sorted(by: {  $0.branch.name < $1.branch.name  })
            }
            else{
                newList = list.sorted(by: { $0.branch.name > $1.branch.name
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
        
        
        return newList
    }
    
    
    
    
}




struct Create_Emergency_Previews: PreviewProvider {
    static var previews: some View {
        Create_Emergency()
            .previewDevice("iPhone SE (2nd generation)")
    }
}



