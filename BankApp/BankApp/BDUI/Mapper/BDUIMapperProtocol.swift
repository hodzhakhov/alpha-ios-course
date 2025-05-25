import UIKit

protocol BDUIMapperProtocol {
    func map(_ model: BDUIModel) throws -> UIView
    func handleAction(_ action: BDUIAction)
    func setReloadableDelegate(_ delegate: BDUIReloadable)
}
