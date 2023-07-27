//
//  CategoryTableController.swift
//  MovieSearch
//
//  Created by Rahul Thengadi on 30/03/22.
//

import UIKit
import StorageProvider

class CategoryTableController: UITableViewController {
    
    // MARK: Properties
    let tableViewCellIdentifier = "categoryCell"
    
    var categoryListVM = CategoryListViewModel()
    var searchController: UISearchController!
    private var resultsTableController: ResultsTableController!
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Categories"
        setupSearchController()
    }
    
    // MARK: Helpers
    private func setupSearchController() {
        resultsTableController = storyboard?.instantiateViewController(withIdentifier: "ResultsTableController") as? ResultsTableController
        resultsTableController.resultControllerDelegate = self
        searchController = UISearchController(searchResultsController: resultsTableController)
        searchController.searchResultsUpdater = resultsTableController
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "search movies by title/actor/genre/director"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

// MARK: ResultControllerDidTapGesture
extension CategoryTableController: ResultControllerDidTapGesture {
    func didTapResultControllerView() {
        searchController.searchBar.resignFirstResponder()
    }
}

// MARK: CategoryTableViewDataSource
extension CategoryTableController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return categoryListVM.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryListVM.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath)
        let categoryVM = categoryListVM.categoryAtIndexPath(indexPath.row)
        cell.configureCell(categoryVM, indexPath: indexPath)
        return cell
    }
}

// MARK: UITableViewCell
extension UITableViewCell {
    func configureCell(_ viewModel: CategoryViewModel, indexPath: IndexPath) {
        textLabel?.text = viewModel.category.rawValue.capitalized
        textLabel?.numberOfLines = 0
        accessoryType = .disclosureIndicator
    }
}


// MARK: CategoryTableViewDelegate
extension CategoryTableController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let category = categoryListVM.categories[indexPath.row]
        let detailListVM = getDetail(at: indexPath.row)
        let detailTC = storyboard?.instantiateViewController(withIdentifier: "DetailTableController") as! DetailTableController
        detailTC.title = category.rawValue.capitalized
        detailTC.detailListVM = detailListVM
        // could be improved using Router design pattern
        navigationController?.pushViewController(detailTC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView === self.tableView {
            return 44
        } else {
            return 232
        }
    }
    
    // TODO: could be moved viewModel extension / struct but could ties the Store with viewModel
    // some kind of coordinator pattern, may be needed make it loose coupled
    
    func getDetail(at index: Int) -> DetailListViewModel? {
        switch index {
        case 0:
            Category.currentCategory = .year
            return DetailListViewModel.getYears()
        case 1:
            Category.currentCategory = .genre
            return DetailListViewModel.getGenres()
        case 2:
            Category.currentCategory = .directors
            return DetailListViewModel.getDirectors()
        case 3:
            Category.currentCategory = .actors
            return DetailListViewModel.getActors()
        default:
            break
        }
        return nil
    }
}

// MARK: UISearchBarDelegate
extension CategoryTableController: UISearchBarDelegate {
    
}

// MARK: UISearchControllerDelegate
extension CategoryTableController: UISearchControllerDelegate {
    
}

extension DetailListViewModel {
    static func getGenres() -> DetailListViewModel {
        let uniqueGenre = Set(Store.movies.map { $0.genre.split(separator: ",") }.flatMap { $0 }.map { $0.trimmingCharacters(in: .whitespaces) })
        return DetailListViewModel(details: uniqueGenre.map { Detail(value: String($0)) })
    }
    
    static func getYears() -> DetailListViewModel {
        return DetailListViewModel(details: Array(Set(Store.movies.map { Detail(value: $0.year) })))
    }
    
    static func getActors() -> DetailListViewModel {
        let uniqueActors = Set(Store.movies.map { $0.actors.split(separator: ",") }.flatMap { $0 }.map { $0.trimmingCharacters(in: .whitespaces) })
        return DetailListViewModel(details: uniqueActors.map { Detail(value: String($0)) })
    }
    
    static func getDirectors() -> DetailListViewModel {
        let uniqueDirectors = Set(Store.movies.map { $0.director.split(separator: ",") }.flatMap { $0 }.map { $0.trimmingCharacters(in: .whitespaces)})
        return DetailListViewModel(details: uniqueDirectors.map { Detail(value: String($0)) })
    }
}
