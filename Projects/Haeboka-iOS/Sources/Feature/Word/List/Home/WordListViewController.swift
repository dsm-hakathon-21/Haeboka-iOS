import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

import Core
import DesignSystem

class WordListViewController: BaseVC {

    let storage: WordStorage? = nil

    private let wordListTableView = UITableView().then {
        $0.register(WordListTableViewCell.self, forCellReuseIdentifier: WordListTableViewCell.identifier)
        $0.separatorStyle = .none
        $0.backgroundColor = .secondarySystemBackground
    }
    
    private let createButton = UIButton().then {
        $0.backgroundColor = .systemPink
        $0.setTitle("추가하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.contentMode = .scaleToFill
        $0.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        $0.layer.cornerRadius = 8
        $0.layer.cornerCurve = .continuous
        $0.layer.masksToBounds = false
    }
    
    private let testButton = UIButton().then {
        $0.backgroundColor = .systemPink
        $0.setTitle("학습하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.contentMode = .scaleToFill
        $0.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        $0.layer.cornerRadius = 8
        $0.layer.cornerCurve = .continuous
        $0.layer.masksToBounds = false
    }
    
    private let popUpView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.layer.cornerCurve = .continuous
        $0.layer.masksToBounds = false
    }
    
    private let popUpLabel = UILabel().then {
        $0.text = "추가하기 버튼을 눌러 단어를 생성할 수 있습니다!"
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.numberOfLines = 2
    }
    
    private let secondPopUpView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.layer.cornerCurve = .continuous
        $0.layer.masksToBounds = false
    }
    
    private let secondPopUpLabel = UILabel().then {
        $0.text = "단어 5개 부터 학습하기를 진행할 수 있습니다!"
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.numberOfLines = 2
    }
    
    private var words: [Word] = [
        Word(definition: "Bonjour", meaning: "Hello in French", parentIdentity: "French Vocabulary"),
        Word(definition: "Hola", meaning: "Hello in Spanish", parentIdentity: "Spanish Verbs"),
        Word(definition: "Guten Tag", meaning: "Good day in German", parentIdentity: "German Phrases")
    ]
    
    override func attribute() {
         super.attribute()
        
        wordListTableView.delegate = self
        wordListTableView.dataSource = self
    }
    
    public override func layout() {
        
        [
            wordListTableView,
            createButton,
            testButton,
            popUpView,
            secondPopUpView,
        ].forEach { view.addSubview($0) }
        
        popUpView.addSubview(popUpLabel)
        secondPopUpView.addSubview(secondPopUpLabel)
        
        wordListTableView.tableFooterView = UIView(frame: .init(x: 0, y: 0, width: view.frame.width, height: 80))
        
        wordListTableView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        createButton.snp.makeConstraints {
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-10)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            $0.leading.equalTo(view.snp.centerX).offset(10)
            $0.height.equalTo(40)
        }
        
        testButton.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            $0.trailing.equalTo(view.snp.centerX).offset(-10)
            $0.height.equalTo(40)
        }
        
        popUpView.snp.makeConstraints {
            $0.height.equalTo(80)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            $0.bottom.equalTo(secondPopUpView.snp.top).offset(-20)
        }
        
        popUpLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.equalToSuperview().offset(5)
            $0.trailing.equalToSuperview().offset(-5)
        }
        
        secondPopUpView.snp.makeConstraints {
            $0.height.equalTo(80)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            $0.bottom.equalTo(createButton.snp.top).offset(-20)
        }
        
        secondPopUpLabel.snp.makeConstraints {
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
        
//        storage?.wordList()
    }
    
    public override func bind() {
        createButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.present(WordListCreateViewController(), animated: true)
            }).disposed(by: disposeBag)
        wordListTableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
//        self.wordList
//            .bind(to: wordListTableView.rx.items(dataSource: self.dataSource))
//            .disposed(by: disposeBag)
//        
//        viewModel.wordList
//            .bind(
//                with: self,
//                onNext: { vc, items in
//                    vc.sceneInitialSet(count: items[0].items.count)
//                }
//            )
//            .disposed(by: disposeBag)
//        
//        wordListTableView.rx.itemSelected
//            .bind(
//                with: self,
//                onNext: { vc, indexPath in
//                    vc.viewModel.itemSelected(tableView: vc.wordListTableView, at: indexPath)
//                }
//            )
//            .disposed(by: disposeBag)
//        
//        wordListTableView.rx.modelDeleted(Word.self)
//            .bind(
//                with: viewModel,
//                onNext: { viewModel, word in
//                    viewModel.delete(word: word)
//                }
//            )
//            .disposed(by: disposeBag)
//        
//        createButton.rx.tap
//            .bind(
//                with: self,
//                onNext: { vc, _ in
//                    vc.viewModel.create(vc)
//                }
//            )
//            .disposed(by: disposeBag)
//        
//        testButton.rx.tap
//            .bind(
//                with: viewModel,
//                onNext: { vm, _ in
//                    vm.test()
//                }
//            )
//            .disposed(by: disposeBag)
//        
//        navigationItem.title = viewModel.storage.title
    }
    
    // MARK: - Init View Helper
    
    private func sceneInitialSet(count: Int) {
        if count == 0 {
            UIView.transition(with: popUpView, duration: 0.5, options: .transitionFlipFromBottom) { [weak self] in
                self?.popUpView.isHidden = false
            }
            UIView.transition(with: secondPopUpView, duration: 0.5, options: .transitionFlipFromBottom) { [weak self] in
                self?.secondPopUpView.isHidden = false
            }
        } else {
            popUpView.isHidden = true
            secondPopUpView.isHidden = true
        }
    }
}

extension WordListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return words.count
     }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let cell = tableView.dequeueReusableCell(withIdentifier: WordListTableViewCell.identifier, for: indexPath) as? WordListTableViewCell else {
             return UITableViewCell()
         }
         let word = words[indexPath.row]
         cell.configure(with: word)
         return cell
     }

}

extension WordListViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
       if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
          navigationController?.setNavigationBarHidden(true, animated: true)
       } else {
          navigationController?.setNavigationBarHidden(false, animated: true)
       }
    }
}

extension WordListViewController {
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
    }
}
