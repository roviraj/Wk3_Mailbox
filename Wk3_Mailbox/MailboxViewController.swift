//
//  MailboxViewController.swift
//  Wk3_Mailbox
//
//  Created by Jaime Rovira on 11/2/14.
//  Copyright (c) 2014 Jaime Rovira. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {
    
    @IBOutlet weak var mailScrollView: UIScrollView!
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var messageImage: UIImageView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var archiveIconImageView: UIImageView!
    @IBOutlet weak var laterIconImageView: UIImageView!
    @IBOutlet weak var dividerView: UIView!
    @IBOutlet weak var rescheduleView: UIImageView!
    @IBOutlet weak var listView: UIImageView!
    
    
    var originalLocation: CGPoint!
    var originalMessageOrigin: CGPoint!
    var originalLaterOrigin: CGPoint!
    var originalArchiveOrigin: CGPoint!
    
    let grayColor  = UIColor.lightGrayColor()
    let yellowColor = UIColor(red: 244/255, green: 198/255, blue: 56/255, alpha: 1)
    let brownColor = UIColor(red: 199/255, green: 151/255, blue: 103/255, alpha: 1)
    let greenColor = UIColor(red: 123/255, green: 199/255, blue: 81/255, alpha: 1)
    let redColor   = UIColor(red: 210/255, green: 79/255, blue: 52/255, alpha: 1)
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        mailScrollView.contentSize = CGSize(width: 320, height: 1375)
        laterIconImageView.alpha = 0
        archiveIconImageView.alpha = 0
        rescheduleView.alpha = 0
        listView.alpha = 0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hideMessage()
    {
        UIView.animateWithDuration(0.2, animations:
            { () -> Void in
                self.feedImageView.frame.origin.y -= 86
            }, completion:
            { (BOOL) -> Void in
                self.dividerView.alpha = 0
                self.messageImage.frame.origin.x = 0
                self.laterIconImageView.frame.origin.x = 279
                self.laterIconImageView.image = UIImage(named: "later_icon")
                self.laterIconImageView.alpha = 0
                self.archiveIconImageView.frame.origin.x = 16
                self.archiveIconImageView.image = UIImage(named: "archive_icon")
                self.archiveIconImageView.alpha = 0
                self.messageView.backgroundColor = self.grayColor
        })
    }
    
    @IBAction func onMessagePan(sender: UIPanGestureRecognizer) {
        
        var location = sender.locationInView(view)
        var velocity = sender.velocityInView(view)
        var translation = sender.translationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            
            originalLocation = location
            originalMessageOrigin = messageImage.frame.origin
            originalLaterOrigin = laterIconImageView.frame.origin
            originalArchiveOrigin = archiveIconImageView.frame.origin
            
            messageView.backgroundColor = grayColor
            laterIconImageView.image = UIImage(named: "later_icon")
            archiveIconImageView.image = UIImage(named: "archive_icon")
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            
            var newOriginX = originalMessageOrigin.x + location.x - originalLocation.x
            messageImage.frame.origin.x = newOriginX
            
            if newOriginX < 0
            {
                if -60 < newOriginX
                {
                    self.laterIconImageView.alpha = translation.x/(60 * -1)
                    self.messageView.backgroundColor = self.grayColor
                }
                else if (-260 <= newOriginX) && (newOriginX < -60)
                {
                    self.laterIconImageView.alpha = 1
                    self.laterIconImageView.frame.origin.x = self.originalLaterOrigin.x + location.x - self.originalLocation.x + 60
                    UIView.animateWithDuration(0.15, animations:
                        { () -> Void in
                            self.messageView.backgroundColor = self.yellowColor
                            self.laterIconImageView.image = UIImage(named: "later_icon")
                    })
                }
                else if newOriginX < -260
                    
                {
                    self.laterIconImageView.alpha = 1
                    self.laterIconImageView.frame.origin.x = self.originalLaterOrigin.x + location.x - self.originalLocation.x + 60
                    UIView.animateWithDuration(0.15, animations:
                        { () -> Void in
                            self.messageView.backgroundColor = self.brownColor
                            self.laterIconImageView.image = UIImage(named: "list_icon")
                    })
                }
            }
            else if 0 < newOriginX
            {
                if newOriginX < 60
                {
                    self.archiveIconImageView.frame.origin.x = 16
                    self.archiveIconImageView.alpha = translation.x/60
                    self.messageView.backgroundColor = self.grayColor
                }
                else if (60 < newOriginX) && (newOriginX <= 260)
                {
                    self.archiveIconImageView.alpha = 1
                    self.archiveIconImageView.frame.origin.x = self.originalArchiveOrigin.x + location.x - self.originalLocation.x - 60
                    UIView.animateWithDuration(0.15, animations:
                        { () -> Void in
                            self.messageView.backgroundColor = self.greenColor
                            self.archiveIconImageView.image = UIImage(named: "archive_icon")
                    })
                }
                else if 260 < newOriginX
                {
                    self.archiveIconImageView.alpha = 1
                    self.archiveIconImageView.frame.origin.x = self.originalArchiveOrigin.x + location.x - self.originalLocation.x - 60
                    UIView.animateWithDuration(0.15, animations:
                        { () -> Void in
                            self.messageView.backgroundColor = self.redColor
                            self.archiveIconImageView.image = UIImage(named: "delete_icon")
                    })
                }
            }
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            if translation.x < 0
            {
                if -60 < translation.x
                {
                    UIView.animateWithDuration(0.2, animations:
                        { () -> Void in
                            self.messageImage.frame.origin.x = self.originalMessageOrigin.x
                            self.laterIconImageView.frame.origin.x = self.originalLaterOrigin.x
                            self.laterIconImageView.alpha = 0.5
                            self.messageView.backgroundColor = self.grayColor
                    })
                }
                else if (-260 <= translation.x) && (translation.x < -60)
                {
                    UIView.animateWithDuration(0.2, animations:
                        { () -> Void in
                            self.messageImage.frame.origin.x = -320
                            self.laterIconImageView.alpha = 0
                            self.messageView.backgroundColor = self.yellowColor
                        }, completion:
                        { (BOOL) -> Void in

                            UIView.animateWithDuration(0.2, animations:
                                { () -> Void in
                                    self.rescheduleView.alpha = 1
                            })
                    })
                }
                else
                {
                    UIView.animateWithDuration(0.2, animations:
                        { () -> Void in
                            self.messageImage.frame.origin.x = -320
                            self.laterIconImageView.alpha = 0
                            self.messageView.backgroundColor = self.brownColor
                        }, completion:
                        { (BOOL) -> Void in
                            //Show the options screen
                            UIView.animateWithDuration(0.2, animations:
                                { () -> Void in
                                    self.listView.alpha = 1
                            })
                    })
                }

            }
            else if 0 < translation.x
            {
                if translation.x < 60
                {
                    UIView.animateWithDuration(0.2, animations:
                        { () -> Void in
                            self.messageImage.frame.origin.x = self.originalMessageOrigin.x
                            self.archiveIconImageView.frame.origin.x = self.originalArchiveOrigin.x
                            self.archiveIconImageView.alpha = 0.5
                            self.messageView.backgroundColor = self.grayColor
                    })
                }
                else if (60 < translation.x) && (translation.x <= 260)
                {
                    UIView.animateWithDuration(0.2, animations:
                        { () -> Void in
                            self.messageImage.frame.origin.x = 320
                            self.archiveIconImageView.alpha = 0
                            self.messageView.backgroundColor = self.greenColor
                        }, completion:
                        { (BOOL) -> Void in

                            self.hideMessage()
                    })
                }
                else
                {
                    UIView.animateWithDuration(0.2, animations:
                        { () -> Void in
                            self.messageImage.frame.origin.x = 320
                            self.archiveIconImageView.alpha = 0
                            self.messageView.backgroundColor = self.redColor
                        }, completion:
                        { (BOOL) -> Void in

                            self.hideMessage()
                    })
                }
            }
        }
    }
    
    @IBAction func onTapReschedule(sender: UITapGestureRecognizer) {
        
        UIView.animateWithDuration(0.2, animations:
            { () -> Void in
                self.rescheduleView.alpha = 0
                self.listView.alpha = 0
            }, completion:
            { (BOOL) -> Void in
                self.hideMessage()
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
