/*
 * Author: Landon Fuller <landonf@plausible.coop>
 *
 * Copyright (c) 2008-2013 Plausible Labs Cooperative, Inc.
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 */

#import "GTMSenTestCase.h"

#include "Result.hpp"

using namespace plcrash::async;

@interface ResultTests : SenTestCase @end

/**
 * Test our Result type.
 */
@implementation ResultTests

/** Verify that successful values can be iterated */
- (void) testSuccessIteration {
    int iterated = 0;
    for (auto v : Result<const char *, int>(42)) {
        STAssertEquals(0, iterated, @"More than one value iterated");
        iterated = v;
    }
    STAssertEquals(42, iterated, @"Incorrect value iterated");
    
}

/** Verify that failure values are not iterated */
- (void) testFailureIteration {
    /* If this doesn't iterate, we're golden */
    for (auto v : Result<const char *, int>("failure")) {
        STFail(@"Iteration should have terminated immediately, instead iterated result: %d", v);
    }
}

@end

