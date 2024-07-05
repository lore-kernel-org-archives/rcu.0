Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7311BF2B;
	Fri,  5 Jul 2024 02:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720146465; cv=none; b=nr7VWx3mQ0UoH6LhZEsVMVaRNPEJB3bw7+eEdoAgceiSi/xyog/PxmG5dCKsLya2qSuiekB6vjMbjZCj/jWiQTSfKT5WRl1dAFb0S8R2Bl62YzG3PK8lqVKuV+aQDHQm/qm8XfJ3g6ePav3n3lO5hhyn3pMdpMhWxSZ4JzN/bms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720146465; c=relaxed/simple;
	bh=S7XD80nOgP3jwSGiQBRT+Pt3ovBt0o42cMQQwLNw7Pw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E8z9hhygPzkhoWcMGT5zx4nxKIHZrxQLgpNPlRuKDgvUoPfvp8WFxWcTfsGgu2ldgY1NScaGvhxp819kducnBLKJ7I7mNGlsI9cmg5awCGf6BOI0FkhzvCNNlV4Bfw31eHCKUjFA5XAo/hgcF9v96OZLAjfkG5z7+6CKP4Duuls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lz+na3hG; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lz+na3hG"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2c8dccd0fa9so786836a91.2;
        Thu, 04 Jul 2024 19:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720146463; x=1720751263; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/E3hy8W+YaHsodpkMI2FX0JZHI9TBrdzzXfqOK/iWSQ=;
        b=lz+na3hGKx1oiUIugDl1zkLnMWT02HbxJD7mZRhPfxzdaugxVL185zjR2d9rxcPCf0
         BzYHIk/x3eAY+pw25Z/vuvL3XZiwG+CE1hlbUR8uKVz/W0hDW3KE3zZTB9Ju+cCZs8Wz
         mF977lPQj/7xihKIU0E08+ArYId2SHU+rbNNWaU8o0ifjMYeCrXfFWbfH1z1zY+KMD5B
         pA4EGN4qvt+7qSu59jnmgqNMFRY9NZVSUV9xQBpAe4hTE7T9DLBofqiZ0FmpkXW0buMp
         gpruMr4UjBD6dymhgqMzuPsXXZGGTGDa6mFTZsdRAKBWGdUAC7jDZnnMQlv//Pgf3rr0
         NVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720146463; x=1720751263;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/E3hy8W+YaHsodpkMI2FX0JZHI9TBrdzzXfqOK/iWSQ=;
        b=rvj8ow0HDkarIquxDX8GN9e4SrZZajlMnG7iKE12P6Anv91Ix7B+P7Ahw5cA5w70x2
         huqzZo6GQJ7ZQ3VsulZlPaNQC+AnY91TbYv+5tveErkKS86ZdAd7WWtH/YH0DtXJU/kI
         xjIh091Z/m2sTZoUqu72ZsfhNtGiVPOanF8hDZOBaCVHcGifq8VXAsMc6mF53CqhYqxE
         IXkTRlJflobhqt6MVBGyjvupYvLpT8E2cwdas80r8dATFN5DhKsy0BzvsDccYiaYr/Vi
         j1svoaHjIaAhUwAO8dt25gVacQ+lnXgmchQJHBPRSkqjfeycijTWMBmCS26p/vE35Mn0
         bn4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUHRM+VoCwcuXjBXV1mK2iMRB+51Htgx3h/rWtZB3OGNeoW9tpMLgJyPg7MZbkQpcH3cAO4w/e08eXx6H5AiC3hxuVQPFr6/bMOewos
X-Gm-Message-State: AOJu0YzB+vzd85B7fH1UL0ocoRjbVbW2BPJBmZVHY035Q1VIEGZ2ETub
	hanOmKHj3RUjKqndZzwkOMyEcWsEArCS8jwBgg+7YX6rBB4wS3rXJ4NLjsGOFDMiqPr8ET/0ZYA
	CgKE68QBmpZZYAZtcslP1jWTp1QQ=
X-Google-Smtp-Source: AGHT+IHZwAqarq18VxCUueb5SrLyt7lAYsKju5Jp+sTOjLEo8qCFKv8DabP+yy6z6nE2QD6ni4X7aKkR08+vye0bIfQ=
X-Received: by 2002:a17:90b:24c:b0:2c1:9892:8fb with SMTP id
 98e67ed59e1d1-2c99c69bb6cmr2291499a91.5.1720146462947; Thu, 04 Jul 2024
 19:27:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604085401.14733-1-qiang.zhang1211@gmail.com>
