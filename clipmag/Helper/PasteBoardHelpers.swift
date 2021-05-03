import SwiftUI
import Swift
import Cocoa
import Foundation
import Combine
import Quartz
import HotKey

//extension NSPasteboard {
//    /// An observable object that publishes updates when the given pasteboard changes.
//    final class Observable: ObservableObject {
//        private var cancellable: AnyCancellable?
//
//        @Published var pasteboard: NSPasteboard {
//            didSet {
//                start()
//            }
//        }
//
//        @Published var info: ContentsInfo?
//
//        private func start() {
//            cancellable = pasteboard.publisher.sink { [weak self] in
//                guard let self = self else {
//                    return
//                }
//
//                self.info = $0
//            }
//        }
//
//        init(_ pasteboard: NSPasteboard) {
//            self.pasteboard = pasteboard
//            start()
//        }
//    }
//}


//extension NSPasteboard {
//    /// Information about the pasteboard contents.
//    struct ContentsInfo: Identifiable {
//        let id = UUID()
//
//        /// The date when the current pasteboard data was added.
//        let created = Date()
//
//        /// The bundle identifier of the app that put the data on the pasteboard.
//        let sourceAppBundleIdentifier: String?
//
//    }
//
//    /// Returns a publisher that emits when the pasteboard changes.
//    var publisher: AnyPublisher<ContentsInfo, Never> {
//        var isFirst = true
//
//        return Timer.publish(every: 0.2, tolerance: 0.1, on: .main, in: .common)
//            .autoconnect()
//            .prepend([Date()]) // We want the publisher to also emit immediately when someone subscribes.
//            .compactMap { [weak self] _ in
//                self?.changeCount
//            }
//            .removeDuplicates()
//            .compactMap { [weak self] _ -> ContentsInfo? in
//                defer {
//                    if isFirst {
//                        isFirst = false
//                    }
//                }
//
//                guard
//                    let self = self,
//                    let source = self.string(forType: .string)
//                else {
//                    // We ignore the first event in this case as we cannot know if the existing pasteboard contents came from the frontmost app.
//                    return nil
//                }
//
//                // An empty string has special behavior ( http://nspasteboard.org ).
//                // > In case the original source of the content is not known, set `org.nspasteboard.source` to the empty string.
//
//                PersistenceController.shared.updateOrInsertItem(text: source, type: "Chrome")
//                return ContentsInfo(sourceAppBundleIdentifier: source.isEmpty ? nil : source)
//            }
//            .eraseToAnyPublisher()
//    }
//}
//
//
