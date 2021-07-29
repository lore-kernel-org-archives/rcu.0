Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC2DC4338F
	for <rcu@archiver.kernel.org>; Thu, 29 Jul 2021 10:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B3D860EC0
	for <rcu@archiver.kernel.org>; Thu, 29 Jul 2021 10:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbhG2Kxi (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 29 Jul 2021 06:53:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233413AbhG2Kxg (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 29 Jul 2021 06:53:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 77E5860C40;
        Thu, 29 Jul 2021 10:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627556014;
        bh=tw6AqWFw33m72IWPa96GClQP3O2//RdQYnMQiK673fk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SZmGzZObuh1DZPTiNEWGUfFgn8ibr/Gaz83ngZssp1DOJdcWQ/QdaptYB5zSw1Ndi
         4cNUsGsZXSXI8f3z5wppLKyX8W8sTNL3+DKRp0FyIauBnuNQhHnHpoRepv3OKmWZOn
         3PjnXjWmYt1F8N3xmHJSP7z6o1Ngh+RRWfDFCirVKpg8VVs64Rbn12GCpXdPzzOy7A
         GG1h4iLhG8usS/cIjHOt+Gx+yaPzg4W3L4SFvSHypy72iP6rpERbvx8+WDJan8XOso
         cDCTT7pS3uuSydLIGppLrDK/Ti1QgQ8PGgXvrIVLsSzQClmAawc1wLWx1IN38IKl7G
         5pMhG3Dqabi6w==
Date:   Thu, 29 Jul 2021 12:53:31 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH rcu 04/18] rcu: Weaken ->dynticks accesses and updates
Message-ID: <20210729105331.GA301667@lothringen>
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
 <20210721202127.2129660-4-paulmck@kernel.org>
 <YQJfjFv8lOnkUkhs@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQJfjFv8lOnkUkhs@boqun-archlinux>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 29, 2021 at 03:58:04PM +0800, Boqun Feng wrote:
> > The following litmus test, also adapted from the one supplied off-list
> > by Frederic Weisbecker, models the RCU grace-period kthread detecting
> > a non-idle CPU that is concurrently transitioning to idle:
> > 
> > 	C dynticks-into-idle
> > 
> > 	{
> > 		DYNTICKS=1; (* Initially non-idle. *)
> > 	}
> > 
> > 	P0(int *X, int *DYNTICKS)
> > 	{
> > 		int dynticks;
> > 
> > 		// Non-idle.
> > 		WRITE_ONCE(*X, 1);
> > 		dynticks = READ_ONCE(*DYNTICKS);
> > 		smp_store_release(DYNTICKS, dynticks + 1);
> > 		smp_mb();
> 
> this smp_mb() is not needed, as we rely on the release-acquire pair to
> provide the ordering.
> 
> This means that if we use different implementations (one w/ smp_mb(),
> another w/o) rcu_dynticks_inc() for idle-to-nonidle and nonidle-to-idle,
> we could save a smp_mb(). Thoughts?

That's exactly what I wanted to propose but everybody was sober. Namely order
only the RCU read side critical sections before/after idle together:

     READ side critical section
     //enter idle
     //exit idle
     smp_mb()
     READ side critical section

instead of ordering the RCU read side critical section before idle - with the RCU
idle extended quiescent state - with the RCU read side critical section after idle:

     READ side critical section
     //enter idle
     smp_mb();
     //exit idle
     smp_mb()
     READ side critical section

So the side effect now is that if the write side waits for the reader to
report a quiescent state and scans its dynticks state and see it's not yet in
RCU idle mode, then later on when the read side enters in RCU idle mode we
expect it to see the write side updates.
But after the barrier removal the reader will only see the write side update
once we exit RCU idle mode.

So the following may happen:

	P0(int *X, int *Y, int *DYNTICKS)
	{
		int y;

		WRITE_ONCE(*X, 1);
		smp_store_release(DYNTICKS, 1); // rcu_eqs_enter
		//smp_mb() not there anymore
		y = READ_ONCE(*Y);
		smp_store_release(DYNTICKS, 2); // rcu_eqs_exit()
		smp_mb();
	}

	P1(int *X, int *Y, int *DYNTICKS)
	{
		int x;
		int dynticks;
		
		WRITE_ONCE(*Y, 1);
		smp_mb();
		dynticks = smp_load_acquire(DYNTICKS);
		x = READ_ONCE(*X);
	}

	exists (1:x=0 /\ 0:y=0)

Theoretically it shouldn't matter because the RCU idle mode isn't
supposed to perform RCU reads. But theoretically again once a CPU
has reported a quiescent state, any further read is expected to see
the latest updates from the write side.

So I don't know what to think. In practice I believe it's not a big deal
because RCU idle mode code is usually a fragile path that just handles
cpuidle code to put the CPU in/out low power mode. But what about dragons...
