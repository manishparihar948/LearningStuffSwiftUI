//
//  LocalNotificationsBootCamp.swift
//  LearningSwiftUI
//
//  Created by Manish Parihar on 16.08.23.
//

import SwiftUI
import UserNotifications
import CoreLocation

// Singleton Class
class NotificationManager {
    
    static let instance = NotificationManager() // This is singleton
    
    func requestAuthorization() {
        
        let option: UNAuthorizationOptions = [.alert,.sound,.badge]
        UNUserNotificationCenter.current().requestAuthorization(options:option) {(success, error) in
            if let error = error {
                print("Error: \(error)")
            } else {
                print("Success")
            }
            
        }
    }
    
    func scheduleNotification() {
        
        let content = UNMutableNotificationContent()
        content.title = "Title is my first notification"
        content.subtitle = "Waow this was so easy"
        content.sound = .default
        content.badge = 1
        
        // There is 3 types of trigger we can send
        // time
        // let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        // calender
        var dateComponents = DateComponents()
        dateComponents.hour = 12
        dateComponents.minute = 29
        // dateComponents.weekday = 2 // Modany
        //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // location
        let coordinates = CLLocationCoordinate2D(
            latitude: 40.00,
            longitude: 50.00)
        
        let region = CLCircularRegion(
            center: coordinates,
            radius: 100,
            identifier: UUID().uuidString)
        region.notifyOnEntry = true // When use enter
        region.notifyOnExit = false // When use leave
        let trigger = UNLocationNotificationTrigger(region:region, repeats: true)
        
        
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification () {
        // Remove all the notifiation from the app and from notification center
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}

struct LocalNotificationsBootCamp: View {
    var body: some View {
        VStack (spacing:40){
            Button("Request Permission"){
                NotificationManager.instance.requestAuthorization()
            }
            
            Button("Schedule Notification"){
                NotificationManager.instance.scheduleNotification()
            }
            
            Button("Cancel Notification"){
                NotificationManager.instance.cancelNotification()
            }

        }
        .onAppear{
            // To remove Badge from App icon
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
}

struct LocalNotificationsBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotificationsBootCamp()
    }
}
