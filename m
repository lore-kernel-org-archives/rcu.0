Return-Path: <SRS0=Tqm2=V3=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EFCC32751
	for <rcu@archiver.kernel.org>; Tue, 30 Jul 2019 22:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DE3B206A2
	for <rcu@archiver.kernel.org>; Tue, 30 Jul 2019 22:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Bo1fdOXM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387733AbfG3WGu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 30 Jul 2019 18:06:50 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33590 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387855AbfG3WGt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 30 Jul 2019 18:06:49 -0400
Received: by mail-pf1-f193.google.com with SMTP id g2so30549367pfq.0
        for <rcu@vger.kernel.org>; Tue, 30 Jul 2019 15:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2c8CaB2ELurnQxpm3AwGKXqUgfnt7ZRXoS6euPgB+6A=;
        b=Bo1fdOXMDxTKO6rah6xhtXKX/n+V/3TcUq5CqUHB6TCvOBJGdFMkoUO/mgeFz5LCJ9
         zHGi01AS+Ts9Z22zIzi2nMXwb93hFzeLkpRA9jxrNqTN6LPr3JlPMKi6JABZeHgpjb+L
         cI8dtkmCSIl4eImB2EJeAWqRm4HR/tOUtaI4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2c8CaB2ELurnQxpm3AwGKXqUgfnt7ZRXoS6euPgB+6A=;
        b=PV50hYMBm5iZmRE3ilIgQxjmsgKY04ZU1cA5z/Ik9vPhmeTn4CmLCNFSqRrusp0SV2
         EdzjxusS2mVO/2dcYiD7BoqIdKybgNmC1aPkYLF6ipXxOfJGWdpYMGjODySKMDJpOZ5h
         GoGgr4B9MQPo07b56Xd9Rk8rMFURkVvck1DBWR6WdswZlg6rXBHmgfg7g6+FBbNNfUbn
         xnR4uZQsfOkJuGjBLIxiWkUs55w70ugakOsrTBmlyFS3e0HoPeRFnmION8c7EM6Zl0BH
         3fq/xXTT8DaHe91eAYbLciE23F6tq99tP9z5VfoghGIEhxUNH/APasZ8p8wkrIj8ApBs
         NdFA==
X-Gm-Message-State: APjAAAXTS2IVqp0GL3bA4f7wJqXvWzOEs437ABCI+vbJhgFVRJJjbm0S
        +Z7hhjfowb95Y+7h9nIaeYo=
X-Google-Smtp-Source: APXvYqyzmKy9MP+sVpcVkLxNhFUnF13lF4Ip5t7Ad9fNkq/IN4kcJ7B8hLvvVXchhAWyjlXe5H7xHA==
X-Received: by 2002:a62:187:: with SMTP id 129mr44391348pfb.128.1564524408671;
        Tue, 30 Jul 2019 15:06:48 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id g18sm110575650pgm.9.2019.07.30.15.06.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 15:06:47 -0700 (PDT)
Date:   Tue, 30 Jul 2019 18:06:46 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Markus Heiser <markus.heiser@darmarit.de>
Subject: Re: [PATCH v2 25/26] docs: rcu: convert some articles from html to
 ReST
Message-ID: <20190730220646.GB254050@google.com>
References: <cover.1564145354.git.mchehab+samsung@kernel.org>
 <8444797277eea7be474f40625bb190775a9cee33.1564145354.git.mchehab+samsung@kernel.org>
 <20190726180201.GE146401@google.com>
 <20190726161405.278e7cfc@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726161405.278e7cfc@coco.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jul 26, 2019 at 04:14:05PM -0300, Mauro Carvalho Chehab wrote:
