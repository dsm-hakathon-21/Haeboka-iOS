import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit
import Then

import Core
import DesignSystem

typealias WordSetSectionModel = AnimatableSectionModel<String, WordSet>

class WordSetViewController: BaseVC {
    
    var storage: WordSetStorageType?
    
    private let setTableView = UITableView().then {
        $0.register(WordSetTableViewCell.self, forCellReuseIdentifier: WordSetTableViewCell.identifier)
        $0.backgroundColor = .secondarySystemBackground
        $0.separatorStyle = .none
    }
    
    private let createButton = UIButton().then {
        $0.backgroundColor = .systemPink
        $0.setTitle("세트 추가하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.setTitleColor(.systemGray, for: .highlighted)
        $0.contentMode = .scaleToFill
        $0.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        $0.layer.cornerRadius = 8
        $0.layer.cornerCurve = .continuous
        $0.layer.shadowOffset = CGSize(width: 3, height: 3)
        $0.layer.masksToBounds = false
    }
    
    private let popUpView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.layer.cornerCurve = .continuous
        $0.layer.masksToBounds = false
    }
    
    private let popUpLabel = UILabel().then {
        $0.text = "세트 추가 버튼을 눌러 단어장을 생성해보세요!"
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
    }
        
    override func attribute() {
        super.attribute()
        
        configureUI()
        setNavigationBar()
        
        print("WordSetViewController")
    }
    private func configureUI() {
        
        [
            setTableView,
            createButton,
            popUpView
        ].forEach { view.addSubview($0) }
        
        popUpView.addSubview(popUpLabel)
        
        setTableView.tableFooterView = UIView(frame: .init(x: 0, y: 0, width: view.frame.width, height: 80))
        
        setTableView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        createButton.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-10)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            $0.height.equalTo(40)
        }
        
        popUpView.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            $0.bottom.equalTo(createButton.snp.top).offset(-20)
        }
        
        popUpLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.equalToSuperview().offset(5)
            $0.trailing.equalToSuperview().offset(-5)
        }
    }
    
    private func setNavigationBar() {
        view.backgroundColor = .secondarySystemBackground
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .red
        navigationItem.backBarButtonItem = backBarButtonItem
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "자기주도"
    }
    
    var dataSource: RxTableViewSectionedAnimatedDataSource<WordSetSectionModel> = {
          let ds = RxTableViewSectionedAnimatedDataSource<WordSetSectionModel> { dataSource, tableView, indexPath, item -> UITableViewCell in
              let cell = tableView.dequeueReusableCell(withIdentifier: WordSetTableViewCell.identifier, for: indexPath) as! WordSetTableViewCell
              cell.setItem(item: item)
              return cell
          }
          ds.canEditRowAtIndexPath = { _, _ in return true }
          return ds
      }()
        
//      var wordSetList: Observable<[WordSetSectionModel]> {
//          return storage?.setList()
//              .map { wordSetList -> [WordSetSectionModel] in
//                  var sectionModels: [WordSetSectionModel] = []
//                  
//                  wordSetList.forEach { wordSet in
//                      let sectionModel = WordSetSectionModel(model: wordSet.title, items: [wordSet])
//                      sectionModels.append(sectionModel)
//                  }
//                  
//                  return sectionModels
//              } ?? Observable.just([.init(model: "더미", items: [.init(title: "더미값")])])
//      }
    var wordSetList: Observable<[WordSetSectionModel]> {
        let initialData = [
            WordSet(title: "Spanish Verbs", insertDate: Date(timeIntervalSinceNow: -86400)),
            WordSet(title: "French Vocabulary", insertDate: Date(timeIntervalSinceNow: -172800)),
            WordSet(title: "German Phrases", insertDate: Date(timeIntervalSinceNow: -259200))
        ]
        
        let sectionModels = initialData.map { wordSet -> WordSetSectionModel in
            WordSetSectionModel(model: wordSet.title, items: [wordSet])
        }
        
        return Observable.just(sectionModels)
    }
    
    override func bind() {
        createButton.rx.tap
                    .bind(onNext: { [weak self] in
                        self?.present(WordSetCreateViewController(), animated: true)
                    }).disposed(by: disposeBag)
        
        //        setTableView.rx.setDataSource(data)
        //            .disposed(by: disposeBag)
        setTableView.rx.setDelegate(self)
                    .disposed(by: disposeBag)
        
        self.wordSetList.bind(to: setTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        self.wordSetList
            .bind(
                with: self,
                onNext: { owner, items in
                    owner.sceneInitialSet(count: items.count)
                }
            )
            .disposed(by: disposeBag)
        
//        tableView.deselectRow(at: indexPath, animated: true)
//        coordinator.push(at: .main, scene: .list, title: model.title, model: model.identity, animated: true)
//        Observable.zip(setTableView.rx.modelSelected(WordSet.self), setTableView.rx.itemSelected)
//            .bind(
//                with: self,
//                onNext: { owner, event in
//                    owner.setTableView.deselectRow(at: event.1, animated: true)
//                    let vc = WordListViewController()
////                    vc.
//                    owner.navigationController?.pushViewController(vc, animated: true)
//                    
////                    owner.wordSetList.modelSelected(tableView: owner.setTableView, model: event.0, indexPath: event.1)
//                }
//            )
//            .disposed(by: disposeBag)
        Observable.zip(setTableView.rx.modelSelected(WordSet.self), setTableView.rx.itemSelected)
                   .bind { [weak self] (model, indexPath) in
                       self?.setTableView.deselectRow(at: indexPath, animated: true)
                       let vc = WordListViewController()
                       self?.navigationController?.pushViewController(vc, animated: true)
                   }
                   .disposed(by: disposeBag)
        
        setTableView.rx.modelDeleted(WordSet.self)
                    .bind { [weak self] wordSet in
                        self?.storage?.delete(set: wordSet)
                    }
                    .disposed(by: disposeBag)
        
//        setTableView.rx.itemMoved
//            .bind(
//                with: self,
//                onNext: { owner, indexPaths in]
//                    owner.storage?.move(source: indexPaths.sourceIndex, destination: indexPaths.destinationIndex)
//                }
//            )
//            .disposed(by: disposeBag)
    }
    
    private func sceneInitialSet(count: Int) {
        if count == 0 {
            UIView.transition(with: popUpView, duration: 0.5, options: .transitionFlipFromBottom) { [weak self] in
                self?.popUpView.isHidden = false
            }
        } else {
            popUpView.isHidden = true
        }
    }

}

extension WordSetViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
       if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
          navigationController?.setNavigationBarHidden(true, animated: true)
       } else {
          navigationController?.setNavigationBarHidden(false, animated: true)
       }
    }
}

extension WordSetViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
    }
}

