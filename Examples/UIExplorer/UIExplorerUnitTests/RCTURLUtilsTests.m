/**
 * The examples provided by Facebook are for non-commercial testing and
 * evaluation purposes only.
 *
 * Facebook reserves all rights not expressly granted.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NON INFRINGEMENT. IN NO EVENT SHALL
 * FACEBOOK BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
 * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import <XCTest/XCTest.h>
#import "RCTUtils.h"

@interface RCTURLUtilsTests : XCTestCase

@end

@implementation RCTURLUtilsTests

- (void)testGetQueryParam
{
  NSURL *URL = [NSURL URLWithString:@"http://example.com?foo=bar&bar=foo"];
  NSString *foo = RCTGetURLQueryParam(URL, @"foo");
  NSString *bar = RCTGetURLQueryParam(URL, @"bar");
  XCTAssertEqualObjects(foo, @"bar");
  XCTAssertEqualObjects(bar, @"foo");
}

- (void)testQueryParamNotFound
{
  NSURL *URL = [NSURL URLWithString:@"http://example.com?foo=bar"];
  NSString *bar = RCTGetURLQueryParam(URL, @"bar");
  XCTAssertNil(bar);
}

- (void)testDuplicateParamTakesLatter
{
  NSURL *URL = [NSURL URLWithString:@"http://example.com?foo=bar&foo=foo"];
  NSString *foo = RCTGetURLQueryParam(URL, @"foo");
  XCTAssertEqualObjects(foo, @"foo");
}

- (void)testNilURLGetQueryParam
{
  NSURL *URL = nil;
  NSString *foo = RCTGetURLQueryParam(URL, @"foo");
  XCTAssertNil(foo);
}

- (void)testReplaceParam
{
  NSURL *URL = [NSURL URLWithString:@"http://example.com?foo=bar&bar=foo"];
  NSURL *result = RCTURLByReplacingQueryParam(URL, @"foo", @"foo");
  XCTAssertEqualObjects(result.absoluteString, @"http://example.com?foo=foo&bar=foo");
}

- (void)testAppendParam
{
  NSURL *URL = [NSURL URLWithString:@"http://example.com?bar=foo"];
  NSURL *result = RCTURLByReplacingQueryParam(URL, @"foo", @"bar");
  XCTAssertEqualObjects(result.absoluteString, @"http://example.com?bar=foo&foo=bar");
}

- (void)testNilURLAppendQueryParam
{
  NSURL *URL = nil;
  NSURL *result = RCTURLByReplacingQueryParam(URL, @"foo", @"bar");
  XCTAssertNil(result);
}

@end
