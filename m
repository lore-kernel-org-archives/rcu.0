Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB2B823CB;
	Tue,  9 Jul 2024 06:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720505700; cv=none; b=hYw32g6Vum5xY3xwKI04coGxcCufd6yMQHwZDjPRS/FJU7c80y3NJ6d8sudUz7nd3g+5pWz+qIrAiAWiHQnGfieNqkJihZlUHlwZov8/zjXwAqUlZbGrWY3D0j7oojmf73Z9OUXC96XJCigcoT4PgsM6oMZHAEFUIYvH/dfYtVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720505700; c=relaxed/simple;
	bh=uaf0k918GNzEIlQzbepz4RbQ9hFNTvCjKeogRrx7w48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QDkFyxoNIINDBf4j1X5H09ihyZewS2BHQDtN2mP4Cy/UByRGgJ27IRdszttDX5SAOcn8GLDx9XbxJ7RNRGmU3rMZ+OziM0+A2d7lxdscupp3L2gmOTePwPdPsIG/9h+mc7wx/aDAp37YIfGgiQxwMeKK5P+DZlN7IBCOnP/mHZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahBZa1Yd; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahBZa1Yd"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-70df213542bso2423527a12.3;
        Mon, 08 Jul 2024 23:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720505698; x=1721110498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6flLYQpcWy6NEE80YV45Eq5sQtMIrLlINbc9bk0jDk8=;
        b=ahBZa1Ydqlt+/DQBdo3h+E3erVt+kM8PErCSF8tkyZEU9AMO/c80NSDZpCI9xIvMfT
         H/1mG1Qpgx2ZjyN7ShpWdzBG+qmm7ElbiAsjlZ7YiC4GzXLMPzj6oLxYOuw5solzpIe1
         q4rD3WCGk5EDFY55F5aq4fPR2EIisibmpVRSZI3HL7EFLpZpiRO9qOP8dT2+1Tzz0T+N
         D5yL1oqTpd89ofHFjZvM8jiKD7/9AcacsU3YngVbcZHQxhAAKgYm1koim1iUiEpG/NX6
         SaQlegXfDAJG7f2CihL9EvuRdx5QX5706Qtz0EUMOxRHX1bLRofz4NKy2AJvORGiPOEf
         x30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720505698; x=1721110498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6flLYQpcWy6NEE80YV45Eq5sQtMIrLlINbc9bk0jDk8=;
        b=AHodKyKxcjFyJWmx5M9jvRzdljFv399Ov/b1aiHAUde7HNrm+hs1RxnMXwgkVrP3z3
         YSafM9vAc1s5EcE5mff7u/+02TVLK/1s6Hb6M8DUfEAw+4bu79Abyg0nFlf18WwYR0ta
         WTPDhzgCvRWE07QBKcln+t5/Amhap1mzoWIK6uRKPOrpVbbCfVYJ9ze/JQp6yrpo9huv
         KZ7iKmNXAa89iMl6FD1P2Ii5lvj+aFd1YitHbvEs/tvQqnjFjb5qHIH41is3KuUmSugm
         FlMNUR5FDxJlGsSH368CHXOaLHUrnNmObK6MIJNGGZNTkvmEsoizTotMvmKfEFWu+2MN
         1YBw==
X-Forwarded-Encrypted: i=1; AJvYcCXXGLbtO/bH6M16SREHjiVUw7uY0HB9E4aQYjDzcWJpGGNaCu1KFFc9xcmC4jNZ7XMxjbr+0UhrCUPMlyNxG2/rYltBkVR4wfXaaLiZegGlwOXcgP28WkYvEZgzSr43bkPk
X-Gm-Message-State: AOJu0YyH4xlTOqo3+HNjLJfaAdbFnGr4yLrBGXIZB0t0xVsT3g38e65m
	d3UuU2WuLYnvI8+n0v6+9xeawGPrft1qmhTq+Na9JV4/hIY16s8cpdR5RahxFO5qopa2OIZVR2K
	ABO3X2htxJqlyN/D6bR9x6+EV79s=
