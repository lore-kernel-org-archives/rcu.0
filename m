Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD4C80638;
	Mon,  8 Jul 2024 13:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720445942; cv=none; b=k18bGVgEFSJL0fqPMxPvtc0vS0pIrpsIFwgxIPcc996s2pKYsd7IADLC60Ldll3vjLKhRg3x7ktLJFnkv4fFMp63m0Mvu6VSf8SlvalP8VY4mhvykFWwp/rRaUDx5EHBCAfnJftWj8c0TZkFBqeNDunjqLXN/GU2XnD2Qdf6CEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720445942; c=relaxed/simple;
	bh=uk2Y45eS4ivodPkMU8DFezTOStSRkEEgl61phSx3r8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JhuQKRl562cn9mL9sXpE7GxC1H+rMW0+wvtqSDMEBC8Q0tEKjFowQKzmPM6oxx8oznAa6mdKEvlTC0yb9ZRCu+D8I0AhkxaBTj9u1bNKt7Ibdu5agjQOvN1nh87pXfC4gcf6Pb+gnb5PvUzG2M4P1RH46koCx1ALRcN7jIRSBqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ky7zI10l; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ky7zI10l"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ebe40673e8so51385661fa.3;
        Mon, 08 Jul 2024 06:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720445938; x=1721050738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cx9W65GHK3l2uSoCoYiyvNBp+enD15zymQ09Ony5qNw=;
        b=Ky7zI10lJ6XH7RRWJeL+vRVWtuWS1z4FzFfrp0Du/KRVl2Ev/TEUJwYQ9EPcA5kIx4
         v0sC/Tv/eQZQf8q957bO1Cc+4z35wIxAKM6mDxLJLp4ItKXFWGQdlRX5LfxcmKI5gyBd
         9nDI+bwpNckMWPqz+Hm/giRSvwrVUSYCVvengeK1BGtBkmdoPkbwTiD6zKkZvKf2p7cg
         yu03TsQYW+iiG6RExrxydZo33qQmD9p3Ih2sfmiMTcABLXVMr3Md+qrtXXz6xhwKnX8D
         +OGCuXcl9RXShevxvemr0GrEfhuv+mUaep3GrzQQLVG1qkE+lCJ7Jnb92VVx6v21q6hl
         6+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720445938; x=1721050738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cx9W65GHK3l2uSoCoYiyvNBp+enD15zymQ09Ony5qNw=;
        b=A7voZXmSF1SBDyzFQCWqp0JaoN8MGsMP2tYQ9yPixWQedaGn9IVx2TtexwvFkyp21x
         xlZldrVPfO8am+KorW2qOuvQ6O64xoAJLwIrsbwK8InF4Ve6rpJTRsKf2NM70J6jSR2o
         YcxTadtBWHaqRdcgbOgnREq6MklkuQ6xAKYTvi1LgcfNhfZF5tmHm6iUywJLHLB68M6a
         3tiwArjuQVguPhr45W26UHHfYAxBvksa9xvaKcvs5Se6WAJVpQe3W8bfK/mX22eWmYKD
         rhKpeDDZPOHg3Wu7BmiMvwjJLwQ2n0+5PLQhKDe735KNopFlTnpbaOzTlH93s1VTL9U4
         0MjA==
X-Forwarded-Encrypted: i=1; AJvYcCU4KPyUS8sv89p3IJsL7J4LJHx0nAqt/sCh1qW9Jn2ls71e/TizX/Hxk0m7OKKXWOW7PZCJqYlHN2/ymdVq3PK6ywMFcHM/o57n7C7aZYVSqjdUQvUmHLSPDDRnV5SG8X/x
X-Gm-Message-State: AOJu0YxwGI9iSC2vqC7eEK/yWcLqzDgZIq/2vNpVqL7mbwh3XP+rEtn2
	S5itg1jYpwGnTGj4SXBkHjcZMhkZHLm8KXIuH+F6QvcdvqPqkroJNq4re9OgDToxGH2E9VF935Y
	NnzlBFHI0CIL02riTJk6dlW+/qAI=
X-Google-Smtp-Source: AGHT+IFCS9NMv9wdLuzfWo0tETRcCeFENcPIznD4mzzRQQ1LQCLTxY5aSfks+W94yTwVVgHrM3m1PGBymXg6NtHxyD8=
X-Received: by 2002:a2e:bb85:0:b0:2ee:8817:422b with SMTP id
 38308e7fff4ca-2ee8ed8f728mr65378571fa.19.1720445938107; Mon, 08 Jul 2024
 06:38:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604085401.14733-1-qiang.zhang1211@gmail.com>
