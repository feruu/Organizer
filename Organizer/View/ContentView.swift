//
//  ContentView.swift
//  Organizer
//
//  Created by Feruza Yuldasheva on 6/29/24.
//
import SwiftUI
import CoreData

struct ContentView: View {
    // MARK: - PROPERTIES
    @Environment(\.managedObjectContext) var managedObjectContext

    // MARK: - FetchRequest
    @FetchRequest(
        entity: TaskToDo.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \TaskToDo.name, ascending: true)])
        var tasks: FetchedResults<TaskToDo>

    @State private var showingAddNewTaskView: Bool = false

    // MARK: - BODY
    var body: some View {
        NavigationView {
            ZStack {
                //MARK: - NO TASK ITEMS
                
                if tasks.count == 0 {
                    EmptyListView()
                    
                }
                
                List {
                    ForEach(self.tasks, id: \.self) { todo in
                        HStack {
                            Text(todo.name ?? "Unknown")
                            Spacer()
                            Text(todo.priority ?? "Unknown")
                        }
                    } //: LOOP
                    .onDelete(perform: deleteTask)
                } //: List
                
                .navigationBarTitle("Organizer", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading ){
                        EditButton()
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            //: SHOW TODO VIEW
                            self.showingAddNewTaskView.toggle()
                        }) {
                            Image(systemName: "plus")
                        } //: ADD BUTTON
                        .sheet(isPresented: $showingAddNewTaskView) {
                            AddToDoView().environment(\.managedObjectContext, self.managedObjectContext)
                        }
                    }
                }
               
        } //: ZSTACK
    } //: NAVIGATION
}
    
    private func deleteTask(at offsets: IndexSet){
        for index in offsets {
            let task = tasks[index]
            managedObjectContext.delete(task)
            do {
                try managedObjectContext.save()
                print("Delete function worked properly")
            } catch {
                print(error)
            } //: CATCH
        } //: FOR LOOP
    } //: DeleteTask
}

// MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var dataController = PersistenceController.preview
    
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(dataController)
    }
}
  

