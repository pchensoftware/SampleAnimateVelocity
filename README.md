# SampleAnimateVelocity

**A sample project that shows how to smoothly animate a view after the user stops panning it**

A common way to animate, say, a nav menu opening and closing is to hardcode a duration of, say, 0.2:

``` objective-c
[UIView animateWithDuration:0.2 animations:^{
   myView.frame = newFrameForMyView;
}];
```

But what if we let the user pan the view to open or close it? If we keep the 0.2 animation duration, then the menu will animate at a velocity
that's different than the velocity that the user ended the pan.

This project shows the smoother way to animate the view after a user pans it.

## Contact

Peter Chen

- http://pchensoftware.com
- http://github.com/pchensoftware
- http://twitter.com/pchensoftware
- http://hidoodle.com
