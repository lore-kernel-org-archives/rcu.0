Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17BE30F7EF
	for <rcu@vger.kernel.org>; Sat, 21 Mar 2026 17:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774112618; cv=none; b=TuuO7gNiGSEj8I0ovJ8LknpOqG4n4zi4g5jS+BtSuz10MhhlB2rOGbEJYVHePs8o0DPaATazfwQUqVl8Y2yjGxJvn7ZpY+pzDiA+p2o9Xgy5wWhAzDWx7iJ3iDm+I+ke1NCEY8I9cquT41Khl1LVYw3EgY1sLhQ21rYwOC3Ss1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774112618; c=relaxed/simple;
	bh=aKu1NOn8rI3OQAPyUcf60IA4nZ5OFtnbZuOCr2dtvyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aecF36y+rHputMoPkG0IkgasXNdBPtKI5jdmXgvd9/WYIytMRo5pPWwiCvWM2pjY2n/s1wWUuhFFJXfqHdHThRN8yaWxI9MtQnb4Vw5qLdFPqd8C3DnNNwZX2s7H1MT+zeRAokaR9RQCUWmLPLx1Os4tPWBxc9OIiuV5d2pbFyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/uIGAaT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/uIGAaT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13829C4AF09;
	Sat, 21 Mar 2026 17:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774112617;
	bh=aKu1NOn8rI3OQAPyUcf60IA4nZ5OFtnbZuOCr2dtvyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p/uIGAaTDpf9GaXvsM/ZUBZBaJ7r022I2qaFQXmYa+PFMLd7j3lpmzCNN8C7TSn4g
	 H4d3fIR/2uxxHHVc4BXhCEgdx4zXP5ujkaG1/FfFxQQKSd8J3JRMSPHaQ3NhYBVhce
	 4/ykKQIQeeJod8njNWmjwpLFAemAFzvBaSlMDWB4sv0vHmtU3afgFlkhAf7sIGa0Ke
	 iKa8Fe9TPxmsrrnI5K0oQlu1QKQFbSNF0diNM7L7aktnI6mdrSgpAxdM9n4GJPGf2J
	 4PGvpv+En+ohgfxS2snyyWD8pMYUKhbffGTTdxjAn56KzmmpOKhcAYyI7zF/24ZiAD
	 BcQt08q6O0skw==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 08C2FF4008C;
	Sat, 21 Mar 2026 13:03:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sat, 21 Mar 2026 13:03:36 -0400
X-ME-Sender: <xms:Z8--aeFioDm6heKlcFRsALWn1hHfJOdplnoeFlge83GTOPsb7a6aQA>
    <xme:Z8--aYuL8rhnS4E2YJEH_bcFwYZZ2KbpO-9z41GYor-ZrT9qi5bBxeoIzCeUXErD3
    08JbyfeHSQXVJslsN_GSWFLqw4yW-zQynzbEWSyHFgMZYDia3gpLw>
X-ME-Received: <xmr:Z8--aQqKx6YGQp661TWXOgcD0X9crDDh0KlorJauLc78GHEbitYAoDjqCdnm6p8vbLMD92GKGImzC7L1Q99xbIwQTxjggzJt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudefgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    eikeeggfdvffevteduudduffettedufffhueejleeffeelhfdvvdefledtveetgeenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhht
    phgruhhthhhpvghrshhonhgrlhhithihqdduieejtdelkeegjeduqddujeejkeehheehvd
    dqsghoqhhunheppehkvghrnhgvlhdrohhrghesfhhigihmvgdrnhgrmhgvpdhnsggprhgt
    phhtthhopedujedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhovghlrghgnh
    gvlhhfsehnvhhiughirgdrtghomhdprhgtphhtthhopehprghulhhmtghksehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehmvghmgihorhesghhmrghilhdrtghomhdprhgtphhtth
    hopegsihhgvggrshihsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepfhhrvggu
    vghrihgtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvggvrhgrjhdrihhithhrud
    dtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhhrvgiikhhisehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Z8--aXlAa3JUWFHd0K5Df6JjZcZW91R2xvmJT5Gj4um55X9Kdi-C6w>
    <xmx:Z8--aVgv0E8XYfc6US1_nQ3xL1ujmfv47l-S-ruchYvRBHsBhbs88w>
    <xmx:Z8--aWUCz6hDBO_grqHsMipt0LN-uCX8O9DC-zh8-JjT4zpCRM9fIQ>
    <xmx:Z8--aWtlXGEetjLzGN-SzMIaOB5wgtKejlhT-BByLUsYCcgpPGcP6Q>
    <xmx:aM--aXYPXgmm4mkFgeh0qQPzcCclgdnZ_2PfLUurLxq8VviNTZPhyvfZ>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Mar 2026 13:03:35 -0400 (EDT)
From: Boqun Feng <boqun@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	frederic@kernel.org,
	neeraj.iitr10@gmail.com,
	urezki@gmail.com,
	boqun.feng@gmail.com,
	rcu@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Song Liu <song@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	stable@kernel.org
Subject: [RFC PATCH] rcu-tasks: Avoid using mod_timer() in call_rcu_tasks_generic()
Date: Sat, 21 Mar 2026 10:03:21 -0700
Message-ID: <20260321170321.32257-1-boqun@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2b3848e9-3b11-41b8-8c44-5de28d4a4433@paulmck-laptop>
References: <2b3848e9-3b11-41b8-8c44-5de28d4a4433@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following deadlock is possible:

