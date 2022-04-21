//
//  Accounts.swift
//  EmergencyNotifier
//
//  Created by Adnan Odimah on 04/01/2022.
//

import SwiftUI

struct showSelectedDelete: View{
    
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
            
            Text(branchInitial(branch: employee.branch))
                .frame(width:40, height: 30, alignment: .leading)
            
            Divider()
            
            Text(typeInitial(emptype: employee.employeeType))
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
    
    var employees:  VM_DB
    
    // New account Properties
    
    @State var newName: String = ""
    @State var newType: String = ""
    @State var newNumber: String = ""
    @State var newID: String = ""
    @State var newBranch: String = ""
    
    @State var created = false
    
    var body: some View{
        ZStack{
            
                if created{
             
            VStack{
                Text("Account Created")
                .frame(width: UIScreen.main.bounds.width, height: 100, alignment: .bottom)
                .padding(.bottom, 35)
                .background(Color.green.opacity(1))
                .cornerRadius(20)
                .foregroundColor(Color.white)
                .animation(Animation.easeInOut, value: !created)
                .transition(AnyTransition.move(edge: .top))

                
                Spacer()
            }
            .animation(Animation.easeInOut, value: !created)
            .transition(AnyTransition.move(edge: .top))
            .ignoresSafeArea()
        }
        
        VStack{
            
            // New Name
            HStack(spacing: 10){
                Text("Name")
                TextField(" New Accout Name", text: $newName)
                    .background(Color.gray.opacity(0.1).cornerRadius(10))
                
            }
            .padding(.horizontal, 10)
            
            //New Number
            HStack(spacing: 10){
                Text("Number")
                TextField(" New Account Number", text: $newNumber)
                    .background(Color.gray.opacity(0.1).cornerRadius(10))
            }
            .padding(.horizontal, 10)
            
            
            // New Id
            HStack(spacing: 10){
                Text("ID")
                TextField(" New Account ID", text: $newID)
                    .background(Color.gray.opacity(0.1).cornerRadius(10))
            }
            
            .padding(.horizontal, 10)
            
            
            
            // New Type
            Menu(newType == "" ? "Select Type":newType) {
                
                Button { newType = "Team Head" } label: { Text("Team Head") }
                
                Button { newType = "Deputy Team Head" } label: { Text("Deputy Team Head") }
                
                Button { newType = "Supervisor" } label: { Text("Supervisor") }
                
                Button { newType = "Assistant Supervisor" } label: { Text("Assistant Supervisor") }
                
                Button { newType = "Fire Fighter" } label: { Text("Fire Fighter") }
                
            }
            
            
            // New branch

            Menu(newBranch == "" ? "Select Branch" : newBranch) {
                
                Button {  newBranch = "Ajman" } label: { Text("Ajman") }
                
                Button { newBranch = "Sharjah" } label: { Text("Sharjah") }
                
                Button { newBranch = "Ras Al Khaimah" } label: { Text("Ras Al Khaimah") }
                
                Button { newBranch = "Umm Al-Quwain" } label: { Text("Umm Al-Quwain") }
                
                Button { newBranch = "Fujairah" } label: { Text("Fujairah") }
                
                Button { newBranch = "Abu Dhabi" } label: { Text("Abu Dhabi") }
                
                Button { newBranch = "Dubai" } label: { Text("Dubai") }
            }

            
            Divider()
            
            //Submit
            HStack{
                Spacer()
                
                Button(action: {
                    
                   employees.addEmployee(name: newName.capitalized(with: .current), id: Int(newID) ?? 0, number: newNumber, branch: newBranch, employeeType: newType)

                    withAnimation{
                        created = true}
                    
                    Timer.scheduledTimer(withTimeInterval: 2.3, repeats: false) { _ in
                        	
                        withAnimation {
                            created = false
                        }
                    }


                    
                    
                }, label:
                        {
                    Text("Create Account")
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .foregroundColor(.black)
                        .background(RoundedRectangle(cornerRadius: 5))
                    
                    
                }
                ).disabled(check() && !created ? false : true)
                
            }
        }.onAppear { employees.getData() }


            
        }
    }
}

