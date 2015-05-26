#import "WCPullRefreshControl.h"
static const CGFloat itemlength = 25.0;
@interface WCPullRefreshControl()

@property (strong,nonatomic)WCProgressItem * progressItem;
@property (strong,nonatomic)WCRefreshingItem * refreshingItem;
@property (copy,nonatomic)WCRefreshAction refreshAction;
@property (strong,nonatomic)UILabel * lastUpdateLabel;
@property (nonatomic,readwrite) WCPullRefreshControlState state;
@property (nonatomic) BOOL showLastUpdate;
//@property (nonatomic) CGFloat originalInset;
@property (nonatomic) CGFloat originalOffset;
@end

@implementation WCPullRefreshControl

-(instancetype)initWithScrollview:(UIScrollView *)scrollview Action:(WCRefreshAction)action{
    return [self initWithScrollview:scrollview Action:action lastUpdate:nil showLastUpdate:NO];
}
-(instancetype)initWithScrollview:(UIScrollView *)scrollview Action:(WCRefreshAction)action lastUpdate:(NSDate *)date showLastUpdate:(BOOL)isShowLastUpdate{
    return [self initWithScrollview:scrollview
                             Action:action
                       progressItem:WCProgressItemTypeRoundCricle
                     refreshingItem:WCRefreshingItemTypeRoundCircle
                         lastUpdate:date
                     showLastUpdate:isShowLastUpdate
                          textColor:[UIColor blueColor]
                          itemColor:[UIColor blueColor]
                         pullHeight:64.0
            ];
}

-(instancetype)initWithScrollview:(UIScrollView *)scrollview
                           Action:(WCRefreshAction)action
                     progressItem:(WCProgressItemType)progressType
                   refreshingItem:(WCRefreshingItemType)refreshingType
                       lastUpdate:(NSDate *)date
                   showLastUpdate:(BOOL)isShowLastUpdate
                        textColor:(UIColor *)textcolor
                        itemColor:(UIColor *)itemColor
                       pullHeight:(CGFloat)pullHeight
{
    if (self = [super init]) {
        CGRect frame = CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,defaultPullHeight);
        self.pullHeight = pullHeight;
        self.frame = frame;
        self.center =CGPointMake([UIScreen mainScreen].bounds.size.width/2, -1 * defaultPullHeight/2);
        self.attachedScrollView = scrollview;
        self.refreshAction = action;
        self.showLastUpdate = isShowLastUpdate;
        [scrollview addSubview:self];
        //Set up items
        CGRect itemFrame;
        itemFrame.origin = CGPointZero;
        itemFrame.size = CGSizeMake(itemlength,itemlength);
        if (progressType == WCProgressItemTypeMagicSquare) {
            self.progressItem = [[WCProgressItem alloc] initWithFrame:CGRectMake(0,0,scrollview.contentSize.width,15) Type:progressType Color:itemColor];
        }else{
            self.progressItem = [[WCProgressItem alloc] initWithFrame:itemFrame Type:progressType Color:itemColor];
        }
        self.progressItem.hidden = NO;
        self.progressItem.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,defaultPullHeight/8 *4);
        
        [self addSubview:self.progressItem];
        if (refreshingType == WCRefreshingItemTypeMagicSquare) {
            self.refreshingItem = [[WCRefreshingItem alloc] initWithFrame:CGRectMake(0,0,scrollview.contentSize.width,15) Type:refreshingType Color:itemColor];
        }else{
            self.refreshingItem = [[WCRefreshingItem alloc] initWithFrame:itemFrame Type:refreshingType Color:itemColor];
        }
        self.refreshingItem.center = self.progressItem.center;
        self.refreshingItem.hidden = YES;
        [self addSubview:self.refreshingItem];
        //Set up label
        
        CGRect labelFrame;
        labelFrame.origin = CGPointMake(0.0,defaultPullHeight/4 * 3);
        labelFrame.size =CGSizeMake([UIScreen mainScreen].bounds.size.width,defaultPullHeight/4);
        self.lastUpdateLabel = [[UILabel alloc] init];
        self.lastUpdateLabel.frame = labelFrame;
        self.lastUpdateLabel.textAlignment = NSTextAlignmentCenter;
        self.lastUpdateLabel.textColor = textcolor;
        self.lastUpdateLabel.font = [UIFont systemFontOfSize:10];
        self.lastUpdateLabel.alpha = 0.0;
        [self addSubview:self.lastUpdateLabel];
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        NSLayoutConstraint * consstraint1 = [NSLayoutConstraint constraintWithItem:self
                                                                         attribute:NSLayoutAttributeCenterX
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:scrollview
                                                                         attribute:NSLayoutAttributeCenterX
                                                                        multiplier:1.0
                                                                          constant:0.0];
        NSLayoutConstraint * consstraint2 = [NSLayoutConstraint constraintWithItem:self
                                                                         attribute:NSLayoutAttributeBottom
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:scrollview
                                                                         attribute:NSLayoutAttributeTop
                                                                        multiplier:1.0
                                                                          constant:-1 * scrollview.contentInset.top];
        NSLayoutConstraint * consstraint3 = [NSLayoutConstraint constraintWithItem:self
                                                                         attribute:NSLayoutAttributeWidth
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute:NSLayoutAttributeWidth
                                                                        multiplier:1.0
                                                                          constant:[UIScreen mainScreen].bounds.size.width];
        NSLayoutConstraint * consstraint4 = [NSLayoutConstraint constraintWithItem:self
                                                                         attribute:NSLayoutAttributeHeight
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute:NSLayoutAttributeHeight
                                                                        multiplier:1.0
                                                                          constant:defaultPullHeight];
        [scrollview addConstraints:@[consstraint1,consstraint2,consstraint3,consstraint4]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationDidChanged:)
                                                     name:UIDeviceOrientationDidChangeNotification
                                                   object:nil];
    }
    return self;
}
-(void)orientationDidChanged:(NSNotification *)notification
{
    if (self.state== WCPullRefreshControlStateIdle) {
        self.originalOffset = 0;
    }if(self.state == WCPullRefreshControlStateRefreshing){
        self.originalOffset = self.attachedScrollView.contentInset.top - defaultPullHeight;
    }
}

