//
//  ContentView.swift
//  Organizer
//
//  Created by Feruza Yuldasheva on 6/29/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
//MARK: - PROPERTIES
    @Environment(\.managedObjectContext) var managedObjectContext
    @State private var showingAddNewTaskView: Bool = false
    
//MARK: - BODY
    var body: some View {
        NavigationView {
            List(0..<5){ item in Text("Alloh")
            }
            .navigationBarTitle("Orginazer", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading){
                    Button(action: {
                        //: SHOW TODO VIEW
                        self.showingAddNewTaskView.toggle()
                    }){
                        Image(systemName: "plus")
                    } //: ADD BUTTON
                    .sheet(isPresented: $showingAddNewTaskView) {
                        AddToDoView().environment(\.managedObjectContext, self.managedObjectContext)
                    }
                }
            }
        }//: NAVIGATION
    }
}
    

//MARK: - PREVIEW
#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
