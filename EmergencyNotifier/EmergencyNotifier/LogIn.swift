//
//  LogIn.swift
//  EmergencyNotifier
//
//  Created by Adnan Odimah on 14/01/2022.
//

import SwiftUI



struct Main_LogIn: View{
    
    @StateObject var employees = EmployeesVM()

    
    @Binding var loggedin: Employee
    
    @State var id = ""
    
    @State var password = ""
    
    @State var failed = false
    @State var loggingIn = false
    
    var body: some View {
        ZStack{
            VStack{
            
            Text("Log In").font(.largeTitle).fontWeight(.bold)
                .padding(.all, 20)
            
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
                
                    print(employee.id)
                    print(employee.password)
                    
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

                        
        }.padding()
            if loggingIn{
                Text("Success! Logging In")
                    .padding()
                    .padding()
                    .background(Color(red: 140/255, green: 150/255, blue: 160/255, opacity: 0.8))
                    .foregroundColor(Color.white)
                    .cornerRadius(20)
                    .font(.title)
                
            }
        }
    }
    
}


struct LogIn_Main: View {
    
    @Binding var loggedin: Employee
    
    
    var body: some View{
        NavigationView{
        Main_LogIn(loggedin: $loggedin).navigationBarHidden(true)
    }
    }
}

/*
struct LogIn_Previews: PreviewProvider {
    static var previews: some View {
        

           LogIn_Main(loggedin: )
        
    
    }
}
*/
