//
//  LoadingPage.swift
//  Emergency Notifier
//
//  Created by Adnan Odimah on 19/07/2022.
//

import SwiftUI

struct LoadingPage: View {
    var body: some View {
        VStack{
            Spacer()
            Text("Loading...")
            Image(systemName: "arrow.clockwise")
            Spacer()
        }
    }
}

struct LoadingPage_Previews: PreviewProvider {
    static var previews: some View {
        LoadingPage()
    }
}
