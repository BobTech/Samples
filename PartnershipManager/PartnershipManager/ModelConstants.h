

#ifdef APP_DEBUG
#define THIRD_DEBUG_MODE
#endif

/* Proper debug macro for logging */

#ifdef THIRD_DEBUG_MODE

#define DebugLog(s, ...) NSLog(@"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__])
#import <Foundation/Foundation.h>
#import "VTPG_Common.h"

#else

#define DebugLog(s, ...)
#define LOG_EXPR(_X_)


#define kClientUserAgent @"Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3 like Mac OS X; en-us) AppleWebKit/528.18 (KHTML, like Gecko) UrhoTVClient"

#endif