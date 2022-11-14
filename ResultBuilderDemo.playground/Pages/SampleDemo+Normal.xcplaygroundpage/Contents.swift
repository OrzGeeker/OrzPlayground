
import Foundation

struct Row {
    let title: String
}
struct List {
    let rows: [Row]
}

let list = List(rows: [Row(title: "row 1"), Row(title: "row 2")])
//: [Next](@next)
