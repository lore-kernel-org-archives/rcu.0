Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B76C2E974D
	for <rcu@vger.kernel.org>; Tue, 19 May 2026 16:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779206703; cv=none; b=jmTKoofIHnDnjL1kZP8MZx7Sj5RYoyh+a07Fsd9UzYlr9kkJ49+cdE3aFKVxxgKVj8r5efizMKoLzXRIHYAW1FZNn6cJlBDa+FoX+TgcJU6HtKDTaRXbC4I6Hmi/IvmVObjpQdd+fpchdsAB7j9fP8y9koUcQFwth2VYPzHZg0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779206703; c=relaxed/simple;
	bh=aOQS/Ul10E9+iIW0YHmFrBvkUxXUucG259HNG/8Yn10=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFZeeMteNx00EfSoiYpBhr0eRtK/6FKOqOB5zlCf8HShvxbz4KoK0aAWuHRtHRx9WBVmyksq1+02podPLHsui2Ag1ypq3dh5WVoA+gN8xU1NMHvbZWu/YBu+/+yxZouItsqgt9KGuFY8pPYwGd78uOUFvRFgmKZRsowSy6J5cWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qs70bP4g; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qs70bP4g"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a887ebb416so4556478e87.2
        for <rcu@vger.kernel.org>; Tue, 19 May 2026 09:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779206699; x=1779811499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e5M23ceYd2E/sbvcTl4ymc9Vdn2GKqdKbAJPBO2K/Z8=;
        b=qs70bP4g//6+XF44K0fHdu6u9ute4QQSacJLL5YOytBFPpkVXRI5M3XHtiH1o39a1W
         CBc9fPtpq4zZ7x/LoFIOCMunxqXJKLVurWuE4i6CyW2rGDA6uE62w8CmvPAW5Fkh18M7
         jV6se6MN/52HWx9WMlHwJDcmLANLK+hD0wZlkotvS+ljce4locRwtZcn8SaM7cv5CYrx
         pfgOQbOY9BDOcGFahtaqg38IiKxwKaDTVgkfnrJ1jIS/PPos38Vc1zr0qaqPvVr6Hx86
         B7fTaHTeK2AwQmTYozQsHjk69W6BqPJrMolw2oXJ+VpB429gM/KOA0hRz47lN2O+VHdj
         g/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779206699; x=1779811499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5M23ceYd2E/sbvcTl4ymc9Vdn2GKqdKbAJPBO2K/Z8=;
        b=pX4IRmU87PkwCRro4KzKqoSyDlHblidxQCcDKSqb6C2bSGb5QRSAwAQun6WlDrowWA
         DL9dpq0mcFwHmGN8yQbOoh9B72x9BcSYaYPsbrncjfjaYt3b9aL3owzyin6PP0fA195A
         W75h+DojhKRch3L51Z6gqPc+ng+rR+tAXA4x196hN/QYSqMCJZJeKbnvpFLUEOl0lWJh
         j6K7apDwlpvSL4JW8ko7HD/7+NIsnwRnq2YN1IEdUi5Cwh/56LaDBlVyLAufOe/4ANwP
         hBI6FuMpztoHNYSLb7B8QJgC8/N897rbpaN4VJHqpxEyc5l7hMcLbjATElKbr8I8WH7A
         OZow==
X-Forwarded-Encrypted: i=1; AFNElJ94KJZ4+Rb1BIMCc0m/4IYsBjCEjAtEfKd35O384SzrwUsZiVeeZZqAK0oZ2YUU0GDHDL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPIQHT5fhh4OExLoumuVxE65Z4Ig2JIuZyzv3go9Tao6Tl3+0A
	A24LoT/g21m4/tzv5+MvS+vC6rgP17vPpbQRIr9hWCEbN1rn8qy1clo8
X-Gm-Gg: Acq92OFXBYfqb6SvcTyzPyhedEqZ/YLBCKKa988k+d+toHdTCj2Y+K39cClyxdVxebu
	43IS1P1wVQwqp33dvCrsHgsofrbeHZszHbFXdKv8QiZSfkp0RTxfS+KklmtN1K9+xktNyXRISOA
	jlXyT3Jicz/PIRB3VqEPuxl9HS3KwjJymcgcmWKIwz64LcBk2H272k26L8dIP78yGY9aCUHPgre
	9Ew1gnEm8UmNnHY6WrnwvxFdZpBbx/9AwXiI6ueVlR8oPxEbyZ3pZs91k0zPfPu4qAjhYMUoNgl
	BHuNwUdaY299vMQzYHEWqjw9jGXPgL+VET2YqD0QIacVK7zpN9bwudDugM/wyrAALtsH2I8wLVV
	Z+EdBMYdQFZXmfBHa56fEjeSaNuNDVPukC1rD/sfdwsj+mvfmX1ZgFM/egC0+h1a8
