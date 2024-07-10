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
    
    //MARK: - BODY
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    //MARK: - ToDoName
                    TextField("Organizer", text: $name)
//MARK: - ToDoPriority
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
                            print("New task: \(newTask.name ?? ""), Priority: \(newTask.priority ?? "")")
                           // name = ""
                        } //: DO
                        catch {
                            print(error)
                        } //: CATCH
                    }
                        else {
                        errorShowing = true
                        errorTitle = "Invalid Name"
                        errorMessage = "Make sure to enter something for /nthe new item."
                    } //: ELSE
                            
                        self.presentationMode.wrappedValue.dismiss()
                            
                       
                    }){
                        Text("Save")
                    } //: SAVE BUTTON
                } //: FORM
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
            return Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton:
                    .default(Text("OK")))
        } //ALERT
    } // : NAVIGATION
}

//MARK: - PREVIEW
#Preview {
    AddToDoView()
}
