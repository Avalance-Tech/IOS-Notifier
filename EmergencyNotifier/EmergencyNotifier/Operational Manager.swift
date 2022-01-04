//
//  Operational Manager.swift.swift
//  Emergency Notifier
//
//  Created by Adnan Odimah on 02/01/2022.
//

import SwiftUI




struct Home_OperationalManager: View{
    
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
            Button( action: {
                
                print("Hhello")
                
            }, label:{
                Text("Assign Operational Manager")
                    .underline()
                    .padding(.vertical, 15)
                    .padding(.horizontal, 10)
                    .foregroundColor(Color.blue)
                    .font(.system(size: 20, design: .rounded))
            })
            
            
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





struct Main_OperationalManager: View {
    
    var body: some View {

            VStack{
                NavigationView{
                    
                    Home_OperationalManager()
                        .navigationTitle("Emergency Link")
                    
                    
                }.opacity(0.9)
                
            
        }
    }
}

struct Operational_Manager_swift_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Main_OperationalManager()
            Main_OperationalManager()
                .previewDevice("iPhone 12")
        }
    }
}
