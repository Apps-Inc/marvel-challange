//
//  RandomAccessCollection+Indexed.swift
//  DesafioGithub
//
// https://stackoverflow.com/questions/57842214/how-to-get-row-index-in-swiftui-list
//

// This is taken from the Release Notes, with a typo correction, marked below
struct IndexedCollection<Base: RandomAccessCollection>: RandomAccessCollection {
    typealias Index = Base.Index
    typealias Element = (index: Index, element: Base.Element)

    let base: Base

    var startIndex: Index { base.startIndex }

   // corrected typo: base.endIndex, instead of base.startIndex
    var endIndex: Index { base.endIndex }

    func index(after index: Index) -> Index {
        base.index(after: index)
    }

    func index(before index: Index) -> Index {
        base.index(before: index)
    }

    func index(_ index: Index, offsetBy distance: Int) -> Index {
        base.index(index, offsetBy: distance)
    }

    subscript(position: Index) -> Element {
        (index: position, element: base[position])
    }
}

extension RandomAccessCollection {
    func indexed() -> IndexedCollection<Self> {
        IndexedCollection(base: self)
    }
}
