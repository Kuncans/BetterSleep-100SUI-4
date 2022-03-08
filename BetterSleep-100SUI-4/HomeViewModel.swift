//
//  HomeViewModel.swift
//  BetterSleep-100SUI-4
//
//  Created by Duncan Kent on 08/03/2022.
//

import CoreML
import Foundation

final class HomeViewModel: ObservableObject {
    
    @Published var coffeeAmount: Int = 1
    @Published var sleepAmount: Double = 8.0
    @Published var wakeUp = defaultWakeTime
    
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var alertShowing = false
    
    @Published var sleepResults = ""
    
    var sleepResultsCalc: String {
        return calculateBedtime()
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    func calculateBedtime() -> String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            return "Your ideal bedtime is " + sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch {
            
            return "Error calculating sleep time"
        }
    }
    
}
