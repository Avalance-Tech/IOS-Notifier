//
//  Recent Emergencies.swift
//  EmergencyNotifier
//
//  Created by Adnan Odimah on 10/01/2022.
//

import SwiftUI
struct WhenClickedEmployee: View{
    
    var employee: Employee
    var replied: String
    
    var body: some View{
        
        HStack{
            
            Text(employee.name)
            
            Text(employee.branch)
            
            Text(employee.employeeType)
            
            if replied == "accepted" || replied == "arrived"{
                
                Image("checkmark.circle.fill")
                
            }
            else if replied == "rejected"{
                Text("Reason")
            }
            else if replied == "not replied"{
                Text("not replied")
            }
            
        }
    }
    
    
}


struct WhenClicked: View{
    
    var emergency: Emergency
    @State var employeePopUp = false
    
    var body: some View{
        
        VStack{
            
            Text("Details:   \(emergency.details)").multilineTextAlignment(.center)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width, alignment: .center)
            
            
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
        if emergency.replied[true]!.contains(employee){
            return "accepted"
        } else if emergency.replied[false]!.contains(employee){
            return "rejected"
        }
        return "not replied"
    }
    
}

struct GalleryWithEmergencies: View{
    
    @StateObject var vm = VM_DB()
    
    @State var showingEmergency = false
    
    var body: some View{
        
        VStack{
            
            ScrollView{
                ForEach(vm.allEmergencies){ emergency in
                    
                    ZStack{
                        Image("").frame(width: UIScreen.main.bounds.width, height: 200, alignment: .center)
                        HStack{
                            
                            NavigationLink{
                                WhenClicked(emergency: emergency)
                            } label: {
                                Spacer()
                                Text(emergency.details)
                                    .foregroundColor(Color.black.opacity(1))
                                    .background(Color.gray.opacity(0.3))
                                Spacer()
                            }

                        }
                    }.onTapGesture {
                        showingEmergency = true
                    }
                    .popover(isPresented: $showingEmergency, content: {
                        
                        VStack{
                            
                            HStack{
                                Text("Meeting Point:\(emergency.meetingPoint)")
                                
                                Text("Location: \(emergency.location)")
                                
                                Text("Time: \(emergency.time)")
                                
                                
                            }
                            
                            HStack{
                                Text(emergency.details)
                                Text("\(emergency.urgency)")
                            }
                            
                            Divider()
                            
                            /*                  ForEach(emergency.checkedIn){image in
                             
                             // Image(image)
                             
                             
                             }
                             */
                            
                            
                            
                        }
                    })
                    .padding(.vertical, 20)
                    .padding(.horizontal, 10)
                }
            }
            
        }
        
    }
}

struct ListWithEmergencies: View{
    
    @StateObject var vm = VM_DB()
    
    
    
    var body: some View{
        
        VStack{
            HStack{
                Text("Location").frame(width: 120, height:50, alignment: .center).font(.title).onAppear {print("\(vm.allEmergencies)")}
                
                Divider().frame(height: 50)
                
                Text("Meeting Point").frame(width: 120, height:50,alignment: .center).font(.system(size: 20))
                    .multilineTextAlignment(.center)
                
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
                    
                    NavigationLink {
                        WhenClicked(emergency: emergency)
                    } label: {
                        
                        HStack{
                            
                            Text("\(emergency.location)").frame(width: 120, height: 50, alignment: .leading).onAppear {
                                print(emergency.details)
                            }
                          
                            Divider().frame(height:50)
                            
                            Text("\(emergency.meetingPoint)").frame(width: 120, height: 50, alignment: .center)
                            
                            Divider().frame(height:50)
                            
                            VStack(alignment: .leading){
                                
                                Text(String(emergency.employeesCalled.count)).frame(width: 100,height: 1)
                                
                                Divider().frame(width: 100, height:1)
                                
                                Text(String(emergency.replied[true]!.count)).frame(width:100, height: 1)
                                
                                Divider().frame(width: 100, height: 1)
                        
                                Text(String(emergency.arrived.count)).frame(width:100, height:1)
                            }
                            
                            
                            
                            
                        }.padding(.horizontal, 10)
                    }
                    Divider()
                }
            }
        }
    }
}




struct Recent_Emergencies: View {
    

    @State var search = ""
    @State var viewType = "list"
    
    var body: some View {
        VStack{
            HStack{
                
                
                Search_Preset(search: $search)
                
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
                ListWithEmergencies()
            }
            else if viewType == "photo"{
                GalleryWithEmergencies()
            }
        }
    }
}

struct Recent_Emergencies_Previews: PreviewProvider {
    static var previews: some View {
        //Recent_Emergencies()
        NavigationView{
            Recent_Emergencies()
        }
    }
}
