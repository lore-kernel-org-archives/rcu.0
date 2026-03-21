Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE15339856
	for <rcu@vger.kernel.org>; Sat, 21 Mar 2026 18:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774116912; cv=none; b=L5Q8BB/YP0YPhqPUJGKv9C/u6j4MeQgIJvdDNhJUDN0ti3C7LSikvXiPMAnHF8nXwJu+B4svK8LKw6BYlHqRLLo1U2eGpfrjoSVRo5IFQnGzGEv1BkIMuLD8CrarXO7EyEVnZxuFxH4/gZdk8xxLt8CfF6C5sWOjBFTCLFZCyQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774116912; c=relaxed/simple;
	bh=T54Pwv/TFW0Q8asb5l1/9TUNyIYDQWrse9kNShvNPX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXnpvpYywCeMws/tHr2JC/9O/e8ELNLW9HdNz6xZYAvB03/65lDVj3PbRgoKJE7m7V1XCc9j6Y15LmWelC+B+pmIZr5oEJ7R20Q8cW9whGf/zJpEWPQWpDWICDe/8bkrWfh1OYcxASfxDsmhaLTkSTLWWW4BsLlwyIhTAIrt2bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUj34A6T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUj34A6T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574FDC2BCB1;
	Sat, 21 Mar 2026 18:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774116911;
	bh=T54Pwv/TFW0Q8asb5l1/9TUNyIYDQWrse9kNShvNPX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bUj34A6TJVaDi08VMZjLmRcXnSnoxTj7ju44bnoDucbKc6feauWUvminwKd62LQCx
	 X+/8TtCb0oTfCdDQVAAHq4Tj+zXhD4HQjqBu5FJAHBJ7q1Wv/uAlspq4z3CTnIITE4
	 qIRGF8pjjGKq5AvjAUSlBbN7TM1JuYfSCUrf7wFxUsoYD1uMfH6GDM8RGhKWBrPzDf
	 8WerIRDJXngLRKH4ELcJiw0ex5ot5k8hAVUHMRfdJxELHt5/025HkGXAZcUOxGOvZT
	 GiMcwWJgfmNQgm3wygCs+Xxzrh+EAnqSe8w7tVSKoFB7Ki8SJEqT0ccwiv0xEiJG1Z
	 CsaaaPCl2vuvA==
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 607A5F40075;
	Sat, 21 Mar 2026 14:15:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Sat, 21 Mar 2026 14:15:10 -0400
X-ME-Sender: <xms:LuC-aUU6nbUd2dFyV38hmogk6h1pQdlwUwtxnpaXqy9UoLVxhBTWZg>
    <xme:LuC-aR8ZTvWKaWuAcIx43WM8DbPKl557Gl82qy5wZ9ues8rJrsi1ll6uWu4-aaf3N
    JJ9jVFteKN_CgyyDZUHQ7gwxMraicrtgNfwXPcuvDofXHIKNZvs8g>
X-ME-Received: <xmr:LuC-aQ7KZXcvacBipTGYZVzaoHj3zwJHxVqwSiSx9AAYlw9KL_K2Z0xF3mQmWQqD8WIacylD_55ND79Ur3awg4ZaY6vFHCGj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudefheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    elueehtefhtddtgfejvdejueehhfekteevueeuueekgeetieeggeehvdffhefhhfenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhn
    rghlihhthidqudeijedtleekgeejuddqudejjeekheehhedvqdgsohhquhhnpeepkhgvrh
    hnvghlrdhorhhgsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehqihgrnhhgrdiihhgrnhhgsehlihhnuhigrd
    guvghvpdhrtghpthhtohepjhhovghlrghgnhgvlhhfsehnvhhiughirgdrtghomhdprhgt
    phhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvghmgi
    horhesghhmrghilhdrtghomhdprhgtphhtthhopegsihhgvggrshihsehlihhnuhhtrhho
    nhhigidruggvpdhrtghpthhtohepfhhrvgguvghrihgtsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehnvggvrhgrjhdrihhithhruddtsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepuhhrvgiikhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghoqhhunhdrfhgvnh
    hgsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:LuC-aS0aAO9znplrsCsAskJAj1VseejhksY4lqvxyqf0xLD0XhGWQQ>
    <xmx:LuC-afyYuOCSlsvNyj7CBEuwKy3NkAf57S9JZqtJeEV6xUfsUpftKA>
    <xmx:LuC-aTlV3cW11F3xRB_eDv5kMQPo7_SvjEfYivPYW00yxecBWd1TGg>
    <xmx:LuC-aa8hUNLH58HK--eakfMgZYkm_tFtT26mcKU6Y4GPkMp2YR4goQ>
    <xmx:LuC-aWpQ-qIf55TC895tu6pfpAgL2sU_qxcJL9ev48d79kQJGICMGG1N>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Mar 2026 14:15:09 -0400 (EDT)
