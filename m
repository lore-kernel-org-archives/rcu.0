Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2704A36212D
	for <rcu@vger.kernel.org>; Sun, 17 May 2026 12:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779021650; cv=none; b=NWbbvKK4YSZ6WPk0uMjxMsQOA6zVQqgd7SzK3TkXmncoF7yCfAP/FMd3txNqqfYyTSn2mmi45Ab1T9oi8hnBUNp+JSvGxx1okkXeKj6q+EtOmH7msI9JHwnXvy7qsPIm40Z4q9q4JQ82ZCqNNWYrtpwZ+gwaX8Fz1pV6UepKRKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779021650; c=relaxed/simple;
	bh=k+BrRivwukn3OK/Y1hu9L8GIvVDUkrvTnBi8DCc2axU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qc78+ncx1dshnVXX6KqMdqLSloee4rx7302ORPu0xCAo2b02Rs551MmPCz/qqkRlX8sYtqkUPoTUKnwZBmq4nwMOg+adgCQ7LYDomzreZDyHBhi0uGu3d2q3znX0oBZZTGjlfbC236+s1482HuCOhTiBp6WaXhQefCn1MohhNt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ct3/h4x/; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ct3/h4x/"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-393c93a0166so16180661fa.2
        for <rcu@vger.kernel.org>; Sun, 17 May 2026 05:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779021645; x=1779626445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bdw84rcYXuEmEaU8wZljv2tbDx3e6Ol+lObzuMrz5QA=;
        b=ct3/h4x/X8om2vOlvUhQOnKi1ryu/h+K9ZHfrCNfm36xKGPkC4ca9DJK+T+WghSeJa
         EPRT57WUJySpy2zCaVzl2f6z/CM7fnhhB9/98bz58HGiqkih8+JP60qRVRHT+B8WE6hV
         iGgOLvar2vTTuoesub1/7Ga/WB11IeM2PsOYXAIFbULhVVbJly0a3vgX253zzcGTaKRS
         RuabuTBl1WSak04A/2elrfbqPSMmMDkLTBp3pulFu9NFD1Mzy7GYdYaTggxxFdvBTPNS
         PBtYod/Tk0rVKTFJS6S+PRfmBYkSIC1neW8LssVKFUEshZlDz39RSjyr0Wb4yJSt+bUY
         9WpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779021645; x=1779626445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bdw84rcYXuEmEaU8wZljv2tbDx3e6Ol+lObzuMrz5QA=;
        b=WMdrBYoPT6/wRJ70nZ2BY1w8JDNPizlzYr7B26qnxMhxSUrpGOzZSOOsFmWmX7cKNY
         v1dKPmfAsWVRTgRhRxPOM/qYf2L8k/wRTfIWXyigiV+pQGQYCEdFfjnnxqlbwx5wJpUI
         XO1Gff7ntHqySUPOKqokwc1zPA2EyFDIkqATBIDLcXaq2xbEThNnkVB0oJXESeVWHVss
         vVzBmWL98/jcJCLAxuGAQMz9zqP/VOBkhDYGJnJwhb5KEdbQeBUwssgyKDj6fAfUpSR8
         vVgdkuyJ/03JdUM3qgdhFacaQLE/541+UF2zt3ZR978jBW9F8hon/wXpVHGrulShwpI6
         l02Q==
X-Forwarded-Encrypted: i=1; AFNElJ/w/BmsS5Shqn3VX7PTUNHZ+NVmlSyKwALSszJQOSxfgboMCxsDPJziH4EF0dh/c+HLmxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAh1mjh1Fq9rekKsBWqj8b67DiJPbBni23UwV5qko405NNY6zX
	GUWigaG7W4M1SElFOZ4cd+zrqPc5YunoDHNaEMeHOIbqIOF2prcDfL4+
X-Gm-Gg: Acq92OFUiHNpUV5w4qCOxgtlrNRAVHMmdmTbtGEy2hUTdLngEfLVnqSurfa4PgS1KlS
	IHE/0B2TePads1BMs3K4wULzF7fO1SE9Nw+jruXwgYDIb5PIXkVYudxtKVgcb6cd0Q52ialDqhb
	ssOo0lTDmMGv9VSi5PYwZFyI9IWIb8B1Ds5817aTkHJWEhbW2i6ns4STIjP5UDTf3b+kSUsSIq0
	ViV4gag2GpAVJbdLakXZlnG6XnCzMzE8N7sjJC2X+Wgai0584xk1DLxhrf/wf4Hs6bCJmJXJCnV
	8nKwWbP6gnoTJx+ABvLVynFUaB+8iFCFlC7Ha+iFNe+0effwB6RMaElI/8lvuyzIdggJz+zvxtr
	B9Mfzo75nFJm4mHjkzCSedRWt64B6rp3IJcwvmRS0m5uddn6ZllF9zhHGWaW92DAa0IWVLII38F
	9Kn/m9H3D8
