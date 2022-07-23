import SwiftUI

struct Supervisor: View{
    @EnvironmentObject var vm: dataViewModel
    @State var actingPopUp = false
    
    var actingList: [Employee] {
        vm.allEmployees.filter { Employee in
            Employee.employeeType == "Assistant Supervisor"
        }
    }
    var currentActing: [Employee]{
        
        return vm.allEmployees.filter({Employee in
            Employee.employeeType == "Acting Supervisor"
        })
    }
    var body: some View{
        
        VStack(spacing:10){
            vm.TopMenu
            
            Spacer()
            
            onCall()
            
            reportEmergency
            
            accountManagement
            
            // TODO: acting
            if vm.account.employeeType == "Supervisor"{
                if currentActing.isEmpty{
                    Button {
                        actingPopUp = true
                    } label: {
                        Text("Assign Acting")
                            .underline()
                            .padding(.vertical, 15)
                            .padding(.horizontal, 10)
                            .font(.system(size: 20, design: .rounded))
                    }} else if !currentActing.isEmpty{
                        Button{
                            let emp = currentActing[0]
                            emp.employeeType = "Assistant Supervisor"
                            vm.updateEmployee(employee: emp)
                        } label: {
                            Text("Remove Acting")
                                .underline()
                                .padding(.vertical, 15)
                                .padding(.horizontal, 10)
                                .font(.system(size: 20, design: .rounded))
                        }
                    }
            }
            
            recentEmergencies
            
            Spacer()
            Spacer()
            
            BottomMenu
            
        }.popover(isPresented: $actingPopUp){actingSVPopUp}
        
    }
    
}


extension Supervisor{
    
    var actingSVPopUp: some View{
        VStack(spacing: 10){
            ScrollView {
                ForEach(actingList){ emp in
                    
                    Button {
                        emp.employeeType = "Acting Supervisor"
                        vm.updateEmployee(employee: emp)
                        actingPopUp = false
                    } label: {
                        HStack {
                            Spacer()
                            
                            Text(String(emp.id))
                            
                            Spacer()
                            
                            Text(emp.name)
                            
                            Spacer()
                            
                            Text(emp.branch)
                            
                            Spacer()
                        }}
                    Divider()
                }
                
            }
        }
    }
}
