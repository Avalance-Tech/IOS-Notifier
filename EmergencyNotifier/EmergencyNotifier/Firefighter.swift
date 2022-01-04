//
//  Main Page Firefighter.swift
//  Emergency Notifier
//
//  Created by Ayman Omarsaalah on 02/01/2022.
//

import SwiftUI

struct Home_Firefighter: View {
    
    
    @State var onCall = false
    
    
    var body: some View {
        

        
        VStack(spacing: 25 ){
            
            TopMenu
            
            
            HStack{
                
                Spacer()
                
                Toggle(isOn: $onCall) {
                Text("On Call")
                    
                }
                
                Spacer()
                
            }.padding([.top, .horizontal], 50)
            
            
            
            // Create Emergency button
            Button( action: {
                
                print("Hhello")
                
            }, label:{
                Text("Report an emergency")
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
            Spacer()
            
            BottomMenu
        }
        
    }
}

struct Main_Page_Firefighter: View {
    @State var menuOpened = false
    
    
    // body
    
    var body: some View {
        ZStack{

        
        
        NavigationView{
            
            Home_Firefighter().navigationTitle("Home")
        
        } // close navi
            
    
        } // close zstack
    } // close body
    
    
    
    // Methods
    
}


struct Main_Page_Firefighter_Previews: PreviewProvider {
    static var previews: some View {
        Main_Page_Firefighter()
    }
}
