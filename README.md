# Motivation

I recently had to submit my academic transcripts along with a job application.  
The company requires that PII (Personally Identifiable Information) to be redacted since they cannot guarantee that such info will be properly guarded.

## Prior Arts

I looked into several options however they were not ideal for my needs:

-   Some were overlaying a box onto the PDF, which can be potentially be undone by many means (extracting and viewing PDF source)
-   Cost / Non-free
-   Proprietary: not sure what goes on under the hood
-   SaaS: requires uploading your PII contained PDF onto the cloud service in order to redact (helllll... no)

There is a good option in [Dangerzone](https://dangerzone.rocks/about.html). It is an open source project created by Micah Lee, a software developer @ the Intercept [Micah Lee](https://theintercept.com/staff/micah-lee/).
It is a GUI tool and can convert many file types (not jsut PDF) to a safe and redacted PDF and worth checking out. Even if you don't plan on using it, it still is worth reading the above Dangerzone page.

# Script

However, for my needs Dangerzone was not necessary and I hate firing up Docker just to run an app, so I wrote this quick and dirty shell script to use open source softwares to do similar things.

It uses the following app, which you may or may not already have installed:

-   [ImageMagick](https://imagemagick.org/index.php)
-   [QPDF](https://qpdf.readthedocs.io/en/stable/)
-   [Gimp](https://www.gimp.org/)

## How it works

Essentially, it

-   decrypt the PDF (if encrypted with an owner password)
-   splits it into pages
-   converts each split into a 300 dpi by 300 dpi PNG image
-   opens up Gimp for each image and waits for you to redact / draw black boxes on your sensitive information
-   after you're done, just save the split image file (overwriting it)
-   then it converts the redacted split file back into PDF
-   and merges them into a whole PDF file with name: `[original_name_here]_redacted.pdf`
-   That's it!