X-Google-Smtp-Source: AGHT+IHa+53zCDeHmR81WLYyQi8Pxc0H3r7o79OYQ/LY6Lrj6JsBdDahghtssfQXCcWDEr4CTVzp2NcOeeRiO8Qi0wc=
X-Received: by 2002:a05:6a20:4320:b0:1c0:e629:390d with SMTP id
 adf61e73a8af0-1c29821e1abmr1955596637.16.1720505697720; Mon, 08 Jul 2024
 23:14:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604085401.14733-1-qiang.zhang1211@gmail.com> <CAFwiDX-fFSHmHxKyM8U1Eu89hj5ZZjLJMsW2Q2z6gqsdoaem9g@mail.gmail.com>
In-Reply-To: <CAFwiDX-fFSHmHxKyM8U1Eu89hj5ZZjLJMsW2Q2z6gqsdoaem9g@mail.gmail.com>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Tue, 9 Jul 2024 14:14:45 +0800
Message-ID: <CALm+0cUX+kz10LpCxj8ww+VEs4ifduODuJ1TM3t1GzAH13M9Zw@mail.gmail.com>
Subject: Re: [PATCH v2] rcu-tasks: Fix access non-existent percpu rtpcp
 variable in rcu_tasks_need_gpcb()
To: Neeraj upadhyay <neeraj.iitr10@gmail.com>
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org, 
	joel@joelfernandes.org, urezki@gmail.com, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhixu.liu@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> Hi Zqiang,
>
>
> On Tue, Jun 4, 2024 at 2:24=E2=80=AFPM Zqiang <qiang.zhang1211@gmail.com>=
 wrote:
> >
> > For kernels built with CONFIG_FORCE_NR_CPUS=3Dy, the nr_cpu_ids is
> > defined as NR_CPUS instead of the number of possible cpus, this
> > will cause the following system panic:
> >
> > [    0.015349][    T0] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
> > ...
> > [    0.021342][    T0] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr=
_cpu_ids:512 nr_node_ids:1
> > ...
> > [    3.681252][   T15] BUG: unable to handle page fault for address: ff=
ffffff9911c8c8
> > [    3.689415][   T45] ehci-pci 0000:00:1a.0: debug port 2
> > [    3.697008][   T15] #PF: supervisor read access in kernel mode
> > [    3.697009][   T15] #PF: error_code(0x0000) - not-present page
> > [    3.706233][   T45] ehci-pci 0000:00:1a.0: irq 16, io mem 0xf7e3c000
> > [    3.708152][   T15] PGD 40fa24067 P4D 40fa24067 PUD 40fa25063 PMD 41=
0bff063
> > [    3.720380][   T45] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.0=
0
> > [    3.720430][   T15] PTE 800ffffbefee3062
> > [    3.720431][   T15] Oops: 0000 [#1] PREEMPT SMP PTI
> > [    3.727873][   T45] usb usb2: New USB device found, idVendor=3D1d6b,=
 idProduct=3D0002, bcdDevice=3D 6.06
> > [    3.734009][   T15] CPU: 0 PID: 15 Comm: rcu_tasks_trace Tainted: G =
W          6.6.21 #1 5dc7acf91a5e8e9ac9dcfc35bee0245691283ea6
> > [    3.734011][   T15] Hardware name: Dell Inc. OptiPlex 9020/005T15, B=
IOS A14 09/14/2015
> > [    3.734012][   T15] RIP: 0010:rcu_tasks_need_gpcb+0x25d/0x2c0
> > [    3.737962][   T45] usb usb2: New USB device strings: Mfr=3D3, Produ=
ct=3D2, SerialNumber=3D1
> > [    3.742877][   T15] RSP: 0018:ffffa371c00a3e60 EFLAGS: 00010082
> > [    3.751891][   T45] usb usb2: Product: EHCI Host Controller
> > [    3.764495][   T15]
> > [    3.764496][   T15] RAX: ffffffff98929ca0 RBX: ffffffff98b3b328 RCX:=
 0000000000021880
> > [    3.764497][   T15] RDX: ffffffff9911c880 RSI: 0000000000000000 RDI:=
 0000000000000000
> > [    3.772461][   T45] usb usb2: Manufacturer: Linux 6.6.21 ehci_hcd
> > [    3.778248][   T15] RBP: 0000000000000202 R08: 0000000000000000 R09:=
 0000000000000000
> > [    3.778249][   T15] R10: 0000000000000000 R11: 0000000000000000 R12:=
 0000000000000003
> > [    3.778249][   T15] R13: 0000000000000000 R14: 0000000000000001 R15:=
 ffffffff98b3b320
> > [    3.786216][   T45] usb usb2: SerialNumber: 0000:00:1a.0
> > [    3.805811][   T15] FS:  0000000000000000(0000) GS:ffff8c781ea00000(=
0000) knlGS:0000000000000000
> > [    3.805813][   T15] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
> > [    3.811993][   T45] hub 2-0:1.0: USB hub found
> > [    3.817383][   T15] CR2: ffffffff9911c8c8 CR3: 000000040fa20005 CR4:=
 00000000001706f0
> > [    3.817385][   T15] Call Trace:
> > [    3.817386][   T15]  <TASK>
> > [    3.817388][   T15]  ? __die+0x23/0x80
> > [    3.819643][   T45] hub 2-0:1.0: 2 ports detected
> > [    3.827481][   T15]  ? page_fault_oops+0xa4/0x180
> > [    3.827485][   T15]  ? exc_page_fault+0x152/0x180
> > [    3.922376][   T15]  ? asm_exc_page_fault+0x26/0x40
> > [    3.927289][   T15]  ? rcu_tasks_need_gpcb+0x25d/0x2c0
> > [    3.932459][   T15]  ? __pfx_rcu_tasks_kthread+0x40/0x40
> > [    3.937806][   T15]  rcu_tasks_one_gp+0x69/0x180
> > [    3.942451][   T15]  rcu_tasks_kthread+0x94/0xc0
> > [    3.947096][   T15]  kthread+0xe8/0x140
> > [    3.950956][   T15]  ? __pfx_kthread+0x40/0x40
> > [    3.955425][   T15]  ret_from_fork+0x34/0x80
> > [    3.959721][   T15]  ? __pfx_kthread+0x40/0x40
> > [    3.964192][   T15]  ret_from_fork_asm+0x1b/0x80
> > [    3.968841][   T15]  </TASK>
> >
> > Consider that there may be holes in the CPU numbers, this commit
> > use the maxcpu variable to store the CPU numbers after traversing
> > possible cpu, and generate the rcu_task_cpu_ids variable and assign
> > it to (maxcpu +1) instead of nr_cpu_ids.
> >
> > Closes: https://lore.kernel.org/linux-input/CALMA0xaTSMN+p4xUXkzrtR5r6k=
7hgoswcaXx7baR_z9r5jjskw@mail.gmail.com/T/#u
> > Reported-by: Zhixu Liu <zhixu.liu@gmail.com>
> > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > ---
> >  kernel/rcu/tasks.h | 78 +++++++++++++++++++++++++++++-----------------
> >  1 file changed, 49 insertions(+), 29 deletions(-)
> >
> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > index e362f72bb65d..22310965acc7 100644
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
> > @@ -481,7 +497,7 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rt=
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
> > @@ -496,7 +512,9 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rt=
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
>
> Do we also need a `!cpu_possible(cpu)` check in `for (cpu =3D 0; cpu <
> dequeue_limit; cpu++)`
> loop in the same function rcu_tasks_need_gpcb()?

Thanks Neeraj, I will update :)

>
>
> - Neeraj
>
>
>
> >                                 struct rcu_tasks_percpu *rtpcp =3D per_=
cpu_ptr(rtp->rtpcpu, cpu);
> >
> >                                 WARN_ON_ONCE(rcu_segcblist_n_cbs(&rtpcp=
->cblist));
> > @@ -511,30 +529,32 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *=
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
