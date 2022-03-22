//
//  Recent Emergencies.swift
//  EmergencyNotifier
//
//  Created by Adnan Odimah on 10/01/2022.
//
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
    
    var vm: VM_DB
    
    @State var dragDown = false
    
    @State var nEDetails: String = ""
    
    @State var nELocation = GeoPoint(latitude: 0, longitude: 0)
    @State var nEMP = GeoPoint(latitude: 0, longitude: 0)
    
    @State var nEUrgency = 1
    
    @State var casualties = 0
    @State var injuries = 0
    
    @State var activeState = true
    
    var docID: String
    
    
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
            
            VStack{
                
                Spacer()
                
                
                HStack(spacing: 10){
                    
                    Stepper("Casualties\n\(casualties)", value: $casualties).multilineTextAlignment(.center)
                    
                    Stepper("Injuries\n\(injuries)", value: $injuries).multilineTextAlignment(.center)
                    
                }
                .onChange(of: casualties) { newValue in
                    if casualties < 0{
                        casualties = 0
                    }
                }
                .onChange(of: injuries) { newValue in
                    if injuries < 0{
                        injuries = 0
                    }
                }
                
                HStack(){
                    Toggle("Active", isOn: $activeState)
                }
                
                HStack(spacing: 30){
                    
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
                
                TextField("Emergency Details", text: $nEDetails)
                    .foregroundColor(Color.white)
                    .padding(.all, 8)
                    .background(Color.gray.opacity(6))
                    .cornerRadius(10)
                Spacer()
                Spacer()
                Divider()
                Button {
                    
                    vm.updateEmergency(emergency: Emergency(id: docID, details: nEDetails, location: nELocation, meetingPoint: nEMP, urgency: nEUrgency, time:emergency.time, employeesCalled: emergency.employeesCalled, branch: emergency.branch, active: true, replied: emergency.replied, arrived: emergency.arrived, imageURLs: [], injuries: injuries, casualties: casualties))
                    
                    withAnimation{
                        dragDown = true}
                    
                    Timer.scheduledTimer(withTimeInterval: 2.3, repeats: false) { _ in
                        
                        withAnimation {
                            dragDown = false
                        }
                    }
                    // Edit Emergency
                } label: {
                    Text("Edit Emergency")
                        .bold()
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .foregroundColor(.black)
                        .background(RoundedRectangle(cornerRadius: 5))
                    
                }.disabled(nEDetails != "" ? false : true)
                
                
            }.padding(.horizontal, 5)
        }.onAppear {
            activeState = emergency.active
        }
    }
    
}

struct WhenClicked: View{
    
    @Binding var loggedin: Employee
    
    var vm: VM_DB
    
    var emergency: Emergency
    @State var employeePopUp = false
    @State var forwardPopUp = false
    
    var body: some View{
        
        VStack{
            
            
            if loggedin.employeeType == "Team Head" || loggedin.employeeType == "Acting Team Head" || loggedin.employeeType == "Operational Manager"{
                topBar
            }
            
            
            
            
            Text("Details:   \(emergency.details)").multilineTextAlignment(.center)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width, alignment: .center)
            
            Text("\(emergency.location)")
            Text("\(emergency.meetingPoint)")
            Text("\(emergency.urgency)")
            Text("\(emergency.branch)")
            //  Text("\(emergency.imageURL)")
            
            
            Text("Time:   \(emergency.time)")
            
            HStack{
                ScrollView{
                    ForEach(emergency.employeesCalled){ employee in
                        
                        NavigationLink {
                            WhenClickedEmployee(employee: employee, replied: checkReply(employee: employee))
                            
                        } label: {
                            
                            HStack{
                                Text(employee.name).frame(width: 140, height: 30, alignment: .leading)
                                Text(String(employee.id)).frame(width: 50, height: 30, alignment: .center)
                                Text(typeInitial(emptype: employee.employeeType)).frame(width: 40, height: 30, alignment: .center)
                                Text(checkReply(employee: employee)).frame(width: 90, height: 30, alignment: .leading)
                                
                            }
                        }
                        
                        
                    }
                }
                
                
            }
        }
    }
    
    
    func checkReply(employee: Employee) -> String{
        if emergency.arrived.contains(employee.id){
            return "arrived"
        }else
        if emergency.replied[true]!.contains(employee.id){
            return "accepted"
        } else if emergency.replied[false]!.contains(employee.id){
            return "rejected"
        }
        return "not replied"
    }
    
}

struct GalleryWithEmergencies: View{
    
    var vm: VM_DB
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
                                
                                WhenClicked(loggedin: $loggedin, vm: vm, emergency: emergency)
                                
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
                    
                }.onAppear {
                    vm.getData()
                }
            }
        }
    }
}

struct ListWithEmergencies: View{
    
    var vm: VM_DB
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
                            WhenClicked(loggedin: $loggedin, vm: vm, emergency: emergency)
                        } label: {
                            
                            Divider().frame(height:70)
                            
                            
                            Text(emergency.details).frame(width: 160, height: 80, alignment: .top)
                                .multilineTextAlignment(.center)
                            
                            
                            Divider().frame(height:70)
                            
                            VStack(alignment: .leading){
                                
                                Text(String(emergency.employeesCalled.count)).frame(width: 100,height: 5)
                                
                                Divider().frame(width: 100, height:1)
                                
                                Text(String(emergency.replied[true]!.count)).frame(width:100, height: 5)
                                
                                Divider().frame(width: 100, height: 1)
                                
                                Text(String(emergency.arrived.count)).frame(width:100, height:5)
                            }
                            
                            
                            
                            
                        }
                    }
                    Divider()
                }
            }.onAppear {
                vm.getData()
            }
        }
    }
}




struct Recent_Emergencies: View {
    @Binding var loggedin: Employee
    
    var vm: VM_DB
    
    @State var search = ""
    @State var viewType = "list"
    
    var body: some View {
        VStack{
            HStack{
                
                
                vm.Search
                
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
                ListWithEmergencies(vm: vm, loggedin: $loggedin)
            }
            else if viewType == "photo"{
                GalleryWithEmergencies(vm: vm, loggedin: $loggedin)
            }
        }
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
                
                EditEmergency(emergency: emergency, vm: vm, nEDetails: emergency.details, nELocation: emergency.location, nEMP: emergency.meetingPoint, nEUrgency: emergency.urgency, casualties: emergency.casualties, injuries: emergency.injuries, docID: emergency.id ?? "")
                //Edit Emergency
            }label: {
                Text("Edit").frame(width: 40, height: 30, alignment: .trailing)
                Image(systemName: "pencil").resizable()
                    .frame(width: 30, height: 30, alignment: .center)
                    .padding()
            }
        }.popover(isPresented: $forwardPopUp) {
            Text("Show Employees")
            
            // add a list of all employees so you can select
            
            
        }
        
    }
    
    
    
}
