//
//  ReviewViewController.m
//  Review
//
//  Created by KentarOu on 2014/08/20.
//  Copyright (c) 2014年 KentarOu. All rights reserved.
//

#import "ReviewViewController.h"
#import "AppDataTableViewCell.h"

#import "NSString+TextLabelSize.h"
#import "AppDetailData.h"

#define CELL_DEFAULT_HEIGHT 70
#define DETAIL_FONT_SIZE 12

@interface ReviewViewController ()
{
    NSMutableArray *titleArray;
    __weak IBOutlet UITableView *detailTableView;
}

@end

@implementation ReviewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDictionary *stringAttributes = @{ NSForegroundColorAttributeName : [UIColor darkGrayColor],
                                        NSFontAttributeName : [UIFont systemFontOfSize:20.0f] };
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:@"Review"
                                                                 attributes:stringAttributes];
    CGSize requestedTitleSize = [@"Review" sizeWithAttributes:stringAttributes];
    CGFloat titleWidth = MIN(200, requestedTitleSize.width);
    
    
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, titleWidth, 20)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.attributedText = string;
    self.navigationItem.titleView = titleLabel;
    
    
    titleArray = [NSMutableArray arrayWithArray:[AppDetailData getKeysArray]];
    
    NSLog(@"self.detailData = %@",_detailData);
    
    [detailTableView registerNib:[UINib nibWithNibName:@"AppDataTableViewCell" bundle:nil] forCellReuseIdentifier:@"CustomCell"];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *string = [_detailData valueForKey:titleArray[indexPath.row]];
    
    
    
    if (!string || [string isEqualToString:@""]) {
        return 70;
    }
    
    CGSize size = [string getTextSizeWithFont:[UIFont systemFontOfSize:DETAIL_FONT_SIZE] viewWidth:280 padding:0];
    
    if (size.height > 25) {
        return CELL_DEFAULT_HEIGHT - 21 + size.height;
    }
    
    return CELL_DEFAULT_HEIGHT;
}

