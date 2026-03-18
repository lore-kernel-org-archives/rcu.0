Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573FB364EA1
	for <rcu@vger.kernel.org>; Wed, 18 Mar 2026 22:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773872109; cv=none; b=dGACjPEABlfnrb0smGQ7qOBpx2fH8dtRtJqYSTVe6bab/E5BnUKPiZdjenLjE3ChVV3t7PPD4q6F4k3KvxYTaFrC5/VZ5dqczY1HU7uX4/gc1c8kgKtPEOTfkZ1trC+6j0Kzm6ct2lORCnAN+TKs1SOos4scqLjVQdykPg3es4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773872109; c=relaxed/simple;
	bh=KadbjDW89prqRlUOAXQRRnU/T8ijVg6gmfoDKWiPmKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PrHSfDqtN9nsA9cv84jt6Fu7GIACT0IFEWAKvxLMHhGZq8EoJfmZi9rGf4QNZp389IQOG3Lh9ibUSYP1Xj6W9+58KhNqr67JfFivKaGhfIe6I4BsuUT4ZlFGW0jcC0fvs0/CJdTyTJv/L4cn4Si3tIZtgJ5NE9u4NVeBT5YeVhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msjr2OID; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msjr2OID"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9196C19421;
	Wed, 18 Mar 2026 22:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773872109;
	bh=KadbjDW89prqRlUOAXQRRnU/T8ijVg6gmfoDKWiPmKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=msjr2OIDp7MCbfyfUaWgKewP6751KsLEezgztFUe/rSG9NGXh6lhoXFk7SfXb84cj
	 boq4NYl04GwKvzrVIeiRwA5eS8piqzAJ1Vh3hpmtaxcXqpSTg5EHhllK86bh4z0znn
	 d7LmZEDxDTcBQOQCu0vF+9YfLtPlTWl5ApK2m/Km24vOa43I5VVXrijv+j/4eFjUkF
	 v82JJ31Pitz6BcZAjx7euRgblsp8PT8itJmqUGottXPWEIv+N0rRpw3grHIjxF4/yU
	 ruJTpBqPUzEvFsbAMbpOpxzPYJnsUlXtx+3RuWUPsR76sfVWcYRSPH7On5Q7tqOMSw
	 qFeWYTM0421qw==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8F29CF40080;
	Wed, 18 Mar 2026 18:15:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 18 Mar 2026 18:15:07 -0400
X-ME-Sender: <xms:6yO7aW9l7lAUWB92TSppFUGYaG7vkicDMJslyyCLW98efuocYpU7KA>
    <xme:6yO7aTTRwuAzgxwmbVckA49-A0BY7sw0a-pMHFtmFQ76jeqodFbTlUHd5upFJ6oCM
    CdaZ-xexVRZ8K7NzwbiENYlaQCqKcfQwkr3jXnpg44oKJdwQuu2>
X-ME-Received: <xmr:6yO7aQcEfiJ0DHOTFsFBrhhUWHaVWspI6geGlXDpu4hTUMT5Y_bDpf3XVMGRHjUtEfORPrbKHXEuY5oA2KU2lG2KczpRqrrb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdehfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnsehkvghrnhgvlhdr
    ohhrgheqnecuggftrfgrthhtvghrnhepkefghffhueehlefhkeetueffjeevteejfeffte
    ettdetgeefffdtudetuddugfelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlih
    hthidqudeijedtleekgeejuddqudejjeekheehhedvqdgsohhquhhnpeepkhgvrhhnvghl
    rdhorhhgsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepuddtpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehjohgvlhgrghhnvghlfhesnhhvihguihgrrdgtohhm
    pdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsg
    highgvrghshieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehfrhgvuggvrhhi
    tgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvvghrrghjrdhiihhtrhdutdesgh
    hmrghilhdrtghomhdprhgtphhtthhopehurhgviihkihesghhmrghilhdrtghomhdprhgt
    phhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopehrtg
    husehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvmhigohhrsehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:6yO7aVQCL-CVBqihWhE1TIAgqrjlUnY0_Or53mPbUoqeP9SlpcLCPQ>
    <xmx:6yO7acJNqQkMe_q0WsYmZz6ZzympjJgoQdmZZ_vSKJFEjACx8ClXGg>
    <xmx:6yO7aSLfzPyOvE8Y4qbrUsKffvLq8-hlK3wCqM0uT2MthbQnZgYv7A>
    <xmx:6yO7aXj2y3byolZ7qrwHplt85scensJEZIkjhDLZ-O-5tr07IujFUw>
    <xmx:6yO7acPRWd3TC0kKhWQsOXLIoqjFGfn2YBY2yjXMYoWOIAm7JAKM_WIu>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Mar 2026 18:15:07 -0400 (EDT)
