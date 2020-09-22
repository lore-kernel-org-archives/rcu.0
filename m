Return-Path: <SRS0=9ZY9=C7=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F896C2D0E2
	for <rcu@archiver.kernel.org>; Tue, 22 Sep 2020 03:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 373B523A6C
	for <rcu@archiver.kernel.org>; Tue, 22 Sep 2020 03:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600745757;
	bh=Zg1voEFK6z5Rkm7iaxnBwo567WXU9h8mw+sC++e4x68=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=WrCtfceUQPEAhoJgzdj0BAz1LD9kaGOcoq6+3KFqFmU6Rm0z3gMvdmyqPm5VfIApr
	 nntT1Zp1QNv1DuYapinWTI0hKCy06flyEMD0KlZ7JEBPERZ7Q4TDQHIviSUkmG+Yxp
	 UpRbGrwfAVZ7uKhrZsI97eqFVA1nZRb5FgM5Ii0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgIVDfy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 21 Sep 2020 23:35:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:43616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728634AbgIVDfy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 21 Sep 2020 23:35:54 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBC5A23A32;
        Tue, 22 Sep 2020 03:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600745754;
        bh=Zg1voEFK6z5Rkm7iaxnBwo567WXU9h8mw+sC++e4x68=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=xLzkxeIta7HsB3m7JlSEs6z5XXhdnouoGY7Dz2Us48cNimR5KW5TnxbmCVc1m9pCE
         OdxIirw8AAnRGZyDoOfR6I4K+hQFLRpukm5FmqQbEz1qyDOP1HO/EJpqORMQMrOtrx
         vZLsgtqPiNsHjdZPJScyqzSSwmCANVB6rHnY26Pg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id BD4D735226C1; Mon, 21 Sep 2020 20:35:53 -0700 (PDT)
Date:   Mon, 21 Sep 2020 20:35:53 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
Message-ID: <20200922033553.GU29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200918194817.48921-1-urezki@gmail.com>
 <20200918194817.48921-3-urezki@gmail.com>
 <20200921074716.GC12990@dhcp22.suse.cz>
 <20200921154558.GD29330@paulmck-ThinkPad-P72>
 <20200921160318.GO12990@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921160318.GO12990@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Sep 21, 2020 at 06:03:18PM +0200, Michal Hocko wrote:
> On Mon 21-09-20 08:45:58, Paul E. McKenney wrote:
> > On Mon, Sep 21, 2020 at 09:47:16AM +0200, Michal Hocko wrote:
> > > On Fri 18-09-20 21:48:15, Uladzislau Rezki (Sony) wrote:
> > > [...]
> > > > Proposal
> > > > ========
> > > > Introduce a lock-free function that obtain a page from the per-cpu-lists
> > > > on current CPU. It returns NULL rather than acquiring any non-raw spinlock.
> > > 
> > > I was not happy about this solution when we have discussed this
> > > last time and I have to say I am still not happy. This is exposing
> > > an internal allocator optimization and allows a hard to estimate
> > > consumption of pcp free pages. IIUC this run on pcp cache can be
> > > controled directly from userspace (close(open) loop IIRC) which makes it
> > > even bigger no-no.
> > 
> > Yes, I do well remember that you are unhappy with this approach.
> > Unfortunately, thus far, there is no solution that makes all developers
> > happy.  You might be glad to hear that we are also looking into other
> > solutions, each of which makes some other developers unhappy.  So we
> > are at least not picking on you alone.  :-/
> 
> No worries I do not feel like a whipping boy here. But do expect me to
> argue against the approach. I would also appreciate it if there was some
> more information on other attempts, why they have failed. E.g. why
> pre-allocation is not an option that works well enough in most
> reasonable workloads. I would also appreciate some more thoughts why we
> need to optimize for heavy abusers of RCU (like close(open) extremes).

Not optimizing for them, but rather defending against them.  Uladzislau
gave the example of low-memory phones.  And we have quite the array
of defenses against other userspace bugs including MMUs, the "limit"
command, and so on.

There have been quite a few successful attempts, starting from the
introduction of blimit and RCU-bh more than 15 years ago, continuing
through making call_rcu() jump-start grace periods, IPIing reluctant
CPUs, tuning RCU callback offloading, and many others.  But these prior
approaches have only taken us so far.

Other approaches under consideration include making CONFIG_PREEMPT_COUNT
unconditional and thus allowing call_rcu() and kvfree_rcu() to determine
whether direct calls to the allocator are safe (some guy named Linus
doesn't like this one), preallocation (Uladzislau covered this, and
the amount that would need to be preallocated is excessive), deferring
allocation to RCU_SOFTIRQ (this would also need CONFIG_PREEMPT_COUNT),
and deferring to some clean context (which is the best we can do within
the confines of RCU, but which can have issues with delay).

So it is not the need to address this general problem that is new.
Far from it!  What is new is the need for changes outside of RCU.

> > > I strongly agree with Thomas http://lkml.kernel.org/r/87tux4kefm.fsf@nanos.tec.linutronix.de
> > > that this optimization is not aiming at reasonable workloads. Really, go
> > > with pre-allocated buffer and fallback to whatever slow path you have
> > > already. Exposing more internals of the allocator is not going to do any
> > > good for long term maintainability.
> > 
> > I suggest that you carefully re-read the thread following that email.
> 
> I clearly remember Thomas not being particularly happy that you optimize
> for a corner case. I do not remember there being a consensus that this
> is the right approach. There was some consensus that this is better than
> a gfp flag. Still quite bad though if you ask me.

Again, this "optimization" is for robustness more than raw speed.

> > Given a choice between making users unhappy and making developers
> > unhappy, I will side with the users each and every time.
> 
> Well, let me rephrase. It is not only about me (as a developer) being
> unhappy but also all the side effects this would have for users when
> performance of their favorite workload declines for no apparent reason
> just because pcp caches are depleted by an unrelated process.

But in the close(open()) case, wouldn't the allocations on the open()
side refill those caches?  Yes, cases where one CPU is doing the
allocating and another the call_rcu()/kvfree_rcu() need additional
help, but as Uladzislau noted, we do have patches that ensure that the
refilling happens.

							Thanx, Paul
