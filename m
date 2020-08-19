Return-Path: <SRS0=uuXb=B5=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAA6C433E3
	for <rcu@archiver.kernel.org>; Wed, 19 Aug 2020 23:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 185E0207DE
	for <rcu@archiver.kernel.org>; Wed, 19 Aug 2020 23:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597878459;
	bh=V20LGmDT5Ym2io0jzlLtfcTqRvub5BXCbJCCdhw306k=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=mG1ClcoM4k22oDyR/iGhy9JH6zD1b1/WaI+VOj0P4R/NEygkw0dN5f0f1gZNHMpWV
	 UKsX5KKm0eyH5rEvjOk+1GgwcmLSDrZ94tQLwR/5DbEapa+hbYoLVqk6NM1HLy/Ncw
	 lnbZYMuOv9d6mToTTjO3ZX7Q7IJp7zTFk/0+psEA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgHSXHi (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 19 Aug 2020 19:07:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:47594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbgHSXHi (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 19 Aug 2020 19:07:38 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1C5920758;
        Wed, 19 Aug 2020 23:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597878456;
        bh=V20LGmDT5Ym2io0jzlLtfcTqRvub5BXCbJCCdhw306k=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TllzW/8MDihvt4DhcI+Wq3hNAL4xl3gRBHZQ1PA6ayPTYAQxsY73BI4VvUf7GH/Ik
         xE4NXwkJvPwlXcjvTD4UatEI5EAtIpsEtgVwLKzvLVRC0S+Eu70qOa5PKeLYJaOiLD
         hQaPlQ8j7QHCpGnpBfIzvixCQSGM3jxzmNNGn+c0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C51753520855; Wed, 19 Aug 2020 16:07:35 -0700 (PDT)
Date:   Wed, 19 Aug 2020 16:07:35 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Michal Hocko <mhocko@suse.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200819230735.GS27891@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200816225655.GA17869@pc636>
 <20200817082849.GA28270@dhcp22.suse.cz>
 <20200817222803.GE23602@paulmck-ThinkPad-P72>
 <20200818074344.GL28270@dhcp22.suse.cz>
 <20200818135327.GF23602@paulmck-ThinkPad-P72>
 <87o8n8hv5p.fsf@nanos.tec.linutronix.de>
 <20200818161355.GE27891@paulmck-ThinkPad-P72>
 <87lfibj3m8.fsf@nanos.tec.linutronix.de>
 <20200818171330.GH27891@paulmck-ThinkPad-P72>
 <87h7szilit.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7szilit.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Aug 19, 2020 at 01:26:02AM +0200, Thomas Gleixner wrote:
> Paul,
> 
> On Tue, Aug 18 2020 at 10:13, Paul E. McKenney wrote:
> > On Tue, Aug 18, 2020 at 06:55:11PM +0200, Thomas Gleixner wrote:
> >> On Tue, Aug 18 2020 at 09:13, Paul E. McKenney wrote:
> >> > On Tue, Aug 18, 2020 at 04:43:14PM +0200, Thomas Gleixner wrote:
> >> >> Throttling the flooder is incresing robustness far more than reducing
> >> >> cache misses.
> >> >
> >> > True, but it takes time to identify a flooding event that needs to be
> >> > throttled (as in milliseconds).  This time cannot be made up.
> >> 
> >> Not really. A flooding event will deplete your preallocated pages very
> >> fast, so you have to go into the allocator and get new ones which
> >> naturally throttles the offender.
> >
> > Should it turn out that we can in fact go into the allocator, completely
> > agreed.
> 
> You better can for any user space controllable flooding source.

For the memory being passed to kvfree_rcu(), but of course.

However, that memory has just as good a chance of going deeply into the
allocator when being freed as when being allocated.  In contrast, the
page of pointers that kvfree_rcu() attempts to allocate can be handed back
via per-CPU variables, avoiding lengthy time on the allocator's free path.

Yes, yes, in theory we could make a devil's pact with potential flooders
so that RCU directly handed memory back to them via a back channel as
well, but in practice that sounds like an excellent source of complexity
and bugs.

> >> So if your open/close thing uses the new single argument free which has
> >> to be called from sleepable context then the allocation either gives you
> >> a page or that thing has to wait. No fancy extras.
> >
> > In the single-argument kvfree_rcu() case, completely agreed.
> >
> >> You still can have a page reserved for your other regular things and
> >> once that it gone, you have to fall back to the linked list for
> >> those. But when that happens the extra cache misses are not your main
> >> problem anymore.
> >
> > The extra cache misses are a problem in that case because they throttle
> > the reclamation, which anti-throttles the producer, especially in the
> > case where callback invocation is offloaded.
> 
> You still did not explain which contexts can create flooding. I gave you
> a complete list a few mails ago, but you still did not tell which of the
> contexts can cause flooding.

Message-ID: <87tux4kefm.fsf@nanos.tec.linutronix.de>, correct?

In case #1 (RCU call flooding), the page of pointers is helpful.

In case #2 (RCU not being able to run and mop up the backlog), allocating
pages of pointers is unhelpful, given that doing so simply speeds up the
potential OOM.  My thought is to skip kvfree_rcu()/call_rcu() pointer-page
allocation once the current grace period's duration exceeds one second.

> If it's any context which is not sleepable or controllable in any way,
> then any attempt to mitigate it is a lost battle:
> 
>   A dependency on allocating memory to free memory is a dead end by
>   definition.

Any attempt to mitigate that -lacks- -a- -fallback- is a losing battle.

> Any flooder which is uncontrollable is a bug and no matter what kind of
> hacks you provide, it will be able to bring the whole thing down.

On to the sources of flooding, based on what reality has managed to
teach me thus far:

1) User space via syscalls, e.g. open/close

	These are definitely in scope.

2) Kernel thread

	In general, these are out of scope, as you would expect.

	For completeness, based on rcutorture-induced callback flooding,
	if the kernel thread's loop contains at least one cond_resched()
	for CONFIG_PREEMPT_NONE=y on the one hand, at least one schedule()
	for preemptible kernels running NO_HZ_FULL, and at least one
	point during which preemption is possible otherwise.

	As discussed at Plumbers last year, the sysadm can always
	configure callback offloading in such a way that RCU has no
	chance of keeping up with a flood.  Then again, the sysadm can
	also always crash the system in all sorts of interesting ways,
	so what is one more?

	But please note that rcutorture does -not- recycle the flooded
	memory via kfree(), and thus avoids any problems with kfree()
	needing to dive deep into the allocator.  What rcutorture
	does instead is to pass the memory back to the flooder using
	a dedicated queue.  At the end of the test, the whole mess
	is kfree()ed.

	And all of these will be solved (as you would hope) by "Don't do
	that!!!", as laid out in the paragraphs above.	Of course, the
	exact form of "Don't do that" will no doubt change over time, but
	this code is in the kernel and therefore can be changed as needed.

