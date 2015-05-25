//
//  MailboxViewController.swift
//  mailbox
//
//  Created by Francisco Guzman on 5/21/15.
//  Copyright (c) 2015 Francisco Guzman. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {
    
    @IBOutlet weak var messageView: UIImageView!
    @IBOutlet weak var mailScrollView: UIScrollView!
    @IBOutlet weak var archiveIconView: UIImageView!
    @IBOutlet weak var deleteIconView: UIImageView!
    @IBOutlet weak var laterIconView: UIImageView!
    @IBOutlet weak var listIconView: UIImageView!
    @IBOutlet weak var rescheduleView: UIImageView!
    @IBOutlet weak var listView: UIImageView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var composeView: UIImageView!
    @IBOutlet weak var keyboardView: UIImageView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var navSegmentedControl: UISegmentedControl!
    @IBOutlet weak var hamburgerView: UIImageView!
    @IBOutlet weak var emailBody: UIImageView!
    
    
    var messageOriginalCenter: CGPoint!
    var messageBack: CGPoint!
    var messageOffScreen: CGPoint!
    var translationStore: CGFloat!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var feedView: UIImageView!
    
    let blueColor = UIColor(red: 68/255, green: 170/225, blue: 210/255, alpha: 1)
    let yellowColor = UIColor(red: 254/255, green: 202/255, blue: 22/255, alpha: 1)
    let brownColor = UIColor(red: 206/255, green: 150/255, blue: 98/255, alpha: 1)
    let greenColor = UIColor(red: 85/225, green: 213/255, blue: 80/255, alpha: 1)
    let redColor = UIColor(red: 231/255, green: 61/255, blue: 14/255, alpha: 1)
    let grayColor = UIColor(red: 178/255, green: 178/255, blue: 178/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundView.backgroundColor=grayColor
        
        mailScrollView.contentSize = CGSize(width: 320, height: 1432)
        
        messageBack = messageView.center
        
        messageOffScreen = CGPoint(x: messageBack.x+320, y: messageBack.y)
        
        var edgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "onEdgePan:")
        edgeGesture.edges = UIRectEdge.Left
        contentView.addGestureRecognizer(edgeGesture)
        
        //navSegmentedControl.
        
    }
    
    
    @IBAction func onChangeControl(sender: UISegmentedControl) {
        
        if navSegmentedControl.selectedSegmentIndex == 0 {
            
            //println("segment 0")
            
            navSegmentedControl.tintColor = yellowColor
            hamburgerView.tintColor = yellowColor
            
//            UIView.animateWithDuration(0.3, animations: { () -> Void in
//                self.contentView.frame.origin.x = 320
//                self.emailBody.frame.origin.x = 0
//            })
            
            
            
        } else if navSegmentedControl.selectedSegmentIndex == 1 {

            //println("segment 1")
            
            navSegmentedControl.tintColor = blueColor
            
        } else if navSegmentedControl.selectedSegmentIndex == 2 {
            
            //println("segment 2")
            
            navSegmentedControl.tintColor = greenColor
            
        }
    }
    
    @IBAction func onComposePress(sender: AnyObject) {
    
        overlayView.hidden=false
        composeView.hidden=false
        keyboardView.hidden=false
        overlayView.alpha = 0.7
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.keyboardView.frame.origin.y = 384
            self.composeView.frame.origin.y = 20
            self.cancelButton.frame.origin.y = 25
        })
        
    }
    
    @IBAction func onMenuPress(sender: AnyObject) {
        
        if contentView.frame.origin.x == 0 {
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.contentView.frame.origin.x = 285
            })
            
        } else {
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.contentView.frame.origin.x = 0
            })
        }
    }
    
    
    func onEdgePan (sender: UIScreenEdgePanGestureRecognizer) {
        
        var point = sender.locationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            contentView.frame.origin.x = point.x
            println(point)
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            if point.x < 100 {
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    self.contentView.frame.origin.x = 0
                })
                
            } else {
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    self.contentView.frame.origin.x = 285
                })
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func onCancelPress(sender: AnyObject) {
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.keyboardView.frame.origin.y = 568
            self.composeView.frame.origin.y = 568
            self.cancelButton.frame.origin.y = 568
        })
        
        delay(0.3, { () -> () in
            self.overlayView.hidden=true
        })
    }
    
    @IBAction func onListPress(sender: UITapGestureRecognizer) {
        listView.hidden=true
        animateFeedUp()
    }
    
    @IBAction func onReschedulePress(sender: UITapGestureRecognizer) {
        rescheduleView.hidden=true
        animateFeedUp()
    }
    
    
    func animateFeedUp () {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.feedView.frame.origin.y = 80
        })
    }
    
    @IBAction func onMessageSwipe(sender: UIPanGestureRecognizer) {
        
        var point = sender.locationInView(view)
        var translation = sender.translationInView(view)
        var velocity = sender.velocityInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            
            messageOriginalCenter = messageView.center
            archiveIconView.alpha=0.0
            deleteIconView.alpha=0.0
            laterIconView.alpha=0.0
            listIconView.alpha=0.0
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            
            translationStore=translation.x
            
            messageView.center = CGPoint(x: messageOriginalCenter.x + translation.x, y: messageOriginalCenter.y)
            
            archiveIconView.frame.origin.x = messageView.frame.origin.x - 40
            deleteIconView.frame.origin.x = messageView.frame.origin.x - 40
            laterIconView.frame.origin.x = messageView.frame.origin.x + 340
            listIconView.frame.origin.x = messageView.frame.origin.x + 340
            
            if translation.x > 60 && translation.x < 260 {
                
                archiveIconView.alpha = 1.0
                deleteIconView.alpha=0.0
                laterIconView.alpha=0.0
                listIconView.alpha=0.0
                
                backgroundView.backgroundColor = greenColor
                
            } else if translation.x >= 260 {
                
                archiveIconView.alpha = 0.0
                deleteIconView.alpha=1.0
                laterIconView.alpha=0.0
                listIconView.alpha=0.0
                
                backgroundView.backgroundColor = redColor
                
                
            } else if translation.x < -60 && translation.x >= -259  {
                
                archiveIconView.alpha = 0.0
                deleteIconView.alpha=0.0
                laterIconView.alpha = 1.0
                listIconView.alpha=0.0
                
                backgroundView.backgroundColor=yellowColor
                
            }
                
            else if translation.x < -260 {
                
                archiveIconView.alpha = 0.0
                deleteIconView.alpha=0.0
                laterIconView.alpha=0.0
                listIconView.alpha=1.0
                
                backgroundView.backgroundColor=brownColor
                
            }
            
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            
            if translationStore > 60 {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.messageView.frame.origin.x = 320
                    self.archiveIconView.frame.origin.x = 320
                    self.deleteIconView.frame.origin.x = 320
                })
                
                delay(0.3, { () -> () in
                    self.animateFeedUp ()
                })
            } else if translationStore < -60 {
                
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.messageView.frame.origin.x = -320
                    self.laterIconView.frame.origin.x = -320
                    self.listIconView.frame.origin.x = -320
                })
                
                if translationStore < -60 && translationStore >= -259 {
                    
                    delay(0.3, { () -> () in
                        self.rescheduleView.hidden = false
                    })
                    
                }
                
                if translationStore < -260 {
                    
                    delay(0.3, { () -> () in
                        self.listView.hidden = false
                    })
                    
                }
                
            } else {
                
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.messageView.center = self.messageBack
                })
                
            }
            
            //println("Gesture ended at: \(point)")
        }
        
        
        
    }
}
