//
//  FBViewController.m
//  FireBaseSample
//
//  Created by Deheng.Xu on 13-3-21.
//  Copyright (c) 2013年 Nicholas.Xu. All rights reserved.
//

#import "FBViewController.h"
#import "FBUtils.h"
#import "FirebaseDB.h"

@interface FBViewController ()

@end

@implementation FBViewController

@synthesize firebase = _firebase;
@synthesize fbDB = _fbDB;

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
    dispatch_queue_t queue = dispatch_queue_create("com.cyblion.firebase", NULL);
    [FirebaseDB setDispatchQueue:queue];
    dispatch_release(queue);
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

- (FirebaseDB *)fbDB
{
    if (!_fbDB) {
        _fbDB = [[FirebaseDB alloc] initWithUrl:kFBURL];
        _fbDB.delegate = self;
    }
    return _fbDB;
}

- (void)onClick_send:(id)sender
{
    @try {
        FirebaseDB *fbDB = self.fbDB;
        [fbDB setValue:@"KKDF" forKeyPath:@"User/Message"];
        [fbDB setValue:[NSString stringWithFormat:@"%@", [NSDate date]] forKeyPath:@"User/Time"];
    }
    @catch (NSException *exception) {
        NSLog(@"~ %@", exception);
    }
    @finally {
        NSLog(@"~ saved over!");
    }
}

- (void)onClick_clear:(id)sender
{
    @try {
        [self.fbDB removeValueForKeyPath:@"User/Message"];
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
    //fetch specified node.
    [self.fbDB valueForKeyPath:@"User/Message"];
    [self.fbDB valueForKeyPath:@"User/Time"];
    [self.fbDB valueForKeyPath:@"/User"];
    //fetch root node.
    [self.fbDB valueForKeyPath:@"/"];
    
}

- (void)didSuccessedWritingFirebaseDB:(FirebaseDB *)afbDB
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)didFailedWritingFirebaseDB:(FirebaseDB *)afbDB withError:(NSError *)anError
{
    NSLog(@"%s %@", __FUNCTION__, [anError localizedDescription]);
}

- (void)friebaseDB:(FirebaseDB *)afbDB didFetchedValue:(id)value
{
    NSLog(@"value :%@", value);
    dispatch_async(dispatch_get_main_queue(), ^{
        self.resultView.text = [NSString stringWithFormat:@"%@\n%@", self.resultView.text, value];
    });
}

@end
