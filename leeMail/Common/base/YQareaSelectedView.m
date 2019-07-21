//
//  YQareaSelectedView.m
//  yiqi
//
//  Created by 孙炯卿 on 2018/7/29.
//  Copyright © 2018年 qiyu. All rights reserved.
//

#import "YQareaSelectedView.h"
#import "NSString+HRExtension.h"

@interface YQareaSelectedView ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger provinceRow;
    NSInteger cityRow;
    NSInteger districtRow;
}
@property (nonatomic) UITableView *provinceTable;
@property (nonatomic) UITableView *cityTable;
@property (nonatomic) UITableView *districtTable;

@end

@implementation YQareaSelectedView
#pragma mark ------ 懒加载 ----------
- (UITableView *)provinceTable{
    if (!_provinceTable) {
        _provinceTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _provinceTable.delegate = self;
        _provinceTable.dataSource = self;
        _provinceTable.showsVerticalScrollIndicator = NO;
        [self addSubview:_provinceTable];
    }
    return _provinceTable;
}
- (UITableView *)cityTable{
    if (!_cityTable) {
        _cityTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _cityTable.delegate = self;
        _cityTable.dataSource = self;
        _cityTable.showsVerticalScrollIndicator = NO;
        [self addSubview:_cityTable];
    }
    return _cityTable;
}
- (UITableView *)districtTable{
    if (!_districtTable) {
        _districtTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _districtTable.showsVerticalScrollIndicator = NO;
        _districtTable.delegate = self;
        _districtTable.dataSource = self;
        [self addSubview:_districtTable];
    }
    return _districtTable;
}

//- (void)setFilterConditions:(NSArray *)filterConditions{
//    _filterConditions = filterConditions;
//    [self.provinceTable reloadData];
//}

