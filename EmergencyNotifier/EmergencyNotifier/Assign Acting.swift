//
//  Assign Acting.swift
//  EmergencyNotifier
//
//  Created by Adnan Odimah on 10/01/2022.
//

import SwiftUI

struct AssignActingMain: View {
    // Properties
    let employee: Employee
    
    var employeetype: String{employee.employeeType}
    
    
    // Body
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Text("Assign Acting \(employeetype)").font(.title)
                Spacer()
            }
            Divider()
            
            
            
        }
    }
    
    // Methods
}


struct Assign_Acting_Previews: PreviewProvider {
    static var previews: some View {
        AssignActingMain(employee: talal)
    }
}
