import SwiftUI

struct login_page{
    
    @StateObject var vm: dataViewModel

	var body: some View{
        ZStack{
            //Background     
            VStack(spacing:20){
                Spacer()
   
            Text("Log In").font(.largeTitle).fontWeight(.bold)
                .padding(.all, 20)
                .padding(.top, 50)
                
                TextField("Employee ID", text: self.$vm.login_id)
                    .padding()
                    .background(Color(red: 239/255, green: 243/255, blue:244/255))
                    .cornerRadius(10)
                    .padding(.bottom, 20)
            
                SecureField("Password", text:   self.$vm.login_password)
                    .padding()
                    .background(Color(red: 239/255, green: 243/255, blue:244/255))
                    .cornerRadius(10)
                    .padding(.bottom, 20)
        
                if(vm.failed && !vm.loggingIn){
                    if !vm.loggingIn{
                    Text("Incorrect Login. Please try again.").foregroundColor(Color.red)
                    }}


            Button {
                //log in

                loggingIn, failed = vm.login(ID: login_id, Password: login_password)
            
                
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
