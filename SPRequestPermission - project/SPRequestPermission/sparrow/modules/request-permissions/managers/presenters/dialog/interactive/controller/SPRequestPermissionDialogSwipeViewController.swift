// The MIT License (MIT)
// Copyright © 2017 Ivan Vorobei (hello@ivanvorobei.by)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit

class SPRequestPermissionDialogInteractiveViewController: SPDialogSwipeController<SPRequestPermissionDialogInteractiveView, UIView>  {
    
    weak var presenterDelegate: SPRequestPermissionDialogInteractivePresenterDelegate?
    
    override init(dialogView: SPRequestPermissionDialogInteractiveView) {
        super.init(dialogView: dialogView)
        self.delegate = self
        self.dialogViewMaxWidth = 300
        self.dialogViewMaxHeight = 450
        self.dialogViewWidthRelativeFactor = 0.8
        self.dialogViewHeightRelativeFactor = 0.8
        self.dialogViewSidesRelativeFactor = 0.667
        self.dialogViewPortraitYtranslationFactor = 0.96
        self.dialogViewLandscapeYtranslationFactor = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dialogView.backgroundColor = UIColor.white
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { (context) in
            self.dialogView.layoutIfNeeded()
        }, completion: nil)
    }
}

extension SPRequestPermissionDialogInteractiveViewController: SPRequestPermissionDialogInteractiveViewControllerInterface {
    
    func hide() {
        self.hide(withDialog: true)
    }
    
    func addControl(_ control: SPRequestPermissionTwiceControlInterface) {
        control.addAsSubviewTo(self.dialogView.buttonsContainerView)
    }
    
    func setHeaderBackgroundView(_ view: UIView) {
        self.dialogView.headerView.setBackgroundView(view)
    }
    
    func setHeaderTitle(_ title: String) {
        self.dialogView.headerView.titleLabel.text = title
        self.dialogView.layoutSubviews()
    }
    
    func setHeaderSubtitle(_ title: String) {
        self.dialogView.headerView.subTitleLabel.text = title
        self.dialogView.layoutSubviews()
    }
    
    func setTopTitle(_ title: String) {
        self.dialogView.topLabel.text = title
        self.dialogView.layoutSubviews()
    }
    
    func setBottomTitle(_ title: String) {
        self.dialogView.bottomLabel.text = title
        self.dialogView.layoutSubviews()
    }
    
    func setUnderDialogTitle(_ title: String) {
        //self.bottomLabel.text = title
    }
}

extension SPRequestPermissionDialogInteractiveViewController: SPDialogSwipeControllerDelegate {
    
    internal var isEnableHideDialogController: Bool {
        return presenterDelegate?.isEnableHide() ?? true
    }
    
    func didHideDialogController() {
        self.presenterDelegate?.didHide()
    }
}

