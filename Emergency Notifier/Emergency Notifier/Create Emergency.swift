//
//  Create Emergency.swift
//  Emergency Notifier
//
//  Created by Adnan Odimah on 02/01/2022.
//

import SwiftUI

struct Create_Emergency: View {
    
   // @State var employee: Employee
    
    
    let shownEmployees: Array<Employee> = [
    Employee(name: "ayman", number: "0578432058", status: false, branch: rak, employeeType: "firefighter"),
    Employee(name: "adnan", number: "07405074600", status: true, branch: uaq, employeeType: "assistant supervisor")
    ]
    
    
    // Emergency Properties
    
    @State var emergencyDetails: String = ""
    @State var emergencyLocation: String = ""
    @State var emergencyUrgency = 1
    @State var emergencyDate: Date = Date()
    
    
    var body: some View {
        
        VStack(spacing: 20){
            
            
            // Emergency Details
            HStack(spacing: 10){
                Text("Details")
                TextField(" Emergency Details", text: $emergencyDetails)
                    .background(Color.gray.opacity(0.1).cornerRadius(10))
                
            }
            
            //Emergency Location
            HStack(spacing: 10){
                Text("Location")
                TextField("Emergency Location", text: $emergencyLocation)
                    .background(Color.gray.opacity(0.1).cornerRadius(10))
            }
            
            HStack(spacing: 10){
                Stepper(value: $emergencyUrgency, in: 1...5) {
                Text("Urgency:")
                    Text(String(emergencyUrgency))
            }
            }
            
            HStack(spacing: 10){
                
                DatePicker(selection: $emergencyDate, label: { Text("Time") })
                
            }
            
            Divider()
             
            
            ScrollView{
                ForEach(shownEmployees, id: \.id) { employee in
                    
                    HStack(spacing: 20){
                        
                        Text(employee.name)
                        
                        //  Spacer()
                        
                        Image(employee.status ? "checkmark.circle.fill" : "circle.slash")
                        
                        Text(employee.branch.name)
                        
                        Text(employee.employeeType ).multilineTextAlignment(.center
                        )
                        
                    } .frame(width: UIScreen.main.bounds.width)
                    
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
        }.padding(.all, 20)
    }
}




struct Create_Emergency_Previews: PreviewProvider {
    static var previews: some View {
        Create_Emergency()
    }
}


