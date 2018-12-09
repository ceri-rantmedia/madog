//
//  RuntimeResolver.swift
//  Madog
//
//  Created by Ceri Hughes on 23/11/2018.
//  Copyright © 2018 Ceri Hughes. All rights reserved.
//

import Foundation

/// An implementation of Resolver which uses objc-runtime magic to find all loaded classes that
/// implement PageFactory and StateFactory respectively.
public final class RuntimeResolver: Resolver {
    private let bundle: Bundle

    private var loadedPageTypes = [Page.Type]()
    private var loadedStateTypes = [State.Type]()

    convenience public init() {
        self.init(bundle: Bundle.main)
    }

    public init(bundle: Bundle) {
        self.bundle = bundle

        inspectLoadedClasses()
    }

    // MARK: Resolver

    public func pageTypes() -> [Page.Type] {
        return loadedPageTypes
    }

    public func stateTypes() -> [State.Type] {
        return loadedStateTypes
    }

    // MARK: Private

    private func inspectLoadedClasses() {
        if let executablePath = bundle.executablePath {
            var classCount: UInt32 = 0
            let classNames = objc_copyClassNamesForImage(executablePath, &classCount)
            if let classNames = classNames {
                for i in 0 ..< classCount {
                    let className = classNames[Int(i)]
                    let name = String.init(cString: className)
                    if let cls = NSClassFromString(name) as? Page.Type {
                        loadedPageTypes.append(cls)
                    }
                    if let cls = NSClassFromString(name) as? State.Type {
                        loadedStateTypes.append(cls)
                    }
                }
            }

            free(classNames);

            // Sort factories alphabetically by class name
            loadedPageTypes.sort { String(describing: $0) < String(describing: $1) }
            loadedStateTypes.sort { String(describing: $0) < String(describing: $1) }
        }
    }
}
