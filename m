Return-Path: <SRS0=BsRz=AR=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12663C433DF
	for <rcu@archiver.kernel.org>; Mon,  6 Jul 2020 21:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE36B206BE
	for <rcu@archiver.kernel.org>; Mon,  6 Jul 2020 21:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594069606;
	bh=8FQG3v8b4r+oJ69mw3ZRz9kF6YWmcxHtUuE/bUg9230=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=nWgTeq6YcOvICYmK2bDv1qei1eG/uy36ULtXKw0pRMrgr1JbHbAC+jqM3DyIsCWqQ
	 EOXOPlNa1PZX3AFJmmsu6haxqQhoyynnHiGLha+sRdzyFRKLU63AWcsCysKvM3gXtX
	 6OgnKifqOwK8H+nvatbleEmPVEGn5xQqrRiTdblg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgGFVGq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 6 Jul 2020 17:06:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:59432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgGFVGq (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 6 Jul 2020 17:06:46 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B15F206B6;
        Mon,  6 Jul 2020 21:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594069605;
        bh=8FQG3v8b4r+oJ69mw3ZRz9kF6YWmcxHtUuE/bUg9230=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=foRYrq9kQ8dcpUY0oJNtXHqyBIQDhSti8Zu24qyU8tMqrPo7ahmkAkAmccqfPDpI4
         hBrQ+B0jTKbMlBQv+Fz6L+QKxuIukK9J3cWq8K+OzsFQ7QCQcAaiSEaRXs3QE//7KN
         oW6uKVLXAnnJJIXwvcMbiXxgIaQBw23ijiHqbfYE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 549073522637; Mon,  6 Jul 2020 14:06:45 -0700 (PDT)
Date:   Mon, 6 Jul 2020 14:06:45 -0700
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
Message-ID: <20200706210645.GJ9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200624201200.GA28901@paulmck-ThinkPad-P72>
 <20200624201226.21197-3-paulmck@kernel.org>
 <20200630164543.4mdcf6zb4zfclhln@linutronix.de>
 <20200630183534.GG9247@paulmck-ThinkPad-P72>
 <20200702141216.r4rbt5w3hjzafpgg@linutronix.de>
 <20200702164826.GQ9247@paulmck-ThinkPad-P72>
 <20200702201908.jfiacgvion6a4nmj@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200702201908.jfiacgvion6a4nmj@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 02, 2020 at 10:19:08PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-07-02 09:48:26 [-0700], Paul E. McKenney wrote:
> > On Thu, Jul 02, 2020 at 04:12:16PM +0200, Sebastian Andrzej Siewior wrote:
> > > On 2020-06-30 11:35:34 [-0700], Paul E. McKenney wrote:
> > > > > This is not going to work together with the "wait context validator"
> > > > > (CONFIG_PROVE_RAW_LOCK_NESTING). As of -rc3 it should complain about
> > > > > printk() which is why it is still disabled by default.
> > > > 
> > > > Fixing that should be "interesting".  In particular, RCU CPU stall
> > > > warnings rely on the raw spin lock to reduce false positives due
> > > > to race conditions.  Some thought will be required here.
> > > 
> > > I don't get this part. Can you explain/give me an example where to look
> > > at?
> > 
> > Starting from the scheduler-clock interrupt's call into RCU,
> > we have rcu_sched_clock_irq() which calls rcu_pending() which
> > calls check_cpu_stall() which calls either print_cpu_stall() or
> > print_other_cpu_stall(), depending on whether the stall is happening on
> > the current CPU or on some other CPU, respectively.
> > 
> > Both of these last functions acquire the rcu_node structure's raw ->lock
> > and expect to do printk()s while holding it.
> 
> …
> > Thoughts?
> 
> Okay. So in the RT queue there is a printk() rewrite which fixes this
> kind of things. Upstream the printk() interface is still broken in this
> regard and therefore CONFIG_PROVE_RAW_LOCK_NESTING is disabled.
> [Earlier the workqueue would also trigger a warning but this has been
> fixed as of v5.8-rc1.]
> This was just me explaining why this bad, what debug function would
> report it and why it is not enabled by default.

Whew!!!  ;-)

> > > > > So assume that this is fixed and enabled then on !PREEMPT_RT it will
> > > > > complain that you have a raw_spinlock_t acquired (the one from patch
> > > > > 02/17) and attempt to acquire a spinlock_t in the memory allocator.
> > > > 
> > > > Given that the slab allocator doesn't acquire any locks until it gets
> > > > a fair way in, wouldn't it make sense to allow a "shallow" allocation
> > > > while a raw spinlock is held?  This would require yet another GFP_ flag,
> > > > but that won't make all that much of a difference in the total.  ;-)
> > > 
> > > That would be one way of dealing with. But we could go back to
> > > spinlock_t and keep the memory allocation even for RT as is. I don't see
> > > a downside of this. And we would worry about kfree_rcu() from real
> > > IRQ-off region once we get to it.
> > 
> > Once we get to it, your thought would be to do per-CPU queuing of
> > memory from IRQ-off kfree_rcu(), and have IRQ work or some such clean
> > up after it?  Or did you have some other trick in mind?
> 
> So for now I would very much like to revert the raw_spinlock_t back to
> the spinlock_t and add a migrate_disable() just avoid the tiny
> possible migration between obtaining the CPU-ptr and acquiring the lock
> (I think Joel was afraid of performance hit).

Performance is indeed a concern here.

> Should we get to a *real* use case where someone must invoke kfree_rcu()
> from a hard-IRQ-off region then we can think what makes sense. per-CPU
> queues and IRQ-work would be one way of dealing with it.

It looks like workqueues can also be used, at least in their current
form.  And timers.

Vlad, Joel, thoughts?

							Thanx, Paul
