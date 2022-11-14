//: [Previous](@previous)

import Foundation

protocol Row {
    var title: String { get }
}
struct ListBuilder {
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
    init(_ content: () -> [R]) {
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
    let row: Row
    var title: String { row.title }
}
extension ListBuilder {
    static func buildLimitedAvailability<R:Row>(_ component: [R]) -> [AnyRow] {
        return component.map{ AnyRow(row: $0) }
    }
}
let buildLimitedAvailabilityList = List {
    var v1: [EitherRow<AnyRow, MacOSRow>]
    if #available(iOS 99, *) {
        let v2 = iOSRow(title: "Row 1")                     // iOSRow
        let v3 = ListBuilder.buildBlock(v2)                 // [iOSRow]
        let v4 = ListBuilder.buildLimitedAvailability(v3)   // [AnyRow]
        v1 = ListBuilder.buildEither(first: v4)             // [EitherRow<AnyRow,MacOSRow>]
    } else {
        let v2 = MacOSRow(title: "MacOS Row 1")             // MacOSRow
        let v3 = ListBuilder.buildBlock(v2)                 // [MacOSRow]
        v1 = ListBuilder.buildEither(second: v3)            // [EitherRow<AnyRow,MacOSRow>]
    }
    return ListBuilder.buildBlock(v1)
}

//: [Next](@next)
