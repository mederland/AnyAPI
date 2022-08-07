//
//  BooksViewModel.swift
//  BookApp
//
//  Created by Consultant on 8/6/22.
//

import UIKit

@objcMembers
class BooksViewModel: NSObject {
    
    private let networkManager: NetworkManager
    private var books: [Book] = [] {
        didSet {
            self.updateHandler?()
        }
    }
    private var currentPage: PageResult?
    private var updateHandler: (() -> Void)?
    
    @objc
    init(networkManager: NetworkManager = NetworkManager.sharedInstance()) {
        self.networkManager = networkManager
    }
    
    @objc
    func bind(updateHandler: @escaping () -> Void) {
        self.updateHandler = updateHandler
    }
    
    @objc
    func fetchBookPage() {
        
        var pageNumber = 1
        if let pageN = self.currentPage?.num_results {
            pageNumber = pageN + 1
        }
        
        self.networkManager.fetchBooks(withPageNumber: pageNumber) { [weak self] (pageResult: PageResult?) in
            self?.currentPage = pageResult
            guard let books = pageResult?.results as? [Book] else { return }
            self?.books.append(contentsOf: books)
        }
    }
    
    var count: Int {
        return self.books.count
    }
    
    func title(for index: Int) -> String? {
        guard index < self.books.count else { return nil }
        return self.books[index].title
    }
    
    func image(for index: Int, completion: @escaping (UIImage?) -> Void) {
        guard index < self.books.count else {
            completion(nil)
            return
        }

        self.networkManager.fetchImage(with: self.books[index].bookImage) { (image: UIImage?) in
            completion(image)
        }
    }
    
    func example() -> (Int, String) {
        return (5, "Hello")
    }
    
}

extension BooksViewModel {
    
    @objc
    func exampleToObjc() -> TupleSubstitute {
        let tuple = self.example()
        return TupleSubstitute(num: tuple.0, str: tuple.1)
    }
    
}

class TupleSubstitute: NSObject {
    
    let number: Int
    let str: String
    
    init(num: Int, str: String) {
        self.number = num
        self.str = str
    }
    
}

extension NetworkManager {
    
    @objc
    func doSomething() {
        print("Function Doing Something")
    }
}

