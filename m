Return-Path: <SRS0=Ypbo=VX=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A66C7618F
	for <rcu@archiver.kernel.org>; Fri, 26 Jul 2019 19:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 912D9218B8
	for <rcu@archiver.kernel.org>; Fri, 26 Jul 2019 19:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564168458;
	bh=8tx3VR6xw7M1yDfaSH2omfirFiKE4vdQ8lzmqCQQnYs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=cdspxsEbyi7JOgXgqoDhjyWMDdrccvMKVTw379y6FyAfAo8Ue86qjHdb3sSfuaibw
	 0VogfqI+VNDDZX6Sc2N6iG0YuOPipDEU810y4MZRvTtE3jj+EJiu4xYw6eVn3uMmEx
	 4iRvV5KCVI97UA0lIYsRxfYv3sNVqjlPJ8P0MlZY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388500AbfGZTOS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 26 Jul 2019 15:14:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:32870 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387455AbfGZTOR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 26 Jul 2019 15:14:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QuuSI3h/iPfOAeS1HjFpnmguE8vR2KmQzjmz1VKVCYo=; b=Q/PtJ4Z14HC9VB0ZJArji+OjB
        dApqUmr8NdU3/bY4IbLgoL8xgPkda+uk7rM1Fcer1jPfh3IzZkeC0Sw9AP/UzrCqWd4HPZuBuF9OG
        NKrXqLDf2LFjrG+9TDhMF7P6o5y27XQ7NERzPTuoiLKcc/Ey8pyP5nCYaRiYn93DyBeKHvoEhdVha
        y0C7oVyEfw9aonpSco7S0H14jznXqzXWwMOloB4nC2Cqi7sVoFNELuhn7J5DwFQxTYKIoRFffmG1I
        uyUKgtsi4Dl+JXAX1v7vcrzIrbkIAfKixSOW/46tOWkhTd9aFC0CaSTl0HBDuxRt5PJYH3G5zWpBN
        JKmcH91DQ==;
Received: from [179.95.31.157] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hr5fO-0007wR-7W; Fri, 26 Jul 2019 19:14:10 +0000
Date:   Fri, 26 Jul 2019 16:14:05 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
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
Message-ID: <20190726161405.278e7cfc@coco.lan>
In-Reply-To: <20190726180201.GE146401@google.com>
References: <cover.1564145354.git.mchehab+samsung@kernel.org>
        <8444797277eea7be474f40625bb190775a9cee33.1564145354.git.mchehab+samsung@kernel.org>
        <20190726180201.GE146401@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Em Fri, 26 Jul 2019 14:02:01 -0400
Joel Fernandes <joel@joelfernandes.org> escreveu:

