import SwiftUI
import MapKit
import Firebase
import UIKit

struct EmergencyPage: View{
		
			@EnvironmentObject var vm: dataViewModel

		// Variables for information about the emergency
			@State var emergencyTitle: String = ""
			@State var emergencyDetails: String = "" 
			
			@State var emergencyLocation: GeoPoint = GeoPoint(latitude: 0, longitude: 0)
			@State var meetingPoint: GeoPoint = GeoPoint(latitude: 0, longitude: 0)
			
			@State var emergencyUrgency: Int = 1
			@State var emergencyDate: Date = Date()
			
			@State var casualties: Int = 0
			@State var injuries: Int = 0

			@State var selectedEmployeeIDs = Set<Int>()

			var selectedEmployees: [Employee]{
				var employees: [Employee] = []
				for employee in vm.allEmployees {		
                    if selectedEmployeeIDs.contains(employee.id){
						employees.append(employee)
					}
				}
				return employees}

		// Variable for Functionality
            private enum Field: Int, CaseIterable {
                case emergencyTitle, emergencyDetails
            }

            @FocusState private var focusedField: Field?
    
			@State var showFilters = false
			@State var showSorts = false
			@State var showDetails = false
			@State var created = false

			@State var locationShowPU = false
			@State var MPShowPU = false

			@State var locationRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
			@State var MPRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
			
			var check: Bool {
				if emergencyDetails == "" || selectedEmployeeIDs.isEmpty || emergencyTitle == "" || created{
					return false
				}
				return true}
    // TODO: Fix up the details tab

		// Emergency Details Tab
			var emergencyDetail: some View{
                VStack(spacing:20){



				HStack{

                    Text("Title")
					TextField(" Emergency Title", text: $emergencyTitle)
						.padding(.all, 8)
						.background(Color.gray.opacity(0.12))
						.cornerRadius(10)
                        .focused($focusedField, equals: .emergencyTitle)
                
                    
				}.padding(.horizontal, 30)
                    
                    
                    HStack(){

                    Text("Details")
                    TextEditor(text: $emergencyDetails)
                        /*.padding(2)
                        .cornerRadius(10)
                        .border(Color.gray)
                        .frame(maxHeight:200)
                        .padding(.top, 10)*/
                        .focused($focusedField, equals: .emergencyDetails)
                        
                    
                        }
                    
                .frame(height: 200)
				.padding(.horizontal, 20)
                    
                    if focusedField != nil{
                    Button {
                        print("Hi")
                        focusedField = nil
                    } label: {
                        Image(systemName: "chevron.up")
                            .resizable()
                            .frame(width: 30, height: 15, alignment: .center)
                    }
                    }

				
				//Emergency Location
				HStack(spacing: 20){
					
					Button {
						
						// TODO: open location tab
						self.MPShowPU = false
						self.locationShowPU.toggle()

					
					} label: {
						Text("Location")
						Image(systemName: "location.circle")
					}

					Button {

						// TODO: open Meeting location tab
						self.locationShowPU = false
						self.MPShowPU.toggle()


					} label: {
						Text("Meeting Point")
						Image(systemName: "location.fill")
					}
				}.padding(.horizontal, 10)
				
				HStack(spacing: 10){
					Stepper(value: $emergencyUrgency, in: 1...5) {
						Text("Urgency:")
						Text(String(emergencyUrgency))
					}
				}.padding(.horizontal, 50)
					
					VStack(spacing: 10){
						
						Stepper("Casualties: \(casualties)", value: $casualties)
						
						Stepper("Injuries: \(injuries)", value: $injuries)
						
					}.padding(.horizontal, 50)
						.onChange(of: casualties) { newValue in
							if casualties < 0{
								casualties = 0
							}
						}.onChange(of: injuries) { newValue in
							if injuries < 0{
								injuries = 0
							}
						}
					
				
				HStack(spacing: 10){
					
					DatePicker(selection: $emergencyDate, label: { Text("Time") })
					
                }.padding(.horizontal, 30)
                }
			}

		// Show the employee list
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

		// Main Page
			var body: some View{
                ZStack{
				VStack(){
					// Shows correct top part
						if(showSorts){
							vm.sortView
                            
                        }
                    else if(showFilters){
							vm.filterView
                            
                        }
                    else if(showDetails){
                        Spacer()
							emergencyDetail
                        }

						Divider().onTapGesture {
						// TODO: scroll to the top
                        }
                    

					ScrollView{

						HStack{

								SearchBar()

								Spacer()

					// Details Toggle
						Button{
							withAnimation(Animation.easeInOut){
									showDetails.toggle()
									showFilters = false
									showSorts = false						
								}}
						label: {
								Text("Details").padding(2)
								}


					// Filters Toggle
						Button{
							withAnimation(Animation.easeInOut){
									showFilters.toggle()
									showDetails = false
									showSorts = false
								}}
						label: {
								Text("Filter").padding(2)
								}


					// Sorts Toggle
						Button{
							withAnimation(Animation.easeInOut){
									showSorts.toggle()
									showFilters = false
									showDetails = false
								}}
						label: {
								Text("Sort").padding(2)
								}


						}.offset(x:(-6))
						.frame(width: UIScreen.main.bounds.width + 10)
						
                        if(showDetails){
                            Spacer()
                        }
                        
 	       if(!showDetails){
                        
					// Employee List
						ForEach(vm.allEmployees) {Employee in
                            EmergencyPage.showSelectedEmployee(employee: Employee, selectedItems: $selectedEmployeeIDs)
                        }
						}	
					// Submit Button
						HStack{

							Spacer()
							Button(action:{

                                
								vm.addEmergency(title: emergencyTitle, details: emergencyDetails, called: selectedEmployees, time: emergencyDate, urgency: emergencyUrgency, location: emergencyLocation, meetingPoint: meetingPoint, injuries: injuries, casualties: casualties, branch: vm.account.branch)

                                self.created = true

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

						}


                    }
                }
            }
				.onAppear{
					vm.getData()
					vm.filterEmployees()
					}
				.popover(isPresented: $locationShowPU){locationPopUp}
				.popover(isPresented: $MPShowPU){MPPopUp}
				
			 }
}


// TODO: Popups for maps (locations)
extension EmergencyPage{


	var locationPopUp: some View{
        
        ZStack{
            VStack{
                HStack{ // Top menu
                    
                    Spacer()
                    Button {
                        self.locationShowPU = false
                    } label: {
                       
						Image(systemName: "xmark.circle")
                            .resizable()
                            .frame(width: 25, height: 25, alignment: .center)
							

					}
                    
                }.padding([.trailing, .top], 10)
				.frame(height: 40)
                
                Divider()
            
                
                Map(coordinateRegion: $locationRegion).ignoresSafeArea().onTapGesture{
					// TODO: Add functionality 
				}
            
        }
     }}

	var MPPopUp: some View{
        
        ZStack{
            VStack{
                HStack{ // Top menu
                    
                    Spacer()
                    Button {
                        self.MPShowPU = false
                    } label: {
                       
						Image(systemName: "xmark.circle")
                            .resizable()
                            .frame(width: 25, height: 25, alignment: .center)
							
								
					}
                    
                }.padding([.trailing, .top], 10)
				.frame(height: 40)
                
                Divider()
            
                
                Map(coordinateRegion: $MPRegion).ignoresSafeArea().onTapGesture{
					// TODO: Add functionality 
				}
            
        }
     }}
}


