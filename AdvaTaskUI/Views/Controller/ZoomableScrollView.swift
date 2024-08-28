//
//  ZoomableScrollView.swift
//  AdvaTaskUI
//
//  Created by Mahmoud on 28/08/2024.
//

import SwiftUI

// MARK: - ZoomableScrollView (unchanged)

import SwiftUI

// MARK: - ZoomableScrollView

struct ZoomableScrollView<Content: View>: UIViewRepresentable {
    // Binding to manage the state of zooming and panning
    @Binding var viewState: ViewState
    // The size of the content view
    let contentSize: CGSize
    // Closure to provide the content view
    let content: () -> Content

    // Create the UIScrollView instance
    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.delegate = context.coordinator
        scrollView.maximumZoomScale = 5.0
        scrollView.minimumZoomScale = 1.0
        scrollView.bouncesZoom = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false

        // Add the hosted view to the scroll view
        let hostedView = context.coordinator.hostingController.view!
        hostedView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(hostedView)

        // Set up constraints for the hosted view
        NSLayoutConstraint.activate([
            hostedView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            hostedView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])

        // Add double tap gesture recognizer for zooming
        let doubleTapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleDoubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTapGesture)

        return scrollView
    }

    // Update the UIScrollView when the view or state changes
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        context.coordinator.hostingController.rootView = content()

        // Apply the current zoom scale and content offset
        uiView.zoomScale = viewState.scale
        uiView.contentOffset = CGPoint(x: viewState.offset.width, y: viewState.offset.height)
    }

    // Create and return the Coordinator instance
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    // MARK: - Coordinator

    class Coordinator: NSObject, UIScrollViewDelegate {
        // Reference to the parent ZoomableScrollView
        var parent: ZoomableScrollView
        // Hosting controller for the content view
        var hostingController: UIHostingController<Content>

        init(_ parent: ZoomableScrollView) {
            self.parent = parent
            self.hostingController = UIHostingController(rootView: parent.content())
            super.init()
        }

        // Return the view to be zoomed
        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return hostingController.view
        }

        // Update the view state when zooming occurs
        func scrollViewDidZoom(_ scrollView: UIScrollView) {
            parent.viewState.scale = scrollView.zoomScale
        }

        // Update the view state when scrolling occurs
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            parent.viewState.offset = CGSize(width: scrollView.contentOffset.x, height: scrollView.contentOffset.y)
        }

        // Handle double tap gesture for zooming in and out
        @objc func handleDoubleTap(_ gesture: UITapGestureRecognizer) {
            guard let scrollView = gesture.view as? UIScrollView else { return }

            if scrollView.zoomScale > scrollView.minimumZoomScale {
                // Zoom out if already zoomed in
                scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
            } else {
                // Zoom in on double tap
                let pointInView = gesture.location(in: scrollView)
                let newZoomScale = min(scrollView.maximumZoomScale, scrollView.zoomScale * 3)
                let scrollViewSize = scrollView.bounds.size

                let width = scrollViewSize.width / newZoomScale
                let height = scrollViewSize.height / newZoomScale
                let originX = pointInView.x - (width / 2.0)
                let originY = pointInView.y - (height / 2.0)

                let rectToZoomTo = CGRect(x: originX, y: originY, width: width, height: height)

                scrollView.zoom(to: rectToZoomTo, animated: true)
            }
        }
    }
}
