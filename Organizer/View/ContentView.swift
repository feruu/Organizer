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
    @State private var showingSettingView: Bool = false
    @State private var showingAddNewTaskView: Bool = false
    @State private var animatingButton: Bool = false
    //@State private var isAnimated: Bool = false

    // MARK: - BODY
    var body: some View {
        NavigationView {
            ZStack {
                //MARK: - NO TASK ITEMS
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
                           self.showingSettingView.toggle()
                        }) {
                            Image(systemName: "paintbrush")
                                .imageScale(.large)
                        } //: ADD BUTTON
                        .sheet(isPresented: $showingSettingView) {
                            SettingsView()
                        }
                    }
                    
                } // Navigation Toolbar Items
                //MARK: - NO TODO ITEMS, Empty list
                if tasks.count == 0 {
                    EmptyListView()
                }
        } //: ZSTACK
            .sheet(isPresented: $showingAddNewTaskView) {
                AddToDoView().environment(\.managedObjectContext, self.managedObjectContext)
             }
            .overlay(
                ZStack{
                    Group{
                        Circle()
                            .fill(Color.blue)
                            .opacity(self.animatingButton ? 0.2 : 0)
                            .scaleEffect(self.animatingButton ? 1 : 0)
                            .frame(width: 68, height: 68, alignment: .center)
                        Circle()
                            .fill(Color.blue)
                            .opacity(self.animatingButton ? 0.15 : 0)
                            .scaleEffect(self.animatingButton ? 1 : 0)
                            .frame(width: 88, height: 88, alignment: .center)
                    } //: GROUP
                    .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true))
                    Button(action: { self.showingAddNewTaskView.toggle()
                    }) { Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .background(Circle().fill(Color("ColorBase")))
                            .frame(width: 48, height: 48, alignment: .center)
                    } //: BUTTON
                    .onAppear(perform: {
                        self.animatingButton.toggle()
                    })
                    
                } //: ZStack
                    .padding(.bottom, 15)
                    .padding(.trailing, 15), alignment: .bottomTrailing
                )
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
  

