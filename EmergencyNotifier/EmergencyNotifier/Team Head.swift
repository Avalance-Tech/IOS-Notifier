//
//  Main Page.swift
//  Emergency Notifier
//
//  Created by Adnan Odimah on 02/01/2022.
//

import SwiftUI

// FOR TEAM HEAD





// Home page for team head

struct Main_TeamHead: View{
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
                Text("Assign Team Head")
                    .underline()
                    .padding(.vertical, 15)
                    .padding(.horizontal, 10)
                    .foregroundColor(Color.blue)
                    .font(.system(size: 20, design: .rounded))
            }).popover(isPresented: $showingAssignPopUp) {
                VStack{
                    Spacer()
                    
                    Text("Are you sure you would like to assign \(deputyTeamHead.name) as the Acting Team Head")
                    TextField("Reason", text: $reason)
                    HStack(spacing: 30){
                        Button {

                            // set acting team head
                            
                        } label: {
                            Text("Yes")
                                .padding(.all, 8)
                                .foregroundColor(Color.red)
                                .border(Color.blue.opacity(0.8))
                        }

                        
                        Button{
                            showingAssignPopUp = false
                        }
                    label: {
                        Text("No")
                    
                        .padding(.all, 8)
                        .foregroundColor(Color.green)
                        .border(Color.blue.opacity(0.8))
                    }
                    }
                    Spacer()
                    
                    
                }
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


// MAIN PAGE


struct MainPage_TeamHead: View {
    // Properties

    
    // body
    
    var body: some View {
        ZStack{
                
                
                NavigationView{
                    
                    Main_TeamHead().navigationTitle("Emergency Link")
                    
                } // close navi
                
            
        } // close zstack
    } // close body
    
    
    
    // Methods
    

    
}




struct MainPreview_TeamHead: PreviewProvider {
    static var previews: some View {
        MainPage_TeamHead()
    }
}
