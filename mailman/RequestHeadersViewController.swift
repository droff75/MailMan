import UIKit

class RequestHeadersViewController: UITableViewController {
    private let headerCellId = "requestHeadersCell"
    private let headersModel: HeadersModel
    private let viewModel: RequestHeadersViewModel
    
    init(headerModel: HeadersModel) {
        self.headersModel = headerModel
        self.viewModel = RequestHeadersViewModel(headers: headerModel.headers)
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
        return viewModel.headers.count > 0 ? viewModel.headers.count : 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: headerCellId, for: indexPath) as! RequestHeaderTableCell
        let header = headersModel.headers[indexPath.row]
        cell.delegate = self
        if let header = header {
            cell.set(key: header.key)
            cell.set(value: header.value)
        }
        return cell
    }
}

extension RequestHeadersViewController: RequestHeaderTableCellDelegate {
    func headerUpdated(_ header: Header, cell: UITableViewCell) {
        guard let index = self.tableView.indexPath(for: cell)?.row else { return }
        
        headersModel.update(header: header, at: index)
    }
    
    func addRow(cell: UITableViewCell) {
        guard let row = self.tableView.indexPath(for: cell)?.row, row == viewModel.headers.count - 1 else { return }
        viewModel.headers.insert(Header.empty, at: row + 1)
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: row + 1, section: 0)], with: .automatic)
        tableView.endUpdates()
    }
}