> On Fri, Jul 26, 2019 at 09:51:35AM -0300, Mauro Carvalho Chehab wrote:
> [snip]
> > +| until the assignment to ``gp``, by which time both fields are fully   |
> > +| initialized. So reordering the assignments to ``p->a`` and ``p->b``   |
> > +| cannot possibly cause any problems.                                   |
> > ++-----------------------------------------------------------------------+
> > +
> > +It is tempting to assume that the reader need not do anything special to
> > +control its accesses to the RCU-protected data, as shown in
> > +``do_something_gp_buggy()`` below:
> > +
> > +   ::
> > +
> > +       1 bool do_something_gp_buggy(void)
> > +       2 {
> > +       3   rcu_read_lock();
> > +       4   p = gp;  /* OPTIMIZATIONS GALORE!!! */
> > +       5   if (p) {
> > +       6     do_something(p->a, p->b);
> > +       7     rcu_read_unlock();
> > +       8     return true;
> > +       9   }
> > +      10   rcu_read_unlock();
> > +      11   return false;
> > +      12 }
> > +
> > +However, this temptation must be resisted because there are a
> > +surprisingly large number of ways that the compiler (to say nothing of
> > +`DEC Alpha CPUs <https://h71000.www7.hp.com/wizard/wiz_2637.html>`__)
> > +can trip this code up. For but one example, if the compiler were short
> > +of registers, it might choose to refetch from ``gp`` rather than keeping
> > +a separate copy in ``p`` as follows:
> > +
> > +   ::
> > +
> > +       1 bool do_something_gp_buggy_optimized(void)
> > +       2 {
> > +       3   rcu_read_lock();
> > +       4   if (gp) { /* OPTIMIZATIONS GALORE!!! */
> > +       5     do_something(gp->a, gp->b);
> > +       6     rcu_read_unlock();
> > +       7     return true;
> > +       8   }
> > +       9   rcu_read_unlock();
> > +      10   return false;
> > +      11 }
> > +
> > +If this function ran concurrently with a series of updates that replaced
> > +the current structure with a new one, the fetches of ``gp->a`` and
> > +``gp->b`` might well come from two different structures, which could
> > +cause serious confusion. To prevent this (and much else besides),
> > +``do_something_gp()`` uses ``rcu_dereference()`` to fetch from ``gp``:
> > +
> > +   ::
> > +
> > +       1 bool do_something_gp(void)
> > +       2 {
> > +       3   rcu_read_lock();
> > +       4   p = rcu_dereference(gp);
> > +       5   if (p) {
> > +       6     do_something(p->a, p->b);
> > +       7     rcu_read_unlock();
> > +       8     return true;
> > +       9   }
> > +      10   rcu_read_unlock();
> > +      11   return false;
> > +      12 }
> > +
> > +The ``rcu_dereference()`` uses volatile casts and (for DEC Alpha) memory
> > +barriers in the Linux kernel. Should a `high-quality implementation of
> > +C11 ``memory_order_consume``
> > +[PDF] <http://www.rdrop.com/users/paulmck/RCU/consume.2015.07.13a.pdf>`__
> > +ever appear, then ``rcu_dereference()`` could be implemented as a
> > +``memory_order_consume`` load. Regardless of the exact implementation, a
> > +pointer fetched by ``rcu_dereference()`` may not be used outside of the
> > +outermost RCU read-side critical section containing that
> > +``rcu_dereference()``, unless protection of the corresponding data
> > +element has been passed from RCU to some other synchronization
> > +mechanism, most commonly locking or `reference
> > +counting <https://www.kernel.org/doc/Documentation/RCU/rcuref.txt>`__.  
> 
> From the make htmldocs output, this appears very poorly for me, I get
> something like this in the browser:
> 
> The rcu_dereference() uses volatile casts and (for DEC Alpha) memory barriers
> in the Linux kernel. Should a high-quality implementation of C11
> ``memory_order_consume` [PDF]
> <http://www.rdrop.com/users/paulmck/RCU/consume.2015.07.13a.pdf>`__ ever
> appear, then rcu_dereference() could be implemented as a memory_order_consume
> load.
> 
> Is there a syntax issue here?

Maybe. I tested those with Sphinx 2.0.1. Didn't test with older versions.

I'll do some tests with Sphinx 1.7.9 (with is the current minimal
recommended version) and do some cleanup on those references.

> One more feedback,
> the image under "RCU read-side critical section that started before the current
> grace period:" should probably be blown up a bit.

Unfortunately, the Kernel Sphinx image extension doesn't allow image scaling.

We had to add our own image extension at the Kernel, as otherwise,
for every image, we would need to add one parser for PDF and another
one for SVG. 

We would also need an extra parser for DOT.

Markus solved all the 3 image formats with a single extension, but
it currently doesn't allow passing the image size.

-

Markus,

Any reason for the kernel-image extension to not support scaling?

-

If this can't be easily solved at the kernel-image.py extension, a
simple alternative would be to simply scale the SVG file
directly. It should be trivial to re-scale with inkscape, although
the diff may be big.




Thanks,
Mauro
