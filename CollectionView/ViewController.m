/*
     File: ViewController.m
 Abstract: The primary view controller for this app.
 
  Version: 1.0
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2012 Apple Inc. All Rights Reserved.
 
 */

#import "ViewController.h"
#import "DetailViewController.h"

//@interface CustomFlowLayout : UICollectionViewFlowLayout
//
//@end
//
//@implementation CustomFlowLayout
//
//-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
//{
//    
//    NSArray* array = [super layoutAttributesForElementsInRect:rect];
//    CGRect visibleRect;
//    visibleRect.origin = self.collectionView.contentOffset;
//    visibleRect.size = self.collectionView.bounds.size;
//    
//    for(UICollectionViewLayoutAttributes* attributes in array) {
//        
//        if(CGRectIntersectsRect(attributes.frame, rect)){
//            
//            CGFloat d = UIInterfaceOrientationIsPortrait(_orientation)?
//            CGRectGetMidY(visibleRect)-attributes.center.y :
//            CGRectGetMidX(visibleRect)-attributes.center.x;
//            
//            CGFloat w = visibleRect.size.width;
//            CGFloat h = visibleRect.size.height;
//            
//            CGFloat dRatio = UIInterfaceOrientationIsPortrait(_orientation)? d/(h/2) : d/(w/2);
//            
//            CGFloat angle = MAX_ANGLE*dRatio; // an angle between 0 and MAX_ANGLE based on proximity to center
//            CGFloat radians = DEGREES_TO_RADIANS(angle);
//            
//            debug = 0;
//            
//            CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
//            rotationAndPerspectiveTransform.m34 = PERSPECTIVE;
//            
//            rotationAndPerspectiveTransform = UIInterfaceOrientationIsPortrait(_orientation)?
//            CATransform3DRotate(rotationAndPerspectiveTransform, radians, 1.0f, 0.0f, 0.0f) :
//            CATransform3DRotate(rotationAndPerspectiveTransform, radians, 0.0f, 1.0f, 0.0f);
//            
//            attributes.transform3D = rotationAndPerspectiveTransform;
//        }
//    }
//    
//    return array;
//    
//}
//
//@end


#import "Cell.h"
#import "HeaderCell.h"
#import "FooterCell.h"

NSString *kDetailedViewControllerID     = @"DetailView";
NSString *kCellID                       = @"cellID";
NSString *kHeaderCellID                 = @"HeaderCellID";
NSString *kFooterCellID                 = @"FooterCellID";

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
#if TEST_MENU
    //добавление кастомного элемента в строку
    UIMenuItem *menuItem = [[UIMenuItem alloc] initWithTitle:@"Show Alert (Custom action)"
                                                      action:@selector(customAction:)];
    [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObject:menuItem]];
#endif
    
#if TEST_UICollectionViewTransitionLayout
    double delayInSeconds = 5.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        UICollectionViewFlowLayout *layout      = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection                  = UICollectionViewScrollDirectionHorizontal;
        [self.collectionView startInteractiveTransitionToCollectionViewLayout:layout
                                                                   completion:nil];
    });
#endif
}



#if TEST_MENU

//Для обработки меню работает ТОЛЬКО в IOS 6. Но универсальнее сделать обработку селектора в самом subclass UICollectionViewCell
//#pragma mark -
//#pragma mark - UIMenuController необходимые методы (только IOS 6)!
//
//- (BOOL)canBecomeFirstResponder
//{
//    NSLog(@"%s", __func__);
//    return YES;
//}
//
//- (BOOL)canPerformAction:(SEL)action
//              withSender:(id)sender
//{
//    NSLog(@"%s action - %@; sender - %@", __func__, NSStringFromSelector(@selector(action)), sender);
//    // The selector(s) should match your UIMenuItem selector
//    if (action == @selector(customAction:))
//    {
//        return YES;
//    }
//    return NO;
//}
//
//- (void)customAction:(id)sender
//{
//    NSLog(@"%s sender - %@", __func__, sender);
//    [[[UIAlertView alloc] initWithTitle:@"Warning"
//                               message:@"test action from menu controller"
//                              delegate:nil
//                     cancelButtonTitle:@"Ok"
//                     otherButtonTitles:nil] show];
//}

#endif