struct EditAccount: View{
    @State var editedEmployee: Employee
     
    var vm: VM_DB
    
    @State var created = false
    
    @State var shownAlert = false
    
    var body: some View{
        ZStack{
        
            if created{
         
        VStack{
            Text("Account Edited")
            .frame(width: UIScreen.main.bounds.width, height: 100, alignment: .bottom)
            .padding(.bottom, 35)
            .background(
                Color.orange
            )
            .cornerRadius(20)
            .foregroundColor(Color.white)
            .animation(Animation.easeInOut, value: !created)
            .transition(AnyTransition.move(edge: .top))

            
            Spacer()
        }
        .animation(Animation.easeInOut, value: !created)
        .transition(AnyTransition.move(edge: .top))
        .ignoresSafeArea()
    }
            
        VStack{
            
            HStack{
                Text("Name:")
                    .padding(.horizontal, 8)
                
                
                TextField("Name", text: $editedEmployee.name)
                    .padding(.all, 8)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
            }
            
            HStack{
                Text("Phone No.:")
                    .padding(.horizontal, 8)
                
                
                TextField("Number", text: $editedEmployee.number)
                    .padding(.all, 8)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
            }
            
            HStack{
                // New Type
                Menu(editedEmployee.employeeType) {
                    
                    Button {
                        editedEmployee.employeeType = "Team Head"
                    } label: {
                        Text("Team Head")
                    }
                    
                    Button {
                        editedEmployee.employeeType = "Deputy Team Head"
                    } label: {
                        Text("Deputy Team Head")
                    }
                    
                    Button {
                        editedEmployee.employeeType = "Supervisor"
                    } label: {
                        Text("Supervisor")
                    }
                    
                    Button {
                        editedEmployee.employeeType = "Assistant Supervisor"
                    } label: {
                        Text("Assistant Supervisor")
                    }
                    
                    
                    Button {
                        editedEmployee.employeeType = "Fire Fighter"
                    } label: {
                        Text("Fire Fighter")
                    }
                }
                
            }
            HStack{
                
                
                // New branch
                Menu(editedEmployee.branch) {
                    Button {
                        editedEmployee.branch = "Ajman"
                    } label: {
                        Text("Ajman")
                    }
                    
                    Button {
                        editedEmployee.branch = "Sharjah"
                    } label: {
                        Text("Sharjah")
                    }
                    
                    Button {
                        editedEmployee.branch = "Ras Al Khaimah"
                    } label: {
                        Text("Ras Al Khaimah")
                    }
                    
                    Button {
                        editedEmployee.branch = "Umm al-Quwain "
                    } label: {
                        Text("Umm Al-Quwain")
                    }
          
                    Button {
                        editedEmployee.branch = "Abu Dhabi"
                    } label: {
                        Text("Abu Dhabi")
                    }
                    
                    Button {
                        editedEmployee.branch = "Dubai"
                    } label: {
                        Text("Dubai")
                    }
                    
                    Button {
                        editedEmployee.branch = "Fujairah"
                    } label: {
                        Text("Fujairah")
                    }
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
                    
                    withAnimation{
                        created = true}
                    
                    Timer.scheduledTimer(withTimeInterval: 2.3, repeats: false) { _ in
                            
                        withAnimation {
                            created = false
                        }
                    }
                }),
                secondaryButton: .cancel())
        }
    }
    
    
}

struct EditAccountMain: View{
    
    @StateObject var employees:  VM_DB
    
    
    
    var shownEmployees: [Employee]{
        employees.allEmployees
    }
    
