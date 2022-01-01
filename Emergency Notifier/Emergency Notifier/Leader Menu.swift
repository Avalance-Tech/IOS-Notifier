//
//  SwiftUIView.swift
//  Emergency Notifier
//
//  Created by Adnan Odimah on 01/01/2022.
//

import SwiftUI




struct LeaderMain: View{
    
// Properties
    
    let employee: Employee
    
    @State var on_call: Bool = false // employee.status  // requests an on call variable
    
    @State var menuOpened: Bool = false
    
// Leader Properties
    
    @State var emergencyDetails = ""
    @State var emergencyLocation = ""
    
    
// Body
    var body: some View{
        ZStack{
            
            
            VStack{ // VStack for the page's actual aspects
                
                
            HStack(alignment: .center){
                
                // Top HStack - Top horizontal stack for menu and title
                    
                Button{ self.menuOpened.toggle() } // Creates a button that toggles the side menu
                    label:{
                                Image(systemName: "list.bullet")  // Makes the button an image
                                    .resizable()
                                    .frame(width: 40, height: 35)
                                    .scaledToFit()
                    }.padding(.horizontal, 20)

                Text("Page Title")
                    .padding(.horizontal,10)
                    .font(.largeTitle)
                        
                        Spacer()
                
            }.padding(.vertical, 50)
                    .padding(.leading, 35)
            
                
                
                VStack{ // Emergency information fields
                    
                    HStack(spacing: 10){
                        Text("Emergency Details")
                        
                        TextField("Test", text: $emergencyDetails, prompt: Text("test")).border(.gray).frame(height: 40)
                        
                    }
                    
                    .onSubmit {
                        print(emergencyDetails)
                    }.padding(.horizontal, 30)
                    
                    
                    
                }
                
                
                
            Spacer()
                
            } // Close Vstack for page's aspects
    
        
        } // Close Zstack
 
    
    }// cloes Body
    
// Methods
    
    
} // Close Leader Main