Date: Sat, 21 Mar 2026 11:15:08 -0700
From: Boqun Feng <boqun@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
	boqun.feng@gmail.com, rcu@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrea Righi <arighi@nvidia.com>
Subject: Re: [PATCH] rcu: Use an intermediate irq_work to start process_srcu()
Message-ID: <ab7gLPXTTM7m4AJj@tardis.local>
References: <2d9e7e42-8667-4880-9708-b81a82443809@nvidia.com>
 <20260320181400.15909-1-boqun@kernel.org>
 <4c23c66f86a2aff8f2d7b759f9dd257b82147a17@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c23c66f86a2aff8f2d7b759f9dd257b82147a17@linux.dev>

On Sat, Mar 21, 2026 at 04:27:02AM +0000, Zqiang wrote:
> > 
> > Since commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms
> > of SRCU-fast") we switched to SRCU in BPF. However as BPF instrument can
> > happen basically everywhere (including where a scheduler lock is held),
> > call_srcu() now needs to avoid acquiring scheduler lock because
> > otherwise it could cause deadlock [1]. Fix this by following what the
> > previous RCU Tasks Trace did: using an irq_work to delay the queuing of
> > the work to start process_srcu().
> > 
> > [boqun: Apply Joel's feedback]
> > 
> > Reported-by: Andrea Righi <arighi@nvidia.com>
> > Closes: https://lore.kernel.org/all/abjzvz_tL_siV17s@gpd4/
> > Fixes: commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")
> > Link: https://lore.kernel.org/rcu/3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com/ [1]
> > Suggested-by: Zqiang <qiang.zhang@linux.dev>
> > Signed-off-by: Boqun Feng <boqun@kernel.org>
> > ---
> > @Zqiang, I put your name as Suggested-by because you proposed the same
> > idea, let me know if you rather not have it.
> 
> Thanks Boqun add me to Suggested-by :) .
> 

No problem.

