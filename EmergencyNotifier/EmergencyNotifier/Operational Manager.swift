//
//  Operational Manager.swift.swift
//  Emergency Notifier
//
//  Created by Adnan Odimah on 02/01/2022.
//

import SwiftUI


var TopMenu: some View {
    HStack(spacing:12){
        
        Image(systemName: "flame")
            .resizable()
            .frame(width: 30, height: 30, alignment: .center)
            .foregroundColor(Color.red)
            .padding(.leading, 15)
        
        Spacer()
        
        // Settings
        NavigationLink {
            
            
            
        } label: {
            Image(systemName: "gear")
                .resizable()
                .frame(width: 30, height: 30, alignment: .center)
                .font(.system(size: 10, weight: .light, design: .rounded))
        }
        
        
        // help
        NavigationLink{
            
            
            
        } label: {
            Image(systemName: "questionmark.circle")
                .resizable()
                .frame(width: 30, height: 30, alignment: .center)
                .font(.system(size: 10, weight: .light, design: .rounded))
        }
        
        // profile
        NavigationLink {
            
            
            
        } label: {
            Image(systemName: "person.crop.circle" )
                .resizable()
                .frame(width: 30, height: 30, alignment: .center)
                .font(.system(size: 10, weight: .light, design: .rounded))
        }
        
        
    }.padding(.trailing, 20)
}


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
        
            BottomMenu

        }
    }
}


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


struct Main_OperationalManager: View {
    
    var body: some View {
        
        ZStack{
            
            Image(systemName: "fire")
                .resizable()
                .frame(width: 50, height: 50, alignment: .center)
                .foregroundColor(Color.red)
                .offset(x:-30, y:-100)
            
            VStack{
                NavigationView{
                    
                    Home_OperationalManager()
                        .navigationTitle("Emergency Link")
                    
                    
                }.opacity(0.9)
                
            }
        }
    }
}

struct Operational_Manager_swift_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Main_OperationalManager()
                .preferredColorScheme(.dark)
            Main_OperationalManager()
                .preferredColorScheme(.dark)
        }
    }
}
