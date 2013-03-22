//
//  FirebaseDB.h
//  FireBaseSample
//
//  Just a simple wrapper for firebase.
//
//  
//
//  Created by Deheng.Xu on 13-3-22.
//  Copyright (c) 2013年 Nicholas.Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FirebaseDB;

@protocol FirebaseDBDelegate <NSObject>

@optional
- (void)friebaseDB:(FirebaseDB *)afbDB didFetchedValue:(id)value;

@end

@class Firebase;

@interface FirebaseDB : NSObject

@property (nonatomic, readonly) NSURL *fbURL;
@property (nonatomic, readonly) Firebase *firebase;
@property (nonatomic, assign) id<FirebaseDBDelegate> delegate;


+ (void)setDispatchQueue:(dispatch_queue_t) dispatch_queue;
+ (id)firebaseWithUrl:(NSString *)aUrl;
- (id)initWithUrl:(NSString *)aUrl;

- (void)setValue:(id)value;
- (id)value;

- (void)setValue:(id)value forKeyPath:(NSString *)keyPath;
- (id)valueForKeyPath:(NSString *)keyPath;

- (void)removeValueForKeyPath:(NSString *)keyPath;

@end
