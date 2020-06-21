//
//  ViewController.swift
//  MVPEasySample
//
//  Created by 入江真礼 on 2020/06/21.
//  Copyright © 2020 入江真礼. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    private var presenter: PresentableInput!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = Presenter(view: self, model: Model())
        presenter.firstAction()
    }
}

extension ViewController: PresentableOutput {
    func reloadView() {
        print("戻ってきた")
    }
}


//View→Presenterの処理
protocol PresentableInput {
    func firstAction()
}

//Presenter→Viewの処理
protocol PresentableOutput: AnyObject {
    func reloadView()
}

final class Presenter: PresentableInput {

    private weak var view: PresentableOutput!
    private var model: ModelInput

    init(view: PresentableOutput, model: ModelInput) {
        self.view = view
        self.model = model
    }

    func firstAction() {
        model.fetch(){ [weak self] in
            self?.view.reloadView()
        }
    }
}

//Presenter→Modelの処理（fetch結果のコールバックをクロージャで行う）
protocol ModelInput {
    func fetch(completion: @escaping () -> ())
}

final class Model: ModelInput {
    func fetch(completion: @escaping () -> ()) {
        //API用のModuleがあれば、そっちに処理を任せ、結果だけここで受け取りPresenterへ返す
        completion()
    }
}
