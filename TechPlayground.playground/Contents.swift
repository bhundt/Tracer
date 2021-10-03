import Foundation

func calculateSomething(taskCount: Int) {
    print("start")
    let start = Date()
    var c : Int64 = 0
    for _ in 0 ..< (1000000/taskCount) {
        c += Int64.random(in: 0..<2)
    }
    let elapsed = Date().timeIntervalSince(start)
    print("end \(c) \(elapsed)")
}

let taskCount = 16
let start = Date()
let operationQueue = OperationQueue()
operationQueue.name = "test"
operationQueue.qualityOfService = .userInitiated
operationQueue.maxConcurrentOperationCount = 20

operationQueue.addOperations((0 ..< taskCount).map { _ in BlockOperation {
    calculateSomething(taskCount: taskCount)
}}, waitUntilFinished: true)
operationQueue.addBarrierBlock {
    let elapsed = Date().timeIntervalSince(start)
    print("finish: \(elapsed)")
}
