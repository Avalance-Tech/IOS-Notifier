//
//  Front End Presets.swift
//  EmergencyNotifier
//
//  Created by Adnan Odimah on 04/01/2022.
//

import SwiftUI


var BottomMenu: some View{
    VStack(spacing: 10){
        
        
        Image("Avala_logo")
            .resizable()
            .frame(width: 40, height: 40, alignment: .bottom)
        
        Text("Made by \n Avalanche Tech")
            .font(.system(size: 15, weight: .light, design: .rounded))
            .multilineTextAlignment(.center)
        
    }.padding(.bottom,15)
}




struct onCall: View{
    @Binding var status: Bool
    
    var body: some View{
        HStack{
            Spacer()
            Toggle(isOn: $status) {
                Text("On Call")
            }
            Spacer()
        }.padding([.top, .horizontal], 50)
    }
}




struct TopMenu: View {
    
    @Binding var loggedin: Employee
    
    @EnvironmentObject var VM: VM_DB
    
    var body: some View{
        VStack{
            
            HStack{
                Text(loggedin.employeeType)
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding()
                
                Spacer()
            }
            
            HStack(spacing:12){
                
         /*       Link(destination: URL(string: "https://www.emiratesfire.ae")!, label:{
                    
                    Image(systemName: "flame")
                        .resizable()
                        .frame(width: 30, height: 30, alignment: .center)
                        .foregroundColor(Color.red)
                        .padding(.leading, 15)
                })*/
                
                
                Spacer()
                
                // help
                NavigationLink{
                    
                    
                    
                } label: {
                    Image(systemName: "questionmark.circle")
                        .resizable()
                        .frame(width: 30, height: 30, alignment: .center)
                        .font(.system(size: 10, weight: .light, design: .rounded))
                }
                
                // profile
                NavigationLink{
                    Account(loggedIn: $loggedin).statusBar(hidden: true)
                }
            label: {
                Image(systemName: "person.crop.circle" )
                    .resizable()
                    .frame(width: 30, height: 30, alignment: .center)
                    .font(.system(size: 10, weight: .light, design: .rounded))
                
            }
                
                
            }.padding(.trailing, 20)
        }
    }
}
