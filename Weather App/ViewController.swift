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
    
    
    @IBOutlet var textField: UITextField!
    
    @IBOutlet var webView: UIWebView!
    
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
        
            var urlString = urlStart + val + urlEnd;
        
            var url = NSURL(string: urlString);
        
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!){
                (data, response, error) in
            
                if(error == nil){
                
                    var content = NSString(data: data, encoding: NSUTF8StringEncoding);
                    
                    dispatch_async(dispatch_get_main_queue()){
                
                        //self.webView.loadHTMLString(content! as String, baseURL: nil);
                        
                        contentArray = content!.componentsSeparatedByString("<span class=\"phrase\">");
                        
                        weather = contentArray[1] as! String;
                        
                        weatherArray = weather.componentsSeparatedByString("</span>");
                        
                        weather = weatherArray[0] as! String;
                        
                        println(weather);
                    
                    }
                
                }
            }
        
            task.resume();
            
        }
        
    }
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        self.view.endEditing(true);
        
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        self.textField.resignFirstResponder();
        
        getWeather();
        
        return false;
        
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

