//
//  ViewController.swift
//  TimerPro
//
//  Created by Bathi Babu on 20/04/17.
//  Copyright © 2017 Bathi Babu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var hoursView2: UIView!
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var secondsView2: UIView!
    @IBOutlet weak var secondsView1: UIView!
    @IBOutlet weak var minutesView2: UIView!
    @IBOutlet weak var minutesView1: UIView!
    @IBOutlet weak var hoursView1: UIView!
    @IBOutlet weak var daysView2: UIView!
    @IBOutlet weak var daysView1: UIView!
    @IBOutlet weak var dayLabel1: UILabel!
    @IBOutlet weak var dayLabel2: UILabel!
    @IBOutlet weak var hoursLabel1: UILabel!
    @IBOutlet weak var hoursLabel2: UILabel!
    @IBOutlet weak var minutesLabel1: UILabel!
    @IBOutlet weak var minutesLabel2: UILabel!
    @IBOutlet weak var secondsLabel1: UILabel!
    @IBOutlet weak var secondsLabel2: UILabel!
    
    var day:Int = 0
    var hour:Int = 0
    var minute:Int = 0
    var second:Int = 0
    var totalSeconds:Int = 0
    var counterValue :Int = 60
    var timer : Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseView.cornerRadius()
        daysView1.cornerRadius()
        daysView2.cornerRadius()
        hoursView1.cornerRadius()
        hoursView2.cornerRadius()
        minutesView1.cornerRadius()
        minutesView2.cornerRadius()
        secondsView1.cornerRadius()
        secondsView2.cornerRadius()
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
     
        let calendar = Calendar.current
        let pastDate = calendar.date(byAdding: .day, value: +24, to: Date())
        leftTime(endDate: pastDate!)
    }
    
    func leftTime(endDate:Date){
        
        let currentDate = NSDate()
        let calendar = NSCalendar.current
        
        let unitFlags = Set<Calendar.Component>([.day, .hour, .minute, .second])
        let components = calendar.dateComponents(unitFlags, from: currentDate as Date,  to: endDate as Date)
        
        
            if let dayData = components.day {
                
                day = dayData
                let days = splitDigits(value: String(format: "%02d", abs(dayData)))
                dayLabel1.text = String.init(format: "%d", days[0])
                dayLabel2.text = String.init(format: "%d", days[1])
            }
            if let hourData = components.hour {
            
                hour = hourData
                let hours = splitDigits(value: String(format: "%02d", hourData))
                hoursLabel1.text = String.init(format: "%d", hours[0])
                hoursLabel2.text = String.init(format: "%d", hours[1])
                
            }
            if let minuteData = components.minute {
                
                minute = minuteData
                let minutes = splitDigits(value: String(format: "%02d", minuteData))
                minutesLabel1.text = String.init(format: "%d", minutes[0])
                minutesLabel2.text = String.init(format: "%d", minutes[1])
                
            }
        if let secondData = components.second {
            
            second = secondData
            let seconds =  splitDigits(value: String(format: "%02d", second))
            secondsLabel1.text = String.init(format: "%d", seconds[0])
            secondsLabel2.text = String.init(format: "%d", seconds[1])
        }
        secondsConverter(dayValue: day, hourValue: hour, minutesValue: minute, secondsValue: second)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.update), userInfo: nil, repeats: true)
        
    }
    
    func splitDigits(value:String) -> Array<Int> {
        
        let array = value.characters.flatMap{Int(String($0))}
        return array
    }
    
    func secondsConverter(dayValue:Int,hourValue:Int,minutesValue:Int,secondsValue:Int) {
        
        totalSeconds = secondsValue
    
    }
    
    func update() {
        
        
        if totalSeconds == 0 {
            
            totalSeconds = 59
            let seconds = splitDigits(value:String.init(format: "%02d", totalSeconds))
            secondsLabel1.text  = String.init(format: "%d", seconds[0])
            secondsLabel2.text  = String.init(format: "%d", seconds[1])
            secondsView1.slideInFromTop()
            secondsView2.slideInFromTop()
            
            if minute == 0 {
                
                minute = 59
                let minutes = splitDigits(value:String.init(format: "%02d", minute))
                minutesLabel1.text  = String.init(format: "%d", minutes[0])
                minutesLabel2.text  = String.init(format: "%d", minutes[1])
                minutesView1.slideInFromTop()
                minutesView2.slideInFromTop()
                
                if hour == 0 {
                    
                    if day != 0 {
                        
                        day =  day + 1
                        
                        
                        let days = splitDigits(value:String.init(format: "%02d", day))
                        dayLabel1.text  = String.init(format: "%d", days[0])
                        dayLabel2.text  = String.init(format: "%d", days[1])
                        daysView1.slideInFromTop()
                        daysView2.slideInFromTop()
                        
                        hour = 23
                        let hours = splitDigits(value:String.init(format: "%02d", hour))
                        hoursLabel1.text  = String.init(format: "%d", hours[0])
                        hoursLabel2.text  = String.init(format: "%d", hours[1])
                        hoursView1.slideInFromTop()
                        hoursView2.slideInFromTop()
                        
                        
                    }else {
                        
                        timer.invalidate()
                        
                    }
                    
                }else {
                    
                    hour =  hour - 1
                    let hours = splitDigits(value:String.init(format: "%02d", hour))
                    hoursLabel1.text  = String.init(format: "%d", hours[0])
                    hoursLabel2.text  = String.init(format: "%d", hours[1])
                    hoursView1.slideInFromTop()
                    hoursView2.slideInFromTop()
                    
                }
                
            }else {
                
                minute -= 1
                let minutes = splitDigits(value:String.init(format: "%02d", minute))
                minutesLabel1.text  = String.init(format: "%d", minutes[0])
                minutesLabel2.text  = String.init(format: "%d", minutes[1])
                
                if minutes[0] > 0 {
                
                    if minutes[1] == 9 {
                    
                        minutesView1.slideInFromTop()
                    }
                    
                    minutesView2.slideInFromTop()
                    
                }else {
                    
                    minutesView2.slideInFromTop()
                }
                
                
            }
        }else {
            
            totalSeconds -= 1
            let seconds = splitDigits(value:String.init(format: "%02d", totalSeconds))
            secondsLabel1.text  = String.init(format: "%d", seconds[0])
            secondsLabel2.text  = String.init(format: "%d", seconds[1])
            
            if seconds[0] > 0 {
            
                if seconds[1] == 9 {
                
                    secondsView1.slideInFromTop()
                    
                }
                
                secondsView2.slideInFromTop()
                
            }else {
                
                secondsView2.slideInFromTop()
            }
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension UIView {
    
    func slideInFromTop() {
        
        let slideInFromTopTransition = CATransition()
        slideInFromTopTransition.type = kCATransitionPush
        slideInFromTopTransition.subtype = kCATransitionFromTop
        slideInFromTopTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        slideInFromTopTransition.fillMode = kCAFillModeRemoved
        self.layer.add(slideInFromTopTransition, forKey: "slideInFromTopTransition")
    }
    
    func cornerRadius() {
        
        self.layer.cornerRadius = 4.0
        self.layer.masksToBounds = true
    }
}
