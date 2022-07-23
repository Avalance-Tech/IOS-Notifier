import SwiftUI

struct showSelectedDelete: View{
    @EnvironmentObject var vm: dataViewModel
    
    let employee: Employee
    
    @Binding var selectedItems: Set<Int>
    
    var isSelected: Bool{
        selectedItems.contains(employee.id)
    }
    
    
    var body: some View{
        
        HStack(spacing: 7){
            
            Text(String(employee.id))
                .frame(width: 45, height: 30, alignment: .leading)
                .padding(.leading, 3)
            
            Divider()
            
            Text(String(employee.name).capitalized(with: .current))
                .frame(width:150, height: 30, alignment: .leading)
            
            
            Image(employee.status ? "checkmark.circle.fill" : "circle.slash")
                .frame(width:23, height: 30, alignment: .leading)
            
            Divider()
            
            Text(branchInitials(branch: employee.branch))
                .frame(width:40, height: 30, alignment: .leading)
            
            Divider()
            
            Text(typeInitial(type: employee.employeeType))
                .font(.system(size: 15,weight: .light))
                .frame(width: 32, height: 30)
            
            Divider()
            
            if self.isSelected{
                Image(systemName:"checkmark")
                    .foregroundColor(Color.blue)
                    .frame(width: 20, height: 30)
            }else{
                Text("").frame(width: 20, height: 30)
            }
            
            
        }
        
        .onTapGesture {
            if self.isSelected{
                self.selectedItems.remove(self.employee.id)
            } else{
                self.selectedItems.insert(self.employee.id)
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: 70, alignment: .leading)
        .border(Color.gray.opacity(self.isSelected ? 1 : 0.3))
        .shadow(color: Color.black.opacity(self.isSelected ? 0.4 : 0), radius: 2, x: 2, y: 2)
        
    }
    
}


struct CreateAccount: View{
    
    @EnvironmentObject var employees: dataViewModel
    
    // New account Properties
    @Environment(\.dismiss) private var dismiss
    
    @State var newName: String = ""
    @State var newType: String = ""
    @State var newID: String = ""
    @State var newBranch: String = ""
    
    var check: Bool{
        if employees.allEmployees.contains(where: { Employee in
            Employee.id == Int(newID)
        })
        {return false}
        
        else if newName == "" || newType == "" || newID == "" || newBranch == ""
        {return false}
        
        else if newType == "Deputy Team Head"{ // Checks if no DTH exist in the branch
            
            if employees.allEmployees.contains(where: { Employee in
                Employee.branch == newBranch && (Employee.employeeType == "Acting Team Head" || Employee.employeeType == "Deputy Team Head")
            })
            {return false}}
        
        else if newType == "Team Head"{  // Checks if no team heads exist in the branch
            if employees.allEmployees.contains(where: { Employee in
                Employee.branch == newBranch && Employee.employeeType == "Team Head" || Employee.employeeType == "Acting Operational Manager"
            })
            {return false}}
        return true
    }
    
    
    
