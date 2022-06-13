# IOS-Notifier

Communication application developed using Swift and SwiftUI. Used for Fire and Rescue companies to communicate with each other in the utmost efficiency and effectivity so as little time as possible is wasted resulting in higher saviour rates etc. Communication is expected to be effecient yet information heavy with a large amount of data neeeded such as the casualties, injuries, location, meeting point and more. This is done possible by the simple UI and the implementation of useful features such as Maps and ETAs. Firefighters and employees out in the field are also expecting information on the available help so it tracks the employee's ETA's and statuses in order to ensure consistent true and correct replies.

There are 5 Employee types, with 7 Branches across the emirates. Where communication is expected across android and IOS with time sensitive notifications where needed and more.

## The 5 Employee types are as follows:

### Operational Manager (OM)
Can send emergencies to the **TH** across the branches
Can recieve requests from the **TH**
Can create, delete and edit accounts for **TH, DTH, SV, AS, FF.**
Can assign acting operational manager to a **TH**
Can reset passwords with requests


### Team Head (TH)
Sends emergency to **SV, Groups, individual AS/FF**
Sends request to **OM**
Recieve requests from **OM and SV and DTH**
Can create/edit/delete accounts for **SV, AS, FF** within his branch.
Can assign **DTH**
Creates Emergencies which he can send to supervisors under his command, groups in his branch, and individual employees within his branch. 
He can also request help from the operational manager where they will decide on the next course of action.
A team head can also create/edit/delete accounts for supervisors, assistant supervisors and firefighters within his branch


### Deputy Team Head (DTH)
Sends emergency to **TH**
Receive emergencies from **TH and SV**
Can be converted into **ATH** (Acting Team Head)

### Supervisor (SV) -Group of 1 assistant and many fire fighters-
Sends emergency to the **TH and DTH**
sends emergency to their **Group**
Can assign **ASV** (Acting Supervisor)

### Assistant Super Visor (ASV) / FireFighter (FF)
recieve emergency from **SV**