// section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// row
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [titleArray count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *detalilText = [_detailData valueForKey:titleArray[indexPath.row]];
    
    
//    // ScreenShot imageCell
//    if ([detalilText isEqualToString:@"screenShot"]) {
//        static NSString *CellIdentifier = @"screenShot";
//        ScreenShotImageViewCell *cell = (ScreenShotImageViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//        
//        for (int i = 0; i < appData.imageCount; i++) {
//            
//            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(20 + (200 * i), 20, 200, 280)];
//            imageV.contentMode = UIViewContentModeScaleAspectFit;
//            
//            if (i == 0) {
//                imageV.image = appData.screenShot1;
//            } else if (i == 1) {
//                imageV.image = appData.screenShot2;
//            } else if (i == 2) {
//                imageV.image = appData.screenShot3;
//            } else if (i == 3) {
//                imageV.image = appData.screenShot4;
//            } else if (i == 4) {
//                imageV.image = appData.screenShot5;
//            }
//            [cell.imageScrollView addSubview:imageV];
//        }
//        
//        cell.imageScrollView.contentSize = CGSizeMake(20 + (200 * appData.imageCount) + 20, 320);
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
//    }
//    
//    // imageCell
//    if ([detalilText isEqualToString:@"image"]) {
//        static NSString *CellIdentifier = @"ImageCell";
//        AppImageCell *cell = (AppImageCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//        
//        NSString *imageTitle = titleArray[indexPath.row - 1];
//        
//        // single image
//        if ([imageTitle isEqualToString:@"artworkUrl100"]) {
//            cell.appImage.image = appData.artworkUrl100Image;
//        } else if ([imageTitle isEqualToString:@"artworkUrl512"]) {
//            cell.appImage.image = appData.artworkUrl512Image;
//        } else if ([imageTitle isEqualToString:@"artworkUrl60"]) {
//            cell.appImage.image = appData.artworkUrl60Image;
//        }
//        
//        
//        NSLog(@"width = %f,height = %f",cell.appImage.image.size.width,cell.appImage.image.size.height);
//        
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//        return cell;
//    }
    
    static NSString *CellIdentifier = @"CustomCell";
    AppDataTableViewCell *cell = (AppDataTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    if ([titleArray count] > 0) {
        
        cell.detailLabel.frame = CGRectMake(cell.detailLabel.frame.origin.x, cell.detailLabel.frame.origin.y, cell.detailLabel.frame.size.width, 21);
        
        cell.titleLabel.text = titleArray[indexPath.row];
        cell.detailLabel.text = detalilText;
        
        CGSize size = [detalilText getTextSizeWithFont:[UIFont systemFontOfSize:DETAIL_FONT_SIZE] viewWidth:280 padding:0];
        
        if (size.height > 25) {
            cell.detailLabel.frame = CGRectMake(cell.detailLabel.frame.origin.x, cell.detailLabel.frame.origin.y, cell.detailLabel.frame.size.width, size.height);
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    NSString *title = titleArray[indexPath.row];
//    
//    if ([title isEqualToString:@"artistViewUrl"] ||
//        [title isEqualToString:@"trackViewUrl"])
//    {
//        NSString *webString = [appData valueForKey:titleArray[indexPath.row]];
//        webURL = [NSURL URLWithString:webString];
//        
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"外部リンク" message:@"URLを外部リンクで開きます。" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"OK", nil];
//        [alert show];
//    }
//    
//    // Screen Shot Select
//    if ([title isEqualToString:@"screenshotUrls"])
//    {
//        
//        (appData.screenShotOpenFlg)? [appData setScreenShotOpenFlg:NO] : [appData setScreenShotOpenFlg:YES];
//        
//        AppDataTableViewCell *cell = (AppDataTableViewCell*)[AppDataTable cellForRowAtIndexPath:indexPath];
//        if (cell.opneFlg) {
//            
//            [titleArray removeObjectAtIndex:indexPath.row + 1];
//            cell.opneFlg = NO;
//            
//            NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];
//            [AppDataTable deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationTop];
//            
//        } else {
//            
//            [titleArray insertObject:@"screenShot" atIndex:indexPath.row + 1];
//            cell.opneFlg = YES;
//            
//            NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];
//            [AppDataTable insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationTop];
//        }
//    }
//    
//    
//    if ([title isEqualToString:@"artworkUrl100"] ||
//        [title isEqualToString:@"artworkUrl512"] ||
//        [title isEqualToString:@"artworkUrl60"])
//    {
//        
//        // imageCellのOpenFlg変更
//        if ([title isEqualToString:@"artworkUrl100"]) {
//            (appData.artworkUrl100OpenFlg)? [appData setArtworkUrl100OpenFlg:NO] : [appData setArtworkUrl100OpenFlg:YES];
//        } else if ([title isEqualToString:@"artworkUrl512"]) {
//            (appData.artworkUrl512OpenFlg)? [appData setArtworkUrl512OpenFlg:NO] : [appData setArtworkUrl512OpenFlg:YES];
//        } else if ([title isEqualToString:@"artworkUrl60"]) {
//            (appData.artworkUrl60OpenFlg)? [appData setArtworkUrl60OpenFlg:NO] : [appData setArtworkUrl60OpenFlg:YES];
//        }
//        
//        
//        AppDataTableViewCell *cell = (AppDataTableViewCell*)[AppDataTable cellForRowAtIndexPath:indexPath];
//        if (cell.opneFlg) {
//            
//            [titleArray removeObjectAtIndex:indexPath.row + 1];
//            cell.opneFlg = NO;
//            
//            NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];
//            [AppDataTable deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationTop];
//            
//        } else {
//            
//            [titleArray insertObject:@"image" atIndex:indexPath.row + 1];
//            cell.opneFlg = YES;
//            
//            NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];
//            [AppDataTable insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationTop];
//            
//        }
//    }
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