In-Reply-To: <20240604085401.14733-1-qiang.zhang1211@gmail.com>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Fri, 5 Jul 2024 10:27:30 +0800
Message-ID: <CALm+0cWG-FMh0BSp3xv=A_sA+7aUk8bRRypXNBpDynT7QAmzvA@mail.gmail.com>
Subject: Re: [PATCH v2] rcu-tasks: Fix access non-existent percpu rtpcp
 variable in rcu_tasks_need_gpcb()
To: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org, 
	joel@joelfernandes.org, urezki@gmail.com
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, zhixu.liu@gmail.com
Content-Type: text/plain; charset="UTF-8"

>
> For kernels built with CONFIG_FORCE_NR_CPUS=y, the nr_cpu_ids is
> defined as NR_CPUS instead of the number of possible cpus, this
> will cause the following system panic:
>
> [    0.015349][    T0] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
> ...
> [    0.021342][    T0] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:512 nr_node_ids:1
> ...
> [    3.681252][   T15] BUG: unable to handle page fault for address: ffffffff9911c8c8
> [    3.689415][   T45] ehci-pci 0000:00:1a.0: debug port 2
> [    3.697008][   T15] #PF: supervisor read access in kernel mode
> [    3.697009][   T15] #PF: error_code(0x0000) - not-present page
> [    3.706233][   T45] ehci-pci 0000:00:1a.0: irq 16, io mem 0xf7e3c000
> [    3.708152][   T15] PGD 40fa24067 P4D 40fa24067 PUD 40fa25063 PMD 410bff063
> [    3.720380][   T45] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
> [    3.720430][   T15] PTE 800ffffbefee3062
> [    3.720431][   T15] Oops: 0000 [#1] PREEMPT SMP PTI
> [    3.727873][   T45] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.06
> [    3.734009][   T15] CPU: 0 PID: 15 Comm: rcu_tasks_trace Tainted: G W          6.6.21 #1 5dc7acf91a5e8e9ac9dcfc35bee0245691283ea6
> [    3.734011][   T15] Hardware name: Dell Inc. OptiPlex 9020/005T15, BIOS A14 09/14/2015
> [    3.734012][   T15] RIP: 0010:rcu_tasks_need_gpcb+0x25d/0x2c0
> [    3.737962][   T45] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    3.742877][   T15] RSP: 0018:ffffa371c00a3e60 EFLAGS: 00010082
> [    3.751891][   T45] usb usb2: Product: EHCI Host Controller
> [    3.764495][   T15]
> [    3.764496][   T15] RAX: ffffffff98929ca0 RBX: ffffffff98b3b328 RCX: 0000000000021880
> [    3.764497][   T15] RDX: ffffffff9911c880 RSI: 0000000000000000 RDI: 0000000000000000
> [    3.772461][   T45] usb usb2: Manufacturer: Linux 6.6.21 ehci_hcd
> [    3.778248][   T15] RBP: 0000000000000202 R08: 0000000000000000 R09: 0000000000000000
> [    3.778249][   T15] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000003
> [    3.778249][   T15] R13: 0000000000000000 R14: 0000000000000001 R15: ffffffff98b3b320
> [    3.786216][   T45] usb usb2: SerialNumber: 0000:00:1a.0
> [    3.805811][   T15] FS:  0000000000000000(0000) GS:ffff8c781ea00000(0000) knlGS:0000000000000000
> [    3.805813][   T15] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    3.811993][   T45] hub 2-0:1.0: USB hub found
> [    3.817383][   T15] CR2: ffffffff9911c8c8 CR3: 000000040fa20005 CR4: 00000000001706f0
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

Hi, Paul

Any suggestions for this modification?

The warning of objtools is unique to the loongarch64 platform.
A similar problem also occurred at this link:
https://lore.kernel.org/oe-kbuild-all/202406211339.BCuCbD2g-lkp@intel.com/

Tiezhu recommends updating compiler toolchain before this, or
apply the following patch:
https://lore.kernel.org/loongarch/20240604150741.30252-1-xry111@xry111.site/
however, this patch was not discussed subsequently.

Thanks
Zqiang






