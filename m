Return-Path: <SRS0=EP0b=2Z=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F16C00523
	for <rcu@archiver.kernel.org>; Sat,  4 Jan 2020 02:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA9EC24649
	for <rcu@archiver.kernel.org>; Sat,  4 Jan 2020 02:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578105095;
	bh=lXjkK/JLSjpc7WvX5Do6GyiHNabXj1+zphe5Y0mgLds=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=PdTMQgrhq5j49cGQNnRTcK69noR9aMgUshUSTQsCySoVUw6n7tHmczREHQZw2iMpH
	 bDiHu36VW2Pf8GD/zONeGvejfTjgY97ZN32wf1xO7CZy9UoeXf1l87JV24k0BhmNDS
	 PiE/zNLUQzvzmJ7kxuzuBsAfiLEnnMEFGhd6AH8I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbgADCbf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 3 Jan 2020 21:31:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:40196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727222AbgADCbf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 3 Jan 2020 21:31:35 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88BFB21835;
        Sat,  4 Jan 2020 02:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578105093;
        bh=lXjkK/JLSjpc7WvX5Do6GyiHNabXj1+zphe5Y0mgLds=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=plxkwgNiC87DylnnXd9PCaLxPWvZRPK+AKxYBV3He+UA1Xi+vt38nwDlLre8l0VAb
         zwogr08FYeoKkcyQlj+Dt6L9m0P8qdd3d7AOMBRoa0CWrCJZzoa2opL7JqnfnJBWPB
         SwkXk3cnW8bVYlpc2iP0/2M6dQM9bo284AyozZNI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5C8AD35227A3; Fri,  3 Jan 2020 18:31:33 -0800 (PST)
Date:   Fri, 3 Jan 2020 18:31:33 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zilstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        Amol Grover <frextrite@gmail.com>
Subject: Re: RCU ideas discussed at LPC
Message-ID: <20200104023133.GD13449@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CAEXW_YTyxm7QZwFV7KYpN2Sds=SDYqOvZ4+qfWL1_Kwx48Dusg@mail.gmail.com>
 <20191226010532.GP13449@paulmck-ThinkPad-P72>
 <20200104015617.GK189259@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200104015617.GK189259@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jan 03, 2020 at 08:56:17PM -0500, Joel Fernandes wrote:
> On Wed, Dec 25, 2019 at 05:05:32PM -0800, Paul E. McKenney wrote:
> > On Wed, Dec 25, 2019 at 05:41:04PM -0500, Joel Fernandes wrote:
> > > Hi Paul,
> > > We were discussing some ideas on facebook so I wanted to just post
> > > them here as well. This is in the context of the RCU section of RT MC
> > > https://www.youtube.com/watch?v=bpyFQJV5gCI
> > > 
> > > Detecting high kfree_rcu() load
> > > ----------
> > > You mentioned about this. As I understand it, we did the kfree_rcu()
> > > batching to let the system not do anything RCU related until a batch
> > > has filled up enough or a timeout has occurred. This makes the GP
> > > thread and the system do less work.
> > > The problem you are raising in our facebook thread is, that during
> > > heavy load the "batch" can be large and be dumped into call_rcu()
> > > eventually. Wouldn't this be better handled generically within
> > > call_rcu() itself, for the benefit of other non-kfree_rcu workloads?
> > > That is if a large number of callbacks is dumped, then try to end the
> > > GP more quickly. This likely doesn't need a signal from kfree_rcu()
> > > since call_rcu() knows that it is being hammered.
> > 
> > Except that call_rcu() currently has no idea how many parcels of memory
> > a given request from kfree_rcu() represents.
> 
> True. At the moment, neither does kfree_rcu() since we store only the
> pointer. We could consult the low level allocator if they have this
> information. If you could let me know how to make RCU more aggressive in this
> case (once we know there's a problem), I could work on something like this. I
> did have OOM issues in earlier versions of the kfree_rcu() patch. I could
> boot a system with less memory and OOM it too with the tests even now.

Let's keep things simple, at first at least!  ;-)

Currently, call_rcu() has no idea how much memory is tied up by a normal
callback, either.  But just counting the callbacks (or, in the case of
kfree_rcu(), counting the block of memory, independent of size) is at
least correlated with the memory footprint.  Plus that is what has been
used in the past, so it should be a good place to start.

Besides, how many call_rcu() invocations is a 1K kfree_rcu() invocation
worth?  A 8K kfree_rcu() invocation?  A 64-byte kfree_rcu() invocation?

We might need to answer those questions over time, but again, let's start
simple.

> > > Detecting recursive call_rcu() within call_rcu()
> > > ---------
> > > We could use a per-cpu variable to detect a scenario like this, though
> > > I am not sure if preemption during call_rcu() itself would cause false
> > > positives.
> > 
> > A call_rcu() from within an RCU callback function is legal and is
> > sometimes done.  Or are you thinking of a call_rcu() from an interrupt
> > handler interrupting another call_rcu()?
> 
> Oh, did not know this. I thought this was the point heavily discussed in the
> LPC talk but must have misunderstood when you said you hoped no one was
> precisely doing this..

What I hoped they avoid is a call_rcu() bomb, where each callback does
several call_rcu() invocations.  Just as with child processes invoking
fork(), within broad limits it is OK for callback functions to invoke
call_rcu().  There is at least one in rcutorture, for example, but it
does just one call_rcu() and also checks a time-to-stop flag.

> > > All rcuogp and rcuop threads tied to a house keeping CPU
> > > ---
> > > In LPC you mentioned about the problem of OOM if all rcuo* threads
> > > including the GP one are not able to keep up with heavy load. On
> > > Facebook I had proposed something like this: What about making the
> > > affinity setting to be a "soft affinity", that is respect it always
> > > expect in the uncommon case. In the uncommon case of heavy load, let
> > > the threads run wherever to prevent OOM. Sure that might make the
> > > system a little more disruptive, but if we are approaching OOM we have
> > > bigger problems right?
> > 
> > The problem is that there are a rather large number of ways to force
> > a given kthread to execute only on a given CPU, and reverse-engineering
> > all that within call_rcu() isn't reasonable.  An alternative is to
> > disable offloading, wait for the offloaded callbacks to drain, then
> > start up the usual softirq approach (or per-CPU kthread, as the case
> > may be).  This self-throttles because whatever is generating callbacks
> > gets preempted by softirq invocation.
> 
> Ok, agreed. Did you already implement the "disable offloading" code?

Not yet, and I do agree with the results of the LPC vote, which is to
do the diagnostic first.  Perhaps given a suitable diagnostic strategy,
"disable offloading" never will be needed.

That said, the changes I have made to RCU over the past several years
are within striking distance of "disable offloading" being possible.
There are fewer race conditions than there used to be, but there is
still no shortage.

> > > ---------
> > > How about doing this kind of call_rcu() to synchronize_rcu()
> > > transition automatically if the context allows it? I.e. Detect the
> > > context and if sleeping is allowed, then wait for the grace period
> > > synchronously in call_rcu(). Not sure about deadlocks and the like
> > > from this kind of waiting and have to think more.
> > 
> > This gets rather strange in a production PREEMPT=n build, so not a
> > fan, actually.  And in real-time systems, I pretty much have to splat
> > anyway if I slow down call_rcu() by that much.
> > 
> > So the preference is instead detecting such misconfiguration and issuing
> > appropriate diagnostics.  And making RCU more able to keep up when not
> > grossly misconfigured, hence the kfree_rcu() memory footprint being
> > fed into core RCU.
> 
> Ok. Is it not Ok to simply assume that a large number of callbacks queued
> along with observing high memory pressure, means RCU should be more
> aggressive anyway since whatever memory can be freed by invoking callbacks
> should be helpful anyway? Or were you thinking making RCU aggressive when
> there's a lot of memory pressure is not worth it, without knowing that RCU is
> the cause for it?

I used to have a memory-pressure switch for RCU, but the OOM guys hated
it.  But given a reliable "running short of memory" indicator, I would
be quite happy to use it.  After all, even if RCU is not at fault, it
might still be helpful for it to pull its memory-footprint horns in a bit.

> > > is square root of N number of rcuogp0 threads - the right optimization?
> > 
> > If there were enough CPUs, it would be necessary to have three levels
> > of hierarchy and to go to the cube root, but that would be more CPUs
> > than I have seen used.
> > > ---------
> > > The question raised was can we do with fewer threads, or even just
> > > one? You mentioned the square root might not be the right choice. How
> > > do we test how well the system is doing. Are you running rcutorture
> > > with a certain tree configuration and monitor memory footprint /
> > > performance?
> > 
> > The issue prompting the hierarcy was wakeup overhead on the grace-period
> > kthread.  Going to a hierarchy reduced the load on that single thread
> > (which could otherwise become a bottleneck on large systems, and also
> > reduced the absolute number of wakeups by up to almost a factor of two.
> > Deepening the hierarchy would further reduce the wakeup load on the
> > grace-period kthread, but would increase the total number of wakeups.
> > 
> > So this is not a matter of tweaks and optimizations.  I would need to
> > see some horrible problem with the current setup to even consider
> > making a change.
> 
> Ok, I only raised this because in the LPC talk you mentioned that you are not
> sure if this is the right optimization. But I understand the rationale for
> choosing some hierarchy in light of the wakeup performance improvements (I
> already knew that this is why you had a hierarchy).

Very good!  ;-)

> > > BTW, I have 2 interns working on RCU (Amol and Madupharna also on CC).
> > > They were selected among several others as a part of the
> > > LinuxFoundation mentorship program. They are familiar with RCU. I have
> > > asked them to look at some RCU-list work and RCU sparse work. However,
> > > I can also have them look into a few other things as time permits and
> > > depending on what interests them.
> > 
> > Dog paddling before cliff diving, please!  ;-)
> 
> Sure. They are working on relatively simpler things for their internship but
> I just put these ideas out there with them on CC so they can pick something
> else as well if they have time and interest ;-)

I considered pointing them at KCSAN reports, but about 5% of them require
global knowledge.  And it is never clear up front which are the 5%.  And
that 5% of "real bugs" is most of the motivation for things like KCSAN.

> > > Thanks, Merry Christmas!
> > 
> > And to you and yours as well!
> 
> Hope you had a good holiday season!

It did!  First holiday season in quite a few years featuring all
three kids, though not all at once.  Might be awhile until the next
time that happens.  Something about them being about 30 years old and
widely dispersed.  ;-)

As the little one becomes more aware, your holiday seasons should become
quite fun.  Don't miss out!  ;-)

							Thanx, Paul
