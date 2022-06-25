import SwiftUI

struct TeamHead: View{
	@EnvironmentObject var vm: dataViewModel

	var body: some View{

VStack{
	vm.TopMenu

	Spacer()

	onCall(vm: vm)
    
    reportEmergency
	
	Spacer()
    Spacer()

}

	}

}
