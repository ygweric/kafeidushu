//
//  Created by Eric Yang on 13-5-29.
//  Copyright (c) 2013年 Eric Yang. All rights reserved.
//

#define IS_IPAD UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define SCREEN_HEIGHT [[UIScreen mainScreen ] bounds ].size.height