Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FCF270552
	for <rcu@vger.kernel.org>; Thu, 19 Mar 2026 01:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773882505; cv=none; b=Bcvq4wpe0qojELGuyXn69dThon0sYLA5ZmxcMwi9tDoUJC+OPMq2g+9OoBENBuTVQFra54kTM4rhime9CFAXlwiqXDBar0hqr3U4Ctogz31otKKqjc+lljbulfPCA1QBkg96VRgOQ4tbu4Y0ePEDa/KXuYjlh7gUhCSrz0nAKZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773882505; c=relaxed/simple;
	bh=O+VSVSvxxWuh4XzJxdiIQm42M+cUuSFQGSHtafVJ7NA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jaCG1pByuH4tZPFAwbNVcXAXxumhXvpFhcIABC/2OyN+cJFISy20PLY4Bdt0EdUexKxME+pekYug61bszYa+CvNC8TLvfKiZfQriGezQCKeetCI2zZ4RA3a0+EQ+ndb5IiEoUreWhOXbsMxHGdZogKaKS65oHx2zoR8lDLpNbEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUwAuD2Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUwAuD2Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B40EC2BCB0;
	Thu, 19 Mar 2026 01:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773882505;
	bh=O+VSVSvxxWuh4XzJxdiIQm42M+cUuSFQGSHtafVJ7NA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OUwAuD2ZCzf6pz4t5cT7aDaTckiekKL1cNO4wVzJXG4siKikf5MrcGeg1ck8Jbicp
	 j64MghrFWU97mlO/aSVHHNRDpH6eRVYnuOgArPBEvL75TPOwo0rjXuzDFo4AjyAQ6z
	 wgSZrGviD8AX4SinrrSMriVNMKvkFueTTCwvoP3BtoTl4ER/PyJWxwEWh5mVX21Xpf
	 epBxecYHNytPDF/hTn6cCgaDja5FywZK4G8EIB3YeYIKDh/L/eO2gu5wSQCacWUU0q
	 Kr+NPKTQgRnY7BJhBZtkekw3pdigXU82pjNtiM8MTqn3miT0KkryE8EEQJYL5j5Hdt
	 J3nmEgGD/KUhA==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id B707BF40069;
	Wed, 18 Mar 2026 21:08:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 18 Mar 2026 21:08:23 -0400
X-ME-Sender: <xms:h0y7aR0wovlLHOVMfjxJVRamDEqxy43k8AaPIhg3bBFBpsoBi3itZA>
    <xme:h0y7aQSbdkQ0AHwD468RYjZyIgMd8hoD6qEfBqfPMnrY9WB7LMXc44jHv6TTpBBmq
    lANkAfu0I61st4imM4jKQHSKQ7ezD40VP9zaEzSMdflqvTb5DOpCUY>
X-ME-Received: <xmr:h0y7adda8J6FZtzdmrbZq2Pj1BhKzUloiwDu92hdWRnjG00Y2SiHpAaAdC5AEgXbvOpGdu90oKvajVCjzBn3TCy07er6-ibh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdehieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnsehkvghrnhgvlhdr
    ohhrgheqnecuggftrfgrthhtvghrnhepleeuheethfdttdfgjedvjeeuhefhkeetveeuue
    eukeegteeigeeghedvffehhffhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnod
    hmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdelkeegjeduqddujeej
    keehheehvddqsghoqhhunheppehkvghrnhgvlhdrohhrghesfhhigihmvgdrnhgrmhgvpd
    hnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhho
    vghlrghgnhgvlhhfsehnvhhiughirgdrtghomhdprhgtphhtthhopehprghulhhmtghkse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegsihhgvggrshihsehlihhnuhhtrhhonhhi
    gidruggvpdhrtghpthhtohepfhhrvgguvghrihgtsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehnvggvrhgrjhdrihhithhruddtsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    uhhrvgiikhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgse
    hgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehmvghmgihorhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:h0y7aZddoDCNNGEwAVHXts95QiK54YmBWu7wzu1H2Y_6c7Si1LBDAw>
    <xmx:h0y7af3G3_gDaFvnYm1Ru8OBUmZDsIR5HNDvJpHGkw-ryRnoBGl3JA>
    <xmx:h0y7aZ_aL9It5fOltwgKCMl_s7ATATuFQO_ldCoFiZYxEM8r7RS-ag>
    <xmx:h0y7ac4KKrkneGeFR1kuUj7_YfMWM5Gd1yNsGzdYgw9nX6a-c7nKiw>
    <xmx:h0y7aZsYtfPRhpVhy0eVjcssdWSK1asI2M8l_bVMa88CeT4p15Anh5iA>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Mar 2026 21:08:22 -0400 (EDT)
