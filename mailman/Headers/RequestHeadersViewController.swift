import UIKit

protocol RequestHeaderViewControllerDelegate: class {
    func headersUpdated(_ headers: [Header])
}

class RequestHeadersViewController: UITableViewController {
    private let headerCellId = "requestHeadersCell"
    private var headers: [Header]
    weak var delegate: RequestHeaderViewControllerDelegate?
    
    init(headers: [Header] = []) {
        self.headers = headers.count > 0 ? headers : [Header.empty]
        if headers.count == 1 && headers[0] != Header.empty { self.headers.append(Header.empty)}
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        tableView.register(RequestHeaderTableCell.self, forCellReuseIdentifier: headerCellId)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headers.count > 0 ? headers.count : 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: headerCellId, for: indexPath) as! RequestHeaderTableCell
        let header = headers[indexPath.row]
        cell.delegate = self
        cell.set(key: header.key)
        cell.set(value: header.value)
        
        return cell
    }
}

extension RequestHeadersViewController: RequestHeaderTableCellDelegate {
    func headerUpdated(_ header: Header, cell: UITableViewCell) {
        guard let index = self.tableView.indexPath(for: cell)?.row else { return }
        
        headers[index] = header
        delegate?.headersUpdated(headers)
    }
    
    func addRow(cell: UITableViewCell) {
        guard let row = self.tableView.indexPath(for: cell)?.row, row == headers.count - 1 else { return }
        headers.insert(Header.empty, at: row + 1)
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: row + 1, section: 0)], with: .automatic)
        tableView.endUpdates()
        delegate?.headersUpdated(headers)
    }
    
    func removeRow(cell: UITableViewCell) {
        guard let row = self.tableView.indexPath(for: cell)?.row, headers.count != 1 else { return }
        headers.remove(at: row)
        tableView.beginUpdates()
        tableView.deleteRows(at: [IndexPath(row: row, section: 0)], with: .automatic)
        tableView.endUpdates()
        delegate?.headersUpdated(headers)
    }
}
