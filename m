Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8988A13B5B2;
	Mon, 15 Jul 2024 08:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721033447; cv=none; b=Sm1UpUp6vFhR13e22Obzcb45Ml3qgKOOEZnbx9EzOHEiWRGZ+RMvlck6vBSWa+PJV3RBIqRmL41JO/u48TfZC8kXQdQoqLfZbCWAUg9uzrxNiQh5cWHpZgtlHibF3mlawoL0a+5CPAIdyS6emNcLTo/luGT8MoWxPCwrYjvo+qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721033447; c=relaxed/simple;
	bh=N144p+CRK7LlNYh39IOquizeMKhCeis0o27lG12p3kA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qwvP6DMeOT12zOsDvqJe49vMnK7yfNzu1WWJydrEM1SEqv3m8/mUwznMdAcyuIqVbTUh1RlsRdk5sMHBfMAMFpSQygWi0ngwzf+ymh64DYX0wt8X/DLW5RDBTjhBtEm5DC3YqQCeLKNN25SOvx/BEtrLhccGigMPjaOhyEORmnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HpNH40Pt; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpNH40Pt"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso445869566b.0;
        Mon, 15 Jul 2024 01:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721033444; x=1721638244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IHFekXz0LKUP3ZAY4L5Tc6nZRqf9KisCvufCjCWSjSQ=;
        b=HpNH40PtQClxWZqZrY/6EMS0curFeqidd6PC3/QXTPaZusn6xXRciCTaYcESBjJRDn
         hXCfeJmpBnOY5lUt9xVuzxTo2CYpNidpS/re+UYBS6dhF5UzsAYkPUQ3bQkeeDiGyrcW
         JHcmg68PvqGzYojN0FCQ5zy14OKxEujn47LgPIFKHX8LYH69D+ETTEoflnJjBE6q5XzW
         1+QCplfHVM3QEcoPds1q87yoPJY5sRxPZFptvILIpN2M/jPOCjUr+BJvP5uiZUmxadF6
         jOG/rVw7dAQvP+VKJ+bF2z6ZFPP7mYu2aOj6HAmNa9fIjo4gKFrLnoWbEnwo/gWSk380
         vtuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721033444; x=1721638244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IHFekXz0LKUP3ZAY4L5Tc6nZRqf9KisCvufCjCWSjSQ=;
        b=H+PPUYuJa9pyd7AErsGPSfHOOhpEktoyxFAvhMkrJkzIfUyJgWBxrg4khWcdcC5EgH
         tuEUckd0GnceBFibEOeb3/7qHAJFp1wZmpiG/jS0LSxSmM5FpjG5m8Yrr9wzKTH2L5je
         k91YUQkq2uPXWZVxxNt21v5I4HyJN9u/h+WXABPSuQBCA+vxEk8N6idspCYNGDVd/WyS
         TbfmNcm1fmsexz/YqHFn+xZfwi2yVZL3hXjAgJaFwQPqEtYT7UwxLRXp1xHRECa0oZwq
         LV6aljQvcbUUpHDSESX6rPxdwdJvWn16z+h7eB5KVHY6cFnzNy3AwTdZ8HEwgEr6512N
         jwFw==
X-Forwarded-Encrypted: i=1; AJvYcCUq/sRu3OqUUwMC/fl30erM50JYn0dNOUiSu6k+B76MnIwDBsfeFmepUYgU1aBLMpw7ly7nxx7yLvhZISNkveZdeW48QYqewkDjbXd1inZL8ac914t1WBIaBFyT43OB9xuO
X-Gm-Message-State: AOJu0Yyg+vBMWXxPURGiStoC72TAgLuCGIw9Z75RvTDqZWIR2ECfjHLm
	mx6rQ99csEAuiFMgzguULy00V1zeNiNQSaaBdRZGAJdiLJAIyCPmy7B73L6ZuEapEKjGBUnaD70
	PCg9MJ+H745Qdxt7LNO6X7m9EeK4=
