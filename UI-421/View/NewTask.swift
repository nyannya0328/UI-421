//
//  NewTask.swift
//  UI-421
//
//  Created by nyannyan0328 on 2022/01/14.
//

import SwiftUI

struct NewTask: View {
    
    
    @State var taskTitle : String = ""
    @State var taskDescription : String = ""
    
    @State var taskDate : Date = Date()
    
    
    
    @Environment(\.dismiss) var dissmiss
    @Environment(\.managedObjectContext) var context
    
    @EnvironmentObject var model : TaskViewModel
    var body: some View {
        NavigationView{
            
            
            
            List{
                
                
                Section {
                    
                    
                    TextField("Go to Work", text: $taskTitle)
                       
                    
                } header: {
                    Text("Task Title")
                        .font(.callout.weight(.light))
                    
                }
                
                Section {
                    
                    
                    TextField("Nothing", text: $taskDescription)
                       
                    
                } header: {
                    Text("Task Decscription")
                        .font(.callout.weight(.light))
                    
                }
                
                if model.editTask == nil{
                    
                    
                    
                    Section {
                        DatePicker("", selection: $taskDate)
                            .datePickerStyle(.graphical)
                            .labelsHidden()
                    } header: {
                        Text("Task Title")
                            .font(.callout.weight(.light))
                        
                        
                        
                        
                    }

                    
                }

                
                
                
                
            }
            .listStyle(.insetGrouped)
            .navigationTitle("NEW TASK")
            .navigationBarTitleDisplayMode(.inline)
            .interactiveDismissDisabled()
            .toolbar {
                
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    
                    Button {
                        
                        
                        if let task = model.editTask{
                            
                            task.taskTitle = taskTitle
                            task.taskDescription = taskDescription
                            
                            
                        }
                        else{
                            
                            
                            let task = Task(context: context)
                            task.taskTitle = taskTitle
                            task.taskDescription = taskDescription
                            task.taskDate = taskDate
                        }
                        
                        try? context.save()
                        dissmiss()
                        
                        
                    } label: {
                        
                        Text("SAVE")
                    }
                    .disabled(taskTitle == "" || taskDescription == "")

                }
                
                
                ToolbarItem(placement: .navigationBarLeading) {
                    
                    
                    Button {
                        
                        dissmiss()
                        
                    } label: {
                        
                        Text("Cancel")
                    }

                }
            }
            .onAppear {
                
                
                if let task = model.editTask{
                    
                    
                    taskTitle = task.taskTitle ?? ""
                    taskDescription = task.taskDescription ?? ""
                    
                    
                }
            }
            
        }
    }
}

struct NewTask_Previews: PreviewProvider {
    static var previews: some View {
        NewTask()
    }
}