Date: Wed, 18 Mar 2026 15:15:06 -0700
From: Boqun Feng <boqun@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: paulmck@kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
	boqun.feng@gmail.com, rcu@vger.kernel.org,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace +
 PREEMPT_RT
Message-ID: <absj6rZbyLZY8PPz@tardis.local>
References: <fe28d664-3872-40f6-83c6-818627ad5b7d@paulmck-laptop>
 <20260318105058.j2aKncBU@linutronix.de>
 <b33d2dc2-7ccf-4524-a846-95c2b64fe117@paulmck-laptop>
 <20260318144305.xI6RDtzk@linutronix.de>
 <abrJ9C637V6keRvd@tardis.local>
 <214fb140-041d-4fd1-8694-658547209b84@paulmck-laptop>
 <3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com>
 <absesPf-10awctq9@tardis.local>
 <absfZGD3en9TUA1U@tardis.local>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <absfZGD3en9TUA1U@tardis.local>

On Wed, Mar 18, 2026 at 02:55:48PM -0700, Boqun Feng wrote:
> On Wed, Mar 18, 2026 at 02:52:48PM -0700, Boqun Feng wrote:
> [...]
> > > Ah so it is an ABBA deadlock, not a ABA self-deadlock. I guess this is a
> > > different issue, from the NMI issue? It is more of an issue of calling
> > > call_srcu  API with scheduler locks held.
> > > 
> > > Something like below I think:
> > > 
> > >   CPU A (BPF tracepoint)                CPU B (concurrent call_srcu)
> > >   ----------------------------         ------------------------------------
> > >   [1] holds  &rq->__lock
> > >                                         [2]
> > >                                         -> call_srcu
> > >                                         -> srcu_gp_start_if_needed
> > >                                         -> srcu_funnel_gp_start
> > >                                         -> spin_lock_irqsave_ssp_content...
> > > 					  -> holds srcu locks
> > > 
> > >   [4] calls  call_rcu_tasks_trace()      [5] srcu_funnel_gp_start (cont..)
> > >                                                  -> queue_delayed_work
> > >           -> call_srcu()                         -> __queue_work()
> > >           -> srcu_gp_start_if_needed()           -> wake_up_worker()
> > >           -> srcu_funnel_gp_start()              -> try_to_wake_up()
> > >           -> spin_lock_irqsave_ssp_contention()  [6] WANTS  rq->__lock
> > >           -> WANTS srcu locks
> > 
> > I see, we can also have a self deadlock even without CPU B, when CPU A
> > is going to try_to_wake_up() the a worker on the same CPU.
> > 
> > An interesting observation is that the deadlock can be avoided in
> > queue_delayed_work() uses a non-zero delay, that means a timer will be
> > armed instead of acquiring the rq lock.
> > 

If my observation is correct, then this can probably fix the deadlock
issue with runqueue lock (untested though), but it won't work if BPF
tracepoint can happen with timer base lock held.

Regards,
Boqun

------>
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 2328827f8775..a5d67264acb5 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1061,6 +1061,7 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
        struct srcu_node *snp_leaf;
        unsigned long snp_seq;
        struct srcu_usage *sup = ssp->srcu_sup;
+       bool irqs_were_disabled;

        /* Ensure that snp node tree is fully initialized before traversing it */
        if (smp_load_acquire(&sup->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
@@ -1098,6 +1099,7 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,

        /* Top of tree, must ensure the grace period will be started. */
        raw_spin_lock_irqsave_ssp_contention(ssp, &flags);
+       irqs_were_disabled = irqs_disabled_flags(flags);
        if (ULONG_CMP_LT(sup->srcu_gp_seq_needed, s)) {
                /*
                 * Record need for grace period s.  Pair with load
@@ -1118,9 +1120,16 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
                // it isn't.  And it does not have to be.  After all, it
                // can only be executed during early boot when there is only
                // the one boot CPU running with interrupts still disabled.
+               //
+               // If irq was disabled when call_srcu() is called, then we
+               // could be in the scheduler path with a runqueue lock held,
+               // delay the process_srcu() work 1 more jiffies so we don't go
+               // through the kick_pool() -> wake_up_process() path below, and
+               // we could avoid deadlock with runqueue lock.
                if (likely(srcu_init_done))
                        queue_delayed_work(rcu_gp_wq, &sup->work,
-                                          !!srcu_get_delay(ssp));
+                                          !!srcu_get_delay(ssp) +
+                                          !!irqs_were_disabled);
                else if (list_empty(&sup->work.work.entry))
                        list_add(&sup->work.work.entry, &srcu_boot_list);
        }