#pragma mark -------- UITableivew ---------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:self.provinceTable]) {
        return _containCurrentLocation ? _filterConditions.count + 1 : _filterConditions.count;
    }
    if (provinceRow == 0 && _containCurrentLocation) {
        return 0;
    }
    if ([tableView isEqual:self.cityTable]) {
        NSDictionary *province = [_filterConditions objectAtIndex:_containCurrentLocation ? provinceRow - 1 : provinceRow];
        NSArray* citys = [province[@"chirdenList"] copy];
        return citys.count;
//        return area.subAreas.count;
    }
    NSDictionary *province = [_filterConditions objectAtIndex: _containCurrentLocation ? provinceRow - 1 : provinceRow];
    NSArray* citys = [province[@"chirdenList"] copy];
    NSDictionary *city = [citys objectAtIndex:cityRow];
    NSArray* areas = [city[@"chirdenList"] copy];
    return _containAll ? areas.count + 1 : areas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.textLabel.textColor = [UIColor YQcolorWithHex000000];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    if ([tableView isEqual:self.provinceTable]) {
        cell.textLabel.text = indexPath.row == 0 && _containCurrentLocation ? @"当前定位" : [[_filterConditions objectAtIndex: _containCurrentLocation ? indexPath.row - 1 : indexPath.row] objectForDictKey:@"name"];
        cell.textLabel.textColor = indexPath.row == 0 && _containCurrentLocation ? [UIColor YQcolor71] : [UIColor YQcolor71];
        cell.textLabel.font = indexPath.row == 0 && _containCurrentLocation ? [UIFont boldSystemFontOfSize:14] : [UIFont systemFontOfSize:14];
    }else if([tableView isEqual:self.cityTable]){
        NSDictionary *province = [_filterConditions objectAtIndex: _containCurrentLocation ? provinceRow - 1 : provinceRow];
        NSArray* citys = [province[@"chirdenList"] copy];
        cell.textLabel.text = [[citys objectAtIndex:indexPath.row] objectForDictKey:@"name"];
    }else{
        NSDictionary *province = [_filterConditions objectAtIndex:_containCurrentLocation ? provinceRow - 1 : provinceRow];
        NSArray* citys = [province[@"chirdenList"] copy];
        NSDictionary *city = [citys objectAtIndex:cityRow];
        NSArray* areas = [city[@"chirdenList"] copy];
//        VoDistrict *city = [province.subAreas objectAtIndex:cityRow];
        
        cell.textLabel.text = indexPath.row == 0 && _containAll ? @"全城" : [[areas objectAtIndex:_containAll ? indexPath.row - 1 : indexPath.row] objectForDictKey:@"name"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.provinceTable]) {
        provinceRow = indexPath.row;
        if (provinceRow == 0 && [tableView isEqual:self.provinceTable] && _containCurrentLocation) {
            if (_areaSelectBlock) {
                _areaSelectBlock(nil,nil,nil);
            }
            [self.cityTable reloadData];
            [self.districtTable reloadData];
            return;
        }
        cityRow = 0;
        [self.cityTable reloadData];
        [self.districtTable reloadData];
        [self.cityTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        [self.districtTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        return;
    }
    if ([tableView isEqual:self.cityTable] && !self.isShowTwo) {
        cityRow = indexPath.row;
        [self.districtTable reloadData];
        [self.districtTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        return;
    }
    if ([tableView isEqual:self.cityTable] && self.isShowTwo) {
//        cityRow = indexPath.row;
        NSDictionary *province = [_filterConditions objectAtIndex:_containCurrentLocation ? provinceRow - 1 : provinceRow];
        NSArray* citys = [province[@"chirdenList"] copy];
        NSDictionary *city = [citys objectAtIndex:indexPath.row];
        if (_areaSelectBlock) {
            self.areaSelectBlock(province, city, @{});
        }
//        [self.districtTable reloadData];
//        [self.districtTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        return;
    }
    
    
    NSDictionary *province = [_filterConditions objectAtIndex:_containCurrentLocation ? provinceRow - 1 : provinceRow];
    NSArray* citys = [province[@"chirdenList"] copy];
    NSDictionary *city = [citys objectAtIndex:cityRow];
//    if (indexPath.row == 0 && _containAll) {
//        city.isAll = YES;
//    }
    NSArray* areas = [city[@"chirdenList"] copy];
    NSDictionary *area = indexPath.row == 0 && _containAll ? city : [areas objectAtIndex:_containAll ? indexPath.row - 1 : indexPath.row];
    if (_areaSelectBlock) {
        self.areaSelectBlock(province, city, area);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *name = @"";
    if ([tableView isEqual:self.provinceTable]) {
        name = indexPath.row == 0 && _containCurrentLocation ? @"当前定位" : [[_filterConditions objectAtIndex: _containCurrentLocation ? indexPath.row - 1 : indexPath.row] objectForDictKey:@"name"];
    }else if ([tableView isEqual:self.cityTable]){
        NSDictionary *province = [_filterConditions objectAtIndex:_containCurrentLocation ? provinceRow - 1 : provinceRow];
        NSArray* citys = [province[@"chirdenList"] copy];
//        NSDictionary *city = [citys objectAtIndex:_containCurrentLocation ? provinceRow - 1 : provinceRow];
        name = [[citys objectAtIndex:indexPath.row] objectForDictKey:@"name"];
    }else{
        NSDictionary*province = [_filterConditions objectAtIndex:_containCurrentLocation ? provinceRow - 1 : provinceRow];
        NSArray* citys = [province[@"chirdenList"] copy];
        NSDictionary *city = [citys objectAtIndex:cityRow];
        NSArray* areas = [city[@"chirdenList"] copy];
        name = indexPath.row == 0 && _containAll ? @"全城" : [[areas objectAtIndex:_containAll ? indexPath.row - 1 : indexPath.row] objectForDictKey:@"name"];
    }
    CGFloat height = [name boundingHeight:CGSizeMake(CGRectGetWidth(tableView.frame), CGRectGetHeight(tableView.frame)) attributions:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} minimumHeight:10];
    return MAX(height, 34);
}


- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width = CGRectGetWidth(self.frame)/3;
    self.provinceTable.frame = CGRectMake(0, 0, width, CGRectGetHeight(self.frame));
    self.cityTable.frame = CGRectMake(width, 0, width, CGRectGetHeight(self.frame));
    self.districtTable.frame = CGRectMake(width * 2, 0, width, CGRectGetHeight(self.frame));
    self.districtTable.hidden = self.isShowTwo;
    
    [self setTableHeadFoot:self.provinceTable];
    [self setTableHeadFoot:self.cityTable];
    [self setTableHeadFoot:self.districtTable];
}

- (void)setTableHeadFoot:(UITableView*)tableview{
    UIView* view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.tableFooterView = view;
    tableview.tableHeaderView = view;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
