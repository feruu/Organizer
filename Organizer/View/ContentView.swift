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
    
    @EnvironmentObject var iconSettings: IconNames
    @State private var showingSettingView: Bool = false
    @State private var showingAddNewTaskView: Bool = false
    @State private var animatingButton: Bool = false
    //@State private var isAnimated: Bool = false

    //: THEME
    let themes : [Theme] = themeData
    @ObservedObject var theme = ThemeSettings()
    
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            ZStack {
                
    //MARK: - NO TASK ITEMS
                List {
                    ForEach(self.tasks, id: \.self) { todo in
                        HStack {
                            Circle()
                                .frame(width: 12,height: 12, alignment: .center)
                                .foregroundStyle(self.colorize(priority: todo.priority ?? "Normal"))
                            Text(todo.name ?? "Unknown")
                                .fontWeight(.semibold)
                            Spacer()
                            Text(todo.priority ?? "Unknown")
                                .font(.footnote)
                                .foregroundStyle(Color(UIColor.systemGray2))
                                .padding(3)
                                .frame(minWidth: 62)
                                .overlay(
                                    Capsule().stroke(Color(UIColor.systemGray2), lineWidth: 0.75))
                        } //:HStack
                        .padding(.vertical, 10)
                    } //: LOOP
                    .onDelete(perform: deleteTask)
                } //: List
                
                .navigationBarTitle("Organizer", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading ){
                        EditButton().accentColor(themes[self.theme.themeSettings].themeColor)
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        
                        Button(action: {
                            //: SHOW TODO VIEW
                           self.showingSettingView.toggle()
                        }) {
                            Image(systemName: "paintbrush")
                                .imageScale(.large)
                        } //: SETTINGS BUTTON
                        .accentColor(themes[self.theme.themeSettings].themeColor)
                        // Setting View
                        .sheet(isPresented: $showingSettingView) {
                            SettingsView().environmentObject(self.iconSettings)
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
                            .fill(themes[self.theme.themeSettings].themeColor)
                            .opacity(self.animatingButton ? 0.2 : 0)
                            .scaleEffect(self.animatingButton ? 1 : 0)
                            .frame(width: 68, height: 68, alignment: .center)
                        Circle()
                            .fill(themes[self.theme.themeSettings].themeColor)
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
                    .accentColor(themes[self.theme.themeSettings].themeColor)
                    .onAppear(perform: {
                        self.animatingButton.toggle()
                    })
                    
                } //: ZStack
                    .padding(.bottom, 15)
                    .padding(.trailing, 15), alignment: .bottomTrailing
                )
    } //: NAVIGATION
        .navigationViewStyle(StackNavigationViewStyle())
        
}
    //MARK: - DELETE FUNCTION
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
private func colorize(priority: String) -> Color
    {
        switch priority{
        case "High":
            return .pink
        case "Normal":
            return .green
        case "Low":
            return .blue
        default:
            return .gray
        }
    }
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
  

