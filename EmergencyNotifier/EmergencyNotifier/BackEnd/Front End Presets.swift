//
//  Front End Presets.swift
//  EmergencyNotifier
//
//  Created by Adnan Odimah on 04/01/2022.
//

import SwiftUI

var BottomMenu: some View{
    VStack(spacing: 10){
    

    Image("Avala_logo")
        .resizable()
        .frame(width: 40, height: 40, alignment: .bottom)
    
    Text("Made by \n Avalanche Tech")
        .font(.system(size: 15, weight: .light, design: .rounded))
        .multilineTextAlignment(.center)
    
    }.padding(.bottom,15)
}


struct TopMenu: View {
    
    @Binding var loggedin: Employee
    
    var body: some View{
    HStack(spacing:12){
        
        Link(destination: URL(string: "https://www.emiratesfire.ae")!, label:{
        
        Image(systemName: "flame")
            .resizable()
            .frame(width: 30, height: 30, alignment: .center)
            .foregroundColor(Color.red)
            .padding(.leading, 15)
        })
        
        
        Spacer()
        
        // help
        NavigationLink{
            
            
            
        } label: {
            Image(systemName: "questionmark.circle")
                .resizable()
                .frame(width: 30, height: 30, alignment: .center)
                .font(.system(size: 10, weight: .light, design: .rounded))
        }
        
        // profile
        NavigationLink{
            Account(loggedIn: $loggedin).statusBar(hidden: true)
        }
        label: {
            Image(systemName: "person.crop.circle" )
                .resizable()
                .frame(width: 30, height: 30, alignment: .center)
                .font(.system(size: 10, weight: .light, design: .rounded))

        }
        
        
    }.padding(.trailing, 20)
        
    }
}


struct Search_Preset: View{
    
    @Binding var search: String
    
    var body: some View{
        
        Image(systemName: "magnifyingglass")
            .resizable()
            .frame(width: 20, height: 20, alignment: .center)
            .padding(.leading, 10)
            .offset(x: 12)
        Divider().frame(width: 1, height: 20, alignment: .center)
            .offset(x: 8)
        TextField("Search", text: $search)
            .frame(width: 160 ,height: 30)
            .padding(.horizontal, 40)
            .background(Color.gray.opacity(0.3))
            .cornerRadius(10).offset(x:-30)
        
    }
}



