//
//  ContentView.swift
//  Emergency Notifier
//
//  Created by Adnan Odimah on 18/12/2021.
//

import SwiftUI

struct HomePage: View {
    
    // Properties
    
    
    var body: some View {
        VStack{  // Big Vstack for the entire page
       
            HStack(alignment: .center, spacing: 100.0){  // Top horizontal stack for menu and title
        
                
                Button { // menu button
            
            print("hi")
            
                } label: {Image(systemName: "list.bullet")
                        
                        .resizable()
                        
                        .frame(width: 20, height: 20)
                        
                        .scaledToFit()
                    
                        .padding(.leading, 50.0)
                    
                    
                        
                    
                }
                
                
                Text("Main")
                
                Spacer()
                
                
                
            }
            .padding(.top, 40.0)
            
            HStack{
                Spacer()
                
                //Toggle("On Call", isOn: <#T##Binding<Bool>#>)
                
                Spacer()
            }
            
            
        Spacer()
        
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
