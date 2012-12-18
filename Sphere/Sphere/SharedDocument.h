//
//  SharedDocument.h
//  ShoppingList
//
//  Created by Søren Bruus Frank on 10/24/12.
//  Copyright (c) 2012 Storm of Brains. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef void (^OnDocumentReady) (UIManagedDocument *document);

@interface SharedDocument : NSObject

@property (strong, nonatomic) UIManagedDocument *document;

+ (SharedDocument *)sharedDocumentHandler;
- (void)performWithDocument:(OnDocumentReady)onDocumentReady;

@end
