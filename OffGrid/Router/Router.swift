import Observation

@Observable
final class Router {
    var path: [RouteDestinations] = []
    var sheet: RouteDestinations?
    
    func push(_ d: RouteDestinations) {path.append(d)}
    func pop() { guard !path.isEmpty else { return }; path.removeLast() }
    func popToRoot() { path.removeAll() }
    func replacePath(_ d: [RouteDestinations]) { path = d }
    func pushReplace(_ d: RouteDestinations) { path.removeLast(); path.append(d)}
    func present(_ d: RouteDestinations) { sheet = d }
    func dismissSheet() { sheet = nil }
    
    var current: RouteDestinations? { path.last}
}
