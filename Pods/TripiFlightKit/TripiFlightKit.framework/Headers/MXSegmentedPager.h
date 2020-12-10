// RF_MXSegmentedPager.h
//
// Copyright (c) 2017 Maxime Epain
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <UIKit/UIKit.h>
#import "HMSegmentedControl.h"
#import "MXPagerView.h"
#import "MXParallaxHeader.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The segmented control position options relative to the segmented-pager.
 */
typedef NS_ENUM(NSInteger, MXSegmentedControlPosition) {
    /** Top position. */
    MXSegmentedControlPositionTop,
    /** Bottom position. */
    MXSegmentedControlPositionBottom,
    /** Top Over position. */
    MXSegmentedControlPositionTopOver

};

@class RF_MXSegmentedPager;

/**
 The delegate of a RF_MXSegmentedPager object may adopt the RF_MXSegmentedPagerDelegate protocol. Optional methods of the protocol allow the delegate to manage selections.
 */
@protocol RF_MXSegmentedPagerDelegate <NSObject>

@optional
/**
 Tells the delegate that a specified view is about to be selected.
 
 @param segmentedPager A segmented-pager object informing the delegate about the impending selection.
 @param view           The selected page view.
 */
- (void)segmentedPager:(RF_MXSegmentedPager *)segmentedPager didSelectView:(UIView *)view;

/**
 Tells the delegate that a specified title is about to be selected.
 
 @param segmentedPager A segmented-pager object informing the delegate about the impending selection.
 @param title          The selected page title.
 */
- (void)segmentedPager:(RF_MXSegmentedPager *)segmentedPager didSelectViewWithTitle:(NSString *)title;

/**
 Tells the delegate that a specified index is about to be selected.
 
 @param segmentedPager A segmented-pager object informing the delegate about the impending selection.
 @param index          The selected page index.
 */
- (void)segmentedPager:(RF_MXSegmentedPager *)segmentedPager didSelectViewWithIndex:(NSInteger)index;

/**
 Tells the delegate the segmented pager is about to draw a page for a particular index.
 A segmented page view sends this message to its delegate just before it uses page to draw a index, thereby permitting the delegate to customize the page object before it is displayed.
 
 @param segmentedPager The segmented-pager object informing the delegate of this impending event.
 @param page A page view object that segmented-pager is going to use when drawing the index.
 @param index An index locating the page in pagerView.
 */
- (void)segmentedPager:(RF_MXSegmentedPager *)segmentedPager willDisplayPage:(UIView *)page atIndex:(NSInteger)index;

/**
 Tells the delegate that the specified page was removed from the pager.
 Use this method to detect when a page is removed from a pager view, as opposed to monitoring the view itself to see when it appears or disappears.
 
 @param segmentedPager The segmented-pager object that removed the view.
 @param page The page that was removed.
 @param index The index of the page.
 */
- (void)segmentedPager:(RF_MXSegmentedPager *)segmentedPager didEndDisplayingPage:(UIView *)page atIndex:(NSInteger)index;

/**
 Asks the delegate to return the height of the segmented control in the segmented-pager.
 If the delegate doesn’t implement this method, 44 is assumed.
 
 @param segmentedPager A segmented-pager object informing the delegate about the impending selection.
 
 @return A nonnegative floating-point value that specifies the height (in points) that segmented-control should be.
 */
- (CGFloat)heightForSegmentedControlInSegmentedPager:(RF_MXSegmentedPager *)segmentedPager;

/**
 Tells the delegate that the segmented pager has scrolled with the parallax header.
 
 @param segmentedPager A segmented-pager object in which the scrolling occurred.
 @param parallaxHeader The parallax-header that has scrolled.
 */
- (void)segmentedPager:(RF_MXSegmentedPager *)segmentedPager didScrollWithParallaxHeader:(RF_MXParallaxHeader *)parallaxHeader;

/**
 Tells the delegate when dragging ended with the parallax header.
 
 @param segmentedPager A segmented-pager object that finished scrolling the content view.
 @param parallaxHeader The parallax-header that has scrolled.
 */
- (void)segmentedPager:(RF_MXSegmentedPager *)segmentedPager didEndDraggingWithParallaxHeader:(RF_MXParallaxHeader *)parallaxHeader;

/**
 Asks the delegate if the segmented-pager should scroll to the top.
 If the delegate doesn’t implement this method, YES is assumed.
 
 @param segmentedPager The segmented-pager object requesting this information.
 
 @return YES to permit scrolling to the top of the content, NO to disallow it.
 */
- (BOOL)segmentedPagerShouldScrollToTop:(RF_MXSegmentedPager *)segmentedPager;

@end

/**
 RF_MXSegmentedPager data source protocol.
 The RF_MXSegmentedPagerDataSource protocol is adopted by an object that mediates the application’s data model for a RF_MXSegmentedPager object. The data source provides the segmented-pager object with the information it needs to construct and modify a RF_MXSegmentedPager view.
 
 The required methods of the protocol provide the pages to be displayed by the segmented-pager as well as inform the RF_MXSegmentedPager object about the number of pages. The data source may implement optional methods to configure the segmented control.
 */
@protocol RF_MXSegmentedPagerDataSource <NSObject>

@required
/**
 Asks the data source to return the number of pages in the segmented-pager.
 
 @param segmentedPager A segmented-pager object requesting this information.
 
 @return The number of pages in segmented-pager.
 */
