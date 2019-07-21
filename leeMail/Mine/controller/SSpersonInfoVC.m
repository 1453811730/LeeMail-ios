//
//  SSpersonInfoVC.m
//  leeMail
//
//  Created by F S on 2019/7/10.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SSpersonInfoVC.h"
#import <UIImageView+WebCache.h>
#import "SSusermodel.h"
#import "SSnameOrPasswdVC.h"

#define headImagCellHeigth 74

@interface SSpersonInfoVC ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property(nonatomic,strong) UIImagePickerController* imagePickerController;
@property(nonatomic,strong) UIImageView* headImageV;
@property(nonatomic,strong) NSArray* array;
@end

@implementation SSpersonInfoVC
#pragma mark ------ 懒加载 ---------
- (UIImagePickerController *)imagePickerController{
    if (!_imagePickerController) {
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.allowsEditing = YES;
        _imagePickerController.delegate = self;
    }
    return _imagePickerController;
}
- (NSArray *)array{
    if (!_array) {
        _array = @[
                          @[@"头像",@"手机号",],
                          @[@"登录密码",@"交易密码"]
//                          @[@""]
                   ];
    }
    return _array;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人资料";
    [self setSubView];
}

- (void)setSubView {
    self.tableView.height = ScreenHeight - statusBarHeight-NaviBarHeight;
    self.tableView.height = ScreenHeight - statusBarHeight - NaviBarHeight - tabBarBottomH;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [UIColor YQseparatorColor];
    UIButton* quitBtn = [YQhelper createButtonWithType:0 andTitle:@"退出登录" andTitleColor:[UIColor YQcolorWithHexString:@"#C62436"] andSelectedtitle:nil andSelectedColor:nil andFont:[UIFont YQfont12] andBgColor:[UIColor whiteColor]];
    quitBtn.frame = CGRectMake(0, 0, ScreenWidth, 44);
    self.tableView.tableFooterView = quitBtn;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)loadData {
    [self.tableView reloadData];
}

#pragma mark ----- UITableviewDelegate -------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.array.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.array[section] count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont YQfont12];
    cell.detailTextLabel.font = [UIFont YQfont12];
    cell.textLabel.text = [self.array[indexPath.section] objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        self.headImageV = (UIImageView*)[cell viewWithTag:1];
        if (!self.headImageV) {
            self.headImageV = [[UIImageView alloc] init];
            self.headImageV.backgroundColor = [UIColor groupTableViewBackgroundColor];
            self.headImageV.frame = keyWindowWidth == 414.f ? CGRectMake(ScreenWidth-39-44, (headImagCellHeigth-44)/2+1, 44, 44) : CGRectMake(ScreenWidth-36-44, (headImagCellHeigth-44)/2+1, 44, 44);
            //                    self.headImageV.frame = CGRectMake(ScreenWidth-40-33, 6, 33, 33);
            self.headImageV.tag = 1;
            self.headImageV.contentMode = UIViewContentModeScaleAspectFit;
            self.headImageV.layer.cornerRadius = self.headImageV.height/2;
            self.headImageV.layer.masksToBounds = YES;
            [self.headImageV sd_setImageWithURL:[NSURL URLWithString:[[SSusermodel sharedModel] headImg]] placeholderImage:[UIImage imageNamed:@"yiqi"]];
        }
        [cell.contentView addSubview:self.headImageV];
    }else if (indexPath.section == 0 && indexPath.row == 1) {
        cell.detailTextLabel.text = [[SSusermodel sharedModel] phone];
    }
    
    return cell;
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        UIAlertAction *action_library = [UIAlertAction actionWithTitle:@"从相册中获取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self didChooseImageSource:UIImagePickerControllerSourceTypePhotoLibrary];
        }];
        UIAlertAction *action_camera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self didChooseImageSource:UIImagePickerControllerSourceTypeCamera];
        }];
        UIAlertAction *action_cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [YQhelper showActionSheetActions:@[action_camera,action_library,action_cancel] tips:@"更改头像" message:@"选择途径" target:self];
        return;
    }
    SSnameOrPasswdVC* name = [SSnameOrPasswdVC new];
    if (indexPath.section == 0 && indexPath.row == 1 ) {
        name.comeinType = SSComeInTypeUserName;
    }else if (indexPath.section == 1 && indexPath.row == 0) {
        name.comeinType = SSComeInTypeLoginPasswd;
    }else if (indexPath.section == 1 && indexPath.row == 1) {
        name.comeinType = SSComeInTypeTransAcPasswd;
    }
    [self.navigationController pushViewController:name animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 74;
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return section == 1 ? 10.0 : 0.0;
}

- (void)didChooseImageSource:(UIImagePickerControllerSourceType)sourceType{
    if ([UIImagePickerController isSourceTypeAvailable: sourceType]) {
        self.imagePickerController.sourceType = sourceType;
        [self presentViewController:self.imagePickerController animated:YES completion:nil];
    }
}
#pragma mark -------- UIImagePickerController ---------
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    weakly(self);
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *pickedImage = [info objectForKey:UIImagePickerControllerEditedImage];
        //        pickedImage = [pickedImage imageScaleWithSize:CGSizeMake(pickedImage.size.width/2, pickedImage.size.height/2)];
        [weakSelf didUploadImage:pickedImage];
    }];
}

- (void)didUploadImage:(UIImage*)selectedImage{
    if (!selectedImage) {
        return;
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
