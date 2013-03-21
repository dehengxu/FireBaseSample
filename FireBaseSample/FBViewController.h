//
//  FBViewController.h
//  FireBaseSample
//
//  Created by Deheng.Xu on 13-3-21.
//  Copyright (c) 2013年 Nicholas.Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Firebase;

@interface FBViewController : UIViewController

@property (nonatomic, readonly) Firebase *firebase;
@property (nonatomic, retain) IBOutlet UITextView *resultView;
@property (nonatomic, retain) IBOutlet UITextView *sendView;

- (IBAction)onClick_send:(id)sender;
- (IBAction)onClick_fetch:(id)sender;

@end
