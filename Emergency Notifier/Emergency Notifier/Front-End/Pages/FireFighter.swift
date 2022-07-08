import SwiftUI

struct FireFighter: View {
    
    @EnvironmentObject var vm: dataViewModel
	
    
    var body: some View {
        
        VStack(spacing: 25 ){
            
            vm.TopMenu
            
            Spacer()
            
            onCall()
            
            // Recent Emergencies
            vm.recentEmergencies
            
            Spacer()
            Spacer()
            
            BottomMenu
            
        }
    }
}
