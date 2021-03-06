//
//  Vector2.m
//  Pleasant3D
//
//  Created by Eberhard Rensch on 23.07.09.
//  Copyright 2009 Pleasant Software. All rights reserved.
//
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

#import "Vector2.h"


@implementation Vector2

- (id)initVectorWithX:(float)inX Y:(float)inY;
{
	self = [super init];
	if (self != nil) 
	{
		_x = inX;
		_y = inY;
	}
	return self;
}

- (id)initWithCoder:(NSCoder*)decoder
{
	self = [super init];
	if(self)
	{
		_x = [decoder decodeFloatForKey:@"x"];
		_y = [decoder decodeFloatForKey:@"y"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder*)encoder
{
	[encoder encodeFloat:_x forKey:@"x"];
	[encoder encodeFloat:_y forKey:@"y"];
}

- (Vector2*)copyWithZone:(NSZone *)zone
{
	return [[Vector2 alloc] initVectorWithX:_x Y:_y];
}

- (Vector2*)vectorByAddingVector:(Vector2*)other
{
	return [[Vector2 alloc] initVectorWithX:_x+other.x Y:_y+other.y];
}

- (Vector2*)addVector:(Vector2*)other
{
	_x+=other.x;
	_y+=other.y;
	return self;
}

- (Vector2*)vectorBySubtractingVector:(Vector2*)other
{
	return [[Vector2 alloc] initVectorWithX:_x-other.x Y:_y-other.y];
}

- (Vector2*)subtractVector:(Vector2*)other
{
	_x-=other.x;
	_y-=other.y;
	return self;
}

- (Vector2*)vectorByMultiplyingVector:(Vector2*)other
{
	return [[Vector2 alloc] initVectorWithX:_x*other.x-_y*other.y Y:_x*other.y+_y*other.x];
}

- (Vector2*)multiplyVector:(Vector2*)other
{
	float a = _x*other.x-_y*other.y;
	float b = _x*other.y+_y*other.x;
	_x=a;
	_y=b;
	return self;
}

- (Vector2*)vectorByMultiplyingScalar:(float)scalar
{
	return [[Vector2 alloc] initVectorWithX:_x*scalar Y:_y*scalar];
}

- (Vector2*)multiplyScalar:(float)scalar
{
	_x*=scalar;
	_y*=scalar;
	return self;
}

- (Vector2*)vectorByDividingScalar:(float)scalar
{
	return [[Vector2 alloc] initVectorWithX:_x/scalar Y:_y/scalar];
}

- (Vector2*)divideScalar:(float)scalar
{
	_x/=scalar;
	_y/=scalar;
	return self;
}

- (float)length
{
	return sqrtf(_x*_x + _y*_y);
}

- (float)lengthOfSubtractionWithVector:(Vector2*)other
{
	float subX=_x-other.x;
	float subY=_y-other.y;
	return sqrtf(subX*subX + subY*subY);
}

- (float)dotProduct:(Vector2*)other
{
	return _x * other.x + _y * other.y;
}

- (float)dotProductPlusOne:(Vector2*)other
{
	return 1.0 + [self dotProduct:other];
}

// Get the normalized complex.
- (Vector2*)vectorByNormalizing
{
	float complexNumberLength = [self length];
	if(complexNumberLength > 0.)
		return [self vectorByDividingScalar:complexNumberLength];
	return self;
}

- (Vector2*)normalize
{
	float complexNumberLength = [self length];
	if(complexNumberLength > 0.)
		return [self divideScalar:complexNumberLength];
	return self;
}

- (float)getCrossProduct:(Vector2*)other
{
	return _x * other.y - _y * other.x;
}

- (float)getWiddershinsDot:(Vector2*)other
{
	float dot = [self dotProductPlusOne:other];
	if([self getCrossProduct:other] >= 0.0)
		return -dot;
	return dot;
}

- (NSString*)description
{
	return [NSString stringWithFormat:@"(%f, %f)",_x,_y];
}

- (void)maximizeWithVector:(Vector2*)other
{
	_x = MAX(_x, other.x);
	_y = MAX(_y, other.y);
}

- (void)minimizeWithVector:(Vector2*)other;
{
	_x = MIN(_x, other.x);
	_y = MIN(_y, other.y);
}

- (Vector2*)vectorBySqrt
{
	float a = atan2(_y, _x);
	float r = sqrtf([self length]);
	return [[Vector2 alloc] initVectorWithX:cos(a)*r Y:sin(a)*r];	
}
@end
