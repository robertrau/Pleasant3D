//
//  P3DPrintJob.m
//  P3DCore
//
//  Created by Eberhard Rensch on 11.04.10.
//  Copyright 2010 Pleasant Software. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify it under
//  the terms of the GNU General Public License as published by the Free Software 
//  Foundation; either version 3 of the License, or (at your option) any later 
//  version.
// 
//  This program is distributed in the hope that it will be useful, but WITHOUT ANY 
//  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A 
//  PARTICULAR PURPOSE. See the GNU General Public License for more details.
// 
//  You should have received a copy of the GNU General Public License along with 
//  this program; if not, see <http://www.gnu.org/licenses>.
// 
//  Additional permission under GNU GPL version 3 section 7
// 
//  If you modify this Program, or any covered work, by linking or combining it 
//  with the P3DCore.framework (or a modified version of that framework), 
//  containing parts covered by the terms of Pleasant Software's software license, 
//  the licensors of this Program grant you additional permission to convey the 
//  resulting work.
//
#import "P3DMachineJob.h"
#import "P3DMachiningQueue.h"
#import "P3DSerialDevice.h"

@implementation P3DMachineJob

- (void)processJob
{
	if(_driver.currentDevice && _driver.currentDevice.activeMachineJob==nil)
	{
		self.progress = 0.;
        _driver.currentDevice.activeMachineJob = self;
		_driver.machining = YES;
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
			[self implProcessJobWithCompletionHandler:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    _driver.machining = NO;
                    _driver.currentDevice.activeMachineJob = nil;
                    [self.queue machiningComplete:self];
				});
            }];
		});
	}
}

// Abstract
- (void)implProcessJobWithCompletionHandler:(dispatch_block_t)completionHandler
{
}

// Abstract
- (void)handleDeviceResponse:(NSString*)response
{
}
@end
