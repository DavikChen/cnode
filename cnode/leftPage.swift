class LeftPage: UIViewController {
    var count = 0
    var top = Top()
    fileprivate var table = Table()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(top)
        view.addSubview(table)
        constrain(view,top,table){
            $1.top == $0.top
            $1.left == $0.left
            $1.right == $0.right
            $1.height == 100
            
            $2.top == $1.bottom
            $2.left == $0.left
            $2.right == $0.right
            $2.bottom == $0.bottom
        }
        
    }
}
class Avatar : UIImageView{
    
}
class Top: UIView{
    var label : UILabel!
    var avatar = Avatar()
    override func layoutSubviews() {
        self.backgroundColor = .white
        label   = UILabel()
        label.text =  "User Name"
        self.addSubview(label)
        let button   = UIButton(type: .system)
        button.setTitle("登录",for: .normal)
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        self.addSubview(button)
        self.addSubview(avatar)
        label.textAlignment = .center
        constrain(self,avatar,label){
            $1.center == $0.center
            $1.width == 38
            $1.height == 38
            $2.top == $1.bottom
            $2.right == $0.right
            $2.left == $0.left
            $2.height == 20
        }
        let url = "https://avatars3.githubusercontent.com/u/20022617?v=4&s=120"
        avatar.kf.setImage(with:URL(string:(url)))
    }
    func buttonAction(_ sender:UIButton!){
        drawerController?.toggleLeftDrawerSide(animated: true, completion: nil)
    }
}
import SwiftIcons
class Item{
    var emoji : EmojiType!
    var title : String!
    init(_ emoji : EmojiType,_ title : String){
        self.emoji = emoji
        self.title = title
    }
}
fileprivate  class Table: UITableView,UITableViewDataSource{
    let arr : [Item] = [
            Item(EmojiType.home,"全部"),
            Item(EmojiType.enter,"问答"),
            Item(EmojiType.bookmark,"招聘"),
            Item(EmojiType.book,"精华"),
            Item(EmojiType.previousPage,"分享"),
            Item(EmojiType.gear,"设置"),
            Item(EmojiType.anchor,"消息"),
            Item(EmojiType.shield,"关于"),
    ]
    let MyIdentifier = "cell"
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame:frame,style:style)
        self.dataSource = self
        self.register(Cell.self, forCellReuseIdentifier: MyIdentifier)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let a = tableView.dequeueReusableCell(withIdentifier: MyIdentifier) as! Cell
        a.label.text = String(arr[indexPath.row].title)
        a.icon.image = UIImage.init(icon: .emoji(arr[indexPath.row].emoji), size: CGSize(width: 35, height: 35), textColor: .black, backgroundColor: .white)
        return a
    }
}
fileprivate class Cell : UITableViewCell{
    var label  = UILabel()
    var icon  = UIImageView()
    override func layoutSubviews() {
        self.contentView.addSubview(label)
        self.contentView.addSubview(icon)
        constrain(contentView, icon, label){
            $1.left == $0.left + 5
            $1.top == $0.top + 5
            $1.height == 20
            $1.width == 20
            
            $2.left == $1.right + 5
            $2.top == $1.top
            $2.height == 20
            $2.width == 200
        }
        
    }
}

import UIKit
import Cartography