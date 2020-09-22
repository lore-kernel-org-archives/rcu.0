Return-Path: <SRS0=9ZY9=C7=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86302C4363D
	for <rcu@archiver.kernel.org>; Tue, 22 Sep 2020 15:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D32D2388B
	for <rcu@archiver.kernel.org>; Tue, 22 Sep 2020 15:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600789584;
	bh=v4kqZ/wvRPWQNmubOFAukYKeGrT7bqqaHTFOvh6Ba54=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=aF69lDV4QU8VNtENWGP7lXmuCnVYjftySj2Nn3Lwc0b/rYvEUib+mv4wCZUisDIDm
	 iOHHR3hQVDFhzVxSla2dyS/ZAvIHgXUn7z5zwTIcRMHdT1RkwQcZw+wL9Dz+j3kWMT
	 x0Ject+bCImafcl5WzYDky6IJ/xgVdk7jwfBhkgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgIVPqX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 22 Sep 2020 11:46:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:36758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbgIVPqX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 22 Sep 2020 11:46:23 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4981D20739;
        Tue, 22 Sep 2020 15:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600789582;
        bh=v4kqZ/wvRPWQNmubOFAukYKeGrT7bqqaHTFOvh6Ba54=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hP1GHfUHxNAR3xr7QDgzA5YqmO2FYZ8drye6LFCTlDVBb2SuTHd0YP+UMWO7r53o2
         ok5LfyVpxqSIYkqc0HXWXKd5kEdIqx1iiUacsn5jN8GG16jlj1ArAd/OjNvMrsHegJ
         ffN4szEJ/AlqDFV8tiTM3F9noEYVUzWgMKAiWFY8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id EC45135226AA; Tue, 22 Sep 2020 08:46:21 -0700 (PDT)
Date:   Tue, 22 Sep 2020 08:46:21 -0700
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
Message-ID: <20200922154621.GW29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200918194817.48921-1-urezki@gmail.com>
 <20200918194817.48921-3-urezki@gmail.com>
 <20200921074716.GC12990@dhcp22.suse.cz>
 <20200921154558.GD29330@paulmck-ThinkPad-P72>
 <20200921160318.GO12990@dhcp22.suse.cz>
 <20200922033553.GU29330@paulmck-ThinkPad-P72>
 <20200922080306.GV12990@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922080306.GV12990@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Sep 22, 2020 at 10:03:06AM +0200, Michal Hocko wrote:
> On Mon 21-09-20 20:35:53, Paul E. McKenney wrote:
> > On Mon, Sep 21, 2020 at 06:03:18PM +0200, Michal Hocko wrote:
> > > On Mon 21-09-20 08:45:58, Paul E. McKenney wrote:
> > > > On Mon, Sep 21, 2020 at 09:47:16AM +0200, Michal Hocko wrote:
> > > > > On Fri 18-09-20 21:48:15, Uladzislau Rezki (Sony) wrote:
> > > > > [...]
> > > > > > Proposal
> > > > > > ========
> > > > > > Introduce a lock-free function that obtain a page from the per-cpu-lists
> > > > > > on current CPU. It returns NULL rather than acquiring any non-raw spinlock.
> > > > > 
> > > > > I was not happy about this solution when we have discussed this
> > > > > last time and I have to say I am still not happy. This is exposing
> > > > > an internal allocator optimization and allows a hard to estimate
> > > > > consumption of pcp free pages. IIUC this run on pcp cache can be
> > > > > controled directly from userspace (close(open) loop IIRC) which makes it
> > > > > even bigger no-no.
> > > > 
> > > > Yes, I do well remember that you are unhappy with this approach.
> > > > Unfortunately, thus far, there is no solution that makes all developers
> > > > happy.  You might be glad to hear that we are also looking into other
> > > > solutions, each of which makes some other developers unhappy.  So we
> > > > are at least not picking on you alone.  :-/
> > > 
> > > No worries I do not feel like a whipping boy here. But do expect me to
> > > argue against the approach. I would also appreciate it if there was some
> > > more information on other attempts, why they have failed. E.g. why
> > > pre-allocation is not an option that works well enough in most
> > > reasonable workloads. I would also appreciate some more thoughts why we
> > > need to optimize for heavy abusers of RCU (like close(open) extremes).
> > 
> > Not optimizing for them, but rather defending against them.  Uladzislau
> > gave the example of low-memory phones.  And we have quite the array
> > of defenses against other userspace bugs including MMUs, the "limit"
> > command, and so on.
> > 
> > There have been quite a few successful attempts, starting from the
> > introduction of blimit and RCU-bh more than 15 years ago, continuing
> > through making call_rcu() jump-start grace periods, IPIing reluctant
> > CPUs, tuning RCU callback offloading, and many others.  But these prior
> > approaches have only taken us so far.
> 
> Thank you this is useful. It gives me some idea about the problem but I
> still cannot picture how serious the problem really is. Is this a DoS
> like scenario where an unprivileged task is able to monopolize the
> system/CPU to do all the RCU heavy lifting? Are other RCU users deprived
> from doing their portion? How much expediting helps? Does it really
> solve the problem or it merely shifts it around as you will have hard
> time to keep up with more and more tasks to hit the same path and the
> pre-allocated memory is a very finite resource.