    var body: some View{
        ZStack{
                
            // Main Page
            VStack{
                // New Account Name
                HStack(spacing: 10){
                    Text("Name")
                    TextField(" New Accout Name", text: $newName)
                        .background(Color.gray.opacity(0.1).cornerRadius(10))
                    
                }
                .padding(.horizontal, 10)
                
                
                //  New Account ID
                HStack(spacing: 10){
                    Text("ID")
                    TextField(" New Account ID", text: $newID)
                        .background(Color.gray.opacity(0.1).cornerRadius(10))
                }
                
                .padding(.horizontal, 10)
                
                
                //  New Account Type
                Menu(newType == "" ? "Select Type":newType) {
                    
                    if employees.account.employeeType == "Operational Manager" || employees.account.employeeType == "Acting Operational Manager"{
                        Button { newType = "Team Head" } label: { Text("Team Head") }}
                    
                    if ["Operational Manager", "Team Head", "Acting Operational Manager", "Acting Team Head"].contains(employees.account.employeeType){
                        Button { newType = "Deputy Team Head" } label: { Text("Deputy Team Head") }}
                    
                    if ["Operational Manager", "Team Head", "Acting Operational Manager", "Acting Team Head"].contains(employees.account.employeeType){
                        Button { newType = "Supervisor" } label: { Text("Supervisor") }}
                    
                    if ["Operational Manager", "Team Head", "Supervisor", "Acting Operational Manager", "Acting Team Head", "Acting Supervisor"].contains(employees.account.employeeType){
                        Button { newType = "Assistant Supervisor" } label: { Text("Assistant Supervisor") }}
                    
                    if ["Operational Manager", "Team Head", "Deputy Team Head", "Supervisor", "Acting Operational Manager", "Acting Team Head", "Acting Supervisor"].contains(employees.account.employeeType){
                        Button { newType = "Fire Fighter" } label: { Text("Fire Fighter") }}
                    
                }
                
                // New branch
                
                if employees.account.employeeType == "Operational Manager" || employees.account.employeeType == "Acting Operational Manager"{
                    
                    Menu(newBranch == "" ? "Select Branch" : newBranch) {
                        
                        Button {  newBranch = "Ajman" } label: { Text("Ajman") }
                        
                        Button { newBranch = "Sharjah" } label: { Text("Sharjah") }
                        
                        Button { newBranch = "Ras Al Khaimah" } label: { Text("Ras Al Khaimah") }
                        
                        Button { newBranch = "Umm Al-Quwain" } label: { Text("Umm Al-Quwain") }
                        
                        Button { newBranch = "Fujairah" } label: { Text("Fujairah") }
                        
                        Button { newBranch = "Abu Dhabi" } label: { Text("Abu Dhabi") }
                        
                        Button { newBranch = "Dubai" } label: { Text("Dubai") }
                    }}
                
                Divider()
                
                //Submit Button
                
                HStack{
                    Spacer()
                    
                    Button {
                        
                        employees.addEmployee(name: newName.capitalized(with: .current), id: Int(newID) ?? -1, branch: newBranch, employeeType: newType)
                        
                            dismiss()
                    } label: {
                        Text("Create Account")
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .foregroundColor(.black)
                            .background(RoundedRectangle(cornerRadius: 5))
                    }.disabled(!check)
                }
            }
        }.onAppear{
            if self.employees.account.employeeType != "Operational Manager" || self.employees.account.employeeType != "Acting Operational Manager"{
                newBranch = employees.account.branch
            }
        }
    }
}

struct EditAccount: View{
    @State var editedEmployee: Employee
    
    @EnvironmentObject var vm: dataViewModel
    
    @State var shownAlert = false
    
    @State var change = false
    @Environment(\.dismiss) private var dismiss

    var body: some View{
        ZStack{
            
            VStack{
                
                HStack{
                    Text("Name:")
                        .padding(.horizontal, 8)
                    
                    
                    TextField("Name", text: $editedEmployee.name)
                        .padding(.all, 8)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                }
                
                
                
                //  New Account Type
                Menu(editedEmployee.employeeType) {
                    
                    if vm.account.employeeType == "Operational Manager" || vm.account.employeeType == "Acting Operational Manager"{
                        Button { editedEmployee.employeeType = "Team Head" } label: { Text("Team Head") }}
                    
                    if ["Operational Manager", "Team Head", "Acting Operational Manager", "Acting Team Head"].contains(vm.account.employeeType){
                        Button { editedEmployee.employeeType = "Deputy Team Head" } label: { Text("Deputy Team Head") }}
                    
                    if ["Operational Manager", "Team Head", "Acting Operational Manager", "Acting Team Head"].contains(vm.account.employeeType){
                        Button { editedEmployee.employeeType = "Supervisor" } label: { Text("Supervisor") }}
                    
                    if ["Operational Manager", "Team Head", "Supervisor", "Acting Operational Manager", "Acting Team Head", "Acting Supervisor"].contains(vm.account.employeeType){
                        Button { editedEmployee.employeeType = "Assistant Supervisor" } label: { Text("Assistant Supervisor") }}
                    
                    if ["Operational Manager", "Team Head", "Deputy Team Head", "Supervisor", "Acting Operational Manager", "Acting Team Head", "Acting Supervisor"].contains(vm.account.employeeType){
                        Button { editedEmployee.employeeType = "Fire Fighter" } label: { Text("Fire Fighter") }}
                    
                }
                
                // New branch
                
                if vm.account.employeeType == "Operational Manager" || vm.account.employeeType == "Acting Operational Manager"{
                    
                    Menu(editedEmployee.branch) {
                        
                        Button { editedEmployee.branch = "Ajman" } label: { Text("Ajman") }
                        
                        Button { editedEmployee.branch = "Sharjah" } label: { Text("Sharjah") }
                        
                        Button { editedEmployee.branch = "Ras Al Khaimah" } label: { Text("Ras Al Khaimah") }
                        
                        Button { editedEmployee.branch = "Umm Al-Quwain" } label: { Text("Umm Al-Quwain") }
                        
                        Button { editedEmployee.branch = "Fujairah" } label: { Text("Fujairah") }
                        
                        Button { editedEmployee.branch = "Abu Dhabi" } label: { Text("Abu Dhabi") }
                        
                        Button { editedEmployee.branch = "Dubai" } label: { Text("Dubai") }
                    }
                    
                }
                
                
                Button {
                    
                    shownAlert.toggle()
                    
                    
                    
                } label: {
                    Text("Edit Employee")
                }
                .foregroundColor(Color.white)
                .padding(.all, 10)
                .background(Color.blue)
                .cornerRadius(10)
                
                
            }
        }.alert(isPresented: $shownAlert) {
            Alert(
                title: Text("Are you sure"),
                message: Text("Are you sure you want to edit this user"),
                primaryButton: .destructive(Text("Confirm"), action: {
                    vm.updateEmployee(employee: editedEmployee)
                
                        dismiss()
                    
                }),
                secondaryButton: .cancel())
        }
    }
}


struct EditAccountMain: View{
    
