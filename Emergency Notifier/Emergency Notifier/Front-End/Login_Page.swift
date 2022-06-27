import SwiftUI

struct login_page: View{
    
    @EnvironmentObject var vm: dataViewModel
    
    @State var login_id = ""
    @State var login_password = ""
    
    @AppStorage("ID") var currentUserID: Int?
    @AppStorage("Password") var currentUserPassword: String?

	var body: some View{
        ZStack{
            //Background     
            VStack(spacing:20){
                Spacer()
   
            Text("Log In").font(.largeTitle).fontWeight(.bold)
                .padding(.all, 20)
                .padding(.top, 50)
                
                TextField("Employee ID", text: self.$login_id)
                    .padding()
                    .background(Color(red: 239/255, green: 243/255, blue:244/255))
                    .cornerRadius(10)
                    .padding(.bottom, 20)
            
                SecureField("Password", text:   self.$login_password)
                    .padding()
                    .background(Color(red: 239/255, green: 243/255, blue:244/255))
                    .cornerRadius(10)
                    .padding(.bottom, 20)
        
                if(vm.failed && !vm.loggingIn){
                    Text("Incorrect Login. Please try again.").foregroundColor(Color.red)
                    }
            
            Button {
                //log in
                
                let IDint = Int(self.login_id) ?? -1
            
                let Employee = vm.login(ID: IDint, Password: self.login_password)
                
                if Employee.id != -1{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {  // Create a delay
                        vm.account = Employee
                        vm.loggingIn = false
                        vm.failed = false
                    }
                }
                

                
            } label: {
                Text("Log In").padding(.all, 20)
                    .padding(.horizontal, 20)
                    .foregroundColor(Color.white)
                    .background(Color.blue.opacity(0.99))
                    .cornerRadius(20)
                    
            }.disabled(login_id == "" || login_password == "")

            
            NavigationLink {

                

            } label: {
                Text("Forgot Password?").underline()
            }

         Spacer()
                Spacer()
                
        }.padding() 
		
    if vm.loggingIn{
        Text("Logging in...")
            .font(Font.title.bold())
                    .padding(30)
                    .background(Color.gray.opacity(0.8))
                    .cornerRadius(20)
            }
            
        }
	}
}
