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


var TopMenu: some View {
    HStack(spacing:12){
        
        Link(destination: URL(string: "https://www.emiratesfire.ae")!, label:{
        
        Image(systemName: "flame")
            .resizable()
            .frame(width: 30, height: 30, alignment: .center)
            .foregroundColor(Color.red)
            .padding(.leading, 15)
        })
        
        
        Spacer()
        
        // Settings
        NavigationLink {
            
            
            
        } label: {
            Image(systemName: "gear")
                .resizable()
                .frame(width: 30, height: 30, alignment: .center)
                .font(.system(size: 10, weight: .light, design: .rounded))
        }
        
        
        // help
        NavigationLink{
            
            
            
        } label: {
            Image(systemName: "questionmark.circle")
                .resizable()
                .frame(width: 30, height: 30, alignment: .center)
                .font(.system(size: 10, weight: .light, design: .rounded))
        }
        
        // profile
        NavigationLink {
            
            
            
        } label: {
            Image(systemName: "person.crop.circle" )
                .resizable()
                .frame(width: 30, height: 30, alignment: .center)
                .font(.system(size: 10, weight: .light, design: .rounded))
        }
        
        
    }.padding(.trailing, 20)
}
