//
//  TaskViewModel.swift
//  UI-421
//
//  Created by nyannyan0328 on 2022/01/14.
//

import SwiftUI

class TaskViewModel: ObservableObject {
    
    
    @Published var addNewTask : Bool = false
    @Published var editTask : Task?
    
    
    @Published var currentWeek : [Date] = []
    
    
    @Published var currentDay : Date = Date()
    
    
    
    init() {
        
        fetchCurrentWeek()
        
    }
    
    
    func fetchCurrentWeek(){
        
        
        let today = Date()
        
        let calender = Calendar.current
        
        let week = calender.dateInterval(of: .weekOfMonth, for: today)
        
        
        guard let firstWeek = week?.start else{
            
            
            return
            
        }
        
        (0..<6).forEach { day in
            
            
            if let weekDay = calender.date(byAdding: .day, value: day, to: firstWeek){
                
                
                currentWeek.append(weekDay)
                
            }
            
            
            
        }
        
        
    }
    
    
    func exTractDate(date : Date,formatte : String)->String{
        
        
        let formatted = DateFormatter()
        
        formatted.dateFormat = formatte
        
        return formatted.string(from: date)
        
    }
    
    
    func isToday(date : Date)->Bool{
        
        
        let calender = Calendar.current
        
        return calender.isDate(currentDay, inSameDayAs: date)
    }
    
    func currentIsHounr(date : Date)->Bool{
        
        let calender = Calendar.current
        let hour = calender.component(.hour, from: date)
        
        let currentHour = calender.component(.hour, from: date)
        
        
        let isToday = calender.isDateInToday(date)
        
        
        return (hour == currentHour && isToday)
        
        
    }
    
    
    
    
    
    
    
   
}

