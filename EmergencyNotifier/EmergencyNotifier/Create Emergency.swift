//
//  Create Emergency.swift
//  Emergency Notifier
//
//  Created by Adnan Odimah on 02/01/2022.
//

import SwiftUI


struct showSelected: View{
    
    let employee: Employee
    
    @Binding var selectedItems: Set<UUID>
    
    var isSelected: Bool{
    
        selectedItems.contains(employee.id)
        
    }
    	 
    
    
    var body: some View{
        
        HStack(spacing: 10){
            
            Text(String(employee.name).capitalized(with: .current))
                .frame(width:130, height: 30, alignment: .leading)
                .padding(.leading, 20)
            
            
            Image(employee.status ? "checkmark.circle.fill" : "circle.slash")
                .frame(width:15, height: 30, alignment: .leading)
            
            Text(employee.branch.name)
                .frame(width:130, height: 30, alignment: .leading)

            Text(typeinitial(emptype: employee.employeeType)).font(.system(size: 15,weight: .light))
                .frame(width: 40, height: 30)
     
            if self.isSelected{
            Image(systemName:"checkmark")
                .foregroundColor(Color.blue)
                .frame(width: 20, height: 30)
            }else{
                Text("").frame(width: 20, height: 30)
            }
            Spacer()
        }.onTapGesture {
            if self.isSelected{
                self.selectedItems.remove(self.employee.id)
            } else{
                self.selectedItems.insert(self.employee.id)
            }
        }.border(Color.gray.opacity(self.isSelected ? 1 : 0))
            .shadow(color: Color.black.opacity(self.isSelected ? 0.4 : 0), radius: 2, x: 2, y: 2)
    }
    
    
    
    func typeinitial(emptype: String) -> String{
        
        if emptype == "Team Head"{
                return "T.H."
        }
        else if emptype == "Fire Fighter"{
            return "F.F."
        }
        else if emptype == "Supervisor"{
            return "S.V."
        }
        else if emptype == "Operational Manager"{
            return "O.M."
        }
        else if emptype == "Deputy Team Head"{
            return "D.T.H"
        }
        else if emptype == "Assistant Supervisor"{
            return "A.S."
        }
        else{
            return "Error"
        }
        
    }
    
}


struct Create_Emergency: View {
    
   // @State var employee: Employee
    
    
    let shownEmployees: Array<Employee> = [
    adnan,
    talal,
    ayman,
    wassim
    ]
    
    
    // Emergency Properties
    
    @State var emergencyDetails: String = ""
    @State var emergencyLocation: String = ""
    @State var emergencyUrgency = 1
    @State var emergencyDate: Date = Date()
    
    
    @State var selectedEmployeesID = Set<UUID>()
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
            
            Divider()
             
            
            ScrollView{
                ForEach(shownEmployees) {Employee in
                    
                showSelected(employee: Employee, selectedItems: $selectedEmployeesID)
                
                }
            }

        
        // Submit Button
        HStack{
            Spacer()
            Button(action: {
                
                
                print(emergencyDetails)
                print(emergencyDate)
                print(emergencyLocation)
                print(emergencyUrgency)
                
                print(shownEmployees)
                
                
            }, label:
                    {
                Text("Submit")
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .foregroundColor(.black)
                    .background(RoundedRectangle(cornerRadius: 5))
            
            
            }
            )


        }
        }
    }

    
}




struct Create_Emergency_Previews: PreviewProvider {
    static var previews: some View {
        Create_Emergency()
    }
}


