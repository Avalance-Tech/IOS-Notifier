import SwiftUI

// Front End presets for Model View View-Model

/* :#Presets for;
		- Search Bar
		- Filter Dropdown View
		- Sort Dropdown View

		- Account Page
*/

extension dataViewModel{
    var Search: some View{
        HStack{

        Image(systemName: "magnifyingglass")
            .resizable()
            .frame(width: 20, height: 20, alignment: .center)
            .padding(.leading, 10)
            .offset(x: 12)


        Divider().frame(width: 1, height: 20, alignment: .center)
            .offset(x: 8)


            /*      TextField("Search", text: $search)
            .frame(width: 160 ,height: 30)
            .padding(.horizontal, 40)
            .background(Color.gray.opacity(0.3))
            .cornerRadius(10).offset(x:-30)*/
        }}
    
	var filterView: some View{

		ZStack{
		HStack{
			
		Spacer()

		Menu("Status"){ // Dropdown Menu where they can filterRules through the Status 
			if !filters.contains(where: { filterModel in
				filterModel.filterRules == "Available"}){
				Button { self.filters.append(filterModel(type: "Status", filterRules: "Available")) } label: { Text("Available") }}
								
			if !filters.contains(where: { filterModel in
				filterModel.filterRules == "Unavailable"}){
				Button { self.filters.append(filterModel(type: "Status", filterRules: "Unavailable")) } label: { Text("Unavailable") 
				}}
			}.frame(width: 180, height: 30, alignment: .center)
		Spacer()

		Menu("Branch") { // Dropdown Menu where they can filterRules through the Branches

			if !filters.contains(where: { filterModel in
				filterModel.filterRules == "Dubai"}){
				Button { self.filters.append(filterModel(type: "Branch", filterRules: "Dubai")) } label: { Text("Dubai") }}
			
			if !filters.contains(where: { filterModel in
				filterModel.filterRules == "Abu Dhabi"}){
				Button { self.filters.append(filterModel(type: "Branch", filterRules: "Abu Dhabi")) } label: { Text("Abu Dhabi") }}
			
			if !filters.contains(where: { filterModel in
				filterModel.filterRules == "Fujairah"}){
				Button { self.filters.append(filterModel(type: "Branch", filterRules: "Fujairah")) } label: { Text("Fujairah") }}
			
			if !filters.contains(where: { filterModel in
				filterModel.filterRules == "Umm Al-Quwain"}){
				Button { self.filters.append(filterModel(type: "Branch", filterRules: "Umm Al-Quwain")) } label: { Text("Umm Al-Quwain") }}
			
			if !filters.contains(where: { filterModel in
				filterModel.filterRules == "Ras AL Khaimah"}){
				Button { self.filters.append(filterModel(type: "Branch", filterRules: "Ras Al Khaimah")) } label: { Text("Ras Al Khaimah") }}
			
			if !filters.contains(where: { filterModel in
				filterModel.filterRules == "Sharjah"}){
				Button { self.filters.append(filterModel(type: "Branch", filterRules: "Sharjah")) } label: { Text("Sharjah") }}
			
			if !filters.contains(where: { filterModel in
				filterModel.filterRules == "Ajman"}){
				Button { self.filters.append(filterModel(type: "Branch", filterRules: "Ajman")) } label: { Text("Ajman") }}
			}.frame(width: 180, height: 30, alignment: .center)
							

		Spacer()}
				

		HStack{
		Spacer()

		Menu("Employee Type") { // Dropdown Menu where they can filterRules through the Type
				
			if !filters.contains(where: { filterModel in
				filterModel.filterRules == "Fire Fighter"}){
				Button { self.filters.append(filterModel(type: "Employee Type", filterRules: "Fire Fighter")) } label: { Text("Fire Fighter") }}
			
			if !filters.contains(where: { filterModel in
				filterModel.filterRules == "Assistant Supervisor"}){
				Button { self.filters.append(filterModel(type: "Employee Type", filterRules: "Assistant Supervisor")) } label: { Text("Assistant Supervisor") }}
			
			if !filters.contains(where: { filterModel in
				filterModel.filterRules == "Supervisor"}){
				Button { self.filters.append(filterModel(type: "Employee Type", filterRules: "Supervisor")) } label: { Text("Supervisor") }}
			
			if !filters.contains(where: { filterModel in
				filterModel.filterRules == "Deputy Team Head"}){
				Button { self.filters.append(filterModel(type: "Employee Type", filterRules: "Deputy Team Head")) } label: { Text("Deputy Team Head") }}
			
			if !filters.contains(where: { filterModel in
				filterModel.filterRules == "Team Head"}){
				Button { self.filters.append(filterModel(type: "Employee Type", filterRules: "Team Head")) } label: { Text("Team Head") }}
			}.frame(width: 180, height: 30, alignment: .center)
													
		Spacer()
				
		}

		ScrollView(.horizontal){
			if filters.isEmpty{
				VStack(alignment: .center){
				Text("No filters Selected").padding(.horizontal, 20)
				}}

			else if !filters.isEmpty{
				HStack(spacing: 0){
					ForEach(filters) { filter in
										
				Text(filter.filterRules)
							.padding(.trailing, 25)
							.padding([.leading, .top, .bottom], 10)
							.background(Color.gray.opacity(0.3))
							.cornerRadius(30)
				Image(systemName: "xmark")
							.offset(x: -20)
							.onTapGesture {
								self.filters.removeAll { filterModel in
									filterModel.filterRules == filter.filterRules
								}
							}
					}
				}.padding(.leading, 10)
			}
		}}}

    

