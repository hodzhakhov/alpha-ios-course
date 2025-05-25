import UIKit

class FeaturesRouter: FeaturesRouterProtocol {
    weak var viewController: UIViewController?
    
    func navigateToAccounts() {
        print("Переход в аккаунты")
    }
    
    func navigateToTransfer() {
        print("Переход в трансфер")
    }
    
    func navigateToTransactionHistory() {
        print("Переход в историю транзакций")
    }
    
    func navigateToProfile() {
        print("Переход в профиль")
    }
    
    func navigateToBDUI() {
        let jsonString = """
        {
            "type": "contentView",
            "content": {
                "style": "plain",
                "backgroundColor": "white"
            },
            "subviews": [
                {
                    "type": "stackView",
                    "content": {
                        "spacing": "s"
                    },
                    "subviews": [
                        {
                            "type": "label",
                            "content": {
                                "text": "Привет, ИТМО!",
                                "style": "headline"
                            }
                        },
                        {
                            "type": "label",
                            "content": {
                                "text": "Хорошего дня",
                                "style": "subtitle"
                            }
                        },
                        {
                            "type": "button",
                            "content": {
                                "text": "Перейти к переводам",
                                "style": "primary",
                                "action": {
                                    "type": "navigate",
                                    "context": {
                                        "route": "transfer"
                                    }
                                }
                            }
                        },
                        {
                            "type": "button",
                            "content": {
                                "text": "Перейти к счетам",
                                "style": "secondary",
                                "action": {
                                    "type": "navigate",
                                    "context": {
                                        "route": "accounts"
                                    }
                                }
                            }
                        },
                        {
                            "type": "button",
                            "content": {
                                "text": "Обновить",
                                "style": "primary",
                                "action": {
                                    "type": "reload"
                                }
                            }
                        }
                    ]
                }
            ]
        }
        """
        
        let mapper = BDUIMapper()
        let bduiViewController = BDUIViewController(mapper: mapper, jsonString: jsonString)
        viewController?.navigationController?.pushViewController(bduiViewController, animated: true)
    }
}
