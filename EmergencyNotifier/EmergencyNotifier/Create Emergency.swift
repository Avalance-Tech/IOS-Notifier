//
//  Create Emergency.swift
//  Emergency Notifier
//
//  Created by Adnan Odimah on 02/01/2022.
//

import SwiftUI
import Firebase
import nanopb
import MapKit


// ADD CASUALTIES AND INJURIES

struct EmergencyDetails: View{
    
    @Binding var emergencyDetails: String
    
    @Binding var emergencyLocation: String
    @Binding var meetingPoint: String
    
    @Binding var emergencyUrgency: Int
    @Binding var emergencyDate: Date
    
    @Binding var casualties: Int
    @Binding var injuries: Int
    
    var body: some View{
    // Emergency Details
    HStack(spacing: 10){
        Text("Details")
        TextField(" Emergency Details", text: $emergencyDetails)
            .padding(.all, 8)
            .background(Color.gray.opacity(0.12))
            .cornerRadius(10)
        
    }
    .padding(.horizontal, 10)
    
    //Emergency Location
    HStack(spacing: 10){
        
        Button {
            // open location tab
        } label: {
            Text("Location")
            Image(systemName: "location.circle")
        }

        Button {
            // open Meeting location tab
        } label: {
            Text("Location")
            Image(systemName: "location.fill")
        }
    }
    .padding(.horizontal, 10)
    
    
    HStack(spacing: 10){
        Stepper(value: $emergencyUrgency, in: 1...99999) {
            Text("Urgency:")
            Text(String(emergencyUrgency))
        }
    }
    .padding(.horizontal, 10)
        
    HStack(spacing: 5){
        
        Stepper(value: $injuries, in: 0...99999) {
            Text("Injuries:")
                Text(String(injuries))
        
        }.font(.system(size: 10))
        
        Spacer()
        
        Stepper(value: $casualties) {
            Text("Casualties:")
            Text(String(casualties))

    }
        .font(.system(size: 10))
    }
        .padding(.horizontal, 10)
    
    HStack(spacing: 10){
        
        DatePicker(selection: $emergencyDate, label: { Text("Time") })
        
    }
    .padding(.horizontal, 10)
}
}

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
            
            Text(branchInitial(branch: employee.branch))
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
            if filters.isEmpty{
                VStack(alignment: .center){
            Text("No filters Selected")
            }
            }

            
        }
    }
    
    
}


struct Create_Emergency: View {
    
    // Sort / filter employees shown
    
    var check: Bool{
        
        if emergencyDetails == "" || selectedEmployeesID.isEmpty{
            return false
        }
        return true
    }
    
    @StateObject var vm = VM_DB()
    
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))

    @State var showFilters = false
    @State var showSorts = false
    

    // Emergency Properties
    
    @State var emergencyDetails: String = ""
    @State var emergencyLocation: String = ""
    @State var meetingPoint: String = ""
    @State var emergencyUrgency = 1
    @State var emergencyDate: Date = Date()
    
    @State var injuries = 0
    @State var casualties = 0
    
    
    @State var selectedEmployeesID = Set<Int>()
    
    
    var selectedEmployees: [Employee]{
        
        var employees: [Employee] = []
        
        for employee in vm.allEmployees {
            
            if selectedEmployeesID.contains(employee.id){
                
                employees.append(employee)
                
            }
            
        }
        
        return employees
    }
        
        
        
    
    
    var body: some View {
        
        VStack(spacing: 15){
            
            
            // to show emergency Details
            if !showSorts && !showFilters{

                EmergencyDetails(emergencyDetails: $emergencyDetails, emergencyLocation: $emergencyLocation, meetingPoint: $meetingPoint, emergencyUrgency: $emergencyUrgency, emergencyDate: $emergencyDate, casualties: $casualties, injuries: $injuries).animation(Animation.easeIn(duration: 2), value: showSorts || showFilters)
                
            }
            
            // to show sorts
            else if showSorts{
                
                vm.sortview
                
            }
            
            // to show filters
            else if showFilters{
                
                
                mapPopUp
                // FiltersView(filters: $vm.filters)
                
            }
            
            
            Divider().onTapGesture {
                // scroll to the top
            }
            
            ScrollView{

                HStack{
                    
                    
                    Search_Preset(search: $vm.search)
                        
                    Spacer()
                    
                    Button {
                        withAnimation(Animation.easeInOut){
                        showFilters.toggle()
                            showSorts = false
                        }
                        
                        
                    } label: {
                        Text("Filter")
                    }
                    
                    
                    Button {
                        withAnimation(Animation.easeInOut){
                        showSorts.toggle()
                        showFilters = false}
                    } label: {	
                        Text("Sort")
                    }.padding(.trailing, 5)
                    
                    
                }.offset(x:-6)
                    .frame(width: UIScreen.main.bounds.width + 10)
                
                ForEach(vm.shownEmployees) {Employee in
                    
                    showSelectedEmergency(employee: Employee, selectedItems: $selectedEmployeesID)
                    
                }
            }
            
            Divider()
            
            // Submit Button
            HStack{
                Spacer()
                Button(action: {
                    
                    vm.addEmergency(details: emergencyDetails, called: selectedEmployees, time: emergencyDate, urgency: emergencyUrgency, location: GeoPoint(latitude: 0, longitude: 0), meetingPoint: GeoPoint(latitude: 0, longitude: 0))
                    
                    
                }, label:
                        {
                    Text("Submit")
                        .bold()
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .foregroundColor(.black)
                        .background(RoundedRectangle(cornerRadius: 5))
                    
                    
                }
                ).disabled(check ? false : true)
                
                
            }.padding(.all, 5)
                .onAppear {
                    vm.getData()
                }
        }
    }
    
    
    
    
    

    

    
    
    
    
}




struct Create_Emergency_Previews: PreviewProvider {
    static var previews: some View {
        Create_Emergency()
            .preferredColorScheme(.dark)
            .previewDevice("iPhone SE (2nd generation)")
    }
}



//MARK: CREATE EMERGENCY POPUPS
extension Create_Emergency{
    

    
    var mapPopUp: some View{
        
        Map(coordinateRegion: $region).ignoresSafeArea()
        
    }
}
