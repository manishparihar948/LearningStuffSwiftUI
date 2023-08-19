//
//  TimerAndOnReceive.swift
//  LearningSwiftUI
//
//  Created by Manish Parihar on 19.08.23.
//

import SwiftUI

// Timer is actually a Publisher.
// Publisher is publishes a value over time.
// On Receive call is SwiftUI funtion, so that we can listen to the publisher, also known as Subscribing
//
//

struct TimerAndOnReceive: View {
    
    // puslish for 1 second, run on main thread, autoconnect starts this publisher this timer as soon as this screen loads
    let timer = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()
    
    @State var currentDate: Date = Date()
    
    // Cuttent Time - Code 1
    /*
    // Date formater
    var dateFormatter : DateFormatter {
        let formatter = DateFormatter()
        //formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }
    */
    
    // Count Down - Code 2
    /*
    @State var count: Int = 10
    @State var finishedText: String? = nil
    */
    
    // Countdown to date - Code 3
    /*
    @State var timeRemaning : String = ""
    //let futureDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    let futureDate: Date = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()
    
    func updateTimeRemainig() {
        //let remaining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: futureDate)
        let remaining = Calendar.current.dateComponents([.minute, .second], from: Date(), to: futureDate)
        let hour = remaining.hour ?? 0
        let minute = remaining.minute ?? 0
        let second = remaining.second ?? 0
        //timeRemaning = "\(hour):\(minute):\(second)"
        timeRemaning = "\(minute) minutes, \(second) seconds"
    }
    */
    
    // Animation counter - Code 4
    @State var count: Int = 0
    
    var body: some View {
        ZStack{
            RadialGradient(gradient: Gradient(colors: [Color.red, Color.blue]),
                           center: .center,
                           startRadius: 5,
                            endRadius: 500)
                           .ignoresSafeArea()
            
           // Text(dateFormatter.string(from: currentDate))
           // Text(finishedText ?? "\(count)")
           /*
            Text(timeRemaning)
                .font(.system(size: 100,weight: .semibold,design: .rounded))
                .foregroundColor(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.1) // if size goes big its scale down to one line
            */
           /*
            HStack(spacing:15){
                Circle()
                    .offset(y: count == 1 ? -20 : 0)
                Circle()
                    .offset(y: count == 2 ? -20 : 0)
                Circle()
                    .offset(y: count == 3 ? -20 : 0)
            }
            .frame(width: 150)
            .foregroundColor(.white)
            */
            
            TabView(selection: $count,
                    content: {
                Rectangle()
                    .foregroundColor(.red)
                    .tag(1)
                Rectangle()
                    .foregroundColor(.blue)
                    .tag(2)
                Rectangle()
                    .foregroundColor(.green)
                    .tag(3)
                Rectangle()
                    .foregroundColor(.pink)
                    .tag(4)
                Rectangle()
                    .foregroundColor(.orange)
                    .tag(5)
            })
            .frame(height: 200)
            .tabViewStyle(PageTabViewStyle())
        }
        // We are listening to the publishers here
        .onReceive(timer, perform: { _ in
           
            // Code 1
            // currentDate = value
            
            // Code 2
            /*
            if count < 1 {
                finishedText = "Wow!!"
            } else {
                count -= 1
            }
            */
            
            // Code 3
            //updateTimeRemainig()
            
            // Code 4
            /*
            withAnimation(.easeInOut(duration: 0.5)) {
                count = count == 3 ? 0 : count + 1
            }
            */
            
            /*
            if count == 3 {
                count = 0
            } else {
                count += 1
            }
            */
            
            withAnimation(.default){
                count = count == 5 ? 0 : count + 1
            }
            
        })
    }
}

struct TimerAndOnReceive_Previews: PreviewProvider {
    static var previews: some View {
        TimerAndOnReceive()
    }
}
