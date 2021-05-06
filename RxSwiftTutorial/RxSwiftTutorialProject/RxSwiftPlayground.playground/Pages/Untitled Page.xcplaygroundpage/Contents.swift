import UIKit
import RxSwift

////'just'
//let observable = Observable.just(1)
//
////'of' Allows you to create observable with set and array of different element
////'of' will create observable to whole array
//let observable2 = Observable.of(1,2,3)
//
//observable2.subscribe { event in
////    print(event)
//}
//
////Using 'onNext' we dont need to unwrap event value
//observable2.subscribe(onNext: { element in
////    print(element)
//})
//
//
//
//let observable3 = Observable.of([1,2,3])
//
//observable3.subscribe { event in
//    if let element = event.element{
////        print(element)
//    }
//}
//
//
//
////'from' means this observable will contain items of array 1,2,3,4
//let  observable4 = Observable.from([1,2,3,4])
//
//observable4.subscribe { event in
//    if let element = event.element{
////        print(element)
//    }
//}
//
////Using 'onNext' we dont need to unwrap event value
//observable4.subscribe(onNext: { element in
////    print(element)
//})
//
//
//
//
////Dispose the Subscriber
//
////Dispose the subscription to avoid memory leak
//let subscription = observable4.subscribe(onNext: { element in
////    print(element)
//})
//subscription.dispose()


//Use DisposeBag to dispose the Subscriber
let dispose = DisposeBag()

Observable.of("A","B","C")
    .subscribe{
//        print($0)
}.disposed(by: dispose)

Observable<String>.create { observer in
    observer.onNext("A")
    observer.onCompleted()
    observer.onNext("?")
    //whenever u are creating (.create) the observable u have to return the Disposables
    return Disposables.create()
}.subscribe(onNext: { print($0) }, onError: { print($0) }, onCompleted: {
//    print("Completed")
}, onDisposed: {
//    print("Disposed")
})
    .disposed(by: dispose)




//Subjects: They are observables and the observer
//example of subject is Newspaper: It gets the news from someone and then it spread to other people(subscriber).
//Types of Subject : Behavior Subject, Replay Subject, Publish subject, Variable, BehaviorRelay

//1. Publish Subject
let subject = PublishSubject<String>()

//Event before subscriber will not work
subject.onNext("issue 1")

subject.subscribe { event in
//    print(event)
}
subject.onNext("issue 2")
subject.onNext("issue 3")

subject.dispose()
//subject.onCompleted()

//Event after dispose or onCompleted will not work
subject.onNext("issue 4")


//1. Behaviour Subject
//Similar to Publish subject with one difference
//In order to initialize behaviour subject you have to pass initial value. and it will init the last value which is available
let bSubject = BehaviorSubject(value: "Initial value")

bSubject.onNext("before initial value")
bSubject.subscribe { event in
//    print(event)
}

bSubject.onNext("After initial value")



//2. Replay Subject
//replays the event based on the buffer size you set
//it will replay execute last bufferSize events
let replaySubject = ReplaySubject<String>.create(bufferSize: 2)

//it will not execute as subscriber is set after setting events
replaySubject.onNext("i m 1")
replaySubject.onNext("i m 2")
replaySubject.onNext("i m 3")

replaySubject.subscribe { event in
    print(event)
//    print($0)
}

replaySubject.onNext("i m 4")
replaySubject.onNext("i m 5")
replaySubject.onNext("i m 6")

print("subscriber 2")
replaySubject.subscribe {
    print($0)
}

//TODO: check
replaySubject.onNext("i m 7")


//3. Variables (subjects)
//Variables : its a behaviour subject and it stores its value in state and access a value using value property
//It is deprecated subject. It is replaced by using BehaviourRelay

//let variable = Variable



