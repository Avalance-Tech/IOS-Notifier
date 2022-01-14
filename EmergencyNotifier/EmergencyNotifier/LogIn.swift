//
//  LogIn.swift
//  EmergencyNotifier
//
//  Created by Adnan Odimah on 14/01/2022.
//

import SwiftUI

struct LogIn_Main: View {
    
    @State var phoneNumber = ""
    
    @State var password = ""
    
    var body: some View {
        
        VStack{
            TextField(" Phone Number", text: $phoneNumber)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .border(Color.gray.opacity(0.6))
        SecureField(" Password", text: $password)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .border(Color.gray.opacity(0.6))
        
            Button {
                //log in
            } label: {
                Text("Log In").padding(.all, 10)
                    .foregroundColor(Color.white)
                    .background(RoundedRectangle(cornerRadius: 10))
            }

                        
        }.padding(.all, 20)
    }
    
    
}

struct LogIn_Previews: PreviewProvider {
    static var previews: some View {
        LogIn_Main()
    }
}
