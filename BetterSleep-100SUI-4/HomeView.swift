//
//  HomeView.swift
//  BetterSleep-100SUI-4
//
//  Created by Duncan Kent on 08/03/2022.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var vm = HomeViewModel()
    
    var sleepResults: String {
        vm.calculateBedtime()
    }
    
    var body: some View {
        
        NavigationView {
            
            Form {
                
                Section ("When do you want to wake up?") {
                    DatePicker("Select time", selection: $vm.wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                
                Section ("Desired amount of sleep") {
                    Stepper("\(vm.sleepAmount.formatted()) hours", value: $vm.sleepAmount, in: 4...12, step: 0.25)
                }
                
                Section("Daily coffee intake") {
                    Stepper(vm.coffeeAmount == 1 ? "1 cup" : "\(vm.coffeeAmount) cups", value: $vm.coffeeAmount, in: 1...10)
                }
                
                Text(sleepResults)
                    .font(.title3)
                
            }
            .font(.headline)
            .navigationTitle("BetterRest")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
