import SwiftUI

struct TeamHead: View{
	@EnvironmentObject var vm: dataViewModel

	var body: some View{

VStack(spacing:10){
	vm.TopMenu

	Spacer()

	onCall()
    
    reportEmergency

	accountManagement

	// TODO: acting

	recentEmergencies
	
	Spacer()
    Spacer()
	
	BottomMenu

}

	}

}
