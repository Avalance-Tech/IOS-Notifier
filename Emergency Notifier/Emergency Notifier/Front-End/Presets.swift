import SwiftUI

var BottomMenu: some View{
    VStack(spacing: 10){
        
        
        Image("Avala_logo")
            .resizable()
            .frame(width: 40, height: 40, alignment: .bottom)
        
        Text("Made by \n Avalanche Tech")
            .font(.system(size: 15, weight: .light, design: .rounded))
            .multilineTextAlignment(.center)
        
    }.padding(.bottom,15)
}


struct onCall: View{
        @StateObject var vm: dataViewModel
    
        var body: some View{
            HStack{
                Spacer()
                Toggle(isOn: self.$vm.account.status) {
                    Text("On Call")
                }
                Spacer()
            }.padding([.top, .horizontal], 50).onChange(of: vm.account.status, perform: { newValue in
                vm.updateEmployee(employee: vm.account)
            })
        
        }
    }


// preset employee features
extension dataViewModel{


    var TopMenu: some View{
        
        VStack{
            
            HStack{
                Text(account.employeeType)
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding()
                
                Spacer()
            }
            
            HStack(spacing:12){
                
         /*       Link(destination: URL(string: "https://www.emiratesfire.ae")!, label:{
                    
                    Image(systemName: "flame")
                        .resizable()
                        .frame(width: 30, height: 30, alignment: .center)
                        .foregroundColor(Color.red)
                        .padding(.leading, 15)
                })*/
                
                
                Spacer()
                
                // help
                NavigationLink{
                    
                }
                label: {
                    Image(systemName: "questionmark.circle")
                        .resizable()
                        .frame(width: 30, height: 30, alignment: .center)
                        .font(.system(size: 10, weight: .light, design: .rounded))
                }
                
                // profile
                NavigationLink{
                    self.accountView.statusBar(hidden: true)
                }
            label: {
                Image(systemName: "person.crop.circle" )
                    .resizable()
                    .frame(width: 30, height: 30, alignment: .center)
                    .font(.system(size: 10, weight: .light, design: .rounded))
                
            }
                
                
            }.padding(.trailing, 20) }
    }



    var reportEmergency: some View{
        
        NavigationLink(destination: {
            
           // createEmergency
            
        }, label: {
            Text("Report an emergency")
                .underline()
                .padding(.vertical, 15)
                .padding(.horizontal, 10)
                .foregroundColor(Color.blue)
                .font(.system(size: 20, design: .rounded))
            
        })
        }
    var recentEmergencies: some View{
        
        NavigationLink(destination:{
            
            // recentEmergency
            
        },label: {
            Text("Previous emergencies")
                .underline()
                .padding(.vertical, 15)
                .padding(.horizontal, 10)
                .font(.system(size: 20, design: .rounded))
            
        })}
	var accountManagement: some View{
        NavigationLink{
            
          //  MainAccountsMenu
            
        }label:{
            Text("Create/edit/delete an account")
            
                .underline()
                .padding(.vertical, 15)
                .padding(.horizontal, 10)
                .foregroundColor(Color.blue)
                .font(.system(size: 20, design: .rounded))
            
        }}
	
}