	var sortView: some View{
        VStack{
            
			Button {
                self.sort = "Name"
                self.ascending.toggle()
            } label: {
                HStack{
                    Text("Name")
                    Image(systemName: ascending && sort == "Name" ? "chevron.down" : "chevron.up")
                }
            }
            
            Button {
                self.sort = "Id"
                self.ascending.toggle()
            } label: {
                HStack{
                    Text("Employee ID")
                    Image(systemName: ascending && sort == "Id" ? "chevron.down" : "chevron.up")
                }}
            
            Button {
                self.sort = "Status"
                self.ascending.toggle()
            } label: {
                HStack{ 
                    Text("Status")
                    Image(systemName: ascending && sort == "Status" ? "chevron.down" : "chevron.up")
                }
            }
            
            Button{
                self.sort = "Branch"
                self.ascending.toggle()
            } label: {
                HStack{
                    Text("Branch")
                    Image(systemName: ascending && sort == "Branch" ? "chevron.down" : "chevron.up")
                }
            }
            
            Button{
                self.sort = "Role"
                self.ascending.toggle()
            } label: {
                HStack{
                    Text("Employee Type")
                    Image(systemName: ascending && sort == "Role" ? "chevron.down" : "chevron.up")
                }
            }
        }}


    var accountView: some View{
        Account(vm: self)
    }
}

// Account Structure

struct Account: View {
    
    var vm: dataViewModel
    
    @State var currentPassword = ""
    @State var newPassword = ""
    @State var newPassword2 = ""
    
    @State var AlertContent = ""
    
    @State var showPop = false
    
    var check: Bool {
        if newPassword == "" || newPassword2 == "" || currentPassword == ""{
            return false
        }
        return true
    }
}


extension Account{

    var body: some View {
        VStack(spacing: 20){
        
            NavigationLink{
                // TODO: add functionality for profile pic
            }
        	label: {
            	Image(systemName: "person.circle.fill").resizable().frame(width: 100, height: 100, alignment: .center).padding()
            }
            
            HStack{
                Text(vm.account.name)
            Image(systemName: "pencil") // TODO: edit name (MAYBE)
            }
         
            Button {showPop = true} label: {Text("Change Password").underline()}.padding()
            
            Button {DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {vm.account = Employee(id: -1, password: "", name: "", status: false, branch: "", employeeType: "", docID: "Logged Out")}} label: {Text("Log Out").underline()}.padding()
        }.popover(isPresented: $showPop) {changePassword}}

	var changePassword: some View{
        VStack(spacing: 15){
            
            Text(AlertContent)
            
            HStack{
				SecureField("Current", text: $currentPassword)
                    .padding(.all, 15)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
					}
            
            HStack{
                SecureField("New Password", text: $newPassword)
                    .padding(.all, 15)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
            }

            HStack{    
                SecureField("Re-Enter New Password", text: $newPassword2)
                    .padding(.all, 15)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
            }
            
            HStack{
                Button {

                    if currentPassword != vm.account.password{
                        AlertContent = "Incorrect Password"
                    }

                    else if newPassword != newPassword2{
                        AlertContent = "The Passwords you have entered do not match"
                    }

                    else{
                        vm.account.password = newPassword
                        vm.updateEmployee(employee: vm.account)
                        AlertContent = "Password Changed"

                        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) {_ in
                            showPop = false
                        }
                    }

                } label: {
                    Text("Change Password")
                        .padding(.all, 10)
                        .background(check ? Color.blue : Color.gray)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                }.disabled(check ? false : true)
            }
        }
        .padding(.all, 15)}

}


