Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632AC4B1D0E;
	Mon, 21 Sep 2026 18:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015446; cv=none; b=OD74X0gNbgGNCCOqLtFxNVg6AERsDMLXNum0IvfNZtJRlBYy7napa2d9DE96781azV50T5FOhmUhvjWMAKUUSdmLmE+xtzrPkMCiSFTfdSRNEucFaCnbXhniLMz+9oJ3TBxJWhp5Srvx4Ep5tHOsy+PRkVCDrol04XA6mBs7QQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015446; c=relaxed/simple;
	bh=zoJd8XJP9YtBDXKnbLMob7vj7LocMaB5vyy3tb21c9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRSGW9DNdZHDvvLD/Rx0EFUh9FpQrxI4SsC1gHW2RsBoWOwvj5m7j/Ew9Hlz44MINoBCYQUaOvgQmJ63L1B8zOOllo/KT7fmEp4x6+EBsM04V3M8CMmbRf6YLcRpMs1E7NL30NM1RnA2L7ZqDE3V6kEMfZH6pwO0W/bq+YZ3LNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kv8fp2ux; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kv8fp2ux"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B771A1F00898;
	Mon, 21 Sep 2026 18:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790015444;
	bh=Ib44sh7lsDJZibI5A+BeUxN5HoiZznttrlHAquJEaN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Kv8fp2uxmpSFuZSL8sfiOJfwgS7oBaBxKAIwMp8f2POqd7MIFHxY7tQ3LrR9cKLCb
	 IDqeYbJCJf+PVdzZhftwIVSX8QPy/wHAlpevqJW2zY+gEQ2zHSNmnjI+DjfFLZDbh1
	 Fhewq6doH1rK17BvUreOYvWqMmqeLWEM1gHjN0oV0SpIJFMAe4DqOq8GzVxCcOJdjV
	 zPqaxz0biaVSK2p2A0/SgpKvts9jfX3kNE5gO42qhIVrZ9TzebE8qUyDEEMaLbPAAS
	 l3I7Mm0a9lDw61vFxmetWWKxe3Urno3lg7pu9HAY4XJ15wRocqGWwdmvDkDQq3glzm
	 Ma8TPhL5yCEuQ==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id E71CDF4006B;
	Mon, 21 Sep 2026 14:30:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 21 Sep 2026 14:30:43 -0400
X-ME-Sender: <xms:03exaihxp85-vHtFyTYO63I3E4Wl9ExXStrD-wcjADIA5ObUZxRjgw>
    <xme:03exajuMhPwCmmHSXxrsyecK8uWCKsmdmp9uD_XXf13mA3VA8W2kTgUp8QTe4ojtM
    25dr6xcX4s3c3_hmJnRU7e4WAba_AqKnN3vHIqg7D7KEXYMkIxwGg>
X-ME-Received: <xmr:03exaoSLhVJD890C2oYy_zwBLif7oEsms5dnjNybTB5AlwTzu2LCPzkv5QoC_3jxuPAL_-hI7ck841GPKWWP6QWovAzUhomPNUc2IzIFj73A3Dds08scyC-b>
X-ME-Proxy-Cause: dmFkZTGvJToo2pvWP5Sn4WY+99p7+fq4jo99yeu4TzF1hG6o5ep3cLUk+ciVPm/4byTwDw
    Kw15jmV6Salor2IHfNlNPJu1mb19UQLVgLAg4rapv2Nyx0MhcGg2jaTs9K/r4Y2Hvdus2F
    jMNPUZ+VOnwUla38oBtBj8dRqbiTkz6BdRgVbwT3Ts670W+XgP6t0A+XUqkz8SwELak4UX
    XQzg6UvNV7m2hnXIHi652/WJVswLSMiFpjNWTCHVH7/XM9/pOajrjnk7SKm9zDdH03qX6U
    UfNFYLb0VIbV15QAR5dLsBtJQOnumB4FnxjXFjYsG3lvBgawUZeVQtvSDIni2M1h46MSDW
    UwOhQS6O1u8Gg9ai7sVh+pD0MZ4sJr2t2HhzKhX0DFfOnwweZ3m35BqHNxcEJx5EK/dBBn
    p87XI9AYD/V3sfO0JOGjgItbL+ZRJaJeDxfcbzGF+3CO5jr/gRB5uWmv66WzHf6OsNjgVK
    G5qJaWJtPSYUbFJS2oddG3NNRwd3GbZdOBtp1tmNXG82kOq0oEtl8L5D7GD5VWNQvKSwme
    X2eqx1f+1PvRz9MSSOwk8Vbjsr/++RQlW98JaaXb6nBv15ydiUE/93+iB0La9TYCLpxy1K
    jRy7B7bCMEvpuaya+Lks4/S04qJWXIbzscmlpHvmJBk5JIW/auT9EOVL1rAA
X-ME-Proxy: <xmx:03exav1eMoYHb5kQjijv9DuIYoE3PIVftqE-uD9GmSQ1gDnVVlosvA>
    <xmx:03exalsb4M8i0MPZUQsM-oF9RaPh6OKg6LqOaA1CqApxjB1NxCciQg>
    <xmx:03exathiTItuxvaS2CwgJhHiJIySUMYyPEkgI3BJmJsNMyqsA5necA>
    <xmx:03exau_jAPOH1Q9vfJNCAAJM_kC4QXzzpBcM3xy3TKRNDXvEtahYig>
    <xmx:03exaovkZhsjztrf4-93o_xxGVY8GfN8TqehKdFReXW2ZgyPAnXzo3Di>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 14:30:43 -0400 (EDT)
