Return-Path: <SRS0=c9Wv=AN=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1177C433DF
	for <rcu@archiver.kernel.org>; Thu,  2 Jul 2020 20:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84E3D20772
	for <rcu@archiver.kernel.org>; Thu,  2 Jul 2020 20:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dsHAlvNM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+9j4rmT8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbgGBUTN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 2 Jul 2020 16:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgGBUTN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 2 Jul 2020 16:19:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588B1C08C5C1;
        Thu,  2 Jul 2020 13:19:11 -0700 (PDT)
Date:   Thu, 2 Jul 2020 22:19:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593721150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NHcHHOfu1jSeEknaYtdDpWniCj0/u4/s6M6KwnTpcsc=;
        b=dsHAlvNM0vIrsjkOgti9Yzdx7SDL5bCd4q+aSP7Q0hSY/PJZQKuM1r2/uIiCvYr3gDG+Gh
        YUBaDl8bAPd3SJpIgW8tujcUMixvm4ojCa2AWkc95/vTpEcKnqB2YTedrCJXNDSkmtu6n3
        mSSrkou2HNtIDfBJj8eBFlHKx2UJfL1xm9PWJI7s9Zlz0KJw0LoHP98yfWXyWHB0VDT1ip
        a8PZW5MRPvgnE+RSNV/U4gPNhN5m1L6NrHra5c94hVIqH90lrJdcjhxNaiuJlA3fCmDqAi
        0aKl73CRYqea5lcvNHQShEpNNbYbXXCOboYgUxBVpwEXsTT28xadxRfX2pZuRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593721150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NHcHHOfu1jSeEknaYtdDpWniCj0/u4/s6M6KwnTpcsc=;
        b=+9j4rmT8q/2x/Qm3/hEbQCNEhekY1t3FqLlhPDfvACust2St4iEcP7o69y7TwgZtOtM67X
        e/klwLVav4ghqbDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <20200702201908.jfiacgvion6a4nmj@linutronix.de>
References: <20200624201200.GA28901@paulmck-ThinkPad-P72>
 <20200624201226.21197-3-paulmck@kernel.org>
 <20200630164543.4mdcf6zb4zfclhln@linutronix.de>
 <20200630183534.GG9247@paulmck-ThinkPad-P72>
 <20200702141216.r4rbt5w3hjzafpgg@linutronix.de>
 <20200702164826.GQ9247@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200702164826.GQ9247@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2020-07-02 09:48:26 [-0700], Paul E. McKenney wrote:
> On Thu, Jul 02, 2020 at 04:12:16PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2020-06-30 11:35:34 [-0700], Paul E. McKenney wrote:
> > > > This is not going to work together with the "wait context validator"
> > > > (CONFIG_PROVE_RAW_LOCK_NESTING). As of -rc3 it should complain about
> > > > printk() which is why it is still disabled by default.
> > >=20
> > > Fixing that should be "interesting".  In particular, RCU CPU stall
> > > warnings rely on the raw spin lock to reduce false positives due
> > > to race conditions.  Some thought will be required here.
> >=20
> > I don't get this part. Can you explain/give me an example where to look
> > at?
>=20
> Starting from the scheduler-clock interrupt's call into RCU,
> we have rcu_sched_clock_irq() which calls rcu_pending() which
> calls check_cpu_stall() which calls either print_cpu_stall() or
> print_other_cpu_stall(), depending on whether the stall is happening on
> the current CPU or on some other CPU, respectively.
>=20
> Both of these last functions acquire the rcu_node structure's raw ->lock
> and expect to do printk()s while holding it.

=E2=80=A6
> Thoughts?

Okay. So in the RT queue there is a printk() rewrite which fixes this
kind of things. Upstream the printk() interface is still broken in this
regard and therefore CONFIG_PROVE_RAW_LOCK_NESTING is disabled.
[Earlier the workqueue would also trigger a warning but this has been
fixed as of v5.8-rc1.]
This was just me explaining why this bad, what debug function would
report it and why it is not enabled by default.

> > > > So assume that this is fixed and enabled then on !PREEMPT_RT it will
> > > > complain that you have a raw_spinlock_t acquired (the one from patch
> > > > 02/17) and attempt to acquire a spinlock_t in the memory allocator.
> > >=20
> > > Given that the slab allocator doesn't acquire any locks until it gets
> > > a fair way in, wouldn't it make sense to allow a "shallow" allocation
> > > while a raw spinlock is held?  This would require yet another GFP_ fl=
ag,
> > > but that won't make all that much of a difference in the total.  ;-)
> >=20
> > That would be one way of dealing with. But we could go back to
> > spinlock_t and keep the memory allocation even for RT as is. I don't see
> > a downside of this. And we would worry about kfree_rcu() from real
> > IRQ-off region once we get to it.
>=20
> Once we get to it, your thought would be to do per-CPU queuing of
> memory from IRQ-off kfree_rcu(), and have IRQ work or some such clean
> up after it?  Or did you have some other trick in mind?

So for now I would very much like to revert the raw_spinlock_t back to
the spinlock_t and add a migrate_disable() just avoid the tiny
possible migration between obtaining the CPU-ptr and acquiring the lock
(I think Joel was afraid of performance hit).

Should we get to a *real* use case where someone must invoke kfree_rcu()
=66rom a hard-IRQ-off region then we can think what makes sense. per-CPU
queues and IRQ-work would be one way of dealing with it.

> 							Thanx, Paul
>=20
Sebastian