X-Google-Smtp-Source: AGHT+IHDjUezjtQiG8H0knVP7lV/zQ0Vw9GTuraO94xZ26J8uDRGku2yp0oH2AGnGSvJW9b4zHYj+z25Zw0d9+3ha+w=
X-Received: by 2002:a17:906:4e98:b0:a77:cc6f:e792 with SMTP id
 a640c23a62f3a-a780b8802f0mr1118280266b.51.1721033443494; Mon, 15 Jul 2024
 01:50:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710044542.444-1-qiang.zhang1211@gmail.com> <CALm+0cUEqgDY_-4OjNYrWhzgP1YB79pP3SdjN2wgoMs65QwP6Q@mail.gmail.com>
In-Reply-To: <CALm+0cUEqgDY_-4OjNYrWhzgP1YB79pP3SdjN2wgoMs65QwP6Q@mail.gmail.com>
From: Neeraj upadhyay <neeraj.iitr10@gmail.com>
Date: Mon, 15 Jul 2024 14:20:30 +0530
Message-ID: <CAFwiDX8hXS72j9m894hSd_hrAvSZ2DZMBu1sncygQNaupx1w8g@mail.gmail.com>
Subject: Re: [PATCH v3] rcu-tasks: Fix access non-existent percpu rtpcp
 variable in rcu_tasks_need_gpcb()
To: Z qiang <qiang.zhang1211@gmail.com>
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org, 
	joel@joelfernandes.org, urezki@gmail.com, boqun.feng@gmail.com, 
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 1:40=E2=80=AFPM Z qiang <qiang.zhang1211@gmail.com>=
 wrote:
>
> >
> > For kernels built with CONFIG_FORCE_NR_CPUS=3Dy, the nr_cpu_ids is
> > defined as NR_CPUS instead of the number of possible cpus, this
> > will cause the following system panic:
> >
> > smpboot: Allowing 4 CPUs, 0 hotplug CPUs
> > ...
> > setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:512 nr_node_id=
s:1
> > ...
> > BUG: unable to handle page fault for address: ffffffff9911c8c8
> > #PF: supervisor read access in kernel mode
> > #PF: error_code(0x0000) - not-present page
> > Oops: 0000 [#1] PREEMPT SMP PTI
> > CPU: 0 PID: 15 Comm: rcu_tasks_trace Tainted: G W
> > 6.6.21 #1 5dc7acf91a5e8e9ac9dcfc35bee0245691283ea6
> > RIP: 0010:rcu_tasks_need_gpcb+0x25d/0x2c0
> > RSP: 0018:ffffa371c00a3e60 EFLAGS: 00010082
> > CR2: ffffffff9911c8c8 CR3: 000000040fa20005 CR4: 00000000001706f0
> > Call Trace:
> > <TASK>
> > ? __die+0x23/0x80
> > ? page_fault_oops+0xa4/0x180
> > ? exc_page_fault+0x152/0x180
> > ? asm_exc_page_fault+0x26/0x40
> > ? rcu_tasks_need_gpcb+0x25d/0x2c0
> > ? __pfx_rcu_tasks_kthread+0x40/0x40
> > rcu_tasks_one_gp+0x69/0x180
> > rcu_tasks_kthread+0x94/0xc0
> > kthread+0xe8/0x140
> > ? __pfx_kthread+0x40/0x40
> > ret_from_fork+0x34/0x80
> > ? __pfx_kthread+0x40/0x40
> > ret_from_fork_asm+0x1b/0x80
> > </TASK>
> >
> > Considering that there may be holes in the CPU numbers, use the
> > maximum possible cpu number, instead of nr_cpu_ids, for configuring
> > enqueue and dequeue limits.
> >
> > Closes: https://lore.kernel.org/linux-input/CALMA0xaTSMN+p4xUXkzrtR5r6k=
7hgoswcaXx7baR_z9r5jjskw@mail.gmail.com/T/#u
> > Reported-by: Zhixu Liu <zhixu.liu@gmail.com>
> > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > ---
> >  kernel/rcu/tasks.h | 80 +++++++++++++++++++++++++++++-----------------
> >  1 file changed, 51 insertions(+), 29 deletions(-)
> >
> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > index 2b1d6abf3ba3..12d63ce84cc9 100644
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -49,6 +49,7 @@ struct rcu_tasks_percpu {
> >         struct list_head rtp_blkd_tasks;
> >         struct list_head rtp_exit_list;
> >         int cpu;
> > +       int index;
> >         struct rcu_tasks *rtpp;
> >  };
> >
> > @@ -110,6 +111,7 @@ struct rcu_tasks {
> >         call_rcu_func_t call_func;
> >         unsigned int wait_state;
> >         struct rcu_tasks_percpu __percpu *rtpcpu;
> > +       struct rcu_tasks_percpu **rtpcp_array;
> >         int percpu_enqueue_shift;
> >         int percpu_enqueue_lim;
> >         int percpu_dequeue_lim;
> > @@ -182,6 +184,8 @@ module_param(rcu_task_collapse_lim, int, 0444);
> >  static int rcu_task_lazy_lim __read_mostly =3D 32;
> >  module_param(rcu_task_lazy_lim, int, 0444);
> >
> > +static int rcu_task_cpu_ids;
> > +
> >  /* RCU tasks grace-period state for debugging. */
> >  #define RTGS_INIT               0
> >  #define RTGS_WAIT_WAIT_CBS      1
> > @@ -245,6 +249,8 @@ static void cblist_init_generic(struct rcu_tasks *r=
tp)
> >         int cpu;
> >         int lim;
> >         int shift;
> > +       int maxcpu;
> > +       int index =3D 0;
> >
> >         if (rcu_task_enqueue_lim < 0) {
> >                 rcu_task_enqueue_lim =3D 1;
> > @@ -254,14 +260,9 @@ static void cblist_init_generic(struct rcu_tasks *=
rtp)
> >         }
> >         lim =3D rcu_task_enqueue_lim;
> >
> > -       if (lim > nr_cpu_ids)
> > -               lim =3D nr_cpu_ids;
> > -       shift =3D ilog2(nr_cpu_ids / lim);
> > -       if (((nr_cpu_ids - 1) >> shift) >=3D lim)
> > -               shift++;
> > -       WRITE_ONCE(rtp->percpu_enqueue_shift, shift);
> > -       WRITE_ONCE(rtp->percpu_dequeue_lim, lim);
> > -       smp_store_release(&rtp->percpu_enqueue_lim, lim);
> > +       rtp->rtpcp_array =3D kcalloc(num_possible_cpus(), sizeof(struct=
 rcu_tasks_percpu *), GFP_KERNEL);
> > +       BUG_ON(!rtp->rtpcp_array);
> > +
> >         for_each_possible_cpu(cpu) {
> >                 struct rcu_tasks_percpu *rtpcp =3D per_cpu_ptr(rtp->rtp=
cpu, cpu);
> >
> > @@ -273,14 +274,29 @@ static void cblist_init_generic(struct rcu_tasks =
*rtp)
> >                 INIT_WORK(&rtpcp->rtp_work, rcu_tasks_invoke_cbs_wq);
> >                 rtpcp->cpu =3D cpu;
> >                 rtpcp->rtpp =3D rtp;
> > +               rtpcp->index =3D index;
> > +               rtp->rtpcp_array[index] =3D rtpcp;
> > +               index++;
> >                 if (!rtpcp->rtp_blkd_tasks.next)
> >                         INIT_LIST_HEAD(&rtpcp->rtp_blkd_tasks);
> >                 if (!rtpcp->rtp_exit_list.next)
> >                         INIT_LIST_HEAD(&rtpcp->rtp_exit_list);
> > +               maxcpu =3D cpu;
> >         }
> >
> > -       pr_info("%s: Setting shift to %d and lim to %d rcu_task_cb_adju=
st=3D%d.\n", rtp->name,
> > -                       data_race(rtp->percpu_enqueue_shift), data_race=
(rtp->percpu_enqueue_lim), rcu_task_cb_adjust);
> > +       rcu_task_cpu_ids =3D maxcpu + 1;
> > +       if (lim > rcu_task_cpu_ids)
> > +               lim =3D rcu_task_cpu_ids;
> > +       shift =3D ilog2(rcu_task_cpu_ids / lim);
> > +       if (((rcu_task_cpu_ids - 1) >> shift) >=3D lim)
> > +               shift++;
> > +       WRITE_ONCE(rtp->percpu_enqueue_shift, shift);
> > +       WRITE_ONCE(rtp->percpu_dequeue_lim, lim);
> > +       smp_store_release(&rtp->percpu_enqueue_lim, lim);
>
> It seems that smp_store_release does not need,  the
> WRITE_ONCE(rtp->percpu_enqueue_lim, lim)
> is enough, cblist_init_generic() is invoke in early boot, at this
> time,  no other tasks access these
> percpu_*lim.
>

Yes, it makes sense to me. Also, the corresponding acquire has moved to
->percpu_dequeue_lim. So, this is something which can be done and
evaluated as a separate change.


- Neeraj

> Thanks
> Zqiang
>
>
> > +
> > +       pr_info("%s: Setting shift to %d and lim to %d rcu_task_cb_adju=
st=3D%d rcu_task_cpu_ids=3D%d.\n",
> > +                       rtp->name, data_race(rtp->percpu_enqueue_shift)=
, data_race(rtp->percpu_enqueue_lim),
> > +                       rcu_task_cb_adjust, rcu_task_cpu_ids);
> >  }
> >
> >  // Compute wakeup time for lazy callback timer.
> > @@ -348,7 +364,7 @@ static void call_rcu_tasks_generic(struct rcu_head =
*rhp, rcu_callback_t func,
> >                         rtpcp->rtp_n_lock_retries =3D 0;
> >                 }
> >                 if (rcu_task_cb_adjust && ++rtpcp->rtp_n_lock_retries >=
 rcu_task_contend_lim &&
> > -                   READ_ONCE(rtp->percpu_enqueue_lim) !=3D nr_cpu_ids)
> > +                   READ_ONCE(rtp->percpu_enqueue_lim) !=3D rcu_task_cp=
u_ids)
> >                         needadjust =3D true;  // Defer adjustment to av=
oid deadlock.
> >         }
> >         // Queuing callbacks before initialization not yet supported.
> > @@ -368,10 +384,10 @@ static void call_rcu_tasks_generic(struct rcu_hea=
d *rhp, rcu_callback_t func,
> >         raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
> >         if (unlikely(needadjust)) {
> >                 raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
> > -               if (rtp->percpu_enqueue_lim !=3D nr_cpu_ids) {
> > +               if (rtp->percpu_enqueue_lim !=3D rcu_task_cpu_ids) {
> >                         WRITE_ONCE(rtp->percpu_enqueue_shift, 0);
> > -                       WRITE_ONCE(rtp->percpu_dequeue_lim, nr_cpu_ids)=
;
> > -                       smp_store_release(&rtp->percpu_enqueue_lim, nr_=
cpu_ids);
> > +                       WRITE_ONCE(rtp->percpu_dequeue_lim, rcu_task_cp=
u_ids);
> > +                       smp_store_release(&rtp->percpu_enqueue_lim, rcu=
_task_cpu_ids);
> >                         pr_info("Switching %s to per-CPU callback queui=
ng.\n", rtp->name);
> >                 }
> >                 raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
> > @@ -444,6 +460,8 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rt=
p)
> >
> >         dequeue_limit =3D smp_load_acquire(&rtp->percpu_dequeue_lim);
> >         for (cpu =3D 0; cpu < dequeue_limit; cpu++) {
> > +               if (!cpu_possible(cpu))
> > +                       continue;
> >                 struct rcu_tasks_percpu *rtpcp =3D per_cpu_ptr(rtp->rtp=
cpu, cpu);
> >
> >                 /* Advance and accelerate any new callbacks. */
> > @@ -481,7 +499,7 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rt=
p)
> >         if (rcu_task_cb_adjust && ncbs <=3D rcu_task_collapse_lim) {
> >                 raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
> >                 if (rtp->percpu_enqueue_lim > 1) {
> > -                       WRITE_ONCE(rtp->percpu_enqueue_shift, order_bas=
e_2(nr_cpu_ids));
> > +                       WRITE_ONCE(rtp->percpu_enqueue_shift, order_bas=
e_2(rcu_task_cpu_ids));
> >                         smp_store_release(&rtp->percpu_enqueue_lim, 1);
> >                         rtp->percpu_dequeue_gpseq =3D get_state_synchro=
nize_rcu();
> >                         gpdone =3D false;
> > @@ -496,7 +514,9 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rt=
p)
> >                         pr_info("Completing switch %s to CPU-0 callback=
 queuing.\n", rtp->name);
> >                 }
> >                 if (rtp->percpu_dequeue_lim =3D=3D 1) {
> > -                       for (cpu =3D rtp->percpu_dequeue_lim; cpu < nr_=
cpu_ids; cpu++) {
> > +                       for (cpu =3D rtp->percpu_dequeue_lim; cpu < rcu=
_task_cpu_ids; cpu++) {
> > +                               if (!cpu_possible(cpu))
> > +                                       continue;
> >                                 struct rcu_tasks_percpu *rtpcp =3D per_=
cpu_ptr(rtp->rtpcpu, cpu);
> >
> >                                 WARN_ON_ONCE(rcu_segcblist_n_cbs(&rtpcp=
->cblist));
> > @@ -511,30 +531,32 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *=
rtp)
> >  // Advance callbacks and invoke any that are ready.
> >  static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp, struct rcu_tas=
ks_percpu *rtpcp)
> >  {
> > -       int cpu;
> > -       int cpunext;
> >         int cpuwq;
> >         unsigned long flags;
> >         int len;
> > +       int index;
> >         struct rcu_head *rhp;
> >         struct rcu_cblist rcl =3D RCU_CBLIST_INITIALIZER(rcl);
> >         struct rcu_tasks_percpu *rtpcp_next;
> >
> > -       cpu =3D rtpcp->cpu;
> > -       cpunext =3D cpu * 2 + 1;
> > -       if (cpunext < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
> > -               rtpcp_next =3D per_cpu_ptr(rtp->rtpcpu, cpunext);
> > -               cpuwq =3D rcu_cpu_beenfullyonline(cpunext) ? cpunext : =
WORK_CPU_UNBOUND;
> > -               queue_work_on(cpuwq, system_wq, &rtpcp_next->rtp_work);
> > -               cpunext++;
> > -               if (cpunext < smp_load_acquire(&rtp->percpu_dequeue_lim=
)) {
> > -                       rtpcp_next =3D per_cpu_ptr(rtp->rtpcpu, cpunext=
);
> > -                       cpuwq =3D rcu_cpu_beenfullyonline(cpunext) ? cp=
unext : WORK_CPU_UNBOUND;
> > +       index =3D rtpcp->index * 2 + 1;
> > +       if (index < num_possible_cpus()) {
> > +               rtpcp_next =3D rtp->rtpcp_array[index];
> > +               if (rtpcp_next->cpu < smp_load_acquire(&rtp->percpu_deq=
ueue_lim)) {
> > +                       cpuwq =3D rcu_cpu_beenfullyonline(rtpcp_next->c=
pu) ? rtpcp_next->cpu : WORK_CPU_UNBOUND;
> >                         queue_work_on(cpuwq, system_wq, &rtpcp_next->rt=
p_work);
> > +                       index++;
> > +                       if (index < num_possible_cpus()) {
> > +                               rtpcp_next =3D rtp->rtpcp_array[index];
> > +                               if (rtpcp_next->cpu < smp_load_acquire(=
&rtp->percpu_dequeue_lim)) {
> > +                                       cpuwq =3D rcu_cpu_beenfullyonli=
ne(rtpcp_next->cpu) ? rtpcp_next->cpu : WORK_CPU_UNBOUND;
> > +                                       queue_work_on(cpuwq, system_wq,=
 &rtpcp_next->rtp_work);
> > +                               }
> > +                       }
> >                 }
> >         }
> >
> > -       if (rcu_segcblist_empty(&rtpcp->cblist) || !cpu_possible(cpu))
> > +       if (rcu_segcblist_empty(&rtpcp->cblist))
> >                 return;
> >         raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
> >         rcu_segcblist_advance(&rtpcp->cblist, rcu_seq_current(&rtp->tas=
ks_gp_seq));
> > --
> > 2.17.1
> >
