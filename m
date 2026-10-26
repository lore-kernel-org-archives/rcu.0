Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793057466;
	b=Lk6rPF4FlAui6n7AmaEa/pSrf7NiuogO0NyJLmcOybMsjqqMnRk4o2PWDopNnWWP7lmT
	 b2leI6Q1SrDwIeKWG3Iq1Zt9Q0Zv89Rrx7nUPLAVTuAF3R2xK2HJ2G/NEdfglTbScPJAG
	 ZR5WAi6w7xMR7n+6kkZGqDrgcPjmrx87JuwO1tckgctC5GzxAAlhpyD2IOBzyF71EaGYK
	 cSk0RWeNHJUVUN3TyGkki73b07v3IFoFlx23GFkHiknq5ZNA9gjoSq+CAn51uVTI3Bo3B
	 aZ3XLBVwxO1UwNh8KZNAqp6k9S+3OVAWPF0zZkxxKemdTZ/N9OzdWfm47EAzsJo3KCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057466;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=BXMaxfxl8pUfKyjU+RYdBrxevhEHCmwAm3DkCRJuUXM=;
	b=VK1JC2AGddsJZXTvCILXFsu2rlc97mmhP/6IIfA404ZVFtOUhjnJacpU7KFt3sQYTv66
	 iGnFd2et2+QrJ8FsTQIntBHSPYYY0ntGQQSoQb4/t57o071NGq8hNE8crKu1ExYSfPiI/
	 OXEEva5duRCpX0Bg3PADxrGZsE2caNLtgaUgNPLzmGmiwm6fsqBKz2jBBt/+pNzRX+jkt
	 q0JCiyipSrDcEs2XQe2ebwsmTbOFz7m699hdLexmeRMINmxNE2z/FXCo6LMOi4wG3KMU+
	 wDSQfDlws+9yqW/gtaRFBPUNNPgdsHPPQi4V3pWoMLT/wytG/7ZQhe7zVmsf30sfbWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b827CWyl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CF3606A323;
	Mon, 26 Oct 2026 23:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b827CWyl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF101F031E0;
	Mon, 26 Oct 2026 23:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793057466;
	bh=BXMaxfxl8pUfKyjU+RYdBrxevhEHCmwAm3DkCRJuUXM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=b827CWyl3P7PTW++NzPzVAN4jcqAt1OMlwu3Tg4YdVJZHb+t3k6vkPdataGUHC09H
	 m5uQjB9F/3YYYC2eIakeohWLgXrBMDbRf9xqVel5D8pwiPsvFCkSYDSrzAJi5FdbI0
	 X2h/JDXw7wymz0h+4g2s4f8SzJP7Tmpnf5/fXzo9iWw9O3s2zAIzQYINpwRLkty60B
	 H34hzkXG+djeZcKcE1ndF9LWu1Jh3vNDmq0wOmjmWLprtvJTGF8bTGojj7HNAyN6r7
	 FaUTgi4vbpouFmDaHeQM0agJtbU4gt/ECf3ntna2xYtvU92+EzqSXo9OjMcQTOVPiB
	 RBuCrmeXavPaA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2F65ACE0C35; Mon, 26 Oct 2026 16:31:06 -0700 (PDT)
Date: Mon, 26 Oct 2026 16:31:06 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: KunWu Chan <kunwu.chan@gmail.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, work@onurozkan.dev,
	frederic@kernel.org, neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com, boqun@kernel.org, urezki@gmail.com,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	qiang.zhang@linux.dev, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH 7/9] srcu: Detect duplicate callback enqueue at
 registration
Message-ID: <c259fb39-153a-41f2-9d82-cba4255e65e8@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261023101841.2910719-1-kunwu.chan@gmail.com>
 <20261023101841.2910719-8-kunwu.chan@gmail.com>
 <60e6148e-b7e1-4f2f-a665-24567305956f@paulmck-laptop>
 <b5c84b27-5e66-44f1-b95a-d7c1655df69d@paulmck-laptop>
 <CAN_Opa9MvTvLemY5DYNHu-yXy9xZvJJiLXigknP-qM=bK0Xw7w@mail.gmail.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN_Opa9MvTvLemY5DYNHu-yXy9xZvJJiLXigknP-qM=bK0Xw7w@mail.gmail.com>

On Mon, Oct 26, 2026 at 10:35:02AM +0800, KunWu Chan wrote:
> Thanks Paul for the detailed review.
> 
> On Sat, Oct 24, 2026 at 3:38 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Fri, Oct 23, 2026 at 12:30:57PM -0700, Paul E. McKenney wrote:
> > > On Fri, Oct 23, 2026 at 06:18:39PM +0800, Kunwu Chan wrote:
> > > > Move the duplicate-callback check from srcu_do_enqueue() to
> > > > __call_srcu() entry so that detected duplicate registrations
> > > > are rejected before they reach the deferred-list enqueue path.
> > > > Report the callback address, function symbol, and object
> > > > information, rate-limited to the first three occurrences.
> > > >
> > > > Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> > >
> > > Getting the stackof the call_srcu() once double-enqueue is detected
> > > would be a very good thing!
> 
> I'm also working on the rcutorture support and will send it out separately.