In-Reply-To: <20240604085401.14733-1-qiang.zhang1211@gmail.com>
From: Neeraj upadhyay <neeraj.iitr10@gmail.com>
Date: Mon, 8 Jul 2024 19:08:45 +0530
Message-ID: <CAFwiDX-fFSHmHxKyM8U1Eu89hj5ZZjLJMsW2Q2z6gqsdoaem9g@mail.gmail.com>
Subject: Re: [PATCH v2] rcu-tasks: Fix access non-existent percpu rtpcp
 variable in rcu_tasks_need_gpcb()
To: Zqiang <qiang.zhang1211@gmail.com>
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org, 
	joel@joelfernandes.org, urezki@gmail.com, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhixu.liu@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zqiang,


On Tue, Jun 4, 2024 at 2:24=E2=80=AFPM Zqiang <qiang.zhang1211@gmail.com> w=
rote:
>
> For kernels built with CONFIG_FORCE_NR_CPUS=3Dy, the nr_cpu_ids is
> defined as NR_CPUS instead of the number of possible cpus, this
> will cause the following system panic:
>
> [    0.015349][    T0] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
> ...
> [    0.021342][    T0] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_c=
pu_ids:512 nr_node_ids:1
> ...
> [    3.681252][   T15] BUG: unable to handle page fault for address: ffff=
ffff9911c8c8
> [    3.689415][   T45] ehci-pci 0000:00:1a.0: debug port 2
> [    3.697008][   T15] #PF: supervisor read access in kernel mode
> [    3.697009][   T15] #PF: error_code(0x0000) - not-present page
> [    3.706233][   T45] ehci-pci 0000:00:1a.0: irq 16, io mem 0xf7e3c000
> [    3.708152][   T15] PGD 40fa24067 P4D 40fa24067 PUD 40fa25063 PMD 410b=
ff063
> [    3.720380][   T45] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
> [    3.720430][   T15] PTE 800ffffbefee3062
> [    3.720431][   T15] Oops: 0000 [#1] PREEMPT SMP PTI
> [    3.727873][   T45] usb usb2: New USB device found, idVendor=3D1d6b, i=
dProduct=3D0002, bcdDevice=3D 6.06
> [    3.734009][   T15] CPU: 0 PID: 15 Comm: rcu_tasks_trace Tainted: G W =
         6.6.21 #1 5dc7acf91a5e8e9ac9dcfc35bee0245691283ea6
> [    3.734011][   T15] Hardware name: Dell Inc. OptiPlex 9020/005T15, BIO=
S A14 09/14/2015
> [    3.734012][   T15] RIP: 0010:rcu_tasks_need_gpcb+0x25d/0x2c0
> [    3.737962][   T45] usb usb2: New USB device strings: Mfr=3D3, Product=
=3D2, SerialNumber=3D1
> [    3.742877][   T15] RSP: 0018:ffffa371c00a3e60 EFLAGS: 00010082
> [    3.751891][   T45] usb usb2: Product: EHCI Host Controller
> [    3.764495][   T15]
> [    3.764496][   T15] RAX: ffffffff98929ca0 RBX: ffffffff98b3b328 RCX: 0=
000000000021880
> [    3.764497][   T15] RDX: ffffffff9911c880 RSI: 0000000000000000 RDI: 0=
000000000000000
> [    3.772461][   T45] usb usb2: Manufacturer: Linux 6.6.21 ehci_hcd
> [    3.778248][   T15] RBP: 0000000000000202 R08: 0000000000000000 R09: 0=
000000000000000
> [    3.778249][   T15] R10: 0000000000000000 R11: 0000000000000000 R12: 0=
000000000000003
> [    3.778249][   T15] R13: 0000000000000000 R14: 0000000000000001 R15: f=
fffffff98b3b320
> [    3.786216][   T45] usb usb2: SerialNumber: 0000:00:1a.0
> [    3.805811][   T15] FS:  0000000000000000(0000) GS:ffff8c781ea00000(00=
00) knlGS:0000000000000000
> [    3.805813][   T15] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    3.811993][   T45] hub 2-0:1.0: USB hub found
> [    3.817383][   T15] CR2: ffffffff9911c8c8 CR3: 000000040fa20005 CR4: 0=
0000000001706f0
> [    3.817385][   T15] Call Trace:
> [    3.817386][   T15]  <TASK>
> [    3.817388][   T15]  ? __die+0x23/0x80
> [    3.819643][   T45] hub 2-0:1.0: 2 ports detected
> [    3.827481][   T15]  ? page_fault_oops+0xa4/0x180
> [    3.827485][   T15]  ? exc_page_fault+0x152/0x180
> [    3.922376][   T15]  ? asm_exc_page_fault+0x26/0x40
> [    3.927289][   T15]  ? rcu_tasks_need_gpcb+0x25d/0x2c0
> [    3.932459][   T15]  ? __pfx_rcu_tasks_kthread+0x40/0x40
> [    3.937806][   T15]  rcu_tasks_one_gp+0x69/0x180
> [    3.942451][   T15]  rcu_tasks_kthread+0x94/0xc0
> [    3.947096][   T15]  kthread+0xe8/0x140
> [    3.950956][   T15]  ? __pfx_kthread+0x40/0x40
> [    3.955425][   T15]  ret_from_fork+0x34/0x80
> [    3.959721][   T15]  ? __pfx_kthread+0x40/0x40
> [    3.964192][   T15]  ret_from_fork_asm+0x1b/0x80
> [    3.968841][   T15]  </TASK>
>
> Consider that there may be holes in the CPU numbers, this commit
> use the maxcpu variable to store the CPU numbers after traversing
> possible cpu, and generate the rcu_task_cpu_ids variable and assign
> it to (maxcpu +1) instead of nr_cpu_ids.
>
> Closes: https://lore.kernel.org/linux-input/CALMA0xaTSMN+p4xUXkzrtR5r6k7h=
goswcaXx7baR_z9r5jjskw@mail.gmail.com/T/#u
> Reported-by: Zhixu Liu <zhixu.liu@gmail.com>
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> ---
>  kernel/rcu/tasks.h | 78 +++++++++++++++++++++++++++++-----------------
>  1 file changed, 49 insertions(+), 29 deletions(-)
>
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index e362f72bb65d..22310965acc7 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -49,6 +49,7 @@ struct rcu_tasks_percpu {
>         struct list_head rtp_blkd_tasks;
>         struct list_head rtp_exit_list;
>         int cpu;
> +       int index;
>         struct rcu_tasks *rtpp;
>  };
>
> @@ -110,6 +111,7 @@ struct rcu_tasks {
>         call_rcu_func_t call_func;
>         unsigned int wait_state;
>         struct rcu_tasks_percpu __percpu *rtpcpu;
> +       struct rcu_tasks_percpu **rtpcp_array;
>         int percpu_enqueue_shift;
>         int percpu_enqueue_lim;
>         int percpu_dequeue_lim;
> @@ -182,6 +184,8 @@ module_param(rcu_task_collapse_lim, int, 0444);
>  static int rcu_task_lazy_lim __read_mostly =3D 32;
>  module_param(rcu_task_lazy_lim, int, 0444);
>
> +static int rcu_task_cpu_ids;
> +
>  /* RCU tasks grace-period state for debugging. */
>  #define RTGS_INIT               0
>  #define RTGS_WAIT_WAIT_CBS      1
> @@ -245,6 +249,8 @@ static void cblist_init_generic(struct rcu_tasks *rtp=
)
>         int cpu;
>         int lim;
>         int shift;
> +       int maxcpu;
> +       int index =3D 0;
>
>         if (rcu_task_enqueue_lim < 0) {
>                 rcu_task_enqueue_lim =3D 1;
> @@ -254,14 +260,9 @@ static void cblist_init_generic(struct rcu_tasks *rt=
p)
>         }
>         lim =3D rcu_task_enqueue_lim;
>
> -       if (lim > nr_cpu_ids)
> -               lim =3D nr_cpu_ids;
> -       shift =3D ilog2(nr_cpu_ids / lim);
> -       if (((nr_cpu_ids - 1) >> shift) >=3D lim)
> -               shift++;
> -       WRITE_ONCE(rtp->percpu_enqueue_shift, shift);
> -       WRITE_ONCE(rtp->percpu_dequeue_lim, lim);
> -       smp_store_release(&rtp->percpu_enqueue_lim, lim);
> +       rtp->rtpcp_array =3D kcalloc(num_possible_cpus(), sizeof(struct r=
cu_tasks_percpu *), GFP_KERNEL);
> +       BUG_ON(!rtp->rtpcp_array);
> +
>         for_each_possible_cpu(cpu) {
>                 struct rcu_tasks_percpu *rtpcp =3D per_cpu_ptr(rtp->rtpcp=
u, cpu);
>
> @@ -273,14 +274,29 @@ static void cblist_init_generic(struct rcu_tasks *r=
tp)
>                 INIT_WORK(&rtpcp->rtp_work, rcu_tasks_invoke_cbs_wq);
>                 rtpcp->cpu =3D cpu;
>                 rtpcp->rtpp =3D rtp;
> +               rtpcp->index =3D index;
> +               rtp->rtpcp_array[index] =3D rtpcp;
> +               index++;
>                 if (!rtpcp->rtp_blkd_tasks.next)
>                         INIT_LIST_HEAD(&rtpcp->rtp_blkd_tasks);
>                 if (!rtpcp->rtp_exit_list.next)
>                         INIT_LIST_HEAD(&rtpcp->rtp_exit_list);
> +               maxcpu =3D cpu;
>         }
>
> -       pr_info("%s: Setting shift to %d and lim to %d rcu_task_cb_adjust=
=3D%d.\n", rtp->name,
> -                       data_race(rtp->percpu_enqueue_shift), data_race(r=
tp->percpu_enqueue_lim), rcu_task_cb_adjust);
> +       rcu_task_cpu_ids =3D maxcpu + 1;
> +       if (lim > rcu_task_cpu_ids)
> +               lim =3D rcu_task_cpu_ids;
> +       shift =3D ilog2(rcu_task_cpu_ids / lim);
> +       if (((rcu_task_cpu_ids - 1) >> shift) >=3D lim)
> +               shift++;
> +       WRITE_ONCE(rtp->percpu_enqueue_shift, shift);
> +       WRITE_ONCE(rtp->percpu_dequeue_lim, lim);
> +       smp_store_release(&rtp->percpu_enqueue_lim, lim);
> +
> +       pr_info("%s: Setting shift to %d and lim to %d rcu_task_cb_adjust=
=3D%d rcu_task_cpu_ids=3D%d.\n",
> +                       rtp->name, data_race(rtp->percpu_enqueue_shift), =
data_race(rtp->percpu_enqueue_lim),
> +                       rcu_task_cb_adjust, rcu_task_cpu_ids);
>  }
>
>  // Compute wakeup time for lazy callback timer.
> @@ -348,7 +364,7 @@ static void call_rcu_tasks_generic(struct rcu_head *r=
hp, rcu_callback_t func,
>                         rtpcp->rtp_n_lock_retries =3D 0;
>                 }
>                 if (rcu_task_cb_adjust && ++rtpcp->rtp_n_lock_retries > r=
cu_task_contend_lim &&
> -                   READ_ONCE(rtp->percpu_enqueue_lim) !=3D nr_cpu_ids)
> +                   READ_ONCE(rtp->percpu_enqueue_lim) !=3D rcu_task_cpu_=
ids)
>                         needadjust =3D true;  // Defer adjustment to avoi=
d deadlock.
>         }
>         // Queuing callbacks before initialization not yet supported.
> @@ -368,10 +384,10 @@ static void call_rcu_tasks_generic(struct rcu_head =
*rhp, rcu_callback_t func,
>         raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
>         if (unlikely(needadjust)) {
>                 raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
> -               if (rtp->percpu_enqueue_lim !=3D nr_cpu_ids) {
> +               if (rtp->percpu_enqueue_lim !=3D rcu_task_cpu_ids) {
>                         WRITE_ONCE(rtp->percpu_enqueue_shift, 0);
> -                       WRITE_ONCE(rtp->percpu_dequeue_lim, nr_cpu_ids);
> -                       smp_store_release(&rtp->percpu_enqueue_lim, nr_cp=
u_ids);
> +                       WRITE_ONCE(rtp->percpu_dequeue_lim, rcu_task_cpu_=
ids);
> +                       smp_store_release(&rtp->percpu_enqueue_lim, rcu_t=
ask_cpu_ids);
>                         pr_info("Switching %s to per-CPU callback queuing=
.\n", rtp->name);
>                 }
>                 raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
> @@ -481,7 +497,7 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
>         if (rcu_task_cb_adjust && ncbs <=3D rcu_task_collapse_lim) {
>                 raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
>                 if (rtp->percpu_enqueue_lim > 1) {
> -                       WRITE_ONCE(rtp->percpu_enqueue_shift, order_base_=
2(nr_cpu_ids));
> +                       WRITE_ONCE(rtp->percpu_enqueue_shift, order_base_=
2(rcu_task_cpu_ids));
>                         smp_store_release(&rtp->percpu_enqueue_lim, 1);
>                         rtp->percpu_dequeue_gpseq =3D get_state_synchroni=
ze_rcu();
>                         gpdone =3D false;
> @@ -496,7 +512,9 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
>                         pr_info("Completing switch %s to CPU-0 callback q=
ueuing.\n", rtp->name);
>                 }
>                 if (rtp->percpu_dequeue_lim =3D=3D 1) {
> -                       for (cpu =3D rtp->percpu_dequeue_lim; cpu < nr_cp=
u_ids; cpu++) {
> +                       for (cpu =3D rtp->percpu_dequeue_lim; cpu < rcu_t=
ask_cpu_ids; cpu++) {
> +                               if (!cpu_possible(cpu))
> +                                       continue;

Do we also need a `!cpu_possible(cpu)` check in `for (cpu =3D 0; cpu <
dequeue_limit; cpu++)`
loop in the same function rcu_tasks_need_gpcb()?


- Neeraj



>                                 struct rcu_tasks_percpu *rtpcp =3D per_cp=
u_ptr(rtp->rtpcpu, cpu);
>
>                                 WARN_ON_ONCE(rcu_segcblist_n_cbs(&rtpcp->=
cblist));
> @@ -511,30 +529,32 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rt=
p)
>  // Advance callbacks and invoke any that are ready.
>  static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp, struct rcu_tasks=
_percpu *rtpcp)
>  {
> -       int cpu;
> -       int cpunext;
>         int cpuwq;
>         unsigned long flags;
>         int len;
> +       int index;
>         struct rcu_head *rhp;
>         struct rcu_cblist rcl =3D RCU_CBLIST_INITIALIZER(rcl);
>         struct rcu_tasks_percpu *rtpcp_next;
>
> -       cpu =3D rtpcp->cpu;
> -       cpunext =3D cpu * 2 + 1;
> -       if (cpunext < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
> -               rtpcp_next =3D per_cpu_ptr(rtp->rtpcpu, cpunext);
> -               cpuwq =3D rcu_cpu_beenfullyonline(cpunext) ? cpunext : WO=
RK_CPU_UNBOUND;
> -               queue_work_on(cpuwq, system_wq, &rtpcp_next->rtp_work);
> -               cpunext++;
> -               if (cpunext < smp_load_acquire(&rtp->percpu_dequeue_lim))=
 {
> -                       rtpcp_next =3D per_cpu_ptr(rtp->rtpcpu, cpunext);
> -                       cpuwq =3D rcu_cpu_beenfullyonline(cpunext) ? cpun=
ext : WORK_CPU_UNBOUND;
> +       index =3D rtpcp->index * 2 + 1;
> +       if (index < num_possible_cpus()) {
> +               rtpcp_next =3D rtp->rtpcp_array[index];
> +               if (rtpcp_next->cpu < smp_load_acquire(&rtp->percpu_deque=
ue_lim)) {
> +                       cpuwq =3D rcu_cpu_beenfullyonline(rtpcp_next->cpu=
) ? rtpcp_next->cpu : WORK_CPU_UNBOUND;
>                         queue_work_on(cpuwq, system_wq, &rtpcp_next->rtp_=
work);
> +                       index++;
> +                       if (index < num_possible_cpus()) {
> +                               rtpcp_next =3D rtp->rtpcp_array[index];
> +                               if (rtpcp_next->cpu < smp_load_acquire(&r=
tp->percpu_dequeue_lim)) {
> +                                       cpuwq =3D rcu_cpu_beenfullyonline=
(rtpcp_next->cpu) ? rtpcp_next->cpu : WORK_CPU_UNBOUND;
> +                                       queue_work_on(cpuwq, system_wq, &=
rtpcp_next->rtp_work);
> +                               }
> +                       }
>                 }
>         }
>
> -       if (rcu_segcblist_empty(&rtpcp->cblist) || !cpu_possible(cpu))
> +       if (rcu_segcblist_empty(&rtpcp->cblist))
>                 return;
>         raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
>         rcu_segcblist_advance(&rtpcp->cblist, rcu_seq_current(&rtp->tasks=
_gp_seq));
> --
> 2.17.1
>
