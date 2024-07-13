//
//  AddToDoView.swift
//  Organizer
//
//  Created by Feruza Yuldasheva on 6/29/24.
//

import SwiftUI

struct AddToDoView: View {
    //MARK: - PROPERTIES
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String = ""
    @State private var priority: String = "Normal"
    
    let priorities = ["High", "Normal", "Low"]
    
    @State private var errorShowing: Bool = false
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    //: THEME
    let themes : [Theme] = themeData
    @ObservedObject var theme = ThemeSettings()
    
    
    //MARK: - BODY
    var body: some View {
        NavigationView{
            VStack{
<<<<<<< HEAD
                VStack(alignment: .leading, spacing: 30){
=======
                VStack(alignment: .leading,spacing: 20 ){
>>>>>>> new-branch
                    //MARK: - ToDoName
                    TextField("Organizer", text: $name)
                        .padding()
                        .background(Color(UIColor.tertiarySystemFill))
                        .cornerRadius(9)
                        .font(.system(size: 24, weight: .bold, design: .default))
<<<<<<< HEAD
                       // .clipShape(OffsetShape(shape: Circle(), offset: 9))
//MARK: - ToDoPriority
=======
                    
                    //MARK: - ToDoPriority
>>>>>>> new-branch
                    Picker("Priority", selection: $priority){
                        ForEach(priorities, id: \.self){
                            Text($0)
                        }//: LOOP
                    }//:PICKER
                    .pickerStyle(SegmentedPickerStyle())
                    //MARK: - SAVE BUTTON
                    Button(action: { if self.name != "" {
                        let newTask = TaskToDo(context: managedObjectContext)
                        newTask.name = self.name
                        newTask.priority = self.priority
                        do {
                            try managedObjectContext.save()
<<<<<<< HEAD
                           
                           
=======
                            //print("New task: \(newTask.name ?? ""), Priority: \(newTask.priority ?? "")")
                            
>>>>>>> new-branch
                        } //: DO
                        catch {
                            print(error)
                        } //: CATCH
                    }
                        else {
<<<<<<< HEAD
                        errorShowing = true
                        errorTitle = "Invalid Name"
                        errorMessage = "Make sure to enter something for /nthe new item."
                    } //: ELSE
                            
                        self.presentationMode.wrappedValue.dismiss()
                            
                       
=======
                            errorShowing = true
                            errorTitle = "Invalid Name"
                            errorMessage = "Make sure to enter something for /nthe new item."
                        } //: ELSE
                        
                        self.presentationMode.wrappedValue.dismiss()
                        
                        
>>>>>>> new-branch
                    }){
                        //MARK: - SAVE BUTTON
                        Text("Save")
                            .font(.system(size: 24, weight: .bold, design: .default))
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
<<<<<<< HEAD
                            .background(Color.blue)
                            .cornerRadius(9)
                            .foregroundColor(Color.white)
                            
                    } //: SAVE BUTTON
                } //: VStack
=======
                            .background(themes[self.theme.themeSettings].themeColor)
                            .cornerRadius(9)
                            .foregroundStyle(Color.white)
                    } //: SAVE BUTTON
                } //: FORM
>>>>>>> new-branch
                .padding(.horizontal)
                .padding(.vertical, 30)
                Spacer()
            }
            .navigationBarTitle("New Task", displayMode: .inline)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }){
                        Image(systemName: "xmark")
                    } //: BUTTON X
                } //: TOOLBARITEM
            } //: TOOLBAR
        } //NAVIGATION TITLE
        .alert(isPresented: $errorShowing){
            Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton:
                    .default(Text("OK")))
        } .accentColor(themes[self.theme.themeSettings].themeColor)
        .navigationViewStyle(StackNavigationViewStyle())
        //ALERT
    }
    // : NAVIGATION
        
    
}

//MARK: - PREVIEW
#Preview {
    AddToDoView()
}