X-Received: by 2002:a05:6512:1590:b0:5a4:d34:5b38 with SMTP id 2adb3069b0e04-5aa0e6191abmr5904374e87.2.1779206698900;
        Tue, 19 May 2026 09:04:58 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a90f10c885sm4174148e87.11.2026.05.19.09.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 09:04:58 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Tue, 19 May 2026 18:04:56 +0200
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Z qiang <qiang.zhang1211@gmail.com>, qiang.zhang@linux.dev,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Saravana Kannan <saravanak@kernel.org>
Subject: Re: [PATCH -next v1 01/12] rcutorture: Fully test lazy RCU
Message-ID: <agyKKNF52K6kq7Cs@milan>
References: <20260511175448.153326-1-urezki@gmail.com>
 <20260511175448.153326-2-urezki@gmail.com>
 <CALm+0cVY4izVdUDVdqVCfGgREMbHcyeDryYwYp_gsHevt4t8_w@mail.gmail.com>
 <agm3SuhBoVjkunjG@pc636>
 <e88e9058-da7d-4e30-bcfb-461b2a6e7f24@paulmck-laptop>
 <agsx6BMegHYEJeko@milan>
 <003e94b0-d562-4cc1-a0be-db68e1969229@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003e94b0-d562-4cc1-a0be-db68e1969229@paulmck-laptop>

