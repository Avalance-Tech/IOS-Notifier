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


struct WhenClicked: View{
    
    var emergency: Emergency
    @State var employeePopUp = false
    
    var body: some View{
        
        VStack{
            HStack{
                Spacer()
                NavigationLink{
                    //Edit Emergency
                }label: {
                    Text("Edit").frame(width: 30, height: 30, alignment: .center)
                    Image(systemName: "pencil").resizable()
                        .frame(width: 30, height: 30, alignment: .center)
                        .padding()
                }
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
                    }
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
