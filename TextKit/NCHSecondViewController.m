//
//  NCHSecondViewController.m
//  TextKit
//
//  Created by andrew lattis on 13/10/29.
//  Copyright (c) 2013 Andrew Lattis. All rights reserved.
//

#import "NCHSecondViewController.h"

@interface NCHSecondViewController ()

///outlet to the body label
@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;

///outlet to the caption1 label
@property (weak, nonatomic) IBOutlet UILabel *caption1Label;

///outlet to the caption2 label
@property (weak, nonatomic) IBOutlet UILabel *caption2Label;

///outlet to the footnote label
@property (weak, nonatomic) IBOutlet UILabel *footnoteLabel;

///outlet to the headline label
@property (weak, nonatomic) IBOutlet UILabel *headlineLabel;

///outlet to the subhead label
@property (weak, nonatomic) IBOutlet UILabel *subheadLabel;

///outlet to the menlo label
@property (weak, nonatomic) IBOutlet UILabel *menloLabel;

///outlet to the scale slider header label
@property (weak, nonatomic) IBOutlet UILabel *scaleLabel;


///property to track the content size notification observer
@property (nonatomic, strong) id contentSizeObserver;


/**
 * adjust the size of the fonts to their defaults and optionally apply a scale factor
 * @param size 0.0 to use the default size, or a point size to override the default
 */
- (void)adjustFontsWithSize:(float) size;


/**
 * action method called when the slider scale is adjusted
 * the scale has a range of 0 to 30, with a default of 0
 * @param sender the scale that sent the action
 * @return nil
 */
- (IBAction)scaleValueChanged:(UISlider *)sender;

@end





@implementation NCHSecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	//make sure we start with the defaults
	[self adjustFontsWithSize:0.0];
	
	//add a listener for the notification center event
	__weak typeof(self)weakSelf = self;

	self.contentSizeObserver = [[NSNotificationCenter defaultCenter] addObserverForName:UIContentSizeCategoryDidChangeNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
		[weakSelf adjustFontsWithSize:0.0];
	}];
	
}


- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self.contentSizeObserver];
}


- (void)adjustFontsWithSize:(float) size {
	
	UIFontDescriptor *bodyDescriptor = [UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleBody];
	self.bodyLabel.font = [UIFont fontWithDescriptor:bodyDescriptor size:size];
	self.scaleLabel.font = [UIFont fontWithDescriptor:bodyDescriptor size:size];
	
	UIFontDescriptor *caption1Descriptor = [UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleCaption1];
	self.caption1Label.font = [UIFont fontWithDescriptor:caption1Descriptor size:size];

	//if you don't need to be able to modify the font descriptor for the base style you can shortcut things a little
	self.caption2Label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption2];
	
	
	UIFontDescriptor *footnoteDescriptor = [UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleFootnote];
	self.footnoteLabel.font = [UIFont fontWithDescriptor:footnoteDescriptor size:size];

	
	UIFontDescriptor *headlineDescriptor = [UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleHeadline];
	self.headlineLabel.font = [UIFont fontWithDescriptor:headlineDescriptor size:size];

	
	UIFontDescriptor *subheadDescriptor = [UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleSubheadline];
	self.subheadLabel.font = [UIFont fontWithDescriptor:subheadDescriptor size:size];

	
	UIFontDescriptor *menloDescriptor = [UIFontDescriptor fontDescriptorWithFontAttributes:@{
																							 UIFontDescriptorFamilyAttribute: @"Menlo",
																							 UIFontDescriptorSizeAttribute: @15.0
																							}];
	self.menloLabel.font = [UIFont fontWithDescriptor:menloDescriptor size:size];

}


- (IBAction)scaleValueChanged:(UISlider *)sender {
	[self adjustFontsWithSize:sender.value];
}


@end