-(void)updateWhenScrollDidEndDraging{
    if ([self currentProgress] >=1 && self.state == WCPullRefreshControlStateIdle) {
        self.state = WCPullRefreshControlStateRefreshing;
        self.refreshingItem.hidden = NO;
        self.progressItem.hidden = YES;
        [self.refreshingItem startAnimating];
        CGPoint currentOffset = self.attachedScrollView.contentOffset;
        self.attachedScrollView.contentInset = UIEdgeInsetsMake(defaultPullHeight+self.originalOffset,0,0,0);
        self.attachedScrollView.contentOffset = currentOffset;
        self.lastUpdateLabel.text = @"Updating...";
        if (self.refreshAction) {
            self.refreshAction();
        }
        if ([self.delegate respondsToSelector:@selector(DidStartRefreshingWithScrollview:)]) {
            [self.delegate DidStartRefreshingWithScrollview:self.attachedScrollView];
        }
    }
}
-(void)updateWhenScrollviewScroll{
    if (self.state == WCPullRefreshControlStateIdle) {
        if (self.originalOffset == 0) {
            self.originalOffset = self.attachedScrollView.contentInset.top;
        }
        self.progressItem.progress = [self currentProgress];
        self.lastUpdateLabel.alpha = [self currentProgress];
        self.progressItem.alpha = [self currentProgress];
        if (self.showLastUpdate) {
            self.lastUpdateLabel.text = [NSDate stringFromLastdate:self.lastUpdateDate];
        }else{
            if ([self currentProgress] < 1.0) {
                self.lastUpdateLabel.text = @"Pull to update...";
            }else{
                self.lastUpdateLabel.text = @"Release to update...";
            }
        }
    }
}
-(void)manualStartRefreshingWithAction{
    [UIView animateWithDuration:0.8
                     animations:^{
                         self.attachedScrollView.contentOffset = CGPointMake(0,-1 * self.attachedScrollView.contentInset.top - self.pullHeight);
                         
                     } completion:^(BOOL finished) {
                         [self updateWhenScrollDidEndDraging];
                         //                         action();
                     }];
}
-(void)finishRefreshingSuccessully:(BOOL)success{
    [self.refreshingItem stopAnimating];
    self.state = WCPullRefreshControlStateDisappearing;
    if (success) {
        self.lastUpdateDate = [NSDate date];
        self.lastUpdateLabel.text = @"Succeed to update";
    }else{
        self.lastUpdateLabel.text = @"Fail to update";
    }
    [UIView animateWithDuration:0.8 animations:^{
        self.attachedScrollView.contentInset = UIEdgeInsetsMake(self.originalOffset,0,0,0);
    } completion:^(BOOL finished) {
        self.refreshingItem.hidden = YES;
        self.progressItem.hidden = NO;
        self.state = WCPullRefreshControlStateIdle;
        self.originalOffset = 0.0;
    }];
}
-(CGFloat)currentProgress{
    return MIN(1.0,MAX(0,-1*(self.attachedScrollView.contentOffset.y + self.originalOffset)/self.pullHeight));
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:UIDeviceOrientationDidChangeNotification];
    [self removeFromSuperview];
}
@end