Yes, this situation can result in an unprivileged task being able to
DoS some or even all of the system.  Which is why I have been pushing
on this despite resistance.

And again yes, expediting can help and RCU does in fact take
auto-expediting steps when any CPU's callback list exceeds 10,000
elements.  These auto-expediting changes have also been made over a
15-year time period.  Joel Fernandes is working on a patch series that
will allow RCU to better choose when to auto-expedite and when to favor
speedy RCU callback invocation.  Currently RCU cannot tell and so just
does both whenever it starts getting into trouble.

Both auto-expediting and speedy RCU callback invocation help the memory
allocator by freeing memory more quickly, thus reducing the system's
memory footprint.  Even more important, these help the RCU callback
invocation (and thus freeing of memory) to better keep up with the
allocation in the various difficult situations, for example, the tight
userspace loop around close(open()).

> > Other approaches under consideration include making CONFIG_PREEMPT_COUNT
> > unconditional and thus allowing call_rcu() and kvfree_rcu() to determine
> > whether direct calls to the allocator are safe (some guy named Linus
> > doesn't like this one),
> 
> I assume that the primary argument is the overhead, right? Do you happen
> to have any reference?

Jon Corbet wrote a very nice article summarizing the current situation:
https://lwn.net/Articles/831678/.  Thomas's measurements show no visible
system-level performance impact.  I will let Uladzislau present his more
microbenchmarky performance work.

We are pursuing this unconditional CONFIG_PREEMPT_COUNT approach as well,
in keeping with our current de-facto policy of irritating everyone across
the full expanse of the Linux-kernel source tree.  :-/

> > preallocation (Uladzislau covered this, and
> > the amount that would need to be preallocated is excessive), deferring
> > allocation to RCU_SOFTIRQ (this would also need CONFIG_PREEMPT_COUNT),
> > and deferring to some clean context (which is the best we can do within
> > the confines of RCU, but which can have issues with delay).
> 
> I have already replied to that so let's not split the discussion into
> several fronts.

I will look at other emails.

> > So it is not the need to address this general problem that is new.
> > Far from it!  What is new is the need for changes outside of RCU.
> > 
> > > > > I strongly agree with Thomas http://lkml.kernel.org/r/87tux4kefm.fsf@nanos.tec.linutronix.de
> > > > > that this optimization is not aiming at reasonable workloads. Really, go
> > > > > with pre-allocated buffer and fallback to whatever slow path you have
> > > > > already. Exposing more internals of the allocator is not going to do any
> > > > > good for long term maintainability.
> > > > 
> > > > I suggest that you carefully re-read the thread following that email.
> > > 
> > > I clearly remember Thomas not being particularly happy that you optimize
> > > for a corner case. I do not remember there being a consensus that this
> > > is the right approach. There was some consensus that this is better than
> > > a gfp flag. Still quite bad though if you ask me.
> > 
> > Again, this "optimization" is for robustness more than raw speed.
> > 
> > > > Given a choice between making users unhappy and making developers
> > > > unhappy, I will side with the users each and every time.
> > > 
> > > Well, let me rephrase. It is not only about me (as a developer) being
> > > unhappy but also all the side effects this would have for users when
> > > performance of their favorite workload declines for no apparent reason
> > > just because pcp caches are depleted by an unrelated process.
> > 
> > But in the close(open()) case, wouldn't the allocations on the open()
> > side refill those caches?
> 
> Yes pcp lists will eventually get replenished. This is not a correctness
> problem I am pointing out. It is the fact that any user of this new
> interface can monopolize the _global_ pool which would affect all other
> users of the pool.

Understood.

However, the kvfree_rcu() and call_rcu() allocations when under stress
will be about one page per 500 objects on 64-bit systems.  These 500
objects are there to begin with.  So it is not at all clear to me that
this additional one-page-per-500-objects memory overhead is significant.

What about when not under stress?  In that case, the absolute number of
additional objects allocated will be small, so it is once again not at
all clear to me that this additional memory overhead is significant.

							Thanx, Paul