> Em Fri, 26 Jul 2019 14:02:01 -0400
> Joel Fernandes <joel@joelfernandes.org> escreveu:
> 
> > On Fri, Jul 26, 2019 at 09:51:35AM -0300, Mauro Carvalho Chehab wrote:
> > [snip]
> > > +| until the assignment to ``gp``, by which time both fields are fully   |
> > > +| initialized. So reordering the assignments to ``p->a`` and ``p->b``   |
> > > +| cannot possibly cause any problems.                                   |
> > > ++-----------------------------------------------------------------------+
> > > +
> > > +It is tempting to assume that the reader need not do anything special to
> > > +control its accesses to the RCU-protected data, as shown in
> > > +``do_something_gp_buggy()`` below:
> > > +
> > > +   ::
> > > +
> > > +       1 bool do_something_gp_buggy(void)
> > > +       2 {
> > > +       3   rcu_read_lock();
> > > +       4   p = gp;  /* OPTIMIZATIONS GALORE!!! */
> > > +       5   if (p) {
> > > +       6     do_something(p->a, p->b);
> > > +       7     rcu_read_unlock();
> > > +       8     return true;
> > > +       9   }
> > > +      10   rcu_read_unlock();
> > > +      11   return false;
> > > +      12 }
> > > +
> > > +However, this temptation must be resisted because there are a
> > > +surprisingly large number of ways that the compiler (to say nothing of
> > > +`DEC Alpha CPUs <https://h71000.www7.hp.com/wizard/wiz_2637.html>`__)
> > > +can trip this code up. For but one example, if the compiler were short
> > > +of registers, it might choose to refetch from ``gp`` rather than keeping
> > > +a separate copy in ``p`` as follows:
> > > +
> > > +   ::
> > > +
> > > +       1 bool do_something_gp_buggy_optimized(void)
> > > +       2 {
> > > +       3   rcu_read_lock();
> > > +       4   if (gp) { /* OPTIMIZATIONS GALORE!!! */
> > > +       5     do_something(gp->a, gp->b);
> > > +       6     rcu_read_unlock();
> > > +       7     return true;
> > > +       8   }
> > > +       9   rcu_read_unlock();
> > > +      10   return false;
> > > +      11 }
> > > +
> > > +If this function ran concurrently with a series of updates that replaced
> > > +the current structure with a new one, the fetches of ``gp->a`` and
> > > +``gp->b`` might well come from two different structures, which could
> > > +cause serious confusion. To prevent this (and much else besides),
> > > +``do_something_gp()`` uses ``rcu_dereference()`` to fetch from ``gp``:
> > > +
> > > +   ::
> > > +
> > > +       1 bool do_something_gp(void)
> > > +       2 {
> > > +       3   rcu_read_lock();
> > > +       4   p = rcu_dereference(gp);
> > > +       5   if (p) {
> > > +       6     do_something(p->a, p->b);
> > > +       7     rcu_read_unlock();
> > > +       8     return true;
> > > +       9   }
> > > +      10   rcu_read_unlock();
> > > +      11   return false;
> > > +      12 }
> > > +
> > > +The ``rcu_dereference()`` uses volatile casts and (for DEC Alpha) memory
> > > +barriers in the Linux kernel. Should a `high-quality implementation of
> > > +C11 ``memory_order_consume``
> > > +[PDF] <http://www.rdrop.com/users/paulmck/RCU/consume.2015.07.13a.pdf>`__
> > > +ever appear, then ``rcu_dereference()`` could be implemented as a
> > > +``memory_order_consume`` load. Regardless of the exact implementation, a
> > > +pointer fetched by ``rcu_dereference()`` may not be used outside of the
> > > +outermost RCU read-side critical section containing that
> > > +``rcu_dereference()``, unless protection of the corresponding data
> > > +element has been passed from RCU to some other synchronization
> > > +mechanism, most commonly locking or `reference
> > > +counting <https://www.kernel.org/doc/Documentation/RCU/rcuref.txt>`__.  
> > 
> > From the make htmldocs output, this appears very poorly for me, I get
> > something like this in the browser:
> > 
> > The rcu_dereference() uses volatile casts and (for DEC Alpha) memory barriers
> > in the Linux kernel. Should a high-quality implementation of C11
> > ``memory_order_consume` [PDF]
> > <http://www.rdrop.com/users/paulmck/RCU/consume.2015.07.13a.pdf>`__ ever
> > appear, then rcu_dereference() could be implemented as a memory_order_consume
> > load.
> > 
> > Is there a syntax issue here?
> 
> Maybe. I tested those with Sphinx 2.0.1. Didn't test with older versions.
> 
> I'll do some tests with Sphinx 1.7.9 (with is the current minimal
> recommended version) and do some cleanup on those references.

Ok, one more thing is broken, clicking links such as "Parallelism Facts of
Life" does not jump to the corresponding section.

Would you mind fixing this, add the description of changes you made (which
you shared in an earlier reply), fixing the above Sphinx issue, and then
resend it?

Otherwise, I believe it looks sane.

> > One more feedback,
> > the image under "RCU read-side critical section that started before the current
> > grace period:" should probably be blown up a bit.
> 
> Unfortunately, the Kernel Sphinx image extension doesn't allow image scaling.

The current scale appears fine to me, it is not a big deal since it is clear.

> We had to add our own image extension at the Kernel, as otherwise,
> for every image, we would need to add one parser for PDF and another
> one for SVG. 
> 
> We would also need an extra parser for DOT.
> 
> Markus solved all the 3 image formats with a single extension, but
> it currently doesn't allow passing the image size.

Cool.

