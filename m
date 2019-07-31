Return-Path: <SRS0=275B=V4=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDED8C433FF
	for <rcu@archiver.kernel.org>; Wed, 31 Jul 2019 00:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC72720665
	for <rcu@archiver.kernel.org>; Wed, 31 Jul 2019 00:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564534056;
	bh=DKItp8XhXj2N5Tn7Oe9101NaA9ADbrsAgl2/yRgaCz4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=KXW2gwd/AlJRdYXcBJOwaJPrHMp3MFqrdBhAnePQsqjoCb1RpMyB6IatpTxRnhxJ3
	 cbur/TLUD5U3aA2q72RbOo+VwJf5H8dT4V+/vrQrZwlu3a7Wv2gpQzjg/Oao9BW14A
	 Nc98Gyrat/AoAt4DJJHs2wGFrVy5lfHqqHGQGq+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfGaArg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 30 Jul 2019 20:47:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34384 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfGaArg (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 30 Jul 2019 20:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ai7I+Bk/el+PU/ACET80BRO0sTvqq0ASgsWfTGc6/so=; b=cDA6Higjfr02ilvAZhGNtaq2/
        i5/Y502Te5ZMS7FSWag1e7Axjs2N7PwlPaqUNWEu7nUjRmmR7q2j0oZZMD5kOzQJEPdnFvskG7AFZ
        VtsHm6fVcXcnSTgVx7FqPhH+e8c5KEa4nZVA7QNk0OmfmyKW3QE68X7mHQUTI7BCuLZZA3x6F3MAE
        IUoIbPY+yGNvMpov8KTnG+dcgUIEDA10/SniyTMZ1Rg4gTMq+2UpZJgANLWwpN+/UfsjWfcB9ACKS
        ztrtKJ91wNmP7+gJ8ZFwoPsWtD/o/D9vmpxQMeOuJZJB4x1CQ466lx0IjoyVB0ghiAMTKOsRXFDnm
        FclctoABw==;
Received: from [177.157.101.143] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hscm8-00060Q-8p; Wed, 31 Jul 2019 00:47:28 +0000
Date:   Tue, 30 Jul 2019 21:47:22 -0300
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
Message-ID: <20190730214722.53432fe3@coco.lan>
In-Reply-To: <20190731000455.GA11465@linux.ibm.com>
References: <cover.1564145354.git.mchehab+samsung@kernel.org>
        <8444797277eea7be474f40625bb190775a9cee33.1564145354.git.mchehab+samsung@kernel.org>
        <20190730212250.GJ14271@linux.ibm.com>
        <20190730185040.3fbc44ca@coco.lan>
        <20190730233720.GL14271@linux.ibm.com>
        <20190731000455.GA11465@linux.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Em Tue, 30 Jul 2019 17:04:55 -0700
"Paul E. McKenney" <paulmck@linux.ibm.com> escreveu:

> On Tue, Jul 30, 2019 at 04:37:20PM -0700, Paul E. McKenney wrote:
> > On Tue, Jul 30, 2019 at 06:50:51PM -0300, Mauro Carvalho Chehab wrote:  
> > > Em Tue, 30 Jul 2019 14:22:50 -0700
> > > "Paul E. McKenney" <paulmck@linux.ibm.com> escreveu:
> > >   
> > > > On Fri, Jul 26, 2019 at 09:51:35AM -0300, Mauro Carvalho Chehab wrote:  
> > > > > There are 4 RCU articles that are written on html format.
> > > > > 
> > > > > The way they are, they can't be part of the Linux Kernel
> > > > > documentation body nor share the styles and pdf output.
> > > > > 
> > > > > So, convert them to ReST format.
> > > > > 
> > > > > This way, make htmldocs and make pdfdocs will produce a
> > > > > documentation output that will be like the original ones, but
> > > > > will be part of the Linux Kernel documentation body.
> > > > > 
> > > > > Part of the conversion was done with the help of pandoc, but
> > > > > the result had some broken things that had to be manually
> > > > > fixed.
> > > > > 
> > > > > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>    
> > > > 
> > > > I am having some trouble applying these, at least in part due to UTF-8
> > > > sequences, for example double left quotation mark.  These end up being
> > > > "=E2=80=9C", with a few space characters turned into "=20".
> > > > 
> > > > Any advice on how to apply these?  
> > > 
> > > Didn't notice it ended with UTF-8 chars. It is probably because it came
> > > from the html conversion.  
> > 
> > Or maybe there are some email issues somewhere along the way.
> >   
> > > I guess it shouldn't hurt keeping those, but if you prefer I can find 
> > > some time later to replace them.
> > >   
> > > > Should I just pull commits from somewhere?  
> > > 
> > > Yeah, if you prefer, you can pull from this branch:
> > > 
> > > 	https://git.linuxtv.org/mchehab/experimental.git/log/?h=rcu-v1
> > > 
> > > It has just two patches: the RCU and tools/memory-model ones.
> > > 
> > > It is based on v5.3-rc2.  
> > 
> > And that does apply, thank you!  
> 
> And "make htmldocs" does produce real HTML!  At first glance anyway,
> quite impressive.

Yeah, its output is pretty decent.

> However, "make pdfdocs" gives me this complaint:
> 
> 	! Dimension too large.
> 	\color@b@x ... #3}\kern \fboxsep }\dimen@ \ht \z@ 
> 							  \advance \dimen@ \fboxsep ...
> 	l.5092 \end{sphinxVerbatim}
> 
> This appears to come from Documentation/output/latex/RCU.tex.
> There is nevertheless an RCU.pdf in this directory.  It is not
> bad, but has a figure full of XML on PDF page 21.  And a few later
> on as well.

PDF output is indeed an issue. The way it works is that it first
generates a LaTeX and then it uses texlive to produce the PDF. 

There is a rst2pdf tool with handles it directly, but it is a way more
 problematic. I have an experimental patch with enables it. Maybe
some day it could be applied, but upstream for the tool needs a lot 
more work.

With regards to the LaTeX/PDF output, on media, we had to tweak the
documents in order for them to produce a good LaTeX/PDF output on tables.

Usually, before some tables, we add something like this:

.. tabularcolumns:: |p{1.2cm}|p{2.9cm}|p{13.4cm}|

in order to teach LaTeX the size of each column.

If the table is really big, the only way for it to fit is to reduce
the font size, using a raw LaTeX syntax. See, for example:

	Documentation/media/uapi/v4l/dev-subdev.rst

There, we use things like:

.. raw:: latex

    \scriptsize

.. tabularcolumns:: |p{2.0cm}|p{2.3cm}|p{2.3cm}|p{2.3cm}|p{2.3cm}|p{2.3cm}|p{2.3cm}|


	+-----------------+ ...
	| Some long table | ...
	+-----------------+ ...
	...
	+-----------------+ ...


.. raw:: latex

    \normalsize

In order to use a small font for the table.

Neither "raw:: latex" nor "tabularcolumns" tag affect html.

There is another trick too. By default, Sphinx LaTeX output uses a
type of table that should fit into a single page ("tabular").

If the table has more than 30 columns, it switches to another type
("longtable"), with can be split into multiple pages.

As the quiz tables usually have only 4 columns, it will always try
the unbreakable tabular table. If it doesn't fit, PDF will break.

In order to avoid that, just add:

.. cssclass:: longtable

Before the offended table. This will make Sphinx to use LaTeX
longtable instead of tabular ones.

This won't affect html output.

> On the HTML side, the quick quizzes have immediately visible answers,
> which defeats the purpose.  The original HTML used a white font,
> so that you selected the answer with your mouse to make it visible.
>
> Can something similar be done with Sphinx?  Another approach is to
> gather the answers into a separate file and link to them.

Yeah, I guess you used a css style that would make the answer visible
when the mouse is inside it on your original lwn.net set of articles. 

Sphinx has a directive to use css, so, the short answer is: yes, you
can. 

For html, you would need to add a css specific for the RCU quiz,
placing it under Documentation/sphinx directory. Then, use the
 ".. css" directive to handle that.

You should notice, however, that this will be ignored for 
LaTeX/pdf output.

I guess you can place this on another file, or perhaps place at the
end of the document, having a link for the quiz answers. 

Another alternative would be to make the answer as a footnote.

> I believe that Joel already noted that internal links are not working.
> The external links that I tried work just fine, though.  As do the
> links from the table of contents.

Yeah. Funny enough, when I tested here, they worked fine. Maybe
this is due to the Sphinx version I used here at the time I wrote
it.

Anyway, Joel already submitted a patch addressing this one. 


Thanks,
Mauro
