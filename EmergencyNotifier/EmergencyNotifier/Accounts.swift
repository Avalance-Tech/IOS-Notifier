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
    
    @State var employees =  VM_DB()
    
    var check: Bool{
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
    
    
    // New account Properties
    
    @State var newName: String = ""
    @State var newType: String = ""
    @State var newNumber: String = ""
    @State var newID: String = ""
    @State var newBranch: String = ""
    
    var body: some View{
        
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
                
                Button {
                    newType = "Team Head"
                } label: {
                    Text("Team Head")
                }
                
                Button {
                    newType = "Deputy Team Head"
                } label: {
                    Text("Deputy Team Head")
                }
                
                Button {
                    newType = "Supervisor"
                } label: {
                    Text("Supervisor")
                }
                
                Button {
                    newType = "Assistant Supervisor"
                } label: {
                    Text("Assistant Supervisor")
                }
                
                
                Button {
                    newType = "Fire Fighter"
                } label: {
                    Text("Fire Fighter")
                }
            }
            
            
            // New branch

            Menu(newBranch == "" ? "Select Branch" : newBranch) {
                Button {
                    newBranch = "Ajman"
                } label: {
                    Text("Ajman")
                }
                
                Button {
                    newBranch = "Sharjah"
                } label: {
                    Text("Sharjah")
                }
                
                Button {
                    newBranch = "Ras Al Khaimah"
                } label: {
                    Text("Ras Al Khaimah")
                }
                
                Button {
                    newBranch = "Umm al-Quwain "
                } label: {
                    Text("Umm Al-Quwain")
                }
                
                
                Button {
                    newBranch = "Fujairah"
                } label: {
                    Text("Fujairah")
                }
            }

            
            Divider()
            
            //Submit
            HStack{
                Spacer()
                
                Button(action: {
                    
                    employees.addEmployee(name: newName, id: Int(newID) ?? 0, number: newNumber, branch: newBranch, employeeType: newType)
                    
                    
                }, label:
                        {
                    Text("Create Account")
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .foregroundColor(.black)
                        .background(RoundedRectangle(cornerRadius: 5))
                    
                    
                }
                ).disabled(check ? false : true)
                
            }
            
            
        }.onAppear { employees.getData() }
        
    }
    
}

struct EditAccount: View{
    @State var editedEmployee: Employee
    
    /// new
    
    @State var newName: String = ""
    @State var newBranch = ""
    @State var newType: String = ""
    
    
    
    var body: some View{
        VStack{
            
            HStack{
                Text("Name:")
                    .padding(.horizontal, 8)
                
                
                TextField("Name", text: $editedEmployee.name)
                    .border(Color.gray.opacity(0.8))
                    .padding(.horizontal, 8)
            }
            
            HStack{
                // New Type
                Menu(newType == "" ? "Select Type":newType) {
                    
                    Button {
                        newType = "Team Head"
                    } label: {
                        Text("Team Head")
                    }
                    
                    Button {
                        newType = "Deputy Team Head"
                    } label: {
                        Text("Deputy Team Head")
                    }
                    
                    Button {
                        newType = "Supervisor"
                    } label: {
                        Text("Supervisor")
                    }
                    
                    Button {
                        newType = "Assistant Supervisor"
                    } label: {
                        Text("Assistant Supervisor")
                    }
                    
                    
                    Button {
                        newType = "Fire Fighter"
                    } label: {
                        Text("Fire Fighter")
                    }
                }
                
            }
            HStack{
                
                
                // New branch
                Menu(newBranch == "" ? "Select Branch" : newBranch) {
                    Button {
                        newBranch = "Ajman"
                    } label: {
                        Text("Ajman")
                    }
                    
                    Button {
                        newBranch = "Sharjah"
                    } label: {
                        Text("Sharjah")
                    }
                    
                    Button {
                        newBranch = "Ras Al Khaimah"
                    } label: {
                        Text("Ras Al Khaimah")
                    }
                    
                    Button {
                        newBranch = "Umm al-Quwain "
                    } label: {
                        Text("Umm Al-Quwain")
                    }
                    
                    
                    Button {
                        newBranch = "Fujairah"
                    } label: {
                        Text("Fujairah")
                    }
                }
            }
            
            Button {
                
                self.editedEmployee.name = newName.lowercased()
                self.editedEmployee.branch = newBranch
                self.editedEmployee.employeeType = newType
                
            } label: {
                Text("change name \(self.editedEmployee.name)")
            }
            .foregroundColor(Color.white)
            .padding(.all, 10)
            .background(RoundedRectangle(cornerRadius: 10))
            
            
        }
    }
    
    
}

struct EditAccountMain: View{
    
    @State var employees =  VM_DB()
    
    
    var shownEmployees: [Employee]{
        employees.allEmployees
    }
    
    var body: some View{
        
        VStack{
            
            Text("Edit an account").font(.title)
            Divider()
            
            ScrollView{
                
                ForEach(shownEmployees){ employee in
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
            .onAppear { employees.getData() }
            
        
    }
    
}

struct DeleteAccounts: View{
    
    @State var employees =  VM_DB()

    
    @State private var showingPopUp = false
    
    @State var selectedEmployeesID = Set<Int>()
    var selectedEmployees: [Employee]{
        
        var employees2: [Employee] = []
        for employee in employees.allEmployees{
            if selectedEmployeesID.contains(employee.id){
                employees2.append(employee)
            }
        }
        return employees2
    }
    
    var body: some View{
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
                ForEach(employees.allEmployees){employee in
                    
                    showSelectedDelete(employee: employee, selectedItems: $selectedEmployeesID)
                    
                }
                
            }
            
            Divider()
            
            Button("Delete \(selectedEmployees.count)"){
                showingPopUp = true
                
            }
            .onAppear { employees.getData() }
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
                        } label: {
                            Text("Yes")
                                .padding(.all, 8)
                                .foregroundColor(Color.red)
                                .border(Color.blue.opacity(0.8))
                        }

                        
                        Button{
                            self.selectedEmployeesID.removeAll()
                            showingPopUp = false
                        }
                    label: {
                        Text("No")
                    
                        .padding(.all, 8)
                        .foregroundColor(Color.green)
                        .border(Color.blue.opacity(0.8))
                    }
                    }
                    Spacer()
                }.padding(.vertical, 30)
            }


            
        }
    }
}

struct MainAccountsMenu: View {
    
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
        
    }
    
    
    
    
}

struct AccountsMain: View{
    
    var body: some View{
        
        NavigationView{
            
            MainAccountsMenu()
            
        }
        
    }
    
    
}


struct Accounts_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccount()
    }
}