On Mon, May 18, 2026 at 05:38:48PM -0700, Paul E. McKenney wrote:
> On Mon, May 18, 2026 at 05:36:08PM +0200, Uladzislau Rezki wrote:
> > On Sun, May 17, 2026 at 11:30:14AM -0700, Paul E. McKenney wrote:
> > > On Sun, May 17, 2026 at 02:40:42PM +0200, Uladzislau Rezki wrote:
> > > > On Thu, May 14, 2026 at 09:33:10PM +0800, Z qiang wrote:
> > > > > >
> > > > > > From: "Paul E. McKenney" <paulmck@kernel.org>
> > > > > >
> > > > > > Currently, rcutorture bypasses lazy RCU by using call_rcu_hurry().
> > > > > > This works, avoiding the dreaded rtort_pipe_count WARN(), but fails to
> > > > > > fully test lazy RCU.  The rtort_pipe_count WARN() splats because lazy RCU
> > > > > > could delay the start of an RCU grace period for a full stutter period,
> > > > > > which defaults to only three seconds.
> > > > > >
> > > > > > This commit therefore reverts the call_rcu_hurry() instances
> > > > > > back to call_rcu(), but, in kernels built with CONFIG_RCU_LAZY=y,
> > > > > > queues a workqueue handler just before the call to stutter_wait() in
> > > > > > rcu_torture_writer().  This workqueue handler invokes rcu_barrier(),
> > > > > > which motivates any lingering lazy callbacks, thus avoiding the splat.
> > > > > >
> > > > > > Questions for review:
> > > > > >
> > > > > > 1.      Should we avoid queueing work for RCU implementations not
> > > > > >         supporting lazy callbacks?
> > > > > 
> > > > > Hello, Paul
> > > > > 
> > > > > maybe we can do this:
> > > > > 
> > > > > rcu_ops = {
> > > > >          ...
> > > > >          .support_lazy = IS_ENABLED(CONFIG_RCU_LAZY),
> > > > > };
> > > > > 
> > > > > and
> > > > > 
> > > > > if (cur_ops->support_lazy )
> > > > >         queue_work(..., &lazy_work);
> > > > > 
> > > > > >
> > > > > > 2.      Should we avoid queueing work in kernels built with
> > > > > >         CONFIG_RCU_LAZY=y, but that were not booted with the
> > > > > >         rcutree.enable_rcu_lazy kernel boot parameter set?  (Note that
> > > > > >         this requires some ugliness to access this parameter, and must
> > > > > >         also handle Tiny RCU.)
> > > > > >
> > > > > > 3.      Does the rcu_torture_ops structure need a ->call_hurry() field,
> > > > > >         and if so, why?  If not, why not?
> > > > > >
> > > > > > 4.      Your additional questions here!
> > > > > >
> > > > > > Reported-by: Saravana Kannan <saravanak@kernel.org>
> > > > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > > > ---
> > > > > >  kernel/rcu/rcutorture.c | 21 ++++++++++++++++++---
> > > > > >  1 file changed, 18 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > > > > > index 5f2848b828dc..91ba3160ba6a 100644
> > > > > > --- a/kernel/rcu/rcutorture.c
> > > > > > +++ b/kernel/rcu/rcutorture.c
> > > > > > @@ -572,7 +572,7 @@ static unsigned long rcu_no_completed(void)
> > > > > >
> > > > > >  static void rcu_torture_deferred_free(struct rcu_torture *p)
> > > > > >  {
> > > > > > -       call_rcu_hurry(&p->rtort_rcu, rcu_torture_cb);
> > > > > > +       call_rcu(&p->rtort_rcu, rcu_torture_cb);
> > > > > >  }
> > > > > >
> > > > > >  static void rcu_sync_torture_init(void)
> > > > > > @@ -619,7 +619,7 @@ static struct rcu_torture_ops rcu_ops = {
> > > > > >         .poll_gp_state_exp      = poll_state_synchronize_rcu,
> > > > > >         .cond_sync_exp          = cond_synchronize_rcu_expedited,
> > > > > >         .cond_sync_exp_full     = cond_synchronize_rcu_expedited_full,
> > > > > > -       .call                   = call_rcu_hurry,
> > > > > > +       .call                   = call_rcu,
> > > > > >         .cb_barrier             = rcu_barrier,
> > > > > >         .fqs                    = rcu_force_quiescent_state,
> > > > > >         .gp_kthread_dbg         = show_rcu_gp_kthreads,
> > > > > > @@ -1145,7 +1145,7 @@ static void rcu_tasks_torture_deferred_free(struct rcu_torture *p)
> > > > > >
> > > > > >  static void synchronize_rcu_mult_test(void)
> > > > > >  {
> > > > > > -       synchronize_rcu_mult(call_rcu_tasks, call_rcu_hurry);
> > > > > > +       synchronize_rcu_mult(call_rcu_tasks, call_rcu);
> > > > > >  }
> > > > > >
> > > > > >  static struct rcu_torture_ops tasks_ops = {
> > > > > > @@ -1631,6 +1631,17 @@ static void do_rtws_sync(struct torture_random_state *trsp, void (*sync)(void))
> > > > > >                 cpus_read_unlock();
> > > > > >  }
> > > > > >
> > > > > > +/*
> > > > > > + * Do an rcu_barrier() to motivate lazy callbacks during a stutter
> > > > > > + * pause.  Without this, we can get false-positives rtort_pipe_count
> > > > > > + * splats.
> > > > > > + */
> > > > > > +static void rcu_torture_writer_work(struct work_struct *work)
> > > > > > +{
> > > > > > +       if (cur_ops->cb_barrier)
> > > > > > +               cur_ops->cb_barrier();
> > > > > > +}
> > > > > > +
> > > > > >  /*
> > > > > >   * RCU torture writer kthread.  Repeatedly substitutes a new structure
> > > > > >   * for that pointed to by rcu_torture_current, freeing the old structure
> > > > > > @@ -1651,6 +1662,7 @@ rcu_torture_writer(void *arg)
> > > > > >         int i;
> > > > > >         int idx;
> > > > > >         unsigned long j;
> > > > > > +       struct work_struct lazy_work;
> > > > > >         int oldnice = task_nice(current);
> > > > > >         struct rcu_gp_oldstate *rgo = NULL;
> > > > > >         int rgo_size = 0;
> > > > > > @@ -1667,6 +1679,7 @@ rcu_torture_writer(void *arg)
> > > > > >                 stallsdone += (stall_cpu_holdoff + stall_gp_kthread + stall_cpu + 60) *
> > > > > >                               HZ * (stall_cpu_repeat + 1);
> > > > > >         VERBOSE_TOROUT_STRING("rcu_torture_writer task started");
> > > > > > +       INIT_WORK_ONSTACK(&lazy_work, rcu_torture_writer_work);
> > > > > >         if (!can_expedite)
> > > > > >                 pr_alert("%s" TORTURE_FLAG
> > > > > >                          " GP expediting controlled from boot/sysfs for %s.\n",
> > > > > > @@ -1895,6 +1908,8 @@ rcu_torture_writer(void *arg)
> > > > > >                                        !rcu_gp_is_normal();
> > > > > >                 }
> > > > > >                 rcu_torture_writer_state = RTWS_STUTTER;
> > > > > > +               if (IS_ENABLED(CONFIG_RCU_LAZY))
> > > > > > +                       queue_work(system_percpu_wq, &lazy_work);
> > > > > 
> > > > > 
> > > > > When the task ends, the lazy_work should be cancel and destroy:
> > > > > 
> > > > > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > > > > index f593f8b794dd..5adf537ab410 100644
> > > > > --- a/kernel/rcu/rcutorture.c
> > > > > +++ b/kernel/rcu/rcutorture.c
> > > > > @@ -1682,7 +1682,6 @@ rcu_torture_writer(void *arg)
> > > > > stallsdone += (stall_cpu_holdoff + stall_gp_kthread + stall_cpu + 60) *
> > > > > HZ * (stall_cpu_repeat + 1);
> > > > > VERBOSE_TOROUT_STRING("rcu_torture_writer task started");
> > > > > - INIT_WORK_ONSTACK(&lazy_work, rcu_torture_writer_work);
> > > > > if (!can_expedite)
> > > > > pr_alert("%s" TORTURE_FLAG
> > > > > " GP expediting controlled from boot/sysfs for %s.\n",
> > > > > @@ -1719,6 +1718,8 @@ rcu_torture_writer(void *arg)
> > > > > pr_alert("%s" TORTURE_FLAG " Waited %lu jiffies for boot to complete.\n",
> > > > > torture_type, jiffies - j);
> > > > > 
> > > > > + INIT_WORK_ONSTACK(&lazy_work, rcu_torture_writer_work);
> > > > > +
> > > > > do {
> > > > > rcu_torture_writer_state = RTWS_FIXED_DELAY;
> > > > > torture_hrtimeout_us(500, 1000, &rand);
> > > > > @@ -1943,6 +1944,9 @@ rcu_torture_writer(void *arg)
> > > > > pr_alert("%s" TORTURE_FLAG
> > > > > " Dynamic grace-period expediting was disabled.\n",
> > > > > torture_type);
> > > > > + if (IS_ENABLED(CONFIG_RCU_LAZY))
> > > > > + cancel_work_sync(&lazy_work);
> > > > > + destroy_work_on_stack(&lazy_work);
> > > > > kfree(ulo);
> > > > > kfree(rgo);
> > > > > rcu_torture_writer_state = RTWS_STOPPING;
> > > > > 
> > > > I agree, we seem miss destroying the work via destroy_work_on_stack()
> > > > and "sync" the lazy_work work via cancel_work_sync().
> > > > 
> > > > Paul, any thoughts?
> > > 
> > > Good eyes!!!  I will take a closer look tomorrow.
> > > 
> > > In the meantime, one question...  Do we want to test for your new
> > > ->support_lazy instead of IS_ENABLED(CONFIG_RCU_LAZY) for that
> > > cancel_work_sync() and destroy_work_on_stack()?  If we really need
> > > IS_ENABLED(CONFIG_RCU_LAZY), could you please suggest a comment giving
> > > the reasoning?
> > > 
> > To me IS_ENABLED(CONFIG_RCU_LAZY) is enough :) I am not sure we really
> > need ->support_lazy flag.
> 
> Good point, given that the queue_work() is also guarded by that same
> IS_ENABLED(CONFIG_RCU_LAZY).
> 
> How does the patch below, based on the patch I sent initially, look?
> 
> I can fold it in and resend, or you can do so, your choice.
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 68284a54b40f4fb1a6595fb9263aae47a56f20bb
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Mon May 18 17:36:10 2026 -0700
> 
>     squash! rcutorture: Fully test lazy RCU
>     
>     [ paulmck: Apply Z qiang feedback. ]
>     
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index e1b4f4dbbb5819..878706beea01cd 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -1682,7 +1682,6 @@ rcu_torture_writer(void *arg)
>  		stallsdone += (stall_cpu_holdoff + stall_gp_kthread + stall_cpu + 60) *
>  			      HZ * (stall_cpu_repeat + 1);
>  	VERBOSE_TOROUT_STRING("rcu_torture_writer task started");
> -	INIT_WORK_ONSTACK(&lazy_work, rcu_torture_writer_work);
>  	if (!can_expedite)
>  		pr_alert("%s" TORTURE_FLAG
>  			 " GP expediting controlled from boot/sysfs for %s.\n",
> @@ -1719,6 +1718,8 @@ rcu_torture_writer(void *arg)
>  		pr_alert("%s" TORTURE_FLAG " Waited %lu jiffies for boot to complete.\n",
>  			 torture_type, jiffies - j);
>  
> +	if (IS_ENABLED(CONFIG_RCU_LAZY))
> +		INIT_WORK_ONSTACK(&lazy_work, rcu_torture_writer_work);
>  	do {
>  		rcu_torture_writer_state = RTWS_FIXED_DELAY;
>  		torture_hrtimeout_us(500, 1000, &rand);
> @@ -1943,6 +1944,10 @@ rcu_torture_writer(void *arg)
>  		pr_alert("%s" TORTURE_FLAG
>  			 " Dynamic grace-period expediting was disabled.\n",
>  			 torture_type);
> +	if (IS_ENABLED(CONFIG_RCU_LAZY)) {
> +		cancel_work_sync(&lazy_work);
> +		destroy_work_on_stack(&lazy_work);
> +	}
>  	kfree(ulo);
>  	kfree(rgo);
>  	rcu_torture_writer_state = RTWS_STOPPING;
>
I will fold it on my own, Paul!

--
Uladzislau Rezki
