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
            
            HStack(spacing:12){Spacer()
                
                // Settings
                NavigationLink {
                    
                    	
                    
                } label: {
                    Image(systemName: "gear")
                        .resizable()
                        .frame(width: 30, height: 30, alignment: .center)
                }

                
                // help
                NavigationLink{
                    
                    
                
                } label: {
                    Image(systemName: "questionmark.circle")
                        .resizable()
                        .frame(width: 30, height: 30, alignment: .center)
                        
                }
                
                // profile
                NavigationLink {
                    
                    
                    
                } label: {
                    Image(systemName: "person.crop.circle" )
                        .resizable()
                        .frame(width: 30, height: 30, alignment: .center)
                }

                
            }.padding(.trailing, 20)
            
            
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
        Button( action: {
            
        print("Hhello")
    
        }, label:{
        Text("Create/edit/delete an account")
        
            .underline()
            .padding(.vertical, 15)
            .padding(.horizontal, 10)
            .foregroundColor(Color.blue)
            .font(.system(size: 20, design: .rounded))
        
    })
            
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

            Image("Avala_logo")
                .resizable()
                .frame(width: 40, height: 40, alignment: .bottom)

            Text("Made by \n Avalanche Tech")
                .font(.system(size: 15, weight: .light, design: .rounded))
                .multilineTextAlignment(.center)
        }
    }
}



struct Main_OperationalManager: View {

    var body: some View {
    
        ZStack{
                
                NavigationView{
                    
                    Home_OperationalManager()
                        .navigationTitle("Home")
                    
        }
    
    }
    
  }
}
struct Operational_Manager_swift_Previews: PreviewProvider {
    static var previews: some View {
        Main_OperationalManager()
            .preferredColorScheme(.dark)
    }
}
