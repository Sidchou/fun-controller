//
//  ViewController.swift
//  funController
//
//  Created by ching Hsi chou on 3/5/19.
//  Copyright © 2019 ching Hsi chou. All rights reserved.
//

import UIKit
import Starscream
import CoreMotion

class ViewController: UIViewController, WebSocketDelegate, UITextFieldDelegate {
//    var arrowLabel:arrowView!
    @IBOutlet weak var arrowLabel: UIView!
    var socket: WebSocket?

    @IBOutlet var tapGest: UITapGestureRecognizer!
    var motionManager = CMMotionManager()
    var ref: Double = 0
    var motionReading: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.\
//        arrowLabel = arrowView(frame: CGRect(x:0, y:0, width:200, height:400))
//        arrowLabel.center = CGPoint(x: 160 , y: 284)
        
        // URL of the websocket server.
        let urlString = "wss://gameserver.mobilelabclass.com"
        
        // Create a WebSocket.
        socket = WebSocket(url: URL(string: urlString)!)
        
        
        // Assign WebSocket delegate to self
        socket?.delegate = self
        
        // Connect.
        socket?.connect()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        motionManager.gyroUpdateInterval = 2
//        motionManager.startGyroUpdates(to: OperationQueue.current!){(data, error) in
//            if let myData = data
//            {
//                print(myData.rotationRate)
//            }
//        }
//    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        motionManager.deviceMotionUpdateInterval = 1
        motionManager.startDeviceMotionUpdates(using: .xMagneticNorthZVertical, to: .main, withHandler: { (motionData: CMDeviceMotion?, error: Error?) in
            if let motion = motionData {
                self.motionReading = motion.heading
//                print("heading:", self.motionReading)
                var refHeading = motion.heading + 360 - self.ref
                refHeading.formTruncatingRemainder(dividingBy: 360.00)
                print("ref heading:", refHeading)
                let postReq:Int = Int(floor(refHeading/90))
                print("post request", postReq)
                self.sendDirectionMessage(theInt: postReq)
            }
        })
        
        
    }
    @IBAction func tap(_ sender: UIGestureRecognizer) {
        ref = motionReading - 45.00
        print("set ref as ", ref)
    }
    
    func websocketDidConnect(socket: WebSocketClient) {
        print("did connect")
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("disconnect")
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
//        print(Data.self)
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
//        print(Data.self)
    }
    func sendDirectionMessage(theInt:Int) {
        // Get the raw string value from the DirectionCode enum
        // that we created at the top of this program.
        sendMessage(String(theInt))
    }
    
    func sendMessage(_ message: String) {
        // Check if there is a valid player id set.
         let playerId =  "Sid"
        
        // Construct server message and write to socket. ///////////
        let message = "\(playerId), \(message)"
        socket?.write(string: message) {
            // This is a completion block.
            // We can write custom code here that will run once the message is sent.
            print("⬆️ sent message to server: ", message)
        }
    }
}

