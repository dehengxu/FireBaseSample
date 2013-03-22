//
//  FirebaseDB.m
//  FireBaseSample
//
//  Created by Deheng.Xu on 13-3-22.
//  Copyright (c) 2013年 Nicholas.Xu. All rights reserved.
//

#import "FirebaseDB.h"

static dispatch_queue_t __fb_dispatch_queue = NULL;

@implementation FirebaseDB

@synthesize firebase = _firebase;
@synthesize fbURL = _fbURL;

+ (void)initialize
{
    if (!__fb_dispatch_queue) {
        __fb_dispatch_queue = dispatch_get_global_queue(0, 0);
        dispatch_retain(__fb_dispatch_queue);
        [Firebase setDispatchQueue:__fb_dispatch_queue];
    }
}

+ (void)setDispatchQueue:(dispatch_queue_t)dispatch_queue
{
    if (__fb_dispatch_queue) {
        dispatch_release(__fb_dispatch_queue);
        __fb_dispatch_queue = NULL;
    }
    __fb_dispatch_queue = dispatch_queue;
    dispatch_retain(dispatch_queue);
}

+ (id)firebaseWithUrl:(NSString *)aUrl
{
    id fb = [[[self alloc] initWithUrl:aUrl] autorelease];
    [Firebase setDispatchQueue:__fb_dispatch_queue];
    return fb;
}

- (id)initWithUrl:(NSString *)aUrl
{
    self = [super init];
    if (self) {
        _fbURL = [[NSURL alloc] initWithString:aUrl];
    }
    return self;
}

- (void)dealloc
{
    dispatch_release(__fb_dispatch_queue);
    [_fbURL release];
    [_firebase release];
    [super dealloc];
}

- (Firebase *)firebase
{
    if (!_firebase) {
        _firebase = [[Firebase alloc] initWithUrl:self.fbURL.absoluteString];
    }
    return _firebase;
}

- (void)setValue:(id)value
{
    [self.firebase setValue:value];
}

- (id)value
{
    [self.firebase observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        if (_delegate && [_delegate respondsToSelector:@selector(friebaseDB:didFetchedValue:)]) {
            [_delegate friebaseDB:self didFetchedValue:snapshot.value];
        }
    }];
    return nil;
}

- (void)setValue:(id)value forKeyPath:(NSString *)keyPath
{
    Firebase *fb = [self.firebase childByAppendingPath:keyPath];
    
    [fb setValue:value withCompletionBlock:^(NSError *error) {
        if (_delegate) {
            if (error) {
                if ([_delegate respondsToSelector:@selector(didFailedWritingFirebaseDB:withError:)]) {
                    [_delegate didFailedWritingFirebaseDB:self withError:error];
                }
            }else {
                if ([_delegate respondsToSelector:@selector(didSuccessedWritingFirebaseDB:)]) {
                    [_delegate didSuccessedWritingFirebaseDB:self];
                }
            }
        }
    }];
}

- (id)valueForKeyPath:(NSString *)keyPath
{
    Firebase *fb = [self.firebase childByAppendingPath:keyPath];
    [fb observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        if (_delegate && [_delegate respondsToSelector:@selector(friebaseDB:didFetchedValue:)]) {
            NSLog(@"finished :%@", keyPath);
            [_delegate friebaseDB:self didFetchedValue:snapshot.value];
        }
    }];
    return nil;
}

- (void)removeValueForKeyPath:(NSString *)keyPath
{
    Firebase *fb = [self.firebase childByAppendingPath:keyPath];
    [fb removeValue];
}

@end
