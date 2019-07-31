Return-Path: <SRS0=275B=V4=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0286C433FF
	for <rcu@archiver.kernel.org>; Wed, 31 Jul 2019 01:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B375E206A2
	for <rcu@archiver.kernel.org>; Wed, 31 Jul 2019 01:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564536814;
	bh=QXtfjt8oxBZOcwlUnbW8dhNB3QODTLXCBYgHmM3Xec4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=uEhTQsbk0UuQ7tAYfAegpzEWRokiCawQjJdTA+t8BlYb0iYOJ4ICoFvxbgn/CL6OE
	 7Zs43IlCW3kFo6LYD7gu3SipuJqw9gOVzg/EyYG39q8DgyvI7u+oagLjZznF8Kzem3
	 uKe1fEavGDsY/Vdvy1sVMnbQ5CWjsOQ7tgapakmM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfGaBde (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 30 Jul 2019 21:33:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39822 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfGaBde (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 30 Jul 2019 21:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CtWv+Kt5oLMIEauP6yj+pwM5nJ2GVTC+1w/6yeuf8Bg=; b=qTMAlS0wVeKvtm0hdT5TMZ1Pw
        DjCeBPgThY7z1IwyUhKUxQwH+MyCFftGkCbyud8mpzubuYfw0bwqsPWltkShl2Ycz+5qWChEYp0P8
        Sx73wsoDvw60mG8mkHBAEpxuuQ5l3HLNwk06pULOiqHnA6o9bcl3gZq/a1j1KCwGE5oEDSaDlql7u
        xbf252uaQuRQKboq39grUCq6Ob0BB82WjngfjZ36rleF6hOFjFhpv2Z7UCMN/+yUDNBnY9XR4wl97
        H1J6N7R6l0f4Y33Hln/eVk8HnlJcwYlqFPKei4hsLpcTg6EtebrSP0ekRv7D/PnRY3n+67dkVXweS
        gOttiTnqw==;
Received: from [177.157.101.143] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsdUc-0002QA-OL; Wed, 31 Jul 2019 01:33:27 +0000
Date:   Tue, 30 Jul 2019 22:33:21 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 25/26] docs: rcu: convert some articles from html to
 ReST
Message-ID: <20190730223321.73f909f2@coco.lan>
In-Reply-To: <20190731010623.GN14271@linux.ibm.com>
References: <cover.1564145354.git.mchehab+samsung@kernel.org>
        <8444797277eea7be474f40625bb190775a9cee33.1564145354.git.mchehab+samsung@kernel.org>
        <20190730212250.GJ14271@linux.ibm.com>
        <20190730185040.3fbc44ca@coco.lan>
        <20190730233720.GL14271@linux.ibm.com>
        <20190731000455.GA11465@linux.ibm.com>
        <20190730214722.53432fe3@coco.lan>
        <20190731010623.GN14271@linux.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Em Tue, 30 Jul 2019 18:06:24 -0700
"Paul E. McKenney" <paulmck@linux.ibm.com> escreveu:

> On Tue, Jul 30, 2019 at 09:47:22PM -0300, Mauro Carvalho Chehab wrote:
> > Em Tue, 30 Jul 2019 17:04:55 -0700
> > "Paul E. McKenney" <paulmck@linux.ibm.com> escreveu:

> > > This appears to come from Documentation/output/latex/RCU.tex.
> > > There is nevertheless an RCU.pdf in this directory.  It is not
> > > bad, but has a figure full of XML on PDF page 21.  And a few later
> > > on as well.  
> > 
> > PDF output is indeed an issue. The way it works is that it first
> > generates a LaTeX and then it uses texlive to produce the PDF. 
> 
> Would it be fair to say that html output is what is currently supported,
> and that PDF output is a future thing?

Sure.

Anyway, if you want to fix PDF later, I suspect that simply adding:

	.. cssclass:: longtable

Before each quiz table should be enough to fix, as the tables there seem
to be simple enough. 

After fixed, the PDF and LaTeX output are usually decent.

> > > On the HTML side, the quick quizzes have immediately visible answers,
> > > which defeats the purpose.  The original HTML used a white font,
> > > so that you selected the answer with your mouse to make it visible.
> > >
> > > Can something similar be done with Sphinx?  Another approach is to
> > > gather the answers into a separate file and link to them.  
> > 
> > Yeah, I guess you used a css style that would make the answer visible
> > when the mouse is inside it on your original lwn.net set of articles. 
> > 
> > Sphinx has a directive to use css, so, the short answer is: yes, you
> > can. 
> > 
> > For html, you would need to add a css specific for the RCU quiz,
> > placing it under Documentation/sphinx directory. Then, use the
> >  ".. css" directive to handle that.
> > 
> > You should notice, however, that this will be ignored for 
> > LaTeX/pdf output.
> > 
> > I guess you can place this on another file, or perhaps place at the
> > end of the document, having a link for the quiz answers. 
> > 
> > Another alternative would be to make the answer as a footnote.  
> 
> Making it CSS for HTML and a footnote for PDF seems eminently
> reasonable to me!

You should either do CSS or PDF, as otherwise you will end with dirty
hacks like:

.. only:: html

	<some quiz table with answers using css>

.. only: latex

	<some quiz table with answers using footnotes>

E. g. you'll need to place the quiz twice, making it harder to maintain
and messier.

Btw, the LaTeX may also parse a css tag, processing it via some custom
macro (with should be added at Documentation/conf.py.

> > > I believe that Joel already noted that internal links are not working.
> > > The external links that I tried work just fine, though.  As do the
> > > links from the table of contents.  
> > 
> > Yeah. Funny enough, when I tested here, they worked fine. Maybe
> > this is due to the Sphinx version I used here at the time I wrote
> > it.
> > 
> > Anyway, Joel already submitted a patch addressing this one.   
> 
> And it works for me, anyway!  ;-)

Great!

Thanks,
Mauro
