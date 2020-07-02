Return-Path: <SRS0=c9Wv=AN=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4909BC433E0
	for <rcu@archiver.kernel.org>; Thu,  2 Jul 2020 16:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26C6920870
	for <rcu@archiver.kernel.org>; Thu,  2 Jul 2020 16:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593708508;
	bh=gWp3jFwoo4iUwOhF7lEopC3ZlQExz1kCNh2JXCd9Fcg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=vZnV+AofNjtJs7y9EKaRfshCztgxjLIIF6daHyq5cIWnUecpCPCSRCkRshGOj2npT
	 ZmFm4U8Q8x/huAnldbV0umxIXioAvJo3hT1n0s84fFsO4J6fMK1VNjlYHtwabF+HfO
	 In5XiwegU4UqHSKX1wGwelbgL/U7L0Rt3ol6rGFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgGBQs1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 2 Jul 2020 12:48:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:55590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbgGBQs1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 2 Jul 2020 12:48:27 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2E362084C;
        Thu,  2 Jul 2020 16:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593708506;
        bh=gWp3jFwoo4iUwOhF7lEopC3ZlQExz1kCNh2JXCd9Fcg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=2b+9C9Nyes63VcSQV+cryOA7jsr1vqfWy4nwf81la+HGYN7YnBVUyFaf6P20GtKk1
         qfbrvZKpCWKVPpdhe7T1sk4GaZ7M3aWrCUo//dt4fStvpVZzJQjJj9eUTdC4E4cdgV
         77Xa30CfU8RtOF8TOrvOgs16YElPGsco2vw9q4vM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 909F435232F8; Thu,  2 Jul 2020 09:48:26 -0700 (PDT)
Date:   Thu, 2 Jul 2020 09:48:26 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH tip/core/rcu 03/17] rcu/tree: Skip entry into the page
 allocator for PREEMPT_RT
Message-ID: <20200702164826.GQ9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200624201200.GA28901@paulmck-ThinkPad-P72>
 <20200624201226.21197-3-paulmck@kernel.org>
 <20200630164543.4mdcf6zb4zfclhln@linutronix.de>
 <20200630183534.GG9247@paulmck-ThinkPad-P72>
 <20200702141216.r4rbt5w3hjzafpgg@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702141216.r4rbt5w3hjzafpgg@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 02, 2020 at 04:12:16PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-06-30 11:35:34 [-0700], Paul E. McKenney wrote:
> > > This is not going to work together with the "wait context validator"
> > > (CONFIG_PROVE_RAW_LOCK_NESTING). As of -rc3 it should complain about
> > > printk() which is why it is still disabled by default.
> > 
> > Fixing that should be "interesting".  In particular, RCU CPU stall
> > warnings rely on the raw spin lock to reduce false positives due
> > to race conditions.  Some thought will be required here.
> 
> I don't get this part. Can you explain/give me an example where to look
> at?

Starting from the scheduler-clock interrupt's call into RCU,
we have rcu_sched_clock_irq() which calls rcu_pending() which
calls check_cpu_stall() which calls either print_cpu_stall() or
print_other_cpu_stall(), depending on whether the stall is happening on
the current CPU or on some other CPU, respectively.

Both of these last functions acquire the rcu_node structure's raw ->lock
and expect to do printk()s while holding it.

Not that the lock matters all that much given that all of this code is
in hardirq context.  Which is necessary if RCU CPU stall warnings are
to be at all reliable.  Yeah, yeah, they would be even more reliable if
invoked in NMI context but that would prevent them from acquiring the
->lock that is used to resolve races between multiple concurrent stall
warnings and between a stall warning and the end of that stall.  ;-)

I could imagine accumulating the data in hardirq context and then
using a workqueue or some such to print it all out, but that
requires that workqueues be fully operational for RCU CPU stall
warnings to appear.  :-(

Thoughts?

> > > So assume that this is fixed and enabled then on !PREEMPT_RT it will
> > > complain that you have a raw_spinlock_t acquired (the one from patch
> > > 02/17) and attempt to acquire a spinlock_t in the memory allocator.
> > 
> > Given that the slab allocator doesn't acquire any locks until it gets
> > a fair way in, wouldn't it make sense to allow a "shallow" allocation
> > while a raw spinlock is held?  This would require yet another GFP_ flag,
> > but that won't make all that much of a difference in the total.  ;-)
> 
> That would be one way of dealing with. But we could go back to
> spinlock_t and keep the memory allocation even for RT as is. I don't see
> a downside of this. And we would worry about kfree_rcu() from real
> IRQ-off region once we get to it.

Once we get to it, your thought would be to do per-CPU queuing of
memory from IRQ-off kfree_rcu(), and have IRQ work or some such clean
up after it?  Or did you have some other trick in mind?

							Thanx, Paul

> > > >  			bnode = (struct kfree_rcu_bulk_data *)
> > > >  				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> > > >  		}
> 
> Sebastian