    var body: some View{
        
        VStack{
            
            Text("Edit an account").font(.title)
            Divider()
            
            ScrollView{
                
                ForEach(VM.shownEmployees){ employee in
                    HStack(spacing: 2){
                        
                        Text(String(employee.name).capitalized(with: .current))
                            .frame(width: 135, height: 40, alignment: .leading)
                        
                        Divider()
                        
                        Text(typeInitial(emptype: employee.employeeType))
                            .frame(width: 38, height: 40, alignment: .center)
                        
                        Divider()
                        
                        Text(String(employee.id))
                            .frame(width: 46, height: 40, alignment: .center)
                        
                        Divider()
                        
                        Text(branchInitial(branch: employee.branch))
                            .frame(width: 39, height: 40, alignment: .center)
                        
                        Spacer()
                        
                        NavigationLink {
                            EditAccount(editedEmployee: employee, vm: employees)
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
            .onAppear { employees.getData() }
            
        
    }
    
}

struct DeleteAccounts: View{
    
    @StateObject var vm:  VM_DB
    
    @State var dragDown = false

    
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
        
            if dragDown{
         
        VStack{
            Text("Accounts Deleted")
            .frame(width: UIScreen.main.bounds.width, height: 100, alignment: .bottom)
            .padding(.bottom, 35)
            .background(Color.red.opacity(1))
            .cornerRadius(20)
            .foregroundColor(Color.white)
            .animation(Animation.easeInOut, value: !dragDown)
            .transition(AnyTransition.move(edge: .top))

            
            Spacer()
        }
        .animation(Animation.easeInOut, value: !dragDown)
        .transition(AnyTransition.move(edge: .top))
        .ignoresSafeArea()
    }
            
        VStack{
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
                ForEach(vm.allEmployees){employee in
                    
                    showSelectedDelete(employee: employee, selectedItems: $selectedEmployeesID)
                    
                }
                
            }
            
            Divider()
            
            Button("Delete \(selectedEmployees.count)"){
                showingPopUp = true
                
            }
            .onAppear { vm.getData() }
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
                            
                            Text(branchInitial(branch: employee.branch))
                                .frame(width:40, height: 30, alignment: .leading)
                            
                            Divider()
                            
                            Text(typeInitial(emptype: employee.employeeType))
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
                            
                            withAnimation{
                                dragDown = true}
                            
                            Timer.scheduledTimer(withTimeInterval: 2.3, repeats: false) { _ in
                                    
                                withAnimation {
                                    dragDown = false
                                }
                            }
                            showingPopUp = false
                            
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
        }.onAppear{ vm.getData() }
        
    }
}

struct MainAccountsMenu: View {
    
    var vm: VM_DB
    
    var body: some View {
        
        VStack{
            NavigationLink {
                
                CreateAccount(employees: vm)
                
            } label: {
                Text("Create a new Account")
                    .underline()
                    .padding(.vertical, 15)
                    .padding(.horizontal, 10)
                    .foregroundColor(Color.blue)
                    .font(.system(size: 20, design: .rounded))
            }
            
            NavigationLink {
                
                EditAccountMain(employees: vm)
                
            } label: {
                Text("Edit an Account")
                    .underline()
                    .padding(.vertical, 15)
                    .padding(.horizontal, 10)
                    .foregroundColor(Color.blue)
                    .font(.system(size: 20, design: .rounded))
            }
            
            NavigationLink {
                
                DeleteAccounts(vm: vm)
                
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
        
    }
    
    
    
    
}

struct AccountsMain: View{
    
    var VM: VM_DB
    
    var body: some View{
        
        NavigationView{
            
            MainAccountsMenu(vm: VM)
            
        }
    }
}


// MARK: Functions Create Account

extension CreateAccount{

func check() -> Bool{
    if !["Team Head", "Fire Fighter", "Operational Manager", "Supervisor", "Deputy Team Head", "Assistant Supervisor"].contains(newType){
        
        return false
        
    } else if newNumber == ""{
        return false
        
    } else if newName == ""{
        return false
        
    } else if newID == ""{
        return false
        
    } else if !["ajman", "fujairah", "sharjah", "umm al-quwain", "ras al khaimah"].contains(newBranch.lowercased()){
        return false
        
    }else{
        for employee in employees.allEmployees{
            if employee.id == Int(newID){
                
                return false
                
            }
        }
    }
    
    return true
}
    
    
    

}
