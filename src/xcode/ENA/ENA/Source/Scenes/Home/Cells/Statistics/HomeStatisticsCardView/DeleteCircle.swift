//
// 🦠 Corona-Warn-App
//

import UIKit

/// A red circle to indicate a delete action
@IBDesignable
class DeleteCircle: UIControl {
	
	// MARK: - Init
	
	convenience init() {
		self.init(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Overrides
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		clipsToBounds = false
		isOpaque = false
		layer.shouldRasterize = true

		isAccessibilityElement = true
		accessibilityIdentifier = AccessibilityIdentifiers.General.deleteButton
		accessibilityLabel = AppStrings.Common.alertActionRemove
		accessibilityTraits = [.button]
	}

    override func draw(_ rect: CGRect) {
		let context = UIGraphicsGetCurrentContext()
		let circleRect = CGRect(x: rect.width / 4, y: rect.height / 4, width: rect.width / 2, height: rect.height / 2)
		context?.addEllipse(in: circleRect)
		context?.setFillColor(UIColor.red.cgColor)
		context?.fillPath()

		context?.setLineCap(.round)
		context?.setLineWidth(circleRect.width / 8) // default: rect-width 24, line-width: 3
		context?.setStrokeColor(UIColor.white.cgColor)
		context?.addLines(between: [
			CGPoint(x: circleRect.minX + circleRect.width / 5, y: circleRect.midY),
			CGPoint(x: circleRect.maxX - circleRect.width / 5, y: circleRect.midY)
		])
		context?.strokePath()
    }

	override func accessibilityElementDidBecomeFocused() {
		super.accessibilityElementDidBecomeFocused()
		superview?.accessibilityElementDidBecomeFocused()
	}
}
