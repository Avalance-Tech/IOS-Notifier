//
//  LogIn.swift
//  EmergencyNotifier
//
//  Created by Adnan Odimah on 14/01/2022.
//

import SwiftUI



struct Main_LogIn: View{
    
    @StateObject var employees =  VM_DB()

    
    @Binding var loggedin: Employee
    
    @State var id = ""
    
    @State var password = ""
    
    @State var failed = false
    @State var loggingIn = false
    
    var body: some View {
        ZStack{
            
            //Background
        
            
            VStack(spacing:20){
                Spacer()
            
            Text("Log In").font(.largeTitle).fontWeight(.bold)
                .padding(.all, 20)
                .padding(.top, 50)
            
            TextField("Employee ID ", text: $id)
                .padding()
                .background(Color(red: 239/255, green: 243/255, blue:244/255))
                .cornerRadius(10)
                .padding(.bottom, 20)
            
            
        SecureField("Password", text: $password)
                .padding()
                .background(Color(red: 239/255, green: 243/255, blue:244/255))
                .cornerRadius(10)
                .padding(.bottom, 20)
        
                if(failed && !loggingIn){
                    if !loggingIn{
                    Text("Incorrect Login. Please try again.").foregroundColor(Color.red)
                    }}
                
                
                
            Button {
                //log in
                
                for employee in employees.allEmployees{
            
                    
                    if employee.id == Int(id){

                        if employee.password == password{
                            
                            
                            
                            loggedin = employee
                            loggingIn = true
                            
                        }
                        
                    }
                
                }
                if loggedin == notLoggedIn{
                    failed = true
                }
            
                
            } label: {
                Text("Log In").padding(.all, 20)
                    .padding(.horizontal, 20)
                    .foregroundColor(Color.white)
                    .background(Color.blue.opacity(0.99))
                    .cornerRadius(10)
                    
            }

            
            NavigationLink {

                

            } label: {
                Text("Forgot Password?").underline()
            }

         Spacer()
                Spacer()
                
        }.padding()
            
            
            
        }
    }
    
}