X-Received: by 2002:a2e:3507:0:b0:38e:ae31:f0a5 with SMTP id 38308e7fff4ca-39561c3db53mr26103021fa.9.1779021645248;
        Sun, 17 May 2026 05:40:45 -0700 (PDT)
Received: from pc636 ([2001:9b1:d5a0:a500:de96:9acf:5dca:ede4])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3958874ec2fsm4927391fa.26.2026.05.17.05.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 05:40:44 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Sun, 17 May 2026 14:40:42 +0200
To: Z qiang <qiang.zhang1211@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, qiang.zhang@linux.dev,
	Joel Fernandes <joelagnelf@nvidia.com>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Saravana Kannan <saravanak@kernel.org>
Subject: Re: [PATCH -next v1 01/12] rcutorture: Fully test lazy RCU
Message-ID: <agm3SuhBoVjkunjG@pc636>
References: <20260511175448.153326-1-urezki@gmail.com>
 <20260511175448.153326-2-urezki@gmail.com>
 <CALm+0cVY4izVdUDVdqVCfGgREMbHcyeDryYwYp_gsHevt4t8_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALm+0cVY4izVdUDVdqVCfGgREMbHcyeDryYwYp_gsHevt4t8_w@mail.gmail.com>

On Thu, May 14, 2026 at 09:33:10PM +0800, Z qiang wrote:
> >
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> >
> > Currently, rcutorture bypasses lazy RCU by using call_rcu_hurry().
> > This works, avoiding the dreaded rtort_pipe_count WARN(), but fails to
> > fully test lazy RCU.  The rtort_pipe_count WARN() splats because lazy RCU
> > could delay the start of an RCU grace period for a full stutter period,
> > which defaults to only three seconds.
> >
> > This commit therefore reverts the call_rcu_hurry() instances
> > back to call_rcu(), but, in kernels built with CONFIG_RCU_LAZY=y,
> > queues a workqueue handler just before the call to stutter_wait() in
> > rcu_torture_writer().  This workqueue handler invokes rcu_barrier(),
> > which motivates any lingering lazy callbacks, thus avoiding the splat.
> >
> > Questions for review:
> >
> > 1.      Should we avoid queueing work for RCU implementations not
> >         supporting lazy callbacks?
> 
> Hello, Paul
> 
> maybe we can do this:
> 
> rcu_ops = {
>          ...
>          .support_lazy = IS_ENABLED(CONFIG_RCU_LAZY),
> };
> 
> and
> 
> if (cur_ops->support_lazy )
>         queue_work(..., &lazy_work);
> 
> >
> > 2.      Should we avoid queueing work in kernels built with
> >         CONFIG_RCU_LAZY=y, but that were not booted with the
> >         rcutree.enable_rcu_lazy kernel boot parameter set?  (Note that
> >         this requires some ugliness to access this parameter, and must
> >         also handle Tiny RCU.)
> >
> > 3.      Does the rcu_torture_ops structure need a ->call_hurry() field,
> >         and if so, why?  If not, why not?
> >
> > 4.      Your additional questions here!
> >
> > Reported-by: Saravana Kannan <saravanak@kernel.org>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  kernel/rcu/rcutorture.c | 21 ++++++++++++++++++---
> >  1 file changed, 18 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > index 5f2848b828dc..91ba3160ba6a 100644
> > --- a/kernel/rcu/rcutorture.c
> > +++ b/kernel/rcu/rcutorture.c
> > @@ -572,7 +572,7 @@ static unsigned long rcu_no_completed(void)
> >
> >  static void rcu_torture_deferred_free(struct rcu_torture *p)
> >  {
> > -       call_rcu_hurry(&p->rtort_rcu, rcu_torture_cb);
> > +       call_rcu(&p->rtort_rcu, rcu_torture_cb);
> >  }
> >
> >  static void rcu_sync_torture_init(void)
> > @@ -619,7 +619,7 @@ static struct rcu_torture_ops rcu_ops = {
> >         .poll_gp_state_exp      = poll_state_synchronize_rcu,
> >         .cond_sync_exp          = cond_synchronize_rcu_expedited,
> >         .cond_sync_exp_full     = cond_synchronize_rcu_expedited_full,
> > -       .call                   = call_rcu_hurry,
> > +       .call                   = call_rcu,
> >         .cb_barrier             = rcu_barrier,
> >         .fqs                    = rcu_force_quiescent_state,
> >         .gp_kthread_dbg         = show_rcu_gp_kthreads,
> > @@ -1145,7 +1145,7 @@ static void rcu_tasks_torture_deferred_free(struct rcu_torture *p)
> >
> >  static void synchronize_rcu_mult_test(void)
> >  {
> > -       synchronize_rcu_mult(call_rcu_tasks, call_rcu_hurry);
> > +       synchronize_rcu_mult(call_rcu_tasks, call_rcu);
> >  }
> >
> >  static struct rcu_torture_ops tasks_ops = {
> > @@ -1631,6 +1631,17 @@ static void do_rtws_sync(struct torture_random_state *trsp, void (*sync)(void))
> >                 cpus_read_unlock();
> >  }
> >
> > +/*
> > + * Do an rcu_barrier() to motivate lazy callbacks during a stutter
> > + * pause.  Without this, we can get false-positives rtort_pipe_count
> > + * splats.
> > + */
> > +static void rcu_torture_writer_work(struct work_struct *work)
> > +{
> > +       if (cur_ops->cb_barrier)
> > +               cur_ops->cb_barrier();
> > +}
> > +
> >  /*
> >   * RCU torture writer kthread.  Repeatedly substitutes a new structure
> >   * for that pointed to by rcu_torture_current, freeing the old structure
> > @@ -1651,6 +1662,7 @@ rcu_torture_writer(void *arg)
> >         int i;
> >         int idx;
> >         unsigned long j;
> > +       struct work_struct lazy_work;
> >         int oldnice = task_nice(current);
> >         struct rcu_gp_oldstate *rgo = NULL;
> >         int rgo_size = 0;
> > @@ -1667,6 +1679,7 @@ rcu_torture_writer(void *arg)
> >                 stallsdone += (stall_cpu_holdoff + stall_gp_kthread + stall_cpu + 60) *
> >                               HZ * (stall_cpu_repeat + 1);
> >         VERBOSE_TOROUT_STRING("rcu_torture_writer task started");
> > +       INIT_WORK_ONSTACK(&lazy_work, rcu_torture_writer_work);
> >         if (!can_expedite)
> >                 pr_alert("%s" TORTURE_FLAG
> >                          " GP expediting controlled from boot/sysfs for %s.\n",
> > @@ -1895,6 +1908,8 @@ rcu_torture_writer(void *arg)
> >                                        !rcu_gp_is_normal();
> >                 }
> >                 rcu_torture_writer_state = RTWS_STUTTER;
> > +               if (IS_ENABLED(CONFIG_RCU_LAZY))
> > +                       queue_work(system_percpu_wq, &lazy_work);
> 
> 
> When the task ends, the lazy_work should be cancel and destroy:
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index f593f8b794dd..5adf537ab410 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -1682,7 +1682,6 @@ rcu_torture_writer(void *arg)
> stallsdone += (stall_cpu_holdoff + stall_gp_kthread + stall_cpu + 60) *
> HZ * (stall_cpu_repeat + 1);
> VERBOSE_TOROUT_STRING("rcu_torture_writer task started");
> - INIT_WORK_ONSTACK(&lazy_work, rcu_torture_writer_work);
> if (!can_expedite)
> pr_alert("%s" TORTURE_FLAG
> " GP expediting controlled from boot/sysfs for %s.\n",
> @@ -1719,6 +1718,8 @@ rcu_torture_writer(void *arg)
> pr_alert("%s" TORTURE_FLAG " Waited %lu jiffies for boot to complete.\n",
> torture_type, jiffies - j);
> 
> + INIT_WORK_ONSTACK(&lazy_work, rcu_torture_writer_work);
> +
> do {
> rcu_torture_writer_state = RTWS_FIXED_DELAY;
> torture_hrtimeout_us(500, 1000, &rand);
> @@ -1943,6 +1944,9 @@ rcu_torture_writer(void *arg)
> pr_alert("%s" TORTURE_FLAG
> " Dynamic grace-period expediting was disabled.\n",
> torture_type);
> + if (IS_ENABLED(CONFIG_RCU_LAZY))
> + cancel_work_sync(&lazy_work);
> + destroy_work_on_stack(&lazy_work);
> kfree(ulo);
> kfree(rgo);
> rcu_torture_writer_state = RTWS_STOPPING;
> 
I agree, we seem miss destroying the work via destroy_work_on_stack()
and "sync" the lazy_work work via cancel_work_sync().

Paul, any thoughts?

--
Uladzislau Rezki