>
> Closes: https://lore.kernel.org/linux-input/CALMA0xaTSMN+p4xUXkzrtR5r6k7hgoswcaXx7baR_z9r5jjskw@mail.gmail.com/T/#u
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
>  static int rcu_task_lazy_lim __read_mostly = 32;
>  module_param(rcu_task_lazy_lim, int, 0444);
>
> +static int rcu_task_cpu_ids;
> +
>  /* RCU tasks grace-period state for debugging. */
>  #define RTGS_INIT               0
>  #define RTGS_WAIT_WAIT_CBS      1
> @@ -245,6 +249,8 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
>         int cpu;
>         int lim;
>         int shift;
> +       int maxcpu;
> +       int index = 0;
>
>         if (rcu_task_enqueue_lim < 0) {
>                 rcu_task_enqueue_lim = 1;
> @@ -254,14 +260,9 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
>         }
>         lim = rcu_task_enqueue_lim;
>
> -       if (lim > nr_cpu_ids)
> -               lim = nr_cpu_ids;
> -       shift = ilog2(nr_cpu_ids / lim);
> -       if (((nr_cpu_ids - 1) >> shift) >= lim)
> -               shift++;
> -       WRITE_ONCE(rtp->percpu_enqueue_shift, shift);
> -       WRITE_ONCE(rtp->percpu_dequeue_lim, lim);
> -       smp_store_release(&rtp->percpu_enqueue_lim, lim);
> +       rtp->rtpcp_array = kcalloc(num_possible_cpus(), sizeof(struct rcu_tasks_percpu *), GFP_KERNEL);
> +       BUG_ON(!rtp->rtpcp_array);
> +
>         for_each_possible_cpu(cpu) {
>                 struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
>
> @@ -273,14 +274,29 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
>                 INIT_WORK(&rtpcp->rtp_work, rcu_tasks_invoke_cbs_wq);
>                 rtpcp->cpu = cpu;
>                 rtpcp->rtpp = rtp;
> +               rtpcp->index = index;
> +               rtp->rtpcp_array[index] = rtpcp;
> +               index++;
>                 if (!rtpcp->rtp_blkd_tasks.next)
>                         INIT_LIST_HEAD(&rtpcp->rtp_blkd_tasks);
>                 if (!rtpcp->rtp_exit_list.next)
>                         INIT_LIST_HEAD(&rtpcp->rtp_exit_list);
> +               maxcpu = cpu;
>         }
>
> -       pr_info("%s: Setting shift to %d and lim to %d rcu_task_cb_adjust=%d.\n", rtp->name,
> -                       data_race(rtp->percpu_enqueue_shift), data_race(rtp->percpu_enqueue_lim), rcu_task_cb_adjust);
> +       rcu_task_cpu_ids = maxcpu + 1;
> +       if (lim > rcu_task_cpu_ids)
> +               lim = rcu_task_cpu_ids;
> +       shift = ilog2(rcu_task_cpu_ids / lim);
> +       if (((rcu_task_cpu_ids - 1) >> shift) >= lim)
> +               shift++;
> +       WRITE_ONCE(rtp->percpu_enqueue_shift, shift);
> +       WRITE_ONCE(rtp->percpu_dequeue_lim, lim);
> +       smp_store_release(&rtp->percpu_enqueue_lim, lim);
> +
> +       pr_info("%s: Setting shift to %d and lim to %d rcu_task_cb_adjust=%d rcu_task_cpu_ids=%d.\n",
> +                       rtp->name, data_race(rtp->percpu_enqueue_shift), data_race(rtp->percpu_enqueue_lim),
> +                       rcu_task_cb_adjust, rcu_task_cpu_ids);
>  }
>
>  // Compute wakeup time for lazy callback timer.
> @@ -348,7 +364,7 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
>                         rtpcp->rtp_n_lock_retries = 0;
>                 }
>                 if (rcu_task_cb_adjust && ++rtpcp->rtp_n_lock_retries > rcu_task_contend_lim &&
> -                   READ_ONCE(rtp->percpu_enqueue_lim) != nr_cpu_ids)
> +                   READ_ONCE(rtp->percpu_enqueue_lim) != rcu_task_cpu_ids)
>                         needadjust = true;  // Defer adjustment to avoid deadlock.
>         }
>         // Queuing callbacks before initialization not yet supported.
> @@ -368,10 +384,10 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
>         raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
>         if (unlikely(needadjust)) {
>                 raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
> -               if (rtp->percpu_enqueue_lim != nr_cpu_ids) {
> +               if (rtp->percpu_enqueue_lim != rcu_task_cpu_ids) {
>                         WRITE_ONCE(rtp->percpu_enqueue_shift, 0);
> -                       WRITE_ONCE(rtp->percpu_dequeue_lim, nr_cpu_ids);
> -                       smp_store_release(&rtp->percpu_enqueue_lim, nr_cpu_ids);
> +                       WRITE_ONCE(rtp->percpu_dequeue_lim, rcu_task_cpu_ids);
> +                       smp_store_release(&rtp->percpu_enqueue_lim, rcu_task_cpu_ids);
>                         pr_info("Switching %s to per-CPU callback queuing.\n", rtp->name);
>                 }
>                 raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
> @@ -481,7 +497,7 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
>         if (rcu_task_cb_adjust && ncbs <= rcu_task_collapse_lim) {
>                 raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
>                 if (rtp->percpu_enqueue_lim > 1) {
> -                       WRITE_ONCE(rtp->percpu_enqueue_shift, order_base_2(nr_cpu_ids));
> +                       WRITE_ONCE(rtp->percpu_enqueue_shift, order_base_2(rcu_task_cpu_ids));
>                         smp_store_release(&rtp->percpu_enqueue_lim, 1);
>                         rtp->percpu_dequeue_gpseq = get_state_synchronize_rcu();
>                         gpdone = false;
> @@ -496,7 +512,9 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
>                         pr_info("Completing switch %s to CPU-0 callback queuing.\n", rtp->name);
>                 }
>                 if (rtp->percpu_dequeue_lim == 1) {
> -                       for (cpu = rtp->percpu_dequeue_lim; cpu < nr_cpu_ids; cpu++) {
> +                       for (cpu = rtp->percpu_dequeue_lim; cpu < rcu_task_cpu_ids; cpu++) {
> +                               if (!cpu_possible(cpu))
> +                                       continue;
>                                 struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
>
>                                 WARN_ON_ONCE(rcu_segcblist_n_cbs(&rtpcp->cblist));
> @@ -511,30 +529,32 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
>  // Advance callbacks and invoke any that are ready.
>  static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp, struct rcu_tasks_percpu *rtpcp)
>  {
> -       int cpu;
> -       int cpunext;
>         int cpuwq;
>         unsigned long flags;
>         int len;
> +       int index;
>         struct rcu_head *rhp;
>         struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
>         struct rcu_tasks_percpu *rtpcp_next;
>
> -       cpu = rtpcp->cpu;
> -       cpunext = cpu * 2 + 1;
> -       if (cpunext < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
> -               rtpcp_next = per_cpu_ptr(rtp->rtpcpu, cpunext);
> -               cpuwq = rcu_cpu_beenfullyonline(cpunext) ? cpunext : WORK_CPU_UNBOUND;
> -               queue_work_on(cpuwq, system_wq, &rtpcp_next->rtp_work);
> -               cpunext++;
> -               if (cpunext < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
> -                       rtpcp_next = per_cpu_ptr(rtp->rtpcpu, cpunext);
> -                       cpuwq = rcu_cpu_beenfullyonline(cpunext) ? cpunext : WORK_CPU_UNBOUND;
> +       index = rtpcp->index * 2 + 1;
> +       if (index < num_possible_cpus()) {
> +               rtpcp_next = rtp->rtpcp_array[index];
> +               if (rtpcp_next->cpu < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
> +                       cpuwq = rcu_cpu_beenfullyonline(rtpcp_next->cpu) ? rtpcp_next->cpu : WORK_CPU_UNBOUND;
>                         queue_work_on(cpuwq, system_wq, &rtpcp_next->rtp_work);
> +                       index++;
> +                       if (index < num_possible_cpus()) {
> +                               rtpcp_next = rtp->rtpcp_array[index];
> +                               if (rtpcp_next->cpu < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
> +                                       cpuwq = rcu_cpu_beenfullyonline(rtpcp_next->cpu) ? rtpcp_next->cpu : WORK_CPU_UNBOUND;
> +                                       queue_work_on(cpuwq, system_wq, &rtpcp_next->rtp_work);
> +                               }
> +                       }
>                 }
>         }
>
> -       if (rcu_segcblist_empty(&rtpcp->cblist) || !cpu_possible(cpu))
> +       if (rcu_segcblist_empty(&rtpcp->cblist))
>                 return;
>         raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
>         rcu_segcblist_advance(&rtpcp->cblist, rcu_seq_current(&rtp->tasks_gp_seq));
> --
> 2.17.1
>
