import SwiftUI

struct TeamHead: View{
    @EnvironmentObject var vm: dataViewModel
    
    @State var actingPopUp = false
    
    
    var actingList: [Employee] {
        vm.allEmployees.filter { Employee in
            Employee.employeeType == "Deputy Team Head"
        }
    }
    var currentActing: [Employee]{
        
        return vm.allEmployees.filter({Employee in
            Employee.employeeType == "Acting Team Head"
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
            if vm.account.employeeType == "Team Head"{
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
                            emp.employeeType = "Deputy Team Head"
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
            
        }.popover(isPresented: $actingPopUp){actingTHPopUp}
        
    }
    
}


extension TeamHead{
    
    var actingTHPopUp: some View{
        VStack(spacing: 10){
            ScrollView {
                ForEach(actingList){ emp in
                    
                    Button {
                        emp.employeeType = "Acting Team Head"
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

