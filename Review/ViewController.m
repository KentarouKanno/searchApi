//
//  ViewController.m
//  Review
//
//  Created by KentarOu on 2014/08/20.
//  Copyright (c) 2014年 KentarOu. All rights reserved.
//

#import "ViewController.h"
#import "AppData.h"
#import "AppDetailData.h"
#import "AppDataTableViewCell.h"
#import "AppImageCell.h"
#import "ScreenShotImageViewCell.h"
#import "NSString+TextLabelSize.h"
#import "ReviewViewController.h"

#define CELL_DEFAULT_HEIGHT 70
#define DETAIL_FONT_SIZE 12

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    AppData *appData;
    AppDetailData *appDetailData;
    
    NSMutableArray *titleArray;
    __weak IBOutlet UITableView *AppDataTable;
    
    UIView *grayView;
    UIActivityIndicatorView *indicator;
    
    NSString *searchApp;
    NSURL *webURL;
    
    NSString *tmpSearchString;
    
}

@property (weak, nonatomic) IBOutlet UISearchBar *searchText;

@end

@implementation ViewController

- (void)viewDidLoad
{
    
//    NSDictionary *stringAttributes = @{ NSForegroundColorAttributeName : [UIColor darkGrayColor],
//                                        NSFontAttributeName : [UIFont systemFontOfSize:20.0f] };
//    NSAttributedString *string = [[NSAttributedString alloc] initWithString:@"App Data"
//                                                                 attributes:stringAttributes];
//    CGSize requestedTitleSize = [@"App Data" sizeWithAttributes:stringAttributes];
//    CGFloat titleWidth = MIN(200, requestedTitleSize.width);
//    
//
//    
//    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, titleWidth, 20)];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.attributedText = string;
//    self.navigationItem.titleView = titleLabel;
    
    
    _searchText.text = @"793157344";
    
    [super viewDidLoad];
    [self makeGrayView];
    
    [self searchApp];
    
    [AppDataTable registerNib:[UINib nibWithNibName:@"AppDataTableViewCell" bundle:nil] forCellReuseIdentifier:@"CustomCell"];
    [AppDataTable registerNib:[UINib nibWithNibName:@"AppImageCell" bundle:nil] forCellReuseIdentifier:@"ImageCell"];
    [AppDataTable registerNib:[UINib nibWithNibName:@"ScreenShotImageViewCell" bundle:nil] forCellReuseIdentifier:@"screenShot"];
    

    
}


- (void)makeGrayView
{
    grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,self.view.frame.size.height)];
    grayView.backgroundColor = [UIColor blackColor];
    grayView.userInteractionEnabled = YES;
    grayView.alpha = 0.5f;
    grayView.hidden = YES;
    [self.navigationController.view addSubview:grayView];
    
    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.center = grayView.center;
    indicator.hidden = YES;
    [self.navigationController.view addSubview:indicator];
}

- (void)showIndicator
{
    grayView.hidden = NO;
    indicator.hidden = NO;
    
    [indicator startAnimating];
}

- (void)hideIndicator
{
    grayView.hidden = YES;
    indicator.hidden = YES;
    
    [indicator stopAnimating];
}

- (void)searchApp
{
    
    [self showIndicator];
    
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    //config.timeoutIntervalForResource = 15;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    //   NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/jp/rss/customerreviews/id=838749747/sortBy=mostRecent/json"];
    
    searchApp = @"793157344";
    // 793157344
    
    if (_searchText.text.length > 0) {
        searchApp = _searchText.text;
    }
    
    // アプリデータを取得するapi
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?country=JP&id=%@",searchApp]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            
                                            if (error) {
                                                // 通信が異常終了したときの処理
                                                [self hideIndicator];
                                                
                                                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"通信エラー" message:@"データを受信できません" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                                
                                                [alert show];
                                                return;
                                            }
                                            
                                            // 通信が正に常終了したときの処理
                                            id jsonObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                                            //NSLog(@"jsonObj: %@", jsonObj);
                                            
                                            [self getAppData:jsonObj];
                                        
                                        }];
    
    // 通信開始
    [task resume];
}

