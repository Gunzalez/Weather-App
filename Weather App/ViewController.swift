//
//  ViewController.swift
//  Weather App
//
//  Created by Segun Konibire on 06/06/2015.
//  Copyright (c) 2015 Segun Konibire. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    let urlStart = "http://www.weather-forecast.com/locations/";
    let urlEnd = "/forecasts/latest";
    
    @IBOutlet var weatherText: UILabel!
    
    @IBOutlet var textField: UITextField!
    
    @IBAction func buttonPressed(sender: AnyObject) {
        
        self.textField.resignFirstResponder();
        
        getWeather();
        
    }
    
    
    func getWeather(){
        
        var val = textField.text;
        
        var contentArray = [];
        
        var weatherArray = [];
        
        var weather: String = "";
        
        if !val.isEmpty {
            
            val = val.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet());
            
            
            val = val.stringByReplacingOccurrencesOfString(" ", withString: "-");
        
            var urlString = urlStart + val + urlEnd;
            
            //val = val.stringByReplacingOccurrencesOfString(" ", withString: "-");
            
            var url = NSURL(string: urlString);
        
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!){
                (data, response, error) in
            
                if(error == nil){
                
                    var content = NSString(data: data, encoding: NSUTF8StringEncoding) as NSString!;
                    
                    dispatch_async(dispatch_get_main_queue()){
                        
                        contentArray = content.componentsSeparatedByString("<span class=\"phrase\">");
                        
                        weather = contentArray[1] as! String;
                        
                        weatherArray = weather.componentsSeparatedByString("</span>");
                        
                        weather = weatherArray[0] as! String;
                        
                        weather = weather.stringByReplacingOccurrencesOfString("&deg;C", withString: "º")
                        
                        //println(weather);
                        self.weatherText.text = weather;
                    
                    }
                
                }
            }
        
            task.resume();
            
        } else {
            
            weatherText.text = "Please enter a city, stupid!";
            
        }
        
    }
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        self.view.endEditing(true);
        
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        self.textField.resignFirstResponder();
        
        getWeather();
        
        return true;
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.textField.delegate = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