Date: Mon, 21 Sep 2026 20:30:42 +0200
From: Boqun Feng <boqun@kernel.org>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH 1/7] rcu: Make call_rcu() safe to call from any context
Message-ID: <arF30s1AAAkmq0DB@MacBook-0RXW5>
References: <2a742578-120a-421d-9305-5de0b22bda33@paulmck-laptop>
 <20260919003258.3134343-1-paulmck@kernel.org>
 <aq6XFyrR3OiSvKl9@MacBook-0RXW5>
 <CANk7y0g5EU8T8cLiU=+tLiZCcMEhZOjhnvs4uzD8Z=8GwN+7LA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANk7y0g5EU8T8cLiU=+tLiZCcMEhZOjhnvs4uzD8Z=8GwN+7LA@mail.gmail.com>

On Mon, Sep 21, 2026 at 07:12:02PM +0100, Puranjay Mohan wrote:
> On Sat, Sep 19, 2026 at 3:07 PM Boqun Feng <boqun@kernel.org> wrote:
> >
> > On Fri, Sep 18, 2026 at 05:32:52PM -0700, Paul E. McKenney wrote:
> > > From: Puranjay Mohan <puranjay@kernel.org>
> > >
> >
> > Hi,
> >
> > Sorry for a bit late repsonse.
> >
> > > RCU's per-CPU callback list is only touched with interrupts disabled: the
> > > enqueue runs under local_irq_save() (and the nocb locks when offloaded),
> > > as do callback invocation and grace-period work.  A call_rcu() that
> > > arrives with interrupts already disabled, whether from an NMI or from
> > > instrumentation that re-enters RCU, can interrupt one of those and corrupt
> > > the list or deadlock.
> > >
> > > Defer instead: stage the callback on a per-CPU llist and raise an irq_work
> > > that re-issues it once interrupts are on, straight to the enqueue so it
> > > cannot defer again.  The gate is bare irqs_disabled(), so callers that
> > > merely hold interrupts off are deferred too and pay one irq_work hop.
> > > Skip it while the scheduler is down (RCU_SCHEDULER_INACTIVE): irq_work is
> > > not usable that early, rcu_init() already calls call_rcu(), and the per-CPU
> > > deferral state is not initialised until rcu_init_one() runs later in it.
> > >
> > > rcu_barrier() drains every CPU's ->defer_head before it scans the lists,
> > > and rcutree_migrate_callbacks() drains an outgoing CPU's.  A drain
> > > re-issues onto the draining CPU, so a barrier moves other CPUs' staged
> > > callbacks onto
> > > its own ->cblist; call_rcu() promises no CPU affinity for invocation.
> > > ->defer_lock is held across llist_del_all() and the whole re-issue so the
> > > drainers
> > > serialize: one that finds the list empty can conclude that everything
> > > staged before it is already on a callback list.  Interrupts stay off for
> > > the batch.  Where the arch has an irq_work self-IPI that is what one
> > > interrupts-disabled region could stage, normally a single callback; where
> > > arch_irq_work_has_interrupt() is false the drain waits for the tick, so
> > > several regions can accumulate first.
> > >
> > > The drain clears ->next before re-issuing.  A double call_rcu() on a head
> > > that is already debug-object-active self-links the staged node, and
> > > rcu_do_enqueue()'s duplicate path returns without clearing it, so the
> > > drain would spin.  A re-add behind other staged callbacks makes a longer
> > > cycle, which that does not bound; a double call_rcu() stays undefined.
> > > llist_del_all() yields newest-first, so a batch is re-issued in reverse
> > > call order; nothing depends on call_rcu() ordering.  The re-issue drops
> > > the lazy hint, since staging records only ->func, so a deferred callback
> > > loses its batching on CONFIG_RCU_LAZY.  kasan_record_aux_stack() moves to
> >
> > I'm not sure this is a good idea, because it effectively remove LAZY
> > support when DEFER is enabled. Since the goal of this patchset supports
> > BPF and NMI, would it be nicer that we skip the whole defer logic if the
> > callback is LAZY? Alternatively, you can have two llist (one for hurry
> > and one for lazy).
> 
> I had made this trade-off of removing the Lazy tag as I thought it is
> not necessary to support lazy when call_rcu() is called from nmi and
> bpf based instrumentation as they should not be frequent. But I like

Ah, I missed that you only defer if irqs_disabled() is true, so this is
much better than I used to think. So..

> the idea of two lists (skipping the defer logic is not possible as it
> could lead to deadlocks/corruption). I will also investigate if we can
> put the Lazy tag on the ->next pointer. But will it be acceptable if I
> do that as a follow up? I want to get the base support fully validated

.. definitely a follow-up would do, thank you!

Regards,
Boqun

> with the BPF side changes. I also have more optimizations planned as
> suggested by Sebastian.
> 
> Thanks,
> Puranjay
> 
