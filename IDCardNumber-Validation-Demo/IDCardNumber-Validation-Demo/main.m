//
//  main.m
//  IDCardNumber-Validation-Demo
//
//  Created by Vincent on 2/26/16.
//  Copyright © 2016 Vincent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDCardNumberValidator.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSArray *IDs = @[@"510234200105183376", @"431037200010280016", @"441322199002093019", @"61232619800820051X", @"522731198402148335", @"441322199211282721", @"522129198306064014", @"420983199207026013", @"452630197408051724", @"512223196111233677", @"522524197103085814", @"43052219730821437X", @"362123197605253015", @"450821199604182192", @"441624199910023816", @"441624198002295248", @"510821197204033718", @"420921199005174422", @"500236198609253983", @"47272819871014361X", @"440481199612124885"];
        for (NSString *ID in IDs) {
            NSLog(@"%@-%@", ID, [IDCardNumberValidator validateIDCardNumber:ID] ? @"有效" : @"无~~效");
        }
    }
    return 0;
}