Date: Wed, 18 Mar 2026 18:08:21 -0700
From: Boqun Feng <boqun@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: paulmck@kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
	boqun.feng@gmail.com, rcu@vger.kernel.org,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tejun Heo <tj@kernel.org>
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace +
 PREEMPT_RT
Message-ID: <abtMhd_LVp3uL_pA@tardis.local>
References: <b33d2dc2-7ccf-4524-a846-95c2b64fe117@paulmck-laptop>
 <20260318144305.xI6RDtzk@linutronix.de>
 <abrJ9C637V6keRvd@tardis.local>
 <214fb140-041d-4fd1-8694-658547209b84@paulmck-laptop>
 <3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com>
 <absesPf-10awctq9@tardis.local>
 <absfZGD3en9TUA1U@tardis.local>
 <absj6rZbyLZY8PPz@tardis.local>
 <da4313b1-9ff5-46e9-b3b7-206dbcb72602@nvidia.com>
 <abs026TUV9oAg_Xy@tardis.local>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abs026TUV9oAg_Xy@tardis.local>

On Wed, Mar 18, 2026 at 04:27:23PM -0700, Boqun Feng wrote:
> On Wed, Mar 18, 2026 at 06:52:53PM -0400, Joel Fernandes wrote:
> > 
> > 
> > On 3/18/2026 6:15 PM, Boqun Feng wrote:
> > > On Wed, Mar 18, 2026 at 02:55:48PM -0700, Boqun Feng wrote:
> > >> On Wed, Mar 18, 2026 at 02:52:48PM -0700, Boqun Feng wrote:
> > >> [...]
> > >>>> Ah so it is an ABBA deadlock, not a ABA self-deadlock. I guess this is a
> > >>>> different issue, from the NMI issue? It is more of an issue of calling
> > >>>> call_srcu  API with scheduler locks held.
> > >>>>
> > >>>> Something like below I think:
> > >>>>
> > >>>>   CPU A (BPF tracepoint)                CPU B (concurrent call_srcu)
> > >>>>   ----------------------------         ------------------------------------
> > >>>>   [1] holds  &rq->__lock
> > >>>>                                         [2]
> > >>>>                                         -> call_srcu
> > >>>>                                         -> srcu_gp_start_if_needed
> > >>>>                                         -> srcu_funnel_gp_start
> > >>>>                                         -> spin_lock_irqsave_ssp_content...
> > >>>> 					  -> holds srcu locks
> > >>>>
> > >>>>   [4] calls  call_rcu_tasks_trace()      [5] srcu_funnel_gp_start (cont..)
> > >>>>                                                  -> queue_delayed_work
> > >>>>           -> call_srcu()                         -> __queue_work()
> > >>>>           -> srcu_gp_start_if_needed()           -> wake_up_worker()
> > >>>>           -> srcu_funnel_gp_start()              -> try_to_wake_up()
> > >>>>           -> spin_lock_irqsave_ssp_contention()  [6] WANTS  rq->__lock
> > >>>>           -> WANTS srcu locks
> > >>>
> > >>> I see, we can also have a self deadlock even without CPU B, when CPU A
> > >>> is going to try_to_wake_up() the a worker on the same CPU.
> > >>>
> > >>> An interesting observation is that the deadlock can be avoided in
> > >>> queue_delayed_work() uses a non-zero delay, that means a timer will be
> > >>> armed instead of acquiring the rq lock.
> > >>>
> > > 
> > > If my observation is correct, then this can probably fix the deadlock
> > > issue with runqueue lock (untested though), but it won't work if BPF
> > > tracepoint can happen with timer base lock held.
> > > 
> > > Regards,
> > > Boqun
> > > 
> > > ------>
> > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > index 2328827f8775..a5d67264acb5 100644
> > > --- a/kernel/rcu/srcutree.c
> > > +++ b/kernel/rcu/srcutree.c
> > > @@ -1061,6 +1061,7 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
> > >         struct srcu_node *snp_leaf;
> > >         unsigned long snp_seq;
> > >         struct srcu_usage *sup = ssp->srcu_sup;
> > > +       bool irqs_were_disabled;
> > > 
> > >         /* Ensure that snp node tree is fully initialized before traversing it */
> > >         if (smp_load_acquire(&sup->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
> > > @@ -1098,6 +1099,7 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
> > > 
> > >         /* Top of tree, must ensure the grace period will be started. */
> > >         raw_spin_lock_irqsave_ssp_contention(ssp, &flags);
> > > +       irqs_were_disabled = irqs_disabled_flags(flags);
> > >         if (ULONG_CMP_LT(sup->srcu_gp_seq_needed, s)) {
> > >                 /*
> > >                  * Record need for grace period s.  Pair with load
> > > @@ -1118,9 +1120,16 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
> > >                 // it isn't.  And it does not have to be.  After all, it
> > >                 // can only be executed during early boot when there is only
> > >                 // the one boot CPU running with interrupts still disabled.
> > > +               //
> > > +               // If irq was disabled when call_srcu() is called, then we
> > > +               // could be in the scheduler path with a runqueue lock held,
> > > +               // delay the process_srcu() work 1 more jiffies so we don't go
> > > +               // through the kick_pool() -> wake_up_process() path below, and
> > > +               // we could avoid deadlock with runqueue lock.
> > >                 if (likely(srcu_init_done))
> > >                         queue_delayed_work(rcu_gp_wq, &sup->work,
> > > -                                          !!srcu_get_delay(ssp));
> > > +                                          !!srcu_get_delay(ssp) +
> > > +                                          !!irqs_were_disabled);
> > Nice, I wonder if it is better to do this in __queue_delayed_work() itself.
> > Do we have queue_delayed_work() with zero delays that are in irq-disabled
> > regions, and they depend on that zero-delay for correctness? Even with
> > delay of 0 though, the work item doesn't execute right away anyway, the
> > worker thread has to also be scheduler right?
> > 
> > Also if IRQ is disabled, I'd think this is a critical path that is not
> > wanting to run the work item right-away anyway since workqueue is more a
> > bottom-half mechanism, than "run this immediately".
> > 
> > IOW, would be good to make the workqueue-layer more resilient to waking up
> > the scheduler when a delay would have been totally ok. But maybe +Tejun can
> > yell if that sounds insane.
> > 
> 
> I think all of these are probably a good point. However my fix is not
> complete :( It's missing the ABBA case in your example (it obviously
> could solve the self deadlock if my observation is correct), because we
> will still build rcu_node::lock -> runqueue::lock in some conditions,
> and BPF contributes the runqueue::lock -> rcu_node::lock dependency.
> Hence we still have ABBA deadlock.
> 
> To remove the rcu_node::lock -> runqueue::lock entirely, we need to
> always delay 1+ jiffies:
> 

Hmm.. or I can do as the old call_rcu_tasks_trace() does: using an
irq_work. I also pushed it at:

	https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git/ srcu-fix

(based on Paul's fix on spinlock already, but only lightly build test).

Regards,
Boqun

-------------------------->8
Subject: [PATCH] rcu: Use an intermediate irq_work to start process_srcu()

Since commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms
of SRCU-fast") we switched to SRCU in BPF. However as BPF instrument can
happen basically everywhere (including where a scheduler lock is held),
call_srcu() now needs to avoid acquiring scheduler lock because
otherwise it could cause deadlock [1]. Fix this by following what the
previous RCU Tasks Trace did: using an irq_work to delay the queuing of
the work to start process_srcu().

Fixes: commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")
Link: https://lore.kernel.org/rcu/3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com/ [1]
Signed-off-by: Boqun Feng <boqun@kernel.org>
---
 include/linux/srcutree.h |  1 +
 kernel/rcu/srcutree.c    | 22 ++++++++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index b122c560a59c..fd1a9270cb9a 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -95,6 +95,7 @@ struct srcu_usage {
 	unsigned long reschedule_jiffies;
 	unsigned long reschedule_count;
 	struct delayed_work work;
+	struct irq_work irq_work;
 	struct srcu_struct *srcu_ssp;
 };
 
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 2328827f8775..57116635e72d 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -19,6 +19,7 @@
 #include <linux/mutex.h>
 #include <linux/percpu.h>
 #include <linux/preempt.h>
+#include <linux/irq_work.h>
 #include <linux/rcupdate_wait.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
@@ -75,6 +76,7 @@ static bool __read_mostly srcu_init_done;
 static void srcu_invoke_callbacks(struct work_struct *work);
 static void srcu_reschedule(struct srcu_struct *ssp, unsigned long delay);
 static void process_srcu(struct work_struct *work);
+static void srcu_irq_work(struct irq_work *work);
 static void srcu_delay_timer(struct timer_list *t);
 
 /*
@@ -216,6 +218,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	mutex_init(&ssp->srcu_sup->srcu_barrier_mutex);
 	atomic_set(&ssp->srcu_sup->srcu_barrier_cpu_cnt, 0);
 	INIT_DELAYED_WORK(&ssp->srcu_sup->work, process_srcu);
+	init_irq_work(&ssp->srcu_sup->irq_work, srcu_irq_work);
 	ssp->srcu_sup->sda_is_static = is_static;
 	if (!is_static) {
 		ssp->sda = alloc_percpu(struct srcu_data);
@@ -1118,9 +1121,13 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 		// it isn't.  And it does not have to be.  After all, it
 		// can only be executed during early boot when there is only
 		// the one boot CPU running with interrupts still disabled.
+		//
+		// Use an irq_work here to avoid acquiring runqueue lock with
+		// srcu rcu_node::lock held. BPF instrument could introduce the
+		// opposite dependency, hence we need to break the possible
+		// locking dependency here.
 		if (likely(srcu_init_done))
-			queue_delayed_work(rcu_gp_wq, &sup->work,
-					   !!srcu_get_delay(ssp));
+			irq_work_queue(&sup->irq_work);
 		else if (list_empty(&sup->work.work.entry))
 			list_add(&sup->work.work.entry, &srcu_boot_list);
 	}
@@ -1979,6 +1986,17 @@ static void process_srcu(struct work_struct *work)
 	srcu_reschedule(ssp, curdelay);
 }
 
+static void srcu_irq_work(struct irq_work *work)
+{
+	struct srcu_struct *ssp;
+	struct srcu_usage *sup;
+
+	sup = container_of(work, struct srcu_usage, irq_work);
+	ssp = sup->srcu_ssp;
+
+	queue_delayed_work(rcu_gp_wq, &sup->work, !!srcu_get_delay(ssp));
+}
+
 void srcutorture_get_gp_data(struct srcu_struct *ssp, int *flags,
 			     unsigned long *gp_seq)
 {
-- 
2.50.1 (Apple Git-155)