-(void)getAppData:(id)jsonData
{
    // データCount取得
    NSNumber *count = [jsonData valueForKey:@"resultCount"];
    
    NSArray *jsonArray = [jsonData valueForKeyPath:@"results"];
    
    if ([jsonArray count] == 0) {
        [self hideIndicator];
        
        _searchText.text = tmpSearchString;
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"取得エラー" message:@"入力されたIDではデータを取得できませんでした。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        return;
    }
    
    NSDictionary *dataDict = jsonArray[0];
    
    
    if (count == 0) return;
    
    
    tmpSearchString = _searchText.text;
    
    appData = [AppData new];
    [appData setAppData:dataDict];
    titleArray = [NSMutableArray arrayWithArray:[appData getKeysArray]];
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // Main Thread
        
        [AppDataTable reloadData];
        [AppDataTable setContentOffset:CGPointZero];
        
        [self hideIndicator];
    
    });
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *string = [appData valueForKey:titleArray[indexPath.row]];
    
    if ([string isEqualToString:@"screenShot"]) {
        return 320;
    } else if ([string isEqualToString:@"image"]) {
        return 150;
    } else if ([string isEqualToString:@"web"]) {
        return 200;
    } else if (!string || [string isEqualToString:@""]) {
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
    NSString *detalilText = [appData valueForKey:titleArray[indexPath.row]];
    
    
    // ScreenShot imageCell
    if ([detalilText isEqualToString:@"screenShot"]) {
        static NSString *CellIdentifier = @"screenShot";
        ScreenShotImageViewCell *cell = (ScreenShotImageViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        for (int i = 0; i < appData.imageCount; i++) {
            
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(20 + (200 * i), 20, 200, 280)];
            imageV.contentMode = UIViewContentModeScaleAspectFit;
            
            if (i == 0) {
                imageV.image = appData.screenShot1;
            } else if (i == 1) {
                imageV.image = appData.screenShot2;
            } else if (i == 2) {
                imageV.image = appData.screenShot3;
            } else if (i == 3) {
                imageV.image = appData.screenShot4;
            } else if (i == 4) {
                imageV.image = appData.screenShot5;
            }
            [cell.imageScrollView addSubview:imageV];
        }
        
        cell.imageScrollView.contentSize = CGSizeMake(20 + (200 * appData.imageCount) + 20, 320);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    // imageCell
    if ([detalilText isEqualToString:@"image"]) {
        static NSString *CellIdentifier = @"ImageCell";
        AppImageCell *cell = (AppImageCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        NSString *imageTitle = titleArray[indexPath.row - 1];
        
        // single image
        if ([imageTitle isEqualToString:@"artworkUrl100"]) {
            cell.appImage.image = appData.artworkUrl100Image;
        } else if ([imageTitle isEqualToString:@"artworkUrl512"]) {
            cell.appImage.image = appData.artworkUrl512Image;
        } else if ([imageTitle isEqualToString:@"artworkUrl60"]) {
            cell.appImage.image = appData.artworkUrl60Image;
        }
        
        
        NSLog(@"width = %f,height = %f",cell.appImage.image.size.width,cell.appImage.image.size.height);
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    static NSString *CellIdentifier = @"CustomCell";
    AppDataTableViewCell *cell = (AppDataTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSString *title = titleArray[indexPath.row];
    
    
    if ([title isEqualToString:@"artworkUrl100"]) {
        cell.opneFlg = appData.artworkUrl100OpenFlg;
    } else if ([title isEqualToString:@"artworkUrl512"]) {
        cell.opneFlg = appData.artworkUrl512OpenFlg;
    } else if ([title isEqualToString:@"artworkUrl60"]) {
        cell.opneFlg = appData.artworkUrl60OpenFlg;
    } else if ([title isEqualToString:@"screenshotUrls"]) {
        cell.opneFlg = appData.screenShotOpenFlg;
    }
    
    
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
    
    NSString *title = titleArray[indexPath.row];
    
    if ([title isEqualToString:@"artistViewUrl"] ||
        [title isEqualToString:@"trackViewUrl"])
    {
        NSString *webString = [appData valueForKey:titleArray[indexPath.row]];
        webURL = [NSURL URLWithString:webString];
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"外部リンク" message:@"URLを外部リンクで開きます。" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"OK", nil];
        [alert show];
    }
    
    // Screen Shot Select
    if ([title isEqualToString:@"screenshotUrls"])
    {
        
        (appData.screenShotOpenFlg)? [appData setScreenShotOpenFlg:NO] : [appData setScreenShotOpenFlg:YES];
        
        AppDataTableViewCell *cell = (AppDataTableViewCell*)[AppDataTable cellForRowAtIndexPath:indexPath];
        if (cell.opneFlg) {
            
            [titleArray removeObjectAtIndex:indexPath.row + 1];
            cell.opneFlg = NO;
            
            NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];
            [AppDataTable deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationTop];
            
        } else {
            
            [titleArray insertObject:@"screenShot" atIndex:indexPath.row + 1];
            cell.opneFlg = YES;
            
            NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];
            [AppDataTable insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationTop];
        }
    }
    
    
    if ([title isEqualToString:@"artworkUrl100"] ||
        [title isEqualToString:@"artworkUrl512"] ||
        [title isEqualToString:@"artworkUrl60"])
    {
        
        // imageCellのOpenFlg変更
        if ([title isEqualToString:@"artworkUrl100"]) {
            (appData.artworkUrl100OpenFlg)? [appData setArtworkUrl100OpenFlg:NO] : [appData setArtworkUrl100OpenFlg:YES];
        } else if ([title isEqualToString:@"artworkUrl512"]) {
            (appData.artworkUrl512OpenFlg)? [appData setArtworkUrl512OpenFlg:NO] : [appData setArtworkUrl512OpenFlg:YES];
        } else if ([title isEqualToString:@"artworkUrl60"]) {
            (appData.artworkUrl60OpenFlg)? [appData setArtworkUrl60OpenFlg:NO] : [appData setArtworkUrl60OpenFlg:YES];
        }
        
        
        AppDataTableViewCell *cell = (AppDataTableViewCell*)[AppDataTable cellForRowAtIndexPath:indexPath];
        if (cell.opneFlg) {
            
            [titleArray removeObjectAtIndex:indexPath.row + 1];
            cell.opneFlg = NO;
            
            NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];
            [AppDataTable deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationTop];
        
        } else {
            
            [titleArray insertObject:@"image" atIndex:indexPath.row + 1];
            cell.opneFlg = YES;
            
            NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];
            [AppDataTable insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationTop];
            
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView 
{
    [self.view endEditing:YES];
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}



- (void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex) {
        case 0:
            
            break;
        case 1:
        {
            [[UIApplication sharedApplication] openURL:webURL];
        }
    
            break;
            
        default:
            break;
    }
}

- (IBAction)openReviewView:(id)sender
{
    
//    if (sender) {
//        
//        [self nextView];
//        return;
//    }
    
    [self showIndicator];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/jp/rss/customerreviews/id=%@/sortBy=mostRecent/json",searchApp]];

    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            
                                            
                                            if (error) {
                                                // 通信が異常終了したときの処理
                                                
                                                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"通信エラー" message:@"データを受信できません" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                                
                                                [alert show];
                                                [self hideIndicator];
                                                return;
                                            }
                                            
                                            // 通信が正に常終了したときの処理
                                            id jsonObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                                          //  NSLog(@"jsonObj: %@", jsonObj);
                                            
                                            NSLog(@"ismain = %d",[NSThread isMainThread]);
                                            
                                            
                                            // 受信したJsonデータをappDetailDataに詰め替える
                                            [self getAppDetailData:jsonObj];
                                            
                                        }];
    // 通信開始
    [task resume];
}

-(void)getAppDetailData:(id)jsonData
{
    
    // データCount取得
    NSMutableDictionary *dataDict = [jsonData valueForKeyPath:@"feed"];
    
    appDetailData = [AppDetailData new];
    [appDetailData setAppDetailData:dataDict];
    
    NSLog(@"hideIndicator = %d",[NSThread isMainThread]);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // Main Thread
        

        [self hideIndicator];
        [self nextView];
    });
}

- (IBAction)searchButton:(id)sender
{

    if (_searchText.text.length == 0) {
        // サーチバーが未入力の時
        
        _searchText.text = tmpSearchString;
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"未入力エラー" message:@"IDを入力してくだささい。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        return;
    }
    
    if ([tmpSearchString isEqualToString:_searchText.text]) {
        return;
    }
    
    [self.view endEditing:YES];
    [self searchApp];
}


- (void)nextView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        // Main Thread
        
        [self hideIndicator];
        
        ReviewViewController *review = [self.storyboard instantiateViewControllerWithIdentifier:@"reviewView"];
        review.detailData = appDetailData;
        
        UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:nil];
        self.navigationItem.backBarButtonItem = bar;
        
        [self.navigationController pushViewController:review animated:YES];
        
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