    @EnvironmentObject var employees:  dataViewModel
    
    var body: some View{
        ZStack{
            VStack{
                
                Text("Edit an account").font(.title)
                Divider()
                
                ScrollView{
                    
                    ForEach(employees.shownEmployees().filter({ emp in
                        switch employees.account.employeeType{
                        case "Operational Manager", "Acting Operational Manager":
                            return emp.employeeType != "Operational Manager"
                        case "Team Head", "Acting Team Head":
                            return emp.employeeType != "Operational Manager" && emp.employeeType != "Acting Operational Manager"
                        case "Acting Supervisor", "Supervisor", "Deputy Team Head":
                            return emp.employeeType != "Team Head" && emp.employeeType != "Acting Team Head" && emp.employeeType != "Deputy Team Head"
                        default:
                            return emp.id == -1
                        }
                    })){ employee in
                        HStack(spacing: 2){
                            
                            Text(String(employee.name).capitalized(with: .current))
                                .frame(width: 135, height: 40, alignment: .leading)
                            
                            Divider()
                            
                            Text(typeInitial(type: employee.employeeType))
                                .frame(width: 38, height: 40, alignment: .center)
                            
                            Divider()
                            
                            Text(String(employee.id))
                                .frame(width: 46, height: 40, alignment: .center)
                            
                            Divider()
                            
                            Text(branchInitials(branch: employee.branch))
                                .frame(width: 39, height: 40, alignment: .center)
                            
                            Spacer()
                            
                            NavigationLink {
                                EditAccount(editedEmployee: employee)
                            } label: {
                                Text("Edit")
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 10)
                                    .foregroundColor(.white)
                                    .background(RoundedRectangle(cornerRadius: 10))
                                
                            }
                            
                            
                        }.padding(.horizontal, 5)
                        
                        Divider().padding(.all, 0)
                        
                    }
                    
                    
                    
                }
            }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/1.12, alignment: .leading)
                .padding(.vertical, 10)
        }
        
    }
    
}

struct DeleteAccounts: View{
    
    @EnvironmentObject var vm:  dataViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var showingPopUp = false
    
    @State var selectedEmployeesID = Set<Int>()
    var selectedEmployees: [Employee]{
        
        var employees2: [Employee] = []
        for employee in vm.allEmployees{
            if selectedEmployeesID.contains(employee.id){
                employees2.append(employee)
            }
        }
        return employees2
    }
    