Looking forward to it!

							Thanx, Paul

> > > One question below.
> > >
> > > > ---
> > > >  kernel/rcu/srcutree.c | 20 ++++++++++++++------
> > > >  1 file changed, 14 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > > index 1993ddbdb828..3838d9fdf532 100644
> > > > --- a/kernel/rcu/srcutree.c
> > > > +++ b/kernel/rcu/srcutree.c
> > > > @@ -27,6 +27,7 @@
> > > >  #include <linux/smp.h>
> > > >  #include <linux/delay.h>
> > > >  #include <linux/module.h>
> > > > +#include <linux/mm.h>
> > > >  #include <linux/slab.h>
> > > >  #include <linux/srcu.h>
> > > >
> > > > @@ -1511,12 +1512,6 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
> > > >  static void srcu_do_enqueue(struct srcu_struct *ssp, struct rcu_head *rhp,
> > > >                         rcu_callback_t func, bool do_norm)
> > > >  {
> > > > -   if (debug_rcu_head_queue(rhp)) {
> > > > -           /* Probable double call_srcu(), so leak the callback. */
> > > > -           WRITE_ONCE(rhp->func, srcu_leak_callback);
> > > > -           WARN_ONCE(1, "call_srcu(): Leaked duplicate callback\n");
> > > > -           return;
> > > > -   }
> > > >     rhp->func = func;
> > > >     (void)srcu_gp_start_if_needed(ssp, rhp, do_norm);
> > > >  }
> > > > @@ -1529,6 +1524,8 @@ static void srcu_do_enqueue(struct srcu_struct *ssp, struct rcu_head *rhp,
> > > >  static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
> > > >                     rcu_callback_t func, bool do_norm)
> > > >  {
> > > > +   static atomic_t doublefrees;
> > > > +
> > > >     /* Misaligned rcu_head! */
> > > >     WARN_ON_ONCE((unsigned long)rhp & (sizeof(void *) - 1));
> > > >
> > > > @@ -1539,6 +1536,16 @@ static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
> > > >     if (WARN_ON_ONCE(ssp->srcu_reader_flavor == SRCU_READ_FLAVOR_ATOMIC))
> > > >             return; // Leak the callback rather than corrupt SRCU state.
> > > >
> > > > +   if (debug_rcu_head_queue(rhp)) {
> > > > +           if (atomic_inc_return(&doublefrees) < 4) {
> > >
> > > Why this hard-coded 4?  Why not 3 or 5?  Should this be adjustable via
> > > Kconfig or kernel boot parameter?  Or, alternatively, should the below
> > > pr_err() instead be pr_err_ratelimited()?
> 
> Regarding the hard-coded limit, I followed the existing code in tree.c when
> choosing 4. Thanks for pointing this out. I'll switch to pr_err_ratelimited()
> in v2 and make the same change in tree.c as well, so the two paths are
> consistent.
> > >
> > > > +                   pr_err("%s(): Duplicate call_srcu() CB %p->%pS()\n",
> > > > +                          __func__, rhp, rhp->func);
> > > > +                   mem_dump_obj(rhp);
> > >
> > > Does any of this automatically dump out the stack that was recorded
> > > in earlier patches in this series?
> >
> 
> I'll also add dump_stack() to all three duplicate-enqueue patches
> to capture the current stack when a duplicate is detected.
> 
> > As in shouldn't there be a kasan_print_aux_stacks() in there somewhere?
> > I did not see an call from mem_dump_obj(), but I could easily have
> > missed it.
> >
> 
> As for kasan_print_aux_stacks(), as mentioned in my reply to patch 1,
> it is called by the existing KASAN report path, which prints the auxiliary
> stack recorded by patches 1-3. It does not need to be called directly
> from these patches.
> 
> Thanks,
> Kunwu
> 
> >                                                         Thanx, Paul
> >
> > > > +           }
> > > > +           WRITE_ONCE(rhp->func, srcu_leak_callback);
> > > > +           return;
> > > > +   }
> > > > +
> > > >     /* Record the caller: the irq_work's stack says nothing about it. */
> > > >     kasan_record_aux_stack(rhp);
> > > >
> > > > @@ -1554,6 +1561,7 @@ static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
> > > >             if (READ_ONCE(sndp->draining) && !in_nmi()) {
> > > >                     WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU),
> > > >                               "call_srcu() re-entered during callback drain; leaking callback\n");
> > > > +                   debug_rcu_head_unqueue(rhp);
> > > >                     return;
> > > >             }
> > > >             sdp = this_cpu_ptr(ssp->sda);
> > > > --
> > > > 2.43.0
> > > >
