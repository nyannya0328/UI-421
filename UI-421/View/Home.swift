//
//  Home.swift
//  UI-421
//
//  Created by nyannyan0328 on 2022/01/14.
//

import SwiftUI

struct Home: View {
    @StateObject var model = TaskViewModel()
    
    @Environment(\.managedObjectContext) var context
    
    @Environment(\.editMode) var editButton
    
    @Namespace var animation
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            LazyVStack(spacing: 20, pinnedViews: [.sectionHeaders]) {
                
                Section {
                    
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        HStack(spacing:30){
                            
                            ForEach(model.currentWeek,id:\.self){day in
                                
                                
                                
                                VStack(spacing:10){
                                    
                                    Text(model.exTractDate(date: day, formatte: "dd"))
                                    
                                    Text(model.exTractDate(date: day, formatte: "EEE"))
                                    
                                    
                                
                                        
                                        Circle()
                                            .fill(.white)
                                            .blur(radius: 1)
                                            .opacity(model.isToday(date: day) ? 1 : 0)
                                            .frame(width: 10, height: 10)
                                    
                                        
                                    
                                    
                                    
                                    
                                }
                                .foregroundStyle(model.isToday(date: day) ? .primary : .secondary)
                                .foregroundColor(model.isToday(date: day) ? .white : .black)
                                .frame(width: 45, height: 90)
                                .background(
                                
                                    ZStack{
                                        
                                        
                                        if model.isToday(date: day){
                                            
                                            Capsule()
                                                .fill(.black)
                                                .matchedGeometryEffect(id: "TABANIMATON", in: animation)
                                            
                                            
                                        }
                                    }
                                
                                
                                )
                                .contentShape(Capsule())
                                .onTapGesture {
                                    
                                    withAnimation{
                                        
                                        
                                        model.currentDay = day
                                        

                                        
                                        
                                        
                                    }
                                }
                                
                                
                            }
                            
                            
                        }
                        .padding(.horizontal)
                        
                        
                    }
                    
                    
                    TaskView()
                    
                } header: {
                    
                    HeaderView()
                }

            }
            
        }
        .ignoresSafeArea(.container, edges: .top)
        .overlay(
        
            Button(action: {
                model.addNewTask.toggle()
            }, label: {
                
                Image(systemName: "plus")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black,in: Circle())
                    .shadow(color: .black.opacity(0.3), radius: 5, x: 5, y: 5)
                    .shadow(color: .white.opacity(0.3), radius: 5, x: -5, y: -5)
            })
                .padding()
            
            ,alignment: .bottomTrailing
        
        
        )
        .sheet(isPresented: $model.addNewTask) {
            
            model.editTask = nil
            
        } content: {
            
            
            NewTask()
                .environmentObject(model)
            
            
            
            
        }

    }
    
    func TaskCardView(task : Task)->some View{
        
        HStack(alignment: editButton?.wrappedValue == .active ? .center : .top, spacing: 15){
            
            
            
            if editButton?.wrappedValue == .active{
                
                
                
            
                
                
                
                
                VStack(spacing:20){
                    
                    
                    
                    if task.taskDate?.compare(Date()) == .orderedAscending || Calendar.current.isDateInToday(task.taskDate ?? Date()){
                        
                        
                        Button {
                            
                            
                            model.editTask = task
                            model.addNewTask.toggle()
                            
                            
                            
                            
                        } label: {
                            
                            Image(systemName: "pencil.circle.fill")
                               
                                .foregroundColor(.white)
                                .padding(2)
                                .background(Color.black,in: Circle())
                        }
                    }
                  
                    
                    
                    
                
                    
                    Button {
                        
                        
                        context.delete(task)
                        try? context.save()
                        
                        
                        
                        
                    } label: {
                        
                        Image(systemName: "minus.circle.fill")
                            
                            .foregroundColor(.white)
                            .padding(2)
                            .background(Color.red,in: Circle())
                    }


                    
                }
                
                
            }
            else{
                VStack(spacing:10){
                    
                    
                    Circle()
                        .fill(model.currentIsHounr(date: task.taskDate ?? Date()) ? (task.isCompleted ? .green : .black) : .clear)
                        .frame(width: 15, height: 15)
                        .background(
                        
                        
                        Circle()
                            .stroke(.black,lineWidth:1)
                            .padding(-1)
                        
                        
                        )
                        .scaleEffect(model.currentIsHounr(date: task.taskDate ?? Date()) ? 0.8 : 1)
                    
                    
                    Rectangle()
                        .fill(.black)
                        .frame(width: 3)
                    
                    
                }
            }
            
            
            VStack{
                
                
                HStack(alignment:.top,spacing: 10){
                    
                    VStack(alignment: .leading, spacing: 13) {
                        
                        
                        
                        Text(task.taskTitle ?? "")
                            .font(.title2.bold())
                            .foregroundColor(.black)
                        
                        
                        Text(task.taskDescription ?? "")
                            .font(.callout)
                            .foregroundColor(.secondary)
                        
                        
                    }
                    .lLeading()
                    
                    
                    Text(task.taskDate?.formatted(date: .omitted, time: .shortened) ?? "")
                      
                    
                    
                    
                }
                
                if model.currentIsHounr(date: task.taskDate ?? Date()){
                    
                    
                    HStack{
                        
                        if !task.isCompleted{
                            
                            Button {
                                
                                
                                task.isCompleted = true
                                
                                try? context.save()
                                
                            } label: {
                                
                                
                                Image(systemName: "checkmark")
                                    .foregroundStyle(.black)
                                    .padding(10)
                                    .background(Color .white,in: RoundedRectangle(cornerRadius: 10))
                                
                            }
                            
                        }
                        
                        Text(task.isCompleted ? "Marked as Completed" : "Mark Task As Completed")
                            .font(.system(size: task.isCompleted ? 15 : 17))
                            .foregroundColor(task.isCompleted ? .gray : .white)
                            .lLeading()
                        
                        
                        

                        
                        
                        
                    }
                    .padding(.top)
                    
                    
                    
                    
                }
                
                
                
                
            }
            .foregroundColor(model.currentIsHounr(date: task.taskDate ?? Date()) ? .white : .black)
            .padding(model.currentIsHounr(date: task.taskDate ?? Date()) ? 10 : 0)
            .padding(.bottom,model.currentIsHounr(date: task.taskDate ?? Date()) ? 0 : 10)
            .lLeading()
            .background(
            
            
        Color("Black")
            .cornerRadius(25)
            .opacity(model.currentIsHounr(date: task.taskDate ?? Date()) ? 1 : 0)
            
            )
            
            
            
            
        }
    
        .lLeading()
        
        
        
    }
    
    
    func TaskView()->some View{
        
        
        LazyVStack(spacing:10){
            
            
            DynamicFilterView(dateFilterd: model.currentDay) { (objcet : Task) in
                TaskCardView(task: objcet)
                
                
                
                
            }
            
            
            
        }
        .padding()
        .padding(.top)
        
        
        
        
        
    }
    func HeaderView()->some View{
        
        
        HStack{
            
            VStack{
                Text(Date().formatted(date: .abbreviated, time: .omitted))
                    .font(.title3.weight(.light))
                
                Text("Today")
                    .font(.largeTitle.weight(.light))
                    .kerning(1.3)
                    
                
            }
            .lLeading()
            
            
            EditButton()
            
        }
        .padding(.horizontal)
        .padding(.top,getSafeArea().top)
        .background(Color.white)
        
       
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
