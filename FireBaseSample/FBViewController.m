//
//  FBViewController.m
//  FireBaseSample
//
//  Created by Deheng.Xu on 13-3-21.
//  Copyright (c) 2013年 Nicholas.Xu. All rights reserved.
//

#import "FBViewController.h"
#import "FBUtils.h"

static NSString *user_name = @"Nick";

@interface FBViewController ()

@end

@implementation FBViewController

@synthesize firebase = _firebase;

- (void)dealloc
{
    [_firebase release];
    [_resultView release];
    [_sendView release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.    
    self.resultView.text = @"";
    self.sendView.text = @"";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

- (Firebase *)firebase
{
    @try {
        if (!_firebase) {
            _firebase = [[Firebase alloc] initWithUrl:kFBURL];
        }
    }@catch (NSException *exception) {
        if (_firebase) {
            [_firebase release];
            _firebase = nil;
        }
        NSLog(@"~ %d %@", __LINE__, exception);
    }@finally {
        return _firebase;
    }
}

- (void)onClick_send:(id)sender
{
    @try {
        Firebase *fdb = nil;
        fdb = [self.firebase childByAppendingPath:@"test"];
        Firebase *subFdb = [fdb childByAutoId];

        NSDate *date = nil;
        
        date = [NSDate date];
        [subFdb setValue:[NSString stringWithFormat:@"Hello %f", date.timeIntervalSince1970]  withCompletionBlock:^(NSError *error) {
            NSLog(@"err:%@, elaps :%f;", [error localizedDescription], [[NSDate date] timeIntervalSinceDate:date]);
        }];
        
        date = [NSDate date];
        [subFdb setValue:[NSString stringWithFormat:@"Hi,where are U? %f", date.timeIntervalSince1970] withCompletionBlock:^(NSError *error) {
            NSLog(@"err:%@, elaps :%f;", [error localizedDescription], [[NSDate date] timeIntervalSinceDate:date]);
        }];
        
    }
    @catch (NSException *exception) {
        NSLog(@"~ %@", exception);
    }
    @finally {
        NSLog(@"~ saved over!");
    }
}

- (void)onClick_fetch:(id)sender
{
    @try {
        
        Firebase *fdb = [self.firebase childByAppendingPath:@"test"];
        [fdb removeValue];        
    }
    @catch (NSException *exception) {
        NSLog(@"~ %@", exception);
    }
    @finally {
        NSLog(@"~ saved over!");
    }
}

@end
