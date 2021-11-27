//
//  ContentView.swift
//  MyTodoList
//
//  Created by Najla Talal on 11/4/21.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Tasky.entity(), sortDescriptors: [NSSortDescriptor(key : "title", ascending: false)], animation:.default)
    private var tasks: FetchedResults<Tasky>
    
    @State var title: String = ""
    @State var descriptionToDo: String = ""
    @State var isFavorite: Bool = false
    
    
    
     func saveTask() {
        do {
            let tasky = Tasky(context: viewContext)
            tasky.title = title
            tasky.descriptionToDo = descriptionToDo
            tasky.isFavorite = isFavorite
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                TextField("Enter title", text: $title).textFieldStyle(.roundedBorder)
                    .padding()
                TextField("Enter description", text: $descriptionToDo).textFieldStyle(.roundedBorder)
                    .padding()
                Toggle(isOn: $isFavorite) {}
                .labelsHidden()
                Button {
                    saveTask()
                    title = ""
                    descriptionToDo = ""
                }label: {
                    Text("Save")
                }
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
               
                List{
                    if tasks.isEmpty {
                        Text("Task are empty")
                    } else {
                        ForEach(tasks) { tasky in
                            NavigationLink(destination: {
                                UpdateTaskyView(tasky: tasky)
                                
                            }, label: {
                                
                                HStack {
                                    Text(tasky.title ?? "")
                                    Spacer()
                                    Button {
                                        tasky.isFavorite = !tasky.isFavorite
                                        do {
                                            try viewContext.save()
                                        } catch {
                                            print(error.localizedDescription)
                                        }
                                        
                                    }label: {
                                        
                                        Image(systemName: tasky.isFavorite ? "heart.fill" : "heart")
                                            .foregroundColor(.red)
                                        
                                    }.buttonStyle(.borderless)
                                }
                            })
                                .swipeActions(edge: .leading, allowsFullSwipe: false) {
                                    Button {
                                        if let deletedTasky = tasks.firstIndex(of: tasky){
                                            viewContext.delete(tasks[deletedTasky])
                                            do {
                                                try viewContext.save()
                                            } catch {
                                            }
                                            
                                        }
                                    }label: {
                                        HStack {
                                            Image(systemName: "trash")
                                            Text("delete")
                                        }
                                    }.tint(.red)
                                }
                        }
                    }
                }
            }
            .navigationTitle("Tasky")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let persistantContainer = CoreDataManager.shared.persistantContainer
        
        ContentView()
            .environment(\.managedObjectContext, persistantContainer.viewContext)
    }
}