3) Softirq

	Flooding from within the confines of a single softirq handler
	is of course out of scope.  There are all sorts of ways for the
	softirq-handler writer to deal with this, for example, dropping
	into workqueue context to do the allocation, which brings things
	back to #2 (kernel thread).

	I have not experimented with this, nor do I intend to.

4) Device interrupt

	Likewise, flooding from within the confines of a single device
	interrupt handler is out of scope.  As with softirq handlers,
	there are all sorts of ways for the device-driver writer to deal
	with this, for example, dropping into workqueue context to do
	the allocation, which brings things back to #2 (kernel thread).

	Again, as with softirq, I have not experimented with this,
	nor do I intend to.

5) System interrupts, deep atomic context, NMI ...

	System interrupts have the same callback-flooding constraints
	as device interrupts, correct?	(I am thinking that by "system
	interrupt" you mean things like the scheduling-clock interrupt,
	except that I have always thought of this interrupt as being a
	form of device interrupt.)

	I have no idea what "deep atomic context" but it does sound
	intriguing.  ;-)  If you mean the entry/exit code that is not
	allowed to be traced, then you cannot allocate, call_rcu(),
	kfree_rcu, or kvfree_rcu() from that context anyway.

	NMI handlers are not allowed to allocate or to invoke either
	call_rcu(), kfree_rcu(), or kvfree_rcu(), so they are going to
	need help from some other execution context if they are going
	to do any flooding at all.

In short, the main concern is flooding driven one way or another from
user space, whether via syscalls, traps, exceptions, or whatever.
Therefore, of the above list, I am worried only about #1.

(OK, OK, I am worried about #2-#4, but only from the perspective of
knowing what to tell the developer not to do.)

> So far this looks like you're trying to cure the symptoms, which is
> wrong to begin with.
> 
> If the flooder is controllable then there is no problem with cache
> misses at all unless the RCU free callbacks are not able to catch up
> which is yet another problem which you can't cure by allocating more
> memory.

As much as I might like to agree with that statement, the possibility
of freeing (not just allocation) going deep into the allocator leads me
to believe that reality might have a rather different opinion.

And the only way to find out is to try it.  I therefore propose that
the eventual patch series be split into three parts:

1.	Maintain separate per-CPU cache of pages of pointers dedicated
	to kfree_rcu() and kvfree_rcu(), and later also to call_rcu().
	If a given cache is empty, the code takes the fallback (either
	use the rcu_head structure or block on synchronize_rcu(),
	depending), but the code also asks for an allocation from a
	sleepable context in order to replenish the cache.  (We could
	use softirq for kfree_rcu() and kvfree_rcu(), but call_rcu()
	would have deadlock issues with softirq.)

2.	Peter's patch or similar.

3.	Use of Peter's patch.

If the need for #2 and #3 are convincing, well and good.  If not, I
create a tag for them in the -rcu tree so that they can be found quickly
in case reality decides to express its opinion at some inconvenient time
at some inconvenient scale.

Thoughts?

							Thanx, Paul
