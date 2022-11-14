//: [Previous](@previous)
import Foundation

protocol Row {
    var title: String { get }
}
@resultBuilder struct ListBuilder {
    static func buildBlock<R: Row>(_ components: R...) -> [R] {
        return components
    }
    
    static func buildBlock<R: Row>(_ components: [R]...) -> [R] {
        return components.flatMap { $0 }
    }
    
    static func buildEither<First, Second>(first component: [First]) -> [EitherRow<First, Second>] {
        return component.map { EitherRow(row: $0) }
    }

    static func buildEither<First, Second>(second component: [Second]) -> [EitherRow<First, Second>] {
        return component.map { EitherRow(row: $0) }
    }
    
}
struct List<R: Row> {
    let rows: [R]
    init(@ListBuilder _ content: () -> [R]) {
        rows = content()
    }
}

struct MacOSRow: Row {
    let title: String
}

@available(iOS 99, *)
struct iOSRow: Row {
    let title: String
}

struct EitherRow<First: Row, Second: Row>: Row {
    let row: Row
    var title: String { row.title }
}

struct AnyRow: Row {
    let row:Row
    var title: String { row.title}
}
extension ListBuilder {
    static func buildLimitedAvailability<R:Row>(_ component: [R]) -> [AnyRow] {
        return component.map{ AnyRow(row: $0) }
    }
}
let buildLimitedAvailabilityList = List {
    if #available(iOS 99, *) {
        iOSRow(title: "Row 1")
    } else {
        MacOSRow(title: "MacOS Row 1")
    }
}
//: [Next](@next)
