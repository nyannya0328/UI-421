//
//  DynamicFilterView.swift
//  UI-421
//
//  Created by nyannyan0328 on 2022/01/14.
//

import SwiftUI
import CoreData

struct DynamicFilterView<Content : View,T>: View where T : NSManagedObject{
    
    @FetchRequest var request : FetchedResults<T>
    
    let content : (T) -> Content
    
    
    init(dateFilterd : Date,@ViewBuilder content : @escaping(T) -> Content) {
        
        let calender = Calendar.current
        let today = calender.startOfDay(for: dateFilterd)
        
        let tomorrow = calender.date(byAdding: .day, value: 1, to: today)!
        
        let filterKey = "taskDate"
        
        
        let predicate = NSPredicate(format: "\(filterKey) >= %@ And \(filterKey) < %@",argumentArray: [today,tomorrow])
        
        
        
        _request = FetchRequest(entity:T.entity() , sortDescriptors: [.init(keyPath: \Task.taskDate, ascending: false)], predicate:predicate)
        self.content = content
    }
    
    
    var body: some View {
        Group{
            
            
            if request.isEmpty{
                
                
                Text("Add New Task")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.black)
                    .offset(y: 100)
            }
            
            else{
                
                
                ForEach(request,id:\.objectID){object in
                    
                    content(object)
                }
            }
            
            
            
        }
    }
}