    var body: some View{
        ZStack{
            VStack{
                SearchBar()
                
                HStack(spacing:10){
                    Text("Delete Accounts").font(.title).padding(.leading, UIScreen.main.bounds.width/3)
                        .multilineTextAlignment(.center)
                    Spacer()
                    Text("\(selectedEmployees.count) \n selected").font(.system(size: 13, weight: .bold, design: .rounded))
                        .multilineTextAlignment(.center)
                }.padding(.trailing, 5)
                Divider()
                
                Spacer()
                
                ScrollView{
                    ForEach(
                        vm.shownEmployees().filter({ emp in
                            switch vm.account.employeeType{
                            case "Operational Manager", "Acting Operational Manager":
                                return emp.employeeType != "Operational Manager"
                            case "Team Head", "Acting Team Head":
                                return emp.employeeType != "Operational Manager" && emp.employeeType != "Acting Operational Manager"
                            case "Acting Supervisor", "Supervisor", "Deputy Team Head":
                                return emp.employeeType != "Team Head" && emp.employeeType != "Acting Team Head" && emp.employeeType != "Deputy Team Head"
                            default:
                                return emp.id == -1
                            }
                        })
                        
                            .sorted(by: { e1, e2 in e1.id < e2.id})){employee in
                        
                        showSelectedDelete(employee: employee, selectedItems: $selectedEmployeesID)
                        
                    }
                    
                }
                
                Divider()
                
                Button("Delete \(selectedEmployees.count)"){
                    showingPopUp = true
                    
                    
                }
                .disabled(selectedEmployees.count > 0 ? false : true)
                .padding([.top, .horizontal], 10)
                .padding(.bottom, 8)
                .popover(isPresented: $showingPopUp) {
                    VStack(alignment: .center){
                        
                        
                        Spacer()
                        
                        
                        Text("Are you sure you would like to delete the \(selectedEmployees.count) account(s)?  This includes:").font(.system(size: 20, weight: .bold))
                        ScrollView { ForEach(selectedEmployees){employee in
                            
                            HStack{
                                Text(String(employee.id))
                                    .frame(width: 45, height: 30, alignment: .leading)
                                    .padding(.leading, 3)
                                
                                Divider()
                                
                                Text(String(employee.name).capitalized(with: .current))
                                    .frame(width:180, height: 30, alignment: .leading)
                                
                                
                                Divider()
                                
                                Text(branchInitials(branch: employee.branch))
                                    .frame(width:40, height: 30, alignment: .leading)
                                
                                Divider()
                                
                                Text(typeInitial(type: employee.employeeType))
                                    .font(.system(size: 15,weight: .light))
                                    .frame(width: 32, height: 30)
                                
                            }
                            Divider()
                        }
                            
                        }.border(Color.gray.opacity(0.6))
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/3)
                        
                        
                        
                        HStack(spacing: 30){
                            Button {
                                // delete accounts
                                for employee in selectedEmployees {
                                    vm.deleteEmployee(employee: employee)
                                }
 
                                    showingPopUp = false
                                    dismiss()
                    
                        
                                
                            } label: {
                                Text("Yes")
                                    .padding(.all, 8)
                                    .background(Color.red)
                                    .cornerRadius(10)
                                    .foregroundColor(Color.white)
                            }
                            
                            
                            Button{
                                self.selectedEmployeesID.removeAll()
                                showingPopUp = false
                            }
                        label: {
                            Text("No")
                                .padding(.all, 8)
                                .background(Color.green)
                                .cornerRadius(10)
                                .foregroundColor(Color.white)
                        }
                        }
                        Spacer()
                    }.padding(.vertical, 30)
                }
            }
        }
    }
}

struct MainAccountsMenu: View {
    
    @EnvironmentObject var vm: dataViewModel
    
    var body: some View {
        
        VStack{
            NavigationLink {
                
                CreateAccount()
                
            } label: {
                Text("Create a new Account")
                    .underline()
                    .padding(.vertical, 15)
                    .padding(.horizontal, 10)
                    .foregroundColor(Color.blue)
                    .font(.system(size: 20, design: .rounded))
            }
            
            NavigationLink {
                
                EditAccountMain()
                
            } label: {
                Text("Edit an Account")
                    .underline()
                    .padding(.vertical, 15)
                    .padding(.horizontal, 10)
                    .foregroundColor(Color.blue)
                    .font(.system(size: 20, design: .rounded))
            }
            
            NavigationLink {
                
                DeleteAccounts()
                
            } label: {
                Text("Delete accounts")
                    .underline()
                    .padding(.vertical, 15)
                    .padding(.horizontal, 10)
                    .foregroundColor(Color.blue)
                    .font(.system(size: 20, design: .rounded))
            }
            
            Spacer()
            
            BottomMenu
            
        }.padding(.top, 90)
            .onAppear{
                vm.getEmployees()
            }
        
    }
    
    
    
    
}



