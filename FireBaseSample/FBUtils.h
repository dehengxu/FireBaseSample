//
//  FBUtils.h
//  FireBaseSample
//
//  Created by Deheng.Xu on 13-3-21.
//  Copyright (c) 2013年 Nicholas.Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

//Firebase url likes :https://SampleChat.firebaseIO-demo.com
#define kFBURL @"http://fdb-sample.firebaseio.com/"

@interface FBUtils : NSObject

@end

extern dispatch_queue_t GetFirebaseWorkingQueue();
