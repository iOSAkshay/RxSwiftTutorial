//
//  ViewController.swift
//  RxSwiftTutorialProject
//
//  Created by Akshay Nandane on 29/04/21.
//  Copyright © 2021 com.app.connectme. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //ReplaySubject
        relaySubject()
        //BehaviorRelay
        BehRelay()
    }
    
    func relaySubject(){
        //2. Replay Subject
        //replays the event based on the buffer size you set
        //it will replay execute last bufferSize events
        let replaySubject = ReplaySubject<String>.create(bufferSize: 2)

        //it will not execute as subscriber is set after setting events
        replaySubject.onNext("i m 1")
        replaySubject.onNext("i m 2")
        replaySubject.onNext("i m 3")

        replaySubject.subscribe { event in
//            print("😁 \(event)")
//            print($0)
        }

        replaySubject.onNext("i m 4")
        replaySubject.onNext("i m 5")
        replaySubject.onNext("i m 6")

//        print("subscriber 2")
        replaySubject.subscribe {
//            print($0)
        }

        //TODO: check
        replaySubject.onNext("i m 7")
    }
    
    //BehaviorRelay
    func BehRelay(){
        let relay = BehaviorRelay(value: ["Initisal value","abs"])
        relay.asObservable().subscribe{
                print($0)
        }
        
        //Cannot assign to property: 'value' is a get-only property
//        relay.value = "change value"
        //Add value in BehaviourRelay
        relay.accept(relay.value + ["New Value"])
    }


}

