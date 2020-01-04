Return-Path: <SRS0=EP0b=2Z=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64A3C32771
	for <rcu@archiver.kernel.org>; Sat,  4 Jan 2020 21:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D545222C4
	for <rcu@archiver.kernel.org>; Sat,  4 Jan 2020 21:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="WJ448ece"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgADVVL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 4 Jan 2020 16:21:11 -0500
Received: from mail-pg1-f178.google.com ([209.85.215.178]:39532 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgADVVL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 4 Jan 2020 16:21:11 -0500
Received: by mail-pg1-f178.google.com with SMTP id b137so24998318pga.6
        for <rcu@vger.kernel.org>; Sat, 04 Jan 2020 13:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0bXAZM2ZOhmgr5xeM+HX+osGY1437+vYxxWGa0OoZ0k=;
        b=WJ448ece0UxYf0jB4EDhwD5zU7RSV6B5zqxkz779IbPrY96BGyeaJj7W6gPUbTd3tD
         aNqXPfYSnLIQrPtYLSFS9SiX5nylcPUSYqTZEYMq2zUiWeo7bZfZNgHqu4qAb0wxkSbk
         s07+4/U4kz0cB+RDdPbcxM+5BbdbOjcKCAObw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0bXAZM2ZOhmgr5xeM+HX+osGY1437+vYxxWGa0OoZ0k=;
        b=Jnb3hls572iUcM+yHAW+7vOqzMUu6lSnF52rWorhwq6+9gaP9LZyWU9YmDm3fNE7C1
         wg37fhaWY1kggz3rC9ufKBeVvNelWGQsxF5Z9G8gffb7rsB9OySqMCklA2UmniIvjaQU
         IXEWiC0goBQnzlZXTifnCBJkgvCp9Xipj1gGNqoJoNktk8bdzwpc/FlxaU7c/AiXC4F0
         J1yW6nPKCblc5+FKzxmcCiYQMD+aRoiMMcDwzlcMRFmJhDPtCGJUsW0l+Dnzc3av4cmF
         i8LhiqlxQBVB2tRxHKUccikEeDMKVALcs+e/CoN4fO8h2THuTZmPQ+6Jbj1t0X9lRhOz
         OPnA==
X-Gm-Message-State: APjAAAVQVX7krQmmY0lMxYVBAVSsQlCSWUtMFOoZRQH7b4W2Fa5mCCju
        qDkw7y7YL5w8Ma2PEde0+ZNBRw==
X-Google-Smtp-Source: APXvYqx8Fg16gaqK+DsyHYDsu7b3DKYgOP5fjkB0Lc26zI15T5tSrp84xI8732X3AjVkeItIxukqjA==
X-Received: by 2002:a62:f243:: with SMTP id y3mr103297572pfl.146.1578172869970;
        Sat, 04 Jan 2020 13:21:09 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id d2sm18975311pjo.32.2020.01.04.13.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2020 13:21:09 -0800 (PST)
Date:   Sat, 4 Jan 2020 16:21:08 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zilstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        Amol Grover <frextrite@gmail.com>
Subject: Re: RCU ideas discussed at LPC
Message-ID: <20200104212108.GM189259@google.com>
References: <CAEXW_YTyxm7QZwFV7KYpN2Sds=SDYqOvZ4+qfWL1_Kwx48Dusg@mail.gmail.com>
 <20191226010532.GP13449@paulmck-ThinkPad-P72>
 <20200104015617.GK189259@google.com>
 <20200104023133.GD13449@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200104023133.GD13449@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jan 03, 2020 at 06:31:33PM -0800, Paul E. McKenney wrote:
> On Fri, Jan 03, 2020 at 08:56:17PM -0500, Joel Fernandes wrote:
> > On Wed, Dec 25, 2019 at 05:05:32PM -0800, Paul E. McKenney wrote:
> > > On Wed, Dec 25, 2019 at 05:41:04PM -0500, Joel Fernandes wrote:
> > > > Hi Paul,
> > > > We were discussing some ideas on facebook so I wanted to just post
> > > > them here as well. This is in the context of the RCU section of RT MC
> > > > https://www.youtube.com/watch?v=bpyFQJV5gCI
> > > > 
> > > > Detecting high kfree_rcu() load
> > > > ----------
> > > > You mentioned about this. As I understand it, we did the kfree_rcu()
> > > > batching to let the system not do anything RCU related until a batch
> > > > has filled up enough or a timeout has occurred. This makes the GP
> > > > thread and the system do less work.
> > > > The problem you are raising in our facebook thread is, that during
> > > > heavy load the "batch" can be large and be dumped into call_rcu()
> > > > eventually. Wouldn't this be better handled generically within
> > > > call_rcu() itself, for the benefit of other non-kfree_rcu workloads?
> > > > That is if a large number of callbacks is dumped, then try to end the
> > > > GP more quickly. This likely doesn't need a signal from kfree_rcu()
> > > > since call_rcu() knows that it is being hammered.
> > > 
> > > Except that call_rcu() currently has no idea how many parcels of memory
> > > a given request from kfree_rcu() represents.
> > 
> > True. At the moment, neither does kfree_rcu() since we store only the
> > pointer. We could consult the low level allocator if they have this
> > information. If you could let me know how to make RCU more aggressive in this
> > case (once we know there's a problem), I could work on something like this. I
> > did have OOM issues in earlier versions of the kfree_rcu() patch. I could
> > boot a system with less memory and OOM it too with the tests even now.
> 
> Let's keep things simple, at first at least!  ;-)
> 
> Currently, call_rcu() has no idea how much memory is tied up by a normal
> callback, either.  But just counting the callbacks (or, in the case of
> kfree_rcu(), counting the block of memory, independent of size) is at
> least correlated with the memory footprint.  Plus that is what has been
> used in the past, so it should be a good place to start.
> 
> Besides, how many call_rcu() invocations is a 1K kfree_rcu() invocation
> worth?  A 8K kfree_rcu() invocation?  A 64-byte kfree_rcu() invocation?
> 
> We might need to answer those questions over time, but again, let's start
> simple.

Sounds great.

> > > > Detecting recursive call_rcu() within call_rcu()
> > > > ---------
> > > > We could use a per-cpu variable to detect a scenario like this, though
> > > > I am not sure if preemption during call_rcu() itself would cause false
> > > > positives.
> > > 
> > > A call_rcu() from within an RCU callback function is legal and is
> > > sometimes done.  Or are you thinking of a call_rcu() from an interrupt
> > > handler interrupting another call_rcu()?
> > 
> > Oh, did not know this. I thought this was the point heavily discussed in the
> > LPC talk but must have misunderstood when you said you hoped no one was
> > precisely doing this..
> 
> What I hoped they avoid is a call_rcu() bomb, where each callback does
> several call_rcu() invocations.  Just as with child processes invoking
> fork(), within broad limits it is OK for callback functions to invoke
> call_rcu().  There is at least one in rcutorture, for example, but it
> does just one call_rcu() and also checks a time-to-stop flag.

Ok, got it now.

> > > > ---------
> > > > How about doing this kind of call_rcu() to synchronize_rcu()
> > > > transition automatically if the context allows it? I.e. Detect the
> > > > context and if sleeping is allowed, then wait for the grace period
> > > > synchronously in call_rcu(). Not sure about deadlocks and the like
> > > > from this kind of waiting and have to think more.
> > > 
> > > This gets rather strange in a production PREEMPT=n build, so not a
> > > fan, actually.  And in real-time systems, I pretty much have to splat
> > > anyway if I slow down call_rcu() by that much.
> > > 
> > > So the preference is instead detecting such misconfiguration and issuing
> > > appropriate diagnostics.  And making RCU more able to keep up when not
> > > grossly misconfigured, hence the kfree_rcu() memory footprint being
> > > fed into core RCU.
> > 
> > Ok. Is it not Ok to simply assume that a large number of callbacks queued
> > along with observing high memory pressure, means RCU should be more
> > aggressive anyway since whatever memory can be freed by invoking callbacks
> > should be helpful anyway? Or were you thinking making RCU aggressive when
> > there's a lot of memory pressure is not worth it, without knowing that RCU is
> > the cause for it?
> 
> I used to have a memory-pressure switch for RCU, but the OOM guys hated
> it.  But given a reliable "running short of memory" indicator, I would
> be quite happy to use it.  After all, even if RCU is not at fault, it
> might still be helpful for it to pull its memory-footprint horns in a bit.

With recent advances in PSI, I am wondering if those pressure signals (for
memory) can be leveraged to pull the memory-footprint horns. I can look more
into this, I am also looking into PSI for other work things.

One thing I am wondering though is, say we get a reliable signal -- what
could RCU do? Were you thinking of having the FQS loop set the usual
emergency flags and hope the "RCU-idle" CPUs enter quiescent states, along
with additional signalling for rcu_read_unlock_special()?  Will think more
about it..

As far as testing goes, I was thinking of initially running rcuperf on a
system with less memory and never entering OOM as a "test has passed"
indication.

> > > > BTW, I have 2 interns working on RCU (Amol and Madupharna also on
> > > > CC).
> > > > They were selected among several others as a part of the
> > > > LinuxFoundation mentorship program. They are familiar with RCU. I have
> > > > asked them to look at some RCU-list work and RCU sparse work. However,
> > > > I can also have them look into a few other things as time permits and
> > > > depending on what interests them.
> > > 
> > > Dog paddling before cliff diving, please!  ;-)
> > 
> > Sure. They are working on relatively simpler things for their internship but
> > I just put these ideas out there with them on CC so they can pick something
> > else as well if they have time and interest ;-)
> 
> I considered pointing them at KCSAN reports, but about 5% of them require
> global knowledge.  And it is never clear up front which are the 5%.  And
> that 5% of "real bugs" is most of the motivation for things like KCSAN.

Interesting.

> > > > Thanks, Merry Christmas!
> > > 
> > > And to you and yours as well!
> > 
> > Hope you had a good holiday season!
> 
> It did!  First holiday season in quite a few years featuring all
> three kids, though not all at once.  Might be awhile until the next
> time that happens.  Something about them being about 30 years old and
> widely dispersed.  ;-)

Oh nice, happy to hear that and hope this year end brings the same.

> As the little one becomes more aware, your holiday seasons should become
> quite fun.  Don't miss out!  ;-)

Looking forward to it and will do ;)

thanks,

 - Joel

