//
//  Operational Manager.swift.swift
//  Emergency Notifier
//
//  Created by Adnan Odimah on 02/01/2022.
//

import SwiftUI




struct Main_OperationalManager: View{
    
    @State var showingAssignPopUp = false
    @State var reason = ""
    
    var body: some View{
        
        VStack{
            
            TopMenu
            
            
            Spacer()
            // Create Emergency button
            
            NavigationLink {
                
                Create_Emergency()
                
            }label:{
                Text("Report an emergency")
                    .underline()
                    .padding(.vertical, 15)
                    .padding(.horizontal, 10)
                    .foregroundColor(Color.blue)
                    .font(.system(size: 20, design: .rounded))
            }
            
            
            // Create account Button
            NavigationLink{
                
                MainAccountsMenu()
                
            }label:{
                Text("Create/edit/delete an account")
                
                    .underline()
                    .padding(.vertical, 15)
                    .padding(.horizontal, 10)
                    .foregroundColor(Color.blue)
                    .font(.system(size: 20, design: .rounded))
                
            }
            
            // Assign Acting Team Head button
            Button(action: {
                
                showingAssignPopUp = true
                
            }, label:{
                Text("Assign Operational Manager")
                    .underline()
                    .padding(.vertical, 15)
                    .padding(.horizontal, 10)
                    .foregroundColor(Color.blue)
                    .font(.system(size: 20, design: .rounded))
            }).popover(isPresented: $showingAssignPopUp) {
                    // add a selection from a list of team heads
            }
            
            
            // Recent Emergencies
            
            Button(action:{
                
                print("test")
                
            },label: {
                Text("Previous emergencies")
                    .underline()
                    .padding(.vertical, 15)
                    .padding(.horizontal, 10)
                    .font(.system(size: 20, design: .rounded))
                
            })
            
            
            
            Spacer()
            
            BottomMenu
            
        }
    }
}





struct MainPage_OperationalManager: View {
    
    var body: some View {
        
        VStack{
            NavigationView{
                
                Main_OperationalManager()
                    .navigationTitle("Emergency Link")
                
                
            }
        }
    }
}

struct Operational_Manager_swift_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainPage_OperationalManager()
            MainPage_OperationalManager()
                .previewDevice("iPhone 12")
        }
    }
}
