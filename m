Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAE4282F08
	for <rcu@vger.kernel.org>; Mon, 18 May 2026 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779118575; cv=none; b=Ycm5Y2o7qpGDfxNnGMl7/Sk3NSziUio/zvFb7GBWKjTWhLEt/1neB3BikGvNtiA1hF0vWu5zk0p1Q+Ik/3SmI4+94i+PFFFWM3TO360AFQszfT7F4DQ+NzYjTNH1+E7OzGEG4PIviTk2yi0yfSDaqpJOsIBeS74i0AxW+uB1h1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779118575; c=relaxed/simple;
	bh=h7UCR9MaIA9qgYd5Ajgi6lk4r8qIQv1V0Qpn/5/cO1c=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zx+rZVmC0+O2sgoRg9YB5++M3kkOdfF6mdkJToEPjaXSho9DRdJksgRB9csrZIR6PBN87UoOuWstffPdoqPxEN5dvBujbB2L5AZhl+1ErSrrS+PFrLfhUNP8sXWAnaspOiDB6H3SDZsAD9TXS0JhcXd5ndwS+zGfXSONlqgRj9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QF3w37aF; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QF3w37aF"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a8fbe18b1dso3996121e87.2
        for <rcu@vger.kernel.org>; Mon, 18 May 2026 08:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779118571; x=1779723371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Cwk6S7lBBEPUcHjRmFGsFLSy4crLtyTGhsVjbDZo/Y=;
        b=QF3w37aFms3uURRB9BZMymHqYahDnSVL1bA0YD2TvFH68mS0fYhPta2WPFLuuIk7kK
         QLKDqg3CwB9I+A+ph/TTW07vWrYwvdbNKqaAYs9qXg/2LZAGBrQFwl+GCzdJXgT0k5mZ
         lzNs2++1aZ6lRB64JuDUypiWb0Humrkmd0/xSK7XXjVaUHihx+Y7U2i6Q7D1hd4EtP64
         T3Lzvuyheetd/5uzVVFVg0qofihBqh5WebiEIvUX6Djq7/HCUJOOY0i4tOVHdGauDOmT
         ew9sn/AgO7ZDPbWhy2HAgIHVF7MzQTGdpJetE/EY5gllecI1f6y+weqjWnso0bTmLvQA
         tf7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779118571; x=1779723371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Cwk6S7lBBEPUcHjRmFGsFLSy4crLtyTGhsVjbDZo/Y=;
        b=RWpMST6kk5YKz96/McfZxJvfZmLE7tc56Ks++9A97YdQQ6hkYPd7vp29ajbzQEIrXH
         X0R9F7ULOXRmTpE0QNKlTlFNE6tEdvbAC5WKe2PXkbIwRAS7xV/GNcPmSBaREcdF1Gnp
         PRS3Nd+bPmlknHTZLoucavqpfPd4Z5ESz8NRX1RpYesLobfONDZuouW+yTPWcASWqgNw
         nbvA1lQI+VMUNfzLujgpq7nhLNVKtmh/vSzVPwudhkF9JiwKzHXAbu9Zxa3s80JXpAfp
         OO7wZT2lvwPZVA8aQ+6yMgJdSVnbRseCKAEYHdaL+T6bn4mnSanQePuKODcHZJAHjUbM
         sV5w==
X-Forwarded-Encrypted: i=1; AFNElJ/rlabgRyphzPIEftR5WiRI71C2DSt7sKe1OOOFlSEPQV0Aa72kYNhOOs6A9RHCWKhtPPA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3ntcl6Vz7D/+JbhUgq4zM/LJltsFsfbdxeMMv7GqcsfR1V8UC
	Wa/RfTyYJXqwqVLr0mJOR73nEpTmCmbRkarkFimLrJkrtEk+5Tpp4lRk
X-Gm-Gg: Acq92OF8G1maBVfstPtiLUMjncRjyc+OpuBNW54yHu8s4TnGjaGXC3hnAkukdlj1xXu
	rbXZDyOhDNRsRv04AYK+8tVopXNd94ULSnMBvLrbmt1Osl+rbbcTW+2WG4x+IUWKYc64lly8deW
	yxby2auHESVILGNsymYmxKOm66KZ/7LSzeLdAzW7DkCfF4bwM7pINlZxYdkwMtHtHlHR8KsMh7c
	4Mit8DHXPtTg7Die5QwWBIC7h9SVt1wHD1iRd+Sq4HHuJR/eq8GfomTZo/meOqtLWMz67b21Nt0
	3IUJY3fLykje6qVaIdOrCOPS6n7AdKPkjI7htc02ByC+2CTAKsDvU4nlTDSwgC9HkDz4uNQoC4m
	tKhIbicYKTzWYEHbzqy5fFrgU8jkHjuJaDbbqxK0Tw0wFKMb7X3b10Fl83kvVLMj+
X-Received: by 2002:a05:6512:685:b0:5a8:8357:5321 with SMTP id 2adb3069b0e04-5aa0e769aeamr4603433e87.31.1779118570932;
        Mon, 18 May 2026 08:36:10 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a90f10c78csm3483531e87.14.2026.05.18.08.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 08:36:09 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Mon, 18 May 2026 17:36:08 +0200
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Z qiang <qiang.zhang1211@gmail.com>, qiang.zhang@linux.dev,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Saravana Kannan <saravanak@kernel.org>
Subject: Re: [PATCH -next v1 01/12] rcutorture: Fully test lazy RCU
Message-ID: <agsx6BMegHYEJeko@milan>
References: <20260511175448.153326-1-urezki@gmail.com>
 <20260511175448.153326-2-urezki@gmail.com>
 <CALm+0cVY4izVdUDVdqVCfGgREMbHcyeDryYwYp_gsHevt4t8_w@mail.gmail.com>
 <agm3SuhBoVjkunjG@pc636>
 <e88e9058-da7d-4e30-bcfb-461b2a6e7f24@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e88e9058-da7d-4e30-bcfb-461b2a6e7f24@paulmck-laptop>

On Sun, May 17, 2026 at 11:30:14AM -0700, Paul E. McKenney wrote:
> On Sun, May 17, 2026 at 02:40:42PM +0200, Uladzislau Rezki wrote:
> > On Thu, May 14, 2026 at 09:33:10PM +0800, Z qiang wrote:
> > > >
> > > > From: "Paul E. McKenney" <paulmck@kernel.org>
> > > >
> > > > Currently, rcutorture bypasses lazy RCU by using call_rcu_hurry().
> > > > This works, avoiding the dreaded rtort_pipe_count WARN(), but fails to
> > > > fully test lazy RCU.  The rtort_pipe_count WARN() splats because lazy RCU
> > > > could delay the start of an RCU grace period for a full stutter period,
> > > > which defaults to only three seconds.
> > > >
> > > > This commit therefore reverts the call_rcu_hurry() instances
> > > > back to call_rcu(), but, in kernels built with CONFIG_RCU_LAZY=y,
> > > > queues a workqueue handler just before the call to stutter_wait() in
> > > > rcu_torture_writer().  This workqueue handler invokes rcu_barrier(),
> > > > which motivates any lingering lazy callbacks, thus avoiding the splat.
> > > >
> > > > Questions for review:
> > > >
> > > > 1.      Should we avoid queueing work for RCU implementations not
> > > >         supporting lazy callbacks?
> > > 
> > > Hello, Paul
> > > 
> > > maybe we can do this:
> > > 
> > > rcu_ops = {
> > >          ...
> > >          .support_lazy = IS_ENABLED(CONFIG_RCU_LAZY),
> > > };
> > > 
> > > and
> > > 
> > > if (cur_ops->support_lazy )
> > >         queue_work(..., &lazy_work);
> > > 
> > > >
> > > > 2.      Should we avoid queueing work in kernels built with
> > > >         CONFIG_RCU_LAZY=y, but that were not booted with the
> > > >         rcutree.enable_rcu_lazy kernel boot parameter set?  (Note that
> > > >         this requires some ugliness to access this parameter, and must
> > > >         also handle Tiny RCU.)
> > > >
> > > > 3.      Does the rcu_torture_ops structure need a ->call_hurry() field,
> > > >         and if so, why?  If not, why not?
> > > >
> > > > 4.      Your additional questions here!
> > > >
> > > > Reported-by: Saravana Kannan <saravanak@kernel.org>
> > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > ---
> > > >  kernel/rcu/rcutorture.c | 21 ++++++++++++++++++---
> > > >  1 file changed, 18 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > > > index 5f2848b828dc..91ba3160ba6a 100644
> > > > --- a/kernel/rcu/rcutorture.c
> > > > +++ b/kernel/rcu/rcutorture.c
> > > > @@ -572,7 +572,7 @@ static unsigned long rcu_no_completed(void)
> > > >
> > > >  static void rcu_torture_deferred_free(struct rcu_torture *p)
> > > >  {
> > > > -       call_rcu_hurry(&p->rtort_rcu, rcu_torture_cb);
> > > > +       call_rcu(&p->rtort_rcu, rcu_torture_cb);
> > > >  }
> > > >
> > > >  static void rcu_sync_torture_init(void)
> > > > @@ -619,7 +619,7 @@ static struct rcu_torture_ops rcu_ops = {
> > > >         .poll_gp_state_exp      = poll_state_synchronize_rcu,
> > > >         .cond_sync_exp          = cond_synchronize_rcu_expedited,
> > > >         .cond_sync_exp_full     = cond_synchronize_rcu_expedited_full,
> > > > -       .call                   = call_rcu_hurry,
> > > > +       .call                   = call_rcu,
> > > >         .cb_barrier             = rcu_barrier,
> > > >         .fqs                    = rcu_force_quiescent_state,
> > > >         .gp_kthread_dbg         = show_rcu_gp_kthreads,
> > > > @@ -1145,7 +1145,7 @@ static void rcu_tasks_torture_deferred_free(struct rcu_torture *p)
> > > >
> > > >  static void synchronize_rcu_mult_test(void)
> > > >  {
> > > > -       synchronize_rcu_mult(call_rcu_tasks, call_rcu_hurry);
> > > > +       synchronize_rcu_mult(call_rcu_tasks, call_rcu);
> > > >  }
> > > >
> > > >  static struct rcu_torture_ops tasks_ops = {
> > > > @@ -1631,6 +1631,17 @@ static void do_rtws_sync(struct torture_random_state *trsp, void (*sync)(void))
> > > >                 cpus_read_unlock();
> > > >  }
> > > >
> > > > +/*
> > > > + * Do an rcu_barrier() to motivate lazy callbacks during a stutter
> > > > + * pause.  Without this, we can get false-positives rtort_pipe_count
> > > > + * splats.
> > > > + */
> > > > +static void rcu_torture_writer_work(struct work_struct *work)
> > > > +{
> > > > +       if (cur_ops->cb_barrier)
> > > > +               cur_ops->cb_barrier();
> > > > +}
> > > > +
> > > >  /*
> > > >   * RCU torture writer kthread.  Repeatedly substitutes a new structure
> > > >   * for that pointed to by rcu_torture_current, freeing the old structure
> > > > @@ -1651,6 +1662,7 @@ rcu_torture_writer(void *arg)
> > > >         int i;
> > > >         int idx;
> > > >         unsigned long j;
> > > > +       struct work_struct lazy_work;
> > > >         int oldnice = task_nice(current);
> > > >         struct rcu_gp_oldstate *rgo = NULL;
> > > >         int rgo_size = 0;
> > > > @@ -1667,6 +1679,7 @@ rcu_torture_writer(void *arg)
> > > >                 stallsdone += (stall_cpu_holdoff + stall_gp_kthread + stall_cpu + 60) *
> > > >                               HZ * (stall_cpu_repeat + 1);
> > > >         VERBOSE_TOROUT_STRING("rcu_torture_writer task started");
> > > > +       INIT_WORK_ONSTACK(&lazy_work, rcu_torture_writer_work);
> > > >         if (!can_expedite)
> > > >                 pr_alert("%s" TORTURE_FLAG
> > > >                          " GP expediting controlled from boot/sysfs for %s.\n",
> > > > @@ -1895,6 +1908,8 @@ rcu_torture_writer(void *arg)
> > > >                                        !rcu_gp_is_normal();
> > > >                 }
> > > >                 rcu_torture_writer_state = RTWS_STUTTER;
> > > > +               if (IS_ENABLED(CONFIG_RCU_LAZY))
> > > > +                       queue_work(system_percpu_wq, &lazy_work);
> > > 
> > > 
> > > When the task ends, the lazy_work should be cancel and destroy:
> > > 
> > > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > > index f593f8b794dd..5adf537ab410 100644
> > > --- a/kernel/rcu/rcutorture.c
> > > +++ b/kernel/rcu/rcutorture.c
> > > @@ -1682,7 +1682,6 @@ rcu_torture_writer(void *arg)
> > > stallsdone += (stall_cpu_holdoff + stall_gp_kthread + stall_cpu + 60) *
> > > HZ * (stall_cpu_repeat + 1);
> > > VERBOSE_TOROUT_STRING("rcu_torture_writer task started");
> > > - INIT_WORK_ONSTACK(&lazy_work, rcu_torture_writer_work);
> > > if (!can_expedite)
> > > pr_alert("%s" TORTURE_FLAG
> > > " GP expediting controlled from boot/sysfs for %s.\n",
> > > @@ -1719,6 +1718,8 @@ rcu_torture_writer(void *arg)
> > > pr_alert("%s" TORTURE_FLAG " Waited %lu jiffies for boot to complete.\n",
> > > torture_type, jiffies - j);
> > > 
> > > + INIT_WORK_ONSTACK(&lazy_work, rcu_torture_writer_work);
> > > +
> > > do {
> > > rcu_torture_writer_state = RTWS_FIXED_DELAY;
> > > torture_hrtimeout_us(500, 1000, &rand);
> > > @@ -1943,6 +1944,9 @@ rcu_torture_writer(void *arg)
> > > pr_alert("%s" TORTURE_FLAG
> > > " Dynamic grace-period expediting was disabled.\n",
> > > torture_type);
> > > + if (IS_ENABLED(CONFIG_RCU_LAZY))
> > > + cancel_work_sync(&lazy_work);
> > > + destroy_work_on_stack(&lazy_work);
> > > kfree(ulo);
> > > kfree(rgo);
> > > rcu_torture_writer_state = RTWS_STOPPING;
> > > 
> > I agree, we seem miss destroying the work via destroy_work_on_stack()
> > and "sync" the lazy_work work via cancel_work_sync().
> > 
> > Paul, any thoughts?
> 
> Good eyes!!!  I will take a closer look tomorrow.
> 
> In the meantime, one question...  Do we want to test for your new
> ->support_lazy instead of IS_ENABLED(CONFIG_RCU_LAZY) for that
> cancel_work_sync() and destroy_work_on_stack()?  If we really need
> IS_ENABLED(CONFIG_RCU_LAZY), could you please suggest a comment giving
> the reasoning?
> 
To me IS_ENABLED(CONFIG_RCU_LAZY) is enough :) I am not sure we really
need ->support_lazy flag.

--
Uladzislau Rezki
