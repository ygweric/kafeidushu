//
//  WifiViewController.m
//  Paging
//
//  Created by Eric Yang on 13-6-13.
//  Copyright (c) 2013年 Eric Yang. All rights reserved.
//

#import "WifiViewController.h"
#import "NetUtil.h"
#import "HTTPServer.h"
#import "DDLog.h"
#import "DDTTYLogger.h"
#import "MyHTTPConnection.h"



@implementation WifiViewController{
    HTTPServer *httpServer;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)handlerPortSuccess:(NSNotification *)notification{
    NSDictionary* userInfo=notification.userInfo;
    NSNumber* port=[userInfo valueForKey:@"local_port"];
    NSLog(@"handlerPortSuccess----port:%d",port.unsignedShortValue);
    
    NSString* localIp=[NetUtil getLocalIp];
    _lbLocalAddress.text=[NSString stringWithFormat:@"%@:%d",localIp,port.unsignedShortValue];
}
-(void)handlerPortFail:(NSNotification *)notification{
    NSLog(@"handlerPortFail-----");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSNotificationCenter *nc=[NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(handlerPortSuccess:) name:@"HTTPServer_get_port_success" object:nil];
    [nc addObserver:self selector:@selector(handlerPortFail:) name:@"HTTPServer_get_port_fail" object:nil];
    

    
    
    // Configure our logging framework.
	// To keep things simple and fast, we're just going to log to the Xcode console.
	[DDLog addLogger:[DDTTYLogger sharedInstance]];
	
	// Initalize our http server
	httpServer = [[HTTPServer alloc] init];
	
	// Tell the server to broadcast its presence via Bonjour.
	// This allows browsers such as Safari to automatically discover our service.
	[httpServer setType:@"_http._tcp."];
	
	// Normally there's no need to run our server on any specific port.
	// Technologies like Bonjour allow clients to dynamically discover the server's port at runtime.
	// However, for easy testing you may want force a certain port so you can just hit the refresh button.
    //	[httpServer setPort:12345];
	
	// Serve files from the standard Sites folder
	NSString *docRoot = [[[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"web"] stringByDeletingLastPathComponent];
	NSLog(@"Setting document root: %@", docRoot);
	
	[httpServer setDocumentRoot:docRoot];
	
	[httpServer setConnectionClass:[MyHTTPConnection class]];
	
	NSError *error = nil;
	if(![httpServer start:&error])
	{
		NSLog(@"Error starting HTTP Server: %@", error);
	}
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)moveAllFileToDocument{
//    NSString* srcPath= [[[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"web"] stringByDeletingLastPathComponent];
    NSString* srcPath=[[[NSBundle mainBundle] resourcePath ] stringByAppendingPathComponent:@"web/upload"];
    
    NSString *dicpath = [NSString stringWithFormat:@"%@/Documents",NSHomeDirectory()];
    
    
    NSFileManager* fm= [NSFileManager defaultManager];
    NSArray *levelList = [fm contentsOfDirectoryAtPath:srcPath error:nil ] ;
    
    for (NSString *fname  in levelList) {
        NSString *fpath = [NSString stringWithFormat:@"%@/%@",srcPath,fname];
        NSString* destPath=[NSString stringWithFormat:@"%@/%@",dicpath,fname];
        if ([fname hasSuffix:@".txt"]) {
            [fm moveItemAtPath:fpath toPath:destPath error:0];
            
        }
    }
}
- (void)dealloc {
    
    NSLog(@"WifiViewController---dealloc");
    [self moveAllFileToDocument];
    
    
    [httpServer stop];
    [httpServer release];
    [_lbLocalAddress release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setLbLocalAddress:nil];
    [super viewDidUnload];
}
@end
