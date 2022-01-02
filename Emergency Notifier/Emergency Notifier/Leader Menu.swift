//
//  SwiftUIView.swift
//  Emergency Notifier
//
//  Created by Adnan Odimah on 01/01/2022.
//

import SwiftUI




struct LeaderMain: View{
    
// Properties
    @Environment (\.colorScheme) var colorScheme
    
    let employee: Employee
    
    @State var on_call: Bool = false // employee.status  // requests an on call variable
    
    @State var menuOpened: Bool = false
    
// Emergency Properties
    
    @State var emergencyDetails = ""
    @State var emergencyLocation = ""
    @State var urgency = 1
    
    
// Body
    var body: some View{
        ZStack{
            if !menuOpened{
            
            VStack{ // VStack for the page's actual aspects
                
        
                VStack{
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
                
                
                
            }.padding(.top, 50)
            .padding(.leading, 35)
            .padding(.bottom, 20)
                    
                    Divider() }.padding(.bottom, 20)
                
            
                HStack{
                    Text("New Emergency").font(.system(size:25)).underline().padding(.horizontal, 20)
                        Spacer()
                }
                
                
                
                VStack{ // Emergency information fields
                    
                    
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
                        Stepper(value: $urgency, in: 1...5) {
                        Text("Urgency:")
                            Text(String(urgency))
                    }
                    }
                    
                    // Submiyt Button
                    HStack{
                        Spacer()
                        Button(action: {
                            
                            
                            print(emergencyDetails)
                            
                            
                            
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
                
                    Divider().padding(.vertical, 20)
                    
                }.padding(.all, 10)  // end of emergency information
                
                
                
            Spacer()
                
                
            } // Close Vstack for page's aspects
    
            }
            
            SideMenu(width: UIScreen.main.bounds.width/1.5, menuOpened: menuOpened, toggleMenu: self.toggleMenu)
                
        } // Close Zstack
        
    
    }// close Body
    
// Methods
    
    func toggleMenu(){
        self.menuOpened.toggle()
    }
    
    
} // Close Leader Main



