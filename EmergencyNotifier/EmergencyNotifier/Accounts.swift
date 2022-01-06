//
//  Accounts.swift
//  EmergencyNotifier
//
//  Created by Adnan Odimah on 04/01/2022.
//

import SwiftUI

struct CreateAccount: View{
    
    var check: Bool{
        if !["Team Head", "Fire Fighter", "Operational Manager", "Supervisor", "Deputy Team Head", "Assistant Supervisor"].contains(newType){
            print(newType)
            return false
        } else if newNumber == ""{
            print(newNumber)
            return false
        } else if newName == ""{
            print(newName)
            return false
        } else if newID == ""{
            print(newID)
            return false
        } else if ![ajman.name, sharjah.name, rak.name, uaq.name, fujairah.name].contains(newBranch.name){
            print(newBranch.name)
            return false
        }
        
        return true
    }

    
    // New account Properties
    
    @State var newName: String = ""
    @State var newType: String = ""
    @State var newNumber: String = ""
    @State var newID: String = ""
    @State var newBranch: Branch = Branch(employees: [], name: "none", emergencies: [])
    
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
            Menu(newBranch.name == "none" ? "Select Branch": newBranch.name) {
                
                Button {
                    newBranch = ajman
                } label: {
                    Text("Ajman")
                }
                
                Button {
                    newBranch = sharjah
                } label: {
                    Text("Sharjah")
                }
                
                Button {
                    newBranch = rak
                } label: {
                    Text("Ras Al Khaimah")
                }
                
                Button {
                    newBranch = uaq
                } label: {
                    Text("Umm Al-Quwain")
                }
                
                
                Button {
                    newBranch = fujairah
                } label: {
                    Text("Fujairah")
                }
            }
            
            Divider()
            
            //Submit
                HStack{
                    Spacer()
                    
                    Button(action: {
                        
                        
                        print(newNumber)
                        print(newID)
                        print(newBranch.name)
                        print(newName)
                        print(newType)
                        
                    }, label:
                            {
                        Text("Create Accountt")
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .foregroundColor(.black)
                            .background(RoundedRectangle(cornerRadius: 5))
                    
                    
                    }
                    ).disabled(check ? false : true)

            }
            
            
        }
        
    }
    
    func createAccount(accountName: String, accountType: String, accountID: String, accountNumber: String) -> Void
    {
    
        
        self.newBranch.employees.append(Employee(employeeID: accountID, name: accountName, number: accountNumber, status: false, branch: newBranch, employeeType: accountType))
        
        
        
        
        
    }
    
    
}

struct EditAccount: View{
    var editedEmployee: Employee
    
    var body: some View{
        
        Text(editedEmployee.name)
        
    }
    
    
}

struct EditAccountMain: View{
    
    var shownEmployees: [Employee]{
        let i = [adnan, wassim, talal, ayman]
        
        return i
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
                    
                    Text(employee.employeeID)
                        .frame(width: 46, height: 40, alignment: .center)
                    
                    Divider()
                    
                    Text(branchInitial(branch: employee.branch.name))
                        .frame(width: 39, height: 40, alignment: .center)
                    
                    Spacer()
                    
                NavigationLink {
                    EditAccount(editedEmployee: employee)
                } label: {
                    Text("Edit")
                        .padding(.horizontal, 10)
                        .padding(.vertical, 10)
                        .foregroundColor(.blue)
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
        EditAccountMain()
    }
}