- (NSInteger)numberOfPagesInSegmentedPager:(RF_MXSegmentedPager *)segmentedPager;

/**
 Asks the data source for a view to insert in a particular page of the segmented-pager.
 
 @param segmentedPager A segmented-pager object requesting the view.
 @param index          An index number identifying a page in segmented-pager.
 
 @return An object inheriting from UIView that the segmented-pager can use for the specified page.
 */
- (__kindof UIView *)segmentedPager:(RF_MXSegmentedPager *)segmentedPager viewForPageAtIndex:(NSInteger)index;

@optional

/**
 Asks the data source for a title to assign to a particular page of the segmented-pager. The title will be used depending on the RF_HMSegmentedControlType you have choosen.
 
 @param segmentedPager A segmented-pager object requesting the title.
 @param index          An index number identifying a page in segmented-pager.
 
 @return The NSString title of the page in segmented-pager.
 */
- (NSString *)segmentedPager:(RF_MXSegmentedPager *)segmentedPager titleForSectionAtIndex:(NSInteger)index;

/**
 Asks the data source for a title to assign to a particular page of the segmented-pager. The title will be used depending on the RF_HMSegmentedControlType you have choosen.
 
 @param segmentedPager A segmented-pager object requesting the title.
 @param index          An index number identifying a page in segmented-pager.
 
 @return The NSAttributedString title of the page in segmented-pager.
 */
- (NSAttributedString *)segmentedPager:(RF_MXSegmentedPager *)segmentedPager attributedTitleForSectionAtIndex:(NSInteger)index;

/**
 Asks the data source for a image to assign to a particular page of the segmented-pager. The image will be used depending on the RF_HMSegmentedControlType you have choosen.
 
 @param segmentedPager A segmented-pager object requesting the title.
 @param index          An index number identifying a page in segmented-pager.
 
 @return The image of the page in segmented-pager.
 */
- (UIImage *)segmentedPager:(RF_MXSegmentedPager *)segmentedPager imageForSectionAtIndex:(NSInteger)index;

/**
 Asks the data source for a selected image to assign to a particular page of the segmented-pager. The image will be used depending on the RF_HMSegmentedControlType you have choosen.
 
 @param segmentedPager A segmented-pager object requesting the title.
 @param index          An index number identifying a page in segmented-pager.
 
 @return The selected image of the page in segmented-pager.
 */
- (UIImage *)segmentedPager:(RF_MXSegmentedPager *)segmentedPager selectedImageForSectionAtIndex:(NSInteger)index;

@end

/**
 You use the RF_MXSegmentedPager class to create and manage segmented pages. A segmented pager displays a horizontal segmented control on top of pages, each segment corresponds to a page in the RF_MXSegmentedPager view.The currently viewed page is indicated by the segmented control.
 */
@interface RF_MXSegmentedPager : UIView

/**
 Delegate instance that adopt the RF_MXSegmentedPagerDelegate.
 */
@property (nonatomic, weak) IBOutlet id<RF_MXSegmentedPagerDelegate> delegate;

/**
 Data source instance that adopt the RF_MXSegmentedPagerDataSource.
 */
@property (nonatomic, weak) IBOutlet id<RF_MXSegmentedPagerDataSource> dataSource;

/**
 The segmented control. cf. [RF_HMSegmentedControl](http://cocoadocs.org/docsets/RF_HMSegmentedControl/1.5/) for customazation.
 */
@property (nonatomic, readonly) RF_HMSegmentedControl *segmentedControl;

/**
 The segmented control position option.
 */
@property (nonatomic) MXSegmentedControlPosition segmentedControlPosition;

/**
 The pager. The pager will be placed above or below the segmented control depending on the segmentedControlPosition property.
 */
@property (nonatomic, readonly) RF_MXPagerView *pager;

/**
 The padding from the top, left, right, and bottom of the segmentedControl
 */
@property (nonatomic) UIEdgeInsets segmentedControlEdgeInsets;

/**
 Reloads everything from scratch. redisplays pages.
 */
- (void)reloadData;

/**
 Scrolls the main contentView back to the top position
 */
- (void)scrollToTopAnimated:(BOOL)animated;

@end

/**
 RF_MXSegmentedPager with parallax header. This category uses [RF_MXParallaxHeader](http://cocoadocs.org/docsets/RF_MXParallaxHeader) to set up a parallax header on top of a segmented-pager.
 */
@interface RF_MXSegmentedPager (ParallaxHeader)

/**
 The parallax header. cf. [RF_MXParallaxHeader](http://cocoadocs.org/docsets/RF_MXParallaxHeader) for more details.
 */
@property (nonatomic, strong, readonly) RF_MXParallaxHeader *parallaxHeader;

/**
 Allows bounces. Default YES.
 */
@property (nonatomic) BOOL bounces;

@end

/**
 While using RF_MXSegmentedPager with Parallax header, your pages can adopt the MXPageDelegate protocol to control subview's scrolling effect.
 */
@protocol MXPageProtocol <NSObject>

@optional
/**
 Asks the page if the segmented-pager should scroll with the view.
 
 @param segmentedPager The segmented-pager. This is the object sending the message.
 @param view           An instance of a sub view.
 
 @return YES to allow segmented-pager and view to scroll together. The default implementation returns YES.
 */
- (BOOL)segmentedPager:(RF_MXSegmentedPager *)segmentedPager shouldScrollWithView:(__kindof UIView *)view;

@end

NS_ASSUME_NONNULL_END