> > 
> > @Joel, I did two updates (including your test feedback, other one is
> > call irq_work_sync() when we clean the srcu_struct), please give it a
> > try.
> > 
> >  include/linux/srcutree.h | 1 +
> >  kernel/rcu/srcutree.c | 29 +++++++++++++++++++++++++++--
> >  2 files changed, 28 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> > index dfb31d11ff05..be76fa4fc170 100644
> > --- a/include/linux/srcutree.h
> > +++ b/include/linux/srcutree.h
> > @@ -95,6 +95,7 @@ struct srcu_usage {
> >  unsigned long reschedule_jiffies;
> >  unsigned long reschedule_count;
> >  struct delayed_work work;
> > + struct irq_work irq_work;
> >  struct srcu_struct *srcu_ssp;
> >  };
> >  
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 2328827f8775..73aef361a524 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/mutex.h>
> >  #include <linux/percpu.h>
> >  #include <linux/preempt.h>
> > +#include <linux/irq_work.h>
> >  #include <linux/rcupdate_wait.h>
> >  #include <linux/sched.h>
> >  #include <linux/smp.h>
> > @@ -75,6 +76,7 @@ static bool __read_mostly srcu_init_done;
> >  static void srcu_invoke_callbacks(struct work_struct *work);
> >  static void srcu_reschedule(struct srcu_struct *ssp, unsigned long delay);
> >  static void process_srcu(struct work_struct *work);
> > +static void srcu_irq_work(struct irq_work *work);
> >  static void srcu_delay_timer(struct timer_list *t);
> >  
> >  /*
> > @@ -216,6 +218,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
> >  mutex_init(&ssp->srcu_sup->srcu_barrier_mutex);
> >  atomic_set(&ssp->srcu_sup->srcu_barrier_cpu_cnt, 0);
> >  INIT_DELAYED_WORK(&ssp->srcu_sup->work, process_srcu);
> > + init_irq_work(&ssp->srcu_sup->irq_work, srcu_irq_work);
> >  ssp->srcu_sup->sda_is_static = is_static;
> >  if (!is_static) {
> >  ssp->sda = alloc_percpu(struct srcu_data);
> > @@ -713,6 +716,8 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
> >  return; /* Just leak it! */
> >  if (WARN_ON(srcu_readers_active(ssp)))
> >  return; /* Just leak it! */
> > + /* Wait for irq_work to finish first as it may queue a new work. */
> > + irq_work_sync(&sup->irq_work);
> >  flush_delayed_work(&sup->work);
> >  for_each_possible_cpu(cpu) {
> >  struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
> > @@ -1118,9 +1123,13 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
> 
> 
> The following should also be replaced, although under normal situation,
> we wouldn't go here:
> 
> if (snp == snp_leaf && snp_seq != s) {
>       srcu_schedule_cbs_sdp(sdp, do_norm ? SRCU_INTERVAL : 0);
>       return;
> }
> 

Sigh, another mole to whack... this one is less fatal since we don't
call it with rcu node lock:

	raw_spin_unlock_irqrestore_rcu_node(snp, flags);
	if (snp == snp_leaf && snp_seq != s) {
		srcu_schedule_cbs_sdp(sdp, do_norm ? SRCU_INTERVAL : 0);
		return;
	}

but the operation is per srcu_data, so we may need per srcu_data (a
hacky way is that we compare with rcu_tasks_trace_srcu_struct and have
only one percpu irq_work for rcu_tasks_trace_srcu_struct).

Note that if we may the delay always >0, then we can dodge the pi->lock
(or the pool->lock as we recently discovered). But we will still have a
timer base lock in call_srcu(). Depending on whether it's considered as
a bug per BPF (we have the issue in v6.19 as well, see [1]). If [1] is
not considered as a bug, then I think we can just fix the issue by an
always positive delay. Otherwise, bring your mallet, we may have more
moles to whack. ;-)

[1]: https://lore.kernel.org/rcu/20260321170321.32257-1-boqun@kernel.org/

Regards,
Boqun

> Thanks
> Zqiang
> 
> 
> 
> 
> >  // it isn't. And it does not have to be. After all, it
> >  // can only be executed during early boot when there is only
> >  // the one boot CPU running with interrupts still disabled.
> > + //
> > + // Use an irq_work here to avoid acquiring runqueue lock with
> > + // srcu rcu_node::lock held. BPF instrument could introduce the
> > + // opposite dependency, hence we need to break the possible
> > + // locking dependency here.
> >  if (likely(srcu_init_done))
> > - queue_delayed_work(rcu_gp_wq, &sup->work,
> > - !!srcu_get_delay(ssp));
> > + irq_work_queue(&sup->irq_work);
> >  else if (list_empty(&sup->work.work.entry))
> >  list_add(&sup->work.work.entry, &srcu_boot_list);
> >  }
> > @@ -1979,6 +1988,22 @@ static void process_srcu(struct work_struct *work)
> >  srcu_reschedule(ssp, curdelay);
> >  }
> >  
> > +static void srcu_irq_work(struct irq_work *work)
> > +{
> > + struct srcu_struct *ssp;
> > + struct srcu_usage *sup;
> > + unsigned long delay;
> > +
> > + sup = container_of(work, struct srcu_usage, irq_work);
> > + ssp = sup->srcu_ssp;
> > +
> > + raw_spin_lock_irq_rcu_node(ssp->srcu_sup);
> > + delay = srcu_get_delay(ssp);
> > + raw_spin_unlock_irq_rcu_node(ssp->srcu_sup);
> > +
> > + queue_delayed_work(rcu_gp_wq, &sup->work, !!delay);
> > +}
> > +
> >  void srcutorture_get_gp_data(struct srcu_struct *ssp, int *flags,
> >  unsigned long *gp_seq)
> >  {
> > -- 
> > 2.50.1 (Apple Git-155)
> >
