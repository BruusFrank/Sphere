//
//  DatabaseFake.m
//  Sphere
//
//  Created by Søren Bruus Frank on 1/16/13.
//  Copyright (c) 2013 Storm of Brains. All rights reserved.
//

#import "DatabaseFake.h"

@implementation DatabaseFake

static DatabaseFake *sharedDatabase = nil;

- (NSArray *)usersInProximity
{
    _usersInProximity = [self generateUsers];
    return _usersInProximity;
}

+ (DatabaseFake *)sharedDatabase
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedDatabase = [[self alloc] init];
    });
    return sharedDatabase;
}

- (DatabaseFake *)init
{
    self.usersInProximity = [self generateUsers];
    
    return self;
}

- (NSArray *)generateUsers
{
    NSDictionary *kasperBF;
    NSDictionary *kasperBJ;
    NSDictionary *soerenBF;
    NSDictionary *boP;
    NSDictionary *courtney;
    NSDictionary *stine;
    NSDictionary *pernille;
    NSDictionary *ganesh;
    NSDictionary *ida;
    NSDictionary *ngabe;
    
    NSString *statement = @"I'm currently having the train ride of my life. Free coffee, first class, and Cannonball is playing on the radio. Does it get any better than this?";
    
    kasperBF = [[NSDictionary alloc] initWithObjectsAndKeys:@"Kasper Bruus Frank", @"name",
                [[NSArray alloc] initWithObjects:@"Snowboarding", @"IT", @"Design", nil], @"interests",
                [[NSArray alloc] initWithObjects:@"Photoshop", @"Front-end programming", @"iOS development", nil], @"skills",
                @"23", @"age", @"Information Technology, Aarhus University", @"education", statement, @"statement", @"Helpdesk supporter, Aarhus University", @"work", @"Aarhus, Denmark", @"hometown",
                [UIImage imageNamed:@"kbf.jpg"], @"picture",
                [NSNumber numberWithInt:1], @"contactable",
                [NSNumber numberWithInt:0], @"request",
                nil];
    
    kasperBJ = [[NSDictionary alloc] initWithObjectsAndKeys:@"Kasper Buhl Jakobsen", @"name",
                [[NSArray alloc] initWithObjects:@"Tricking", @"IT", @"Android", nil], @"interests",
                [[NSArray alloc] initWithObjects:@"Android development", @"Poker", @"Concept development", nil], @"skills",
                @"23", @"age", statement, @"statement", @"Instruktor (Innovation processes), Aarhus University", @"work", @"Aarhus, Denmark", @"hometown", @"Information Technology, Aarhus University", @"education",
                [UIImage imageNamed:@"kbj.jpg"], @"picture",
                [NSNumber numberWithInt:0], @"contactable",
                [NSNumber numberWithInt:0], @"request",
                nil];
    
    soerenBF = [[NSDictionary alloc] initWithObjectsAndKeys:@"Søren Bruus Frank", @"name",
                [[NSArray alloc] initWithObjects:@"Snowboarding", @"IT", @"iOS development", nil], @"interests",
                [[NSArray alloc] initWithObjects:@"Client-side programming", @"Server-side programming", @"iOS development", nil], @"skills",
                @"23", @"age", @"Information Technology, Aarhus University", @"education", statement, @"statement", @"Helpdesk supporter, Aarhus University", @"work", @"Aarhus, Denmark", @"hometown",
                [UIImage imageNamed:@"sbf.jpg"], @"picture",
                [NSNumber numberWithInt:0], @"contactable",
                [NSNumber numberWithInt:0], @"request",
                nil];
    
    boP = [[NSDictionary alloc] initWithObjectsAndKeys:@"Bo Penstoft", @"name",
           [[NSArray alloc] initWithObjects:@"Gaming", @"IT", @"Exercise", nil], @"interests",
           [[NSArray alloc] initWithObjects:@"After effects", @"Business models", nil], @"skills",
           @"23", @"age", @"Information Technology, Aarhus University", @"education", statement, @"statement", @"IT supporter, Danske Bank", @"work", @"Aarhus, Denmark", @"hometown",
           [UIImage imageNamed:@"bo.jpg"], @"picture",
           [NSNumber numberWithInt:1], @"contactable",
           [NSNumber numberWithInt:0], @"request",
           nil];
    
    courtney = [[NSDictionary alloc] initWithObjectsAndKeys:@"Courtney Davis", @"name",
                [[NSArray alloc] initWithObjects:@"Movies", @"Journalism", @"Exercise", nil], @"interests",
                [[NSArray alloc] initWithObjects:@"Photography", @"Writing", @"Article layout", nil], @"skills",
                @"23", @"age", @"War, Media and Globalization, Aarhus University", @"education", statement, @"statement", @"Cashier, Coles", @"work", @"Aarhus, Denmark", @"hometown",
                [UIImage imageNamed:@"cd.jpg"], @"picture",
                [NSNumber numberWithInt:1], @"contactable",
                [NSNumber numberWithInt:0], @"request",
                nil];
    stine = [[NSDictionary alloc] initWithObjectsAndKeys:@"Stine Frank Kristensen", @"name",
             [[NSArray alloc] initWithObjects:@"Economics", @"Horseriding", @"Cleaning", nil], @"interests",
             [[NSArray alloc] initWithObjects:@"Micro economics", @"Project planning", nil], @"skills",
             @"23", @"age", @"Økonomi, Aarhus University", @"education", statement, @"statement", @"Postomdeler, Post Danmark", @"work", @"Aarhus, Denmark", @"hometown",
             [UIImage imageNamed:@"stine.jpg"], @"picture",
             [NSNumber numberWithInt:0], @"contactable",
             [NSNumber numberWithInt:0], @"request",
             nil];
    pernille = [[NSDictionary alloc] initWithObjectsAndKeys:@"Pernille Bohl Clausen", @"name",
                [[NSArray alloc] initWithObjects:@"Journalism", @"Party-planning", @"Traveling", nil], @"interests",
                [[NSArray alloc] initWithObjects:@"Project management", @"HTML & CSS", @"Digital media layout", nil], @"skills",
                @"23", @"age", @"Digital design, Aarhus University", @"education", statement, @"statement", @"Piccolo, Scandic Hotel", @"work", @"Aarhus, Denmark", @"hometown",
                [UIImage imageNamed:@"pernille.jpg"], @"picture",
                [NSNumber numberWithInt:1], @"contactable",
                [NSNumber numberWithInt:0], @"request",
                nil];
    ganesh = [[NSDictionary alloc] initWithObjectsAndKeys:@"Ganesh (Knallert starter)", @"name",
              [[NSArray alloc] initWithObjects:@"Fitness", @"Music", @"Business", nil], @"interests",
              [[NSArray alloc] initWithObjects:@"Skill1", @"Skill2", @"Skill3", nil], @"skills",
              @"23", @"age", @"Information Technology, Aarhus University", @"education", statement, @"statement", @"Helpdesk supporter, Aarhus University", @"work", @"Aarhus, Denmark", @"hometown",
              [UIImage imageNamed:@"ganesh.jpg"], @"picture",
              [NSNumber numberWithInt:0], @"contactable",
              [NSNumber numberWithInt:0], @"request",
              nil];
    ida = [[NSDictionary alloc] initWithObjectsAndKeys:@"Ida Hekman Nielsen", @"name",
           [[NSArray alloc] initWithObjects:@"Photography", @"Media", @"Music", nil], @"interests",
           [[NSArray alloc] initWithObjects:@"HTML", @"Commercial law", nil], @"skills",
           @"23", @"age", @"Jura, Aarhus University", @"education", statement, @"statement", @"Helpdesk supporter, Aarhus University", @"work", @"Aarhus, Denmark", @"hometown",
           [UIImage imageNamed:@"ida.jpg"], @"picture",
           [NSNumber numberWithInt:1], @"contactable",
           [NSNumber numberWithInt:0], @"request",
           nil];
    ngabe = [[NSDictionary alloc] initWithObjectsAndKeys:@"Ngabe Johnson", @"name",
             [[NSArray alloc] initWithObjects:@"Therapy", @"Cooking", @"Disco dancing", nil], @"interests",
             [[NSArray alloc] initWithObjects:@"Skill1", @"Skill2", @"Skill3", nil], @"skills",
             @"23", @"age", @"Information Technology, Aarhus University", @"education", statement, @"statement", @"Helpdesk supporter, Aarhus University", @"work", @"Aarhus, Denmark", @"hometown",
             [UIImage imageNamed:@"ngabe.jpg"], @"picture",
             [NSNumber numberWithInt:1], @"contactable",
             [NSNumber numberWithInt:0], @"request",
             nil];
    
    return [[NSArray alloc] initWithObjects:kasperBF, kasperBJ, pernille, stine, boP, courtney, ida, nil];
}


@end