__mod_timer()
  lock_timer_base()
    raw_spin_lock_irqsave(&base->lock)   <- base->lock ACQUIRED
  trace_timer_start()                    <- tp_btf/timer_start fires here
    [probe_timer_start BPF program]
      bpf_task_storage_delete()
        bpf_selem_unlink(selem, false)   <- reuse_now=false
          bpf_selem_free(false)
            call_rcu_tasks_trace()
              call_rcu_tasks_generic()
                raw_spin_trylock(rtpcp)  <- succeeds (different lock)
                mod_timer(lazy_timer)    <- lazy_timer is on this CPU's base
                  lock_timer_base()
                    raw_spin_lock_irqsave(&base->lock) <- SAME LOCK -> DEADLOCK

because BPF can instrument a place while the timer base lock is held.
Fix it by using an intermediate irq_work.

Further, because a "timer base->lock" to a "rtpcp lock" lock dependency
can be establish in this way, we cannot mod_timer() with a rtpcp lock
held. Fix that as well.

Fixes: d119357d0743 ("rcu-tasks: Treat only synchronous grace periods urgently")
Cc: stable@kernel.org
Signed-off-by: Boqun Feng <boqun@kernel.org>
---
This is a follow-up of [1], and yes we can trigger a whole system
deadlock freeze easily with (even non-recursively) tracing the
timer_start tracepoint. I have a reproduce at:

	https://github.com/fbq/rcu_tasks_deadlock

Be very careful, since it'll freeze your system when run it.

I've tested it on 6.17 and 6.19 and can confirm the deadlock could be
triggered. So this is an old bug if it's a bug.

It's up to BPF whether this is a bug or not, because it has existed for
a while and nobody seems to get hurt(?).

[1]: https://lore.kernel.org/rcu/2b3848e9-3b11-41b8-8c44-5de28d4a4433@paulmck-laptop/

 kernel/rcu/tasks.h | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 2b55e6acf3c1..d9d5b7d5944e 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -46,6 +46,7 @@ struct rcu_tasks_percpu {
 	unsigned int urgent_gp;
 	struct work_struct rtp_work;
 	struct irq_work rtp_irq_work;
+	struct irq_work timer_irq_work;
 	struct rcu_head barrier_q_head;
 	struct list_head rtp_blkd_tasks;
 	struct list_head rtp_exit_list;
@@ -134,6 +135,7 @@ static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp);
 static DEFINE_PER_CPU(struct rcu_tasks_percpu, rt_name ## __percpu) = {			\
 	.lock = __RAW_SPIN_LOCK_UNLOCKED(rt_name ## __percpu.cbs_pcpu_lock),		\
 	.rtp_irq_work = IRQ_WORK_INIT_HARD(call_rcu_tasks_iw_wakeup),			\
+	.timer_irq_work = IRQ_WORK_INIT(call_rcu_tasks_mod_timer_lazy),			\
 };											\
 static struct rcu_tasks rt_name =							\
 {											\
@@ -321,11 +323,19 @@ static void call_rcu_tasks_generic_timer(struct timer_list *tlp)
 		if (!rtpcp->urgent_gp)
 			rtpcp->urgent_gp = 1;
 		needwake = true;
-		mod_timer(&rtpcp->lazy_timer, rcu_tasks_lazy_time(rtp));
+		/*
+		 * We cannot mod_timer() here because "timer base lock ->
+		 * rcu_node lock" lock dependencies can be establish by having
+		 * a BPF instrument at timer_start(), and that means deadlock
+		 * if we mod_timer() here. So delay the mod_timer() when we are
+		 * out of the lock critical section.
+		 */
 	}
 	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
-	if (needwake)
+	if (needwake) {
+		mod_timer(&rtpcp->lazy_timer, rcu_tasks_lazy_time(rtp));
 		rcuwait_wake_up(&rtp->cbs_wait);
+	}
 }
 
 // IRQ-work handler that does deferred wakeup for call_rcu_tasks_generic().
@@ -338,6 +348,16 @@ static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp)
 	rcuwait_wake_up(&rtp->cbs_wait);
 }
 
+static void call_rcu_tasks_mod_timer_lazy(struct irq_work *iwp)
+{
+	struct rcu_tasks *rtp;
+	struct rcu_tasks_percpu *rtpcp = container_of(iwp, struct rcu_tasks_percpu, timer_irq_work);
+	rtp = rtpcp->rtpp;
+
+	if (!timer_pending(&rtpcp->lazy_timer))
+		mod_timer(&rtpcp->lazy_timer, rcu_tasks_lazy_time(rtp));
+}
+
 // Enqueue a callback for the specified flavor of Tasks RCU.
 static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 				   struct rcu_tasks *rtp)
@@ -377,7 +397,7 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 		   (rcu_segcblist_n_cbs(&rtpcp->cblist) == rcu_task_lazy_lim);
 	if (havekthread && !needwake && !timer_pending(&rtpcp->lazy_timer)) {
 		if (rtp->lazy_jiffies)
-			mod_timer(&rtpcp->lazy_timer, rcu_tasks_lazy_time(rtp));
+			irq_work_queue(&rtpcp->timer_irq_work);
 		else
 			needwake = rcu_segcblist_empty(&rtpcp->cblist);
 	}
-- 
2.50.1 (Apple Git-155)