#pragma mark - 
#pragma mark - <UICollectionViewDatasource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    NSLog(@"%s collectionView - %@", __func__, collectionView);
    return 5;
}

- (NSInteger)collectionView:(UICollectionView *)view
     numberOfItemsInSection:(NSInteger)section;
{
    NSLog(@"%s collectionView - %@; section - %d", __func__, view, section);
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    NSLog(@"%s collectionView - %@; indexPath - %@", __func__, cv, indexPath);
    // we're going to use a custom UICollectionViewCell, which will hold an image and its label
    //
    Cell *cell = [cv dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
    
    // make the cell's title the actual NSIndexPath value
    cell.label.text = [NSString stringWithFormat:@"{%ld,%ld}", (long)indexPath.row, (long)indexPath.section];
    
    // load the image for this cell
    NSString *imageToLoad = [NSString stringWithFormat:@"%d.JPG", indexPath.section * [self numberOfSectionsInCollectionView:cv] + indexPath.row];
    cell.image.image = [UIImage imageNamed:imageToLoad];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s collectionView - %@; kind - %@; indexPath - %@", __func__, collectionView, kind, indexPath);
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        HeaderCell *cell    = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                 withReuseIdentifier:kHeaderCellID
                                                                        forIndexPath:indexPath];
        
        return cell;
        
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter])
    {
        FooterCell *cell    = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                 withReuseIdentifier:kFooterCellID
                                                                        forIndexPath:indexPath];
        
        return cell;
    }
    
    return nil;
}

#pragma mark -
#pragma mark - <UICollectionViewDelegate>

/*                                                                                          МЕТОДЫ ОБРАБОТКИ КАСАНИЙ*/
// Methods for notification of selection/deselection and highlight/unhighlight events.
// The sequence of calls leading to selection from a user touch is:
//
// (when the touch begins)
// 1. -collectionView:shouldHighlightItemAtIndexPath:
// 2. -collectionView:didHighlightItemAtIndexPath:
//
// (when the touch lifts)
// 3. -collectionView:shouldSelectItemAtIndexPath: or -collectionView:shouldDeselectItemAtIndexPath:
// 4. -collectionView:didSelectItemAtIndexPath: or -collectionView:didDeselectItemAtIndexPath:
// 5. -collectionView:didUnhighlightItemAtIndexPath:
- (BOOL)collectionView:(UICollectionView *)collectionView
shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s collectionView - %@; indexPath - %@", __func__, collectionView, indexPath);
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView
didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s collectionView - %@; indexPath - %@", __func__, collectionView, indexPath);
}

- (BOOL)collectionView:(UICollectionView *)collectionView
shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s collectionView - %@; indexPath - %@", __func__, collectionView, indexPath);
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s collectionView - %@; indexPath - %@", __func__, collectionView, indexPath);
}

- (BOOL)collectionView:(UICollectionView *)collectionView
shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath // called when the user taps on an already-selected item in multi-select mode
{
    NSLog(@"%s collectionView - %@; indexPath - %@", __func__, collectionView, indexPath);
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView
didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s collectionView - %@; indexPath - %@", __func__, collectionView, indexPath);
}

- (void)collectionView:(UICollectionView *)collectionView
didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s collectionView - %@; indexPath - %@", __func__, collectionView, indexPath);
}

/*                                                                                          МЕТОДЫ ПОЛУЕНИЯ ОБНОВЛЕНИЯ СОСТОНИЯ ДЛЯ ЯЧЕЕК*/
- (void)collectionView:(UICollectionView *)collectionView
  didEndDisplayingCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s collectionView - %@; cell - %@; indexPath - %@", __func__, collectionView, cell, indexPath);
}

- (void)collectionView:(UICollectionView *)collectionView
didEndDisplayingSupplementaryView:(UICollectionReusableView *)view
      forElementOfKind:(NSString *)elementKind
           atIndexPath:(NSIndexPath *)indexPath
{
       NSLog(@"%s collectionView - %@; view - %@; elementKind - %@, indexPath - %@", __func__, collectionView, view, elementKind, indexPath);
}

#if TEST_MENU

