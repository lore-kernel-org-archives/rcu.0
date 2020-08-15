Return-Path: <SRS0=YobW=BZ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE01C433E1
	for <rcu@archiver.kernel.org>; Sat, 15 Aug 2020 22:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35B7B2063A
	for <rcu@archiver.kernel.org>; Sat, 15 Aug 2020 22:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597529454;
	bh=ADnDcxQp2V8HOw/PuJLE5kvRQJ9cpSo0bvw+VQMcP6Y=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=tWzm0j+h/uqYPzAlMjZYdp2HjguEzt66l+Ho/zhd/WLDy7m873xncCvLskvKNjDCh
	 el1Zjfg59vdhKjkqw3mHYXerNE/RlZoZ6o5vZfACS0ORNk4jf+hnK34idtoVh2UuQv
	 hOCOW8lWjS8yqqPUdTL/rplqy3ASgZWS7PMkBrDA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbgHOWKx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:10:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:41798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729617AbgHOWKh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 15 Aug 2020 18:10:37 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC3E520729;
        Sat, 15 Aug 2020 14:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597501406;
        bh=ADnDcxQp2V8HOw/PuJLE5kvRQJ9cpSo0bvw+VQMcP6Y=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bjsTDAf6Fj18zDffLso3bADg2dt4QoLnH7wH3gCWaTfuSBwkcIu13zPUv+Mjj/xGO
         +uEPtedw9Btk8lR0TnIvXHphtmK+xjkekv582H+gxEGzLfjT7UkpadFVoyeBbPRnji
         uf1JvTGripiLbmcipsYfcsYGUWdmXLDSgcVzDeZg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id CDE6035230C2; Sat, 15 Aug 2020 07:23:25 -0700 (PDT)
Date:   Sat, 15 Aug 2020 07:23:25 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michal Hocko <mhocko@suse.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200815142325.GA32640@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200814180141.GP4295@paulmck-ThinkPad-P72>
 <87tux4kefm.fsf@nanos.tec.linutronix.de>
 <20200815084250.GN3982@worktop.programming.kicks-ass.net>
 <20200815141839.GA4295@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200815141839.GA4295@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Aug 15, 2020 at 07:18:39AM -0700, Paul E. McKenney wrote:
> On Sat, Aug 15, 2020 at 10:42:50AM +0200, Peter Zijlstra wrote:
> > On Sat, Aug 15, 2020 at 01:14:53AM +0200, Thomas Gleixner wrote:
> > 
> > > #1 trivial fix is to force switching to an high prio thread or a soft
> > >    interrupt which does the allocation
> > 
> > Yeah, push the alocation out to another context. I did consider it, but
> > why bother?
> > 
> > Also, raising a softirq can't be done from every context, that's a whole
> > new problem. You can do irq_work I suppose, but not all architectures
> > support the self-IPI yet.
> > 
> > All in all, it's just more complexity than the fairly trivial
> > __alloc_page_lockless().
> > 
> > Whichever way around, we can't rely on the allocation.
> 
> One way to enforce that would be to put something like this at the
> beginning of the __alloc_page_lockless() function:
> 
> 	if (IS_ENABLED(CONFIG_PROVE_LOCKING) && (prandom_u32() & 0xffff))
> 		return NULL;

Right, too early in the morning.  :-/

This "slight" variation might include a bit of usefulness along with
the convincing:

	if (IS_ENABLED(CONFIG_PROVE_LOCKING) && !(prandom_u32() & 0xff))
		return NULL;

Plus failing one out of 256 times is likely a better choice than once
out of 65536 times, especially for the occasional caller of this
function.

							Thanx, Paul

> I am sure that there is a better choice than CONFIG_PROVE_LOCKING.
> But whatever the choice, there is nothing quite like the occasional
> allocation failure during testing to convince people that such failure
> really can happen.
> 
> 							Thanx, Paul
