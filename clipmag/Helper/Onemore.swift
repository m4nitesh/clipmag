import Cocoa
import SwiftUI

class FirstResponderNSSearchFieldController: NSViewController {

  @Binding var text: String

  init(text: Binding<String>) {
    self._text = text
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func loadView() {
    let searchField = NSSearchField()
    searchField.delegate = self
    self.view = searchField
  }

  override func viewDidAppear() {
    self.view.window?.makeFirstResponder(self.view)
  }
}

extension FirstResponderNSSearchFieldController: NSSearchFieldDelegate {

  func controlTextDidChange(_ obj: Notification) {
    if let textField = obj.object as? NSTextField {
      self.text = textField.stringValue
    }
  }
}

struct FirstResponderNSSearchFieldRepresentable: NSViewControllerRepresentable {

  @Binding var text: String

  func makeNSViewController(
    context: NSViewControllerRepresentableContext<FirstResponderNSSearchFieldRepresentable>
  ) -> FirstResponderNSSearchFieldController {
    return FirstResponderNSSearchFieldController(text: $text)
  }

  func updateNSViewController(
    _ nsViewController: FirstResponderNSSearchFieldController,
    context: NSViewControllerRepresentableContext<FirstResponderNSSearchFieldRepresentable>
  ) {
  }
}