/*                                                                                          МЕТОДЫ ОБРАБОТКИ ВСПЛЫВАЮЩЕГО МЕНЮ*/
// These methods provide support for copy/paste actions on cells.
// All three should be implemented if any are.
- (BOOL)collectionView:(UICollectionView *)collectionView
shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s collectionView - %@; indexPath - %@", __func__, collectionView, indexPath);
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView
      canPerformAction:(SEL)action
    forItemAtIndexPath:(NSIndexPath *)indexPath
            withSender:(id)sender
{
    //Исключаем из меню пункты cut, copy, paste
    if ([NSStringFromSelector(action) isEqualToString:NSStringFromSelector(@selector(paste:))] ||
        [NSStringFromSelector(action) isEqualToString:NSStringFromSelector(@selector(copy:))])
    {
        return NO;
    }
    NSLog(@"%s collectionView - %@; action - %@; indexPath - %@, sender - %@", __func__, collectionView, NSStringFromSelector(action), indexPath, sender);
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView
         performAction:(SEL)action
    forItemAtIndexPath:(NSIndexPath *)indexPath
            withSender:(id)sender
{
    //вызывается для стандартных опций. Для своих нужно селетор добалять в subclass UICollectionViewCell
    NSLog(@"%s collectionView - %@; action - %@; indexPath - %@, sender - %@", __func__, collectionView, NSStringFromSelector(action), indexPath, sender);
}

#endif

#if TEST_UICollectionViewTransitionLayout

/*                                                                                          КАСТОМНАЯ ТРАНЗАКЦИЯ (ONLY IOS 7+)*/
// support for custom transition layout
- (UICollectionViewTransitionLayout *)collectionView:(UICollectionView *)collectionView
                        transitionLayoutForOldLayout:(UICollectionViewLayout *)fromLayout
                                           newLayout:(UICollectionViewLayout *)toLayout
{
    return [[UICollectionViewTransitionLayout alloc] initWithCurrentLayout:fromLayout
                                                                nextLayout:toLayout];
}

#endif

#pragma mark -
#pragma mark - <UICollectionViewDelegateFlowLayout>

//- (CGSize)collectionView:(UICollectionView *)collectionView
//                  layout:(UICollectionViewLayout*)collectionViewLayout
//  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionViewFlowLayout *flowLayout  = (UICollectionViewFlowLayout *)collectionViewLayout;
//    return CGSizeMake(flowLayout.itemSize.width + arc4random() % 50, flowLayout.itemSize.width + arc4random() % 50);
//}

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
//                        layout:(UICollectionViewLayout*)collectionViewLayout
//        insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(0, 20, 0, 20);
//}

//- (CGFloat)collectionView:(UICollectionView *)collectionView
//                   layout:(UICollectionViewLayout*)collectionViewLayout
//minimumLineSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 20;
//}

//- (CGFloat)collectionView:(UICollectionView *)collectionView
//                   layout:(UICollectionViewLayout*)collectionViewLayout
//minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 20;
//}

//- (CGSize)collectionView:(UICollectionView *)collectionView
//                  layout:(UICollectionViewLayout*)collectionViewLayout
//referenceSizeForHeaderInSection:(NSInteger)section
//{
//    return CGSizeMake(0, 200);
//}

//- (CGSize)collectionView:(UICollectionView *)collectionView
//                  layout:(UICollectionViewLayout*)collectionViewLayout
//referenceSizeForFooterInSection:(NSInteger)section
//{
//    return CGSizeMake(0, 200);
//}

#pragma mark -
#pragma mark - segue

// the user tapped a collection item, load and set the image on the detail view controller
//
- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"])
    {
        NSIndexPath *selectedIndexPath      = [[self.collectionView indexPathsForSelectedItems] objectAtIndex:0];
        
        // load the image, to prevent it from being cached we use 'initWithContentsOfFile'
        NSString *imageNameToLoad           = [NSString stringWithFormat:@"%d_full", selectedIndexPath.section * [self numberOfSectionsInCollectionView:self.collectionView] + selectedIndexPath.row];
        NSString *pathToImage               = [[NSBundle mainBundle] pathForResource:imageNameToLoad ofType:@"JPG"];
        UIImage *image                      = [[UIImage alloc] initWithContentsOfFile:pathToImage];
        
        DetailViewController *detailViewController = [segue destinationViewController];
        detailViewController.image          = image;
    }
}

@end
