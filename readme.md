# JCS_Kit

[toc]

目录

* [JCS_Kit](#JCS_Kit)
    * [介绍](#介绍)
    * [初体验](#初体验)
    * [集成方法](#集成方法)
    * [JCS_BaseLib](#JCS_BaseLib)
    * [JCS_Category](#JCS_Category)
    * [JCS_Injection](#JCS_Injection)
    * [JCS_EventBus](#JCS_EventBus)
    * [JCS_Router](#JCS_Router)
    * [JCS_Create](#JCS_Create)
        * [UITableView(代码创建)](#UITableView代码创建)
        * [UICollectionView(代码创建)](#UICollectionView代码创建)
        * [UITableView(配置文件)](#UITableView配置文件)
        * [UICollectionView(配置文件)](#UICollectionView配置文件)
* [Author](#Author)

## 介绍

JCS_Kit为快速便捷开发而生。JCS_Kit包含下面几个模块
* JCS_BaseLib(主要是常用的宏定义)
* JCS_Category(常用分类)
* JCS_Router(路由)
* JCS_Injection(从配置文件进行数据注入)
* JCS_EventBus(事件总线)
* JCS_Create(链式语法创建UI对象)

## 初体验

示例1: 创建Label对象

原先代码：

```objc
UILabel *titleLabel = [[UILabel alloc] init];
titleLabel.font = [UIFont systemFontOfSize:14];
titleLabel.textColor = UIColor.redColor;
titleLabel.text = @"Hello World";
titleLabel.textAlignment = NSTextAlignmentCenter;
[self.view addSubview:titleLabel];
[titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(16);
    make.right.mas_equalTo(-16);
    make.top.mas_equalTo(10);
}];
self.titleLabel = titleLabel;
```

使用JCS_Create后的代码

```
[UILabel jcs_create].jcs_layout(self.view, ^(MASConstraintMaker *make) {
    make.left.mas_equalTo(16);
    make.right.mas_equalTo(-16);
    make.top.mas_equalTo(10);
}).jcs_toLabel()
.jcs_fontSize(14)
.jcs_textColor(UIColor.redColor)
.jcs_text(@"Hello World")
.jcs_textAlignment_Center()
.jcs_associated(&_titleLabel);
```

示例2: 创建UIButton对象

原先代码

```
- (void)setup {
    UIButton *loginBtn = [[UIButton alloc] init];
    [loginBtn setTitle:@"Login" forState:(UIControlStateNormal)];
    [loginBtn setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
    [loginBtn setImage:[UIImage imageNamed:@"login-icon"] forState:(UIControlStateNormal)];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    loginBtn.layer.cornerRadius = 22;
    loginBtn.layer.masksToBounds = YES;
    [loginBtn addTarget:self action:@selector(loginButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(44);
        make.center.equalTo(self.view);
    }];
    self.loginBtn = loginBtn;
}

- (void)loginButtonClick:(UIButton*)sender{
    //TODO: 登录逻辑
}
```

是使用JCS_Create后的代码

```
@weakify(self)
[UIButton jcs_create].jcs_layout(self.view, ^(MASConstraintMaker *make) {
    make.width.mas_equalTo(100);
    make.height.mas_equalTo(44);
    make.center.equalTo(self.view);
}).jcs_toButton()
.jcs_normalTitle(@"Login")
.jcs_normalTitleColor(UIColor.blackColor)
.jcs_normalImage([UIImage imageNamed:@"login-icon"])
.jcs_fontSize(14)
.jcs_clickBlock(^(UIButton *sender){
    @strongify(self)
    //TODO: 登录逻辑
})
.jcs_cornerRadius(22)
.jcs_associated(&_loginBtn);
```

示例3: 创建UITableView对象

原先代码

```
@interface ExampleVC ()<UITableViewDataSource,UITableViewDelegate>

/** UITableView **/
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ExampleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] init];
    [self.tableView registerClass:DemoCell.class forCellReuseIdentifier:@"DemoCell"];
    [self.tableView registerClass:DemoSectionHeaderView.class forHeaderFooterViewReuseIdentifier:@"DemoSectionHeaderView"];
    [self.tableView registerClass:DemoSectionFooterView.class forHeaderFooterViewReuseIdentifier:@"DemoSectionFooterView"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // return cell
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //点击事件
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    //Section Header
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    //Section Footer
}

@end
```

使用JCS_Create后的代码

```
@interface ExampleVC ()

/** UITableView **/
@property (nonatomic, strong) UITableView *tableView;
/** UITableView 数据源 **/
@property (nonatomic, strong) NSMutableArray<JCS_TableSectionModel*> *sections;

@end

@implementation ExampleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @weakify(self)
    [UITableView jcs_create].jcs_layout(self.view, ^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }).jcs_toTableView()
    .jcs_customerSections(self.sections)
    .jcs_customerDidSelectRowBlock(^(NSIndexPath*indexPath,JCS_TableRowModel*selecedModel){
        @strongify(self)
        //TODO: Cell 点击事件
    })
    .jcs_associated(&_sections);
}

///配置数据源
- (void)configSectionss {
    self.sections = [NSMutableArray array];
    for (NSInteger sectionIndex = 0; sectionIndex < 5; sectionIndex++) {
        
        JCS_TableSectionModel *sectionModel = [JCS_TableSectionModel jcs_create];
        sectionModel.headerClass = @"DemoSectionHeaderView";
        sectionModel.footerClass = @"DemoSectionFooterView";
        sectionModel.headerHeight = 50;
        sectionModel.footerHeight = 50;
        sectionModel.headerData = @{@"title":@"This is Header Data"};
        sectionModel.footerData = @{@"title":@"This is Footer Data"};
        [self.sections addObject:sectionModel];
        
        for (NSInteger rowIndex = 0; rowIndex < 10; rowIndex++) {
            JCS_TableRowModel *rowModel = [JCS_TableRowModel jcs_create];
            rowModel.cellClass = @"DemoCell";
            rowModel.cellHeight = 44;
            rowModel.data = @{@"title":@"This is Cell Data"};
            [sectionModel.rows addObject:rowModel];
        }
    }
}

@end
```

## 集成方法

```
//添加源
source 'https://gitee.com/devjackcat/JCS_PodSpecs.git'

//导入
pod 'JCS_Kit'
```

## JCS_BaseLib

包含一些常会宏, 自行参考```JCS_Macros.h```定义
* 颜色创建
* 屏幕属性
* 设备判断
* 导航栏、Tab等高度
* .....

## JCS_Category

常用的分类，代码不多，自行阅读实现文件吧

## JCS_Injection

JCS_Injection

## JCS_EventBus

## JCS_Router

## JCS_Create

### UITableView(代码创建)
### UICollectionView(代码创建)
### UITableView(配置文件)
### UICollectionView(配置文件)

# Author

devjackcat@163.com
