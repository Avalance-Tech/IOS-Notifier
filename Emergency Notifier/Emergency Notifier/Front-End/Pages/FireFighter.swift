import SwiftUI

struct Main_FireFighter: View {
    
    @StateObject var vm: dataViewModel
	
    
    var body: some View {
        
        VStack(spacing: 25 ){
            
            vm.TopMenu
            
            Spacer()
            
            onCall(vm: vm)
            
            // Recent Emergencies
            vm.recentEmergencies
            
            Spacer()
            Spacer()
            
            BottomMenu
            
        }
    }
}
