import UIKit

final class BDUIMapper: BDUIMapperProtocol {
    private weak var reloadableDelegate: BDUIReloadable?
    
    func setReloadableDelegate(_ delegate: BDUIReloadable) {
        self.reloadableDelegate = delegate
    }
    
    func map(_ model: BDUIModel) throws -> UIView {
        let view = try mapComponent(model)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        if let subviews = model.subviews {
            for submodel in subviews {
                let subview = try map(submodel)
                if let stackView = view as? UIStackView {
                    stackView.addArrangedSubview(subview)
                } else {
                    view.addSubview(subview)
                    
                    NSLayoutConstraint.activate([
                        subview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                        subview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                        subview.topAnchor.constraint(equalTo: view.topAnchor),
                        subview.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                    ])
                }
            }
        }
        
        return view
    }
    
    private func mapComponent(_ model: BDUIModel) throws -> UIView {
        switch model.type {
        case .contentView:
            return mapContentView(model.content)
        case .stackView:
            return mapStackView(model.content)
        case .label:
            return mapLabel(model.content)
        case .button:
            return mapButton(model.content)
        case .card:
            return mapCard(model.content)
        case .textField:
            return mapTextField(model.content)
        }
    }
    
    private func mapContentView(_ content: BDUIContent) -> UIView {
        let view = UIView()
        if let backgroundColor = content.backgroundColor {
            view.backgroundColor = UIColor(named: backgroundColor) ?? .white
        }
        return view
    }
    
    private func mapStackView(_ content: BDUIContent) -> UIStackView {
        let stackView = DSStackView()
        let spacing: CGFloat = mapSpacing(content.spacing ?? "s")
        
        stackView.configure(with: DSStackViewModel(
            axis: .vertical,
            spacing: spacing,
            distribution: .fill,
            alignment: .fill
        ))
        
        return stackView
    }
    
    private func mapLabel(_ content: BDUIContent) -> UILabel {
        let label = DSLabel()
        label.configure(with: DSLabelViewModel(
            text: content.text ?? "",
            style: mapStyle(content.style ?? "body")
        ))
        return label
    }
    
    private func mapButton(_ content: BDUIContent) -> UIButton {
        let button = DSButton()
        button.configure(with: DSButtonViewModel(
            title: content.text ?? "",
            style: mapButtonStyle(content.style ?? "primary"),
            action: { [weak self] in
                if let action = content.action {
                    self?.handleAction(action)
                }
            }
        ))
        return button
    }
    
    private func mapCard(_ content: BDUIContent) -> UIView {
        let card = DSCard()
        card.configure(with: DSCardViewModel(
            title: content.text,
            style: mapCardStyle(content.style ?? "bordered")
        ))
        return card
    }
    
    private func mapTextField(_ content: BDUIContent) -> UITextField {
        let textField = DSTextField()
        textField.configure(with: DSTextFieldViewModel(
            placeholder: content.text,
            style: mapTextFieldStyle(content.style ?? "standard")
        ))
        return textField
    }
    
    private func mapSpacing(_ token: String) -> CGFloat {
        switch token {
        case "xs": return Spacing.spacing8
        case "s": return Spacing.spacing16
        case "m": return Spacing.spacing24
        case "l": return Spacing.spacing32
        default: return Spacing.spacing16
        }
    }
    
    private func mapStyle(_ style: String) -> DSLabelStyle {
        switch style {
        case "headline": return .headline
        case "title": return .title
        case "subtitle": return .subtitle
        case "body": return .body
        case "caption": return .caption
        default: return .body
        }
    }
    
    private func mapButtonStyle(_ style: String) -> DSButtonStyle {
        switch style {
        case "primary": return .primary
        case "secondary": return .secondary
        case "bordered": return .bordered
        case "plain": return .plain
        default: return .primary
        }
    }
    
    private func mapCardStyle(_ style: String) -> DSCardStyle {
        switch style {
        case "bordered": return .bordered
        case "filled": return .filled
        default: return .bordered
        }
    }
    
    private func mapTextFieldStyle(_ style: String) -> DSTextFieldStyle {
        switch style {
        case "standard": return .standard
        case "bordered": return .bordered
        case "error": return .error
        default: return .standard
        }
    }
    
    func handleAction(_ action: BDUIAction) {
        switch action.type {
        case .print:
            if let message = action.context?["message"] {
                print(message)
            }
        case .navigate:
            if let route = action.context?["route"] {
                print(route)
            }
        case .reload:
            reloadableDelegate?.reload()
        }
    }
}
