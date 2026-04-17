Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1052A2701C4
	for <rcu@vger.kernel.org>; Fri, 17 Apr 2026 01:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776388710; cv=none; b=QAZrCcFy8MlW4lkFoCpUmB+spEvSRtDHXqVRG6/TrS6hJqXzdK8FZn9+CNWEHHKx5H2jsEHroUUmviDZUlREbebtQcM19ONFJ9zDaIIaEVq9yFeKOVuBuVofeqQLE5qin/yBN/90qHVqvpdt/FWqeLgNqMo6zItqaXRW9/Y5iXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776388710; c=relaxed/simple;
	bh=yHLzhoSFsanUc5wM8tUNLhd4cSDOKlSPlPPYYT8oQns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jNBPp7FgIq9oVVQE32LCxiDj0+gqfAS/A41y/rG3MEw5/vHt4Zva5/8Pk8Kk4oxGjHYfAs5zj8HdVlid0wL824J8Be7CGTGmj9wRs2F0M9oSdbqy0cDXsiHnXmkhZMPGDvE19eFSbUdXLm4huEGoTWVRYh5CsKQJ1gK05YrVnlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=MDuHnY67; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="MDuHnY67"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8d583bfc415so21909585a.2
        for <rcu@vger.kernel.org>; Thu, 16 Apr 2026 18:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1776388707; x=1776993507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7SWJQmxN8yF3gmDOfvheMSok4KRz78/0fq5QXZ/i00=;
        b=MDuHnY674ns02UilA460o2LrAwVR2ZCP94VmFUlS4HJFkpAqR6uqR0V7O1jYQwjfbf
         aZvXIONhvT5ysLud+KfdcjzUwOTkvw87JafJcuf4UWf8mBbD7yqdkzaVpE0BOgajMshQ
         0GcXuC3LcKn0NK4tbCB5IirTICAt+UaWAAju0nFC0nWub1ZiOc7nc9G6E0tCQOJZQFBk
         Z5bUNxI+waGoLsB4uRgq4v7Q0EpWroJ7Q+xgSBhuX+WYaWwqEzvPh87gJEv7jnTc5dal
         AizlP93oKDgQ0Y5m58mJqC2r5dl5BJL5EqqFAR398CHcEujHkdB/rxMyu/t72ezvLZd7
         E6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776388707; x=1776993507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n7SWJQmxN8yF3gmDOfvheMSok4KRz78/0fq5QXZ/i00=;
        b=krHYUgQmxhDaKC5VQvYw0WnfCg7fmLR9GqlftS5TKf8Ok+wOPou/hny3ZL7fQZTj7i
         FBEceJ+/P0VyPglg+zgc61SCzBAJK8Bq6yGQ0oKGcYZdlPnGWnnTj8zfPJRpZszMsRda
         Oj6CZ94YcFliS2kOyB2yeJTDaK9/AGXHTlPRpwlso9wujRp4EXDiejrUEJYCLVFstnNE
         CH000sn1cv8R6c9+WS2Q9tFkJh7Bj8NFoygCKWUPyZH1GlFFdxw0grgHcg6CmrgAgQPe
         g4RMSLXjVK3bgqTWrbQg6jaXL0h74BMtkuDP0C72Ha881VXg8Cnr1BY1I3B8rYPFd6N6
         +e9Q==
X-Forwarded-Encrypted: i=1; AFNElJ8odGsev9lT4AybyX1AXy3enMqf6WveClKn7359IsxsqoDPTr124fedFZZqAglphJPP16Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9kmtIhQMkRiCa/+wLUsCyDVxJq040wxUKI+aH7p8hKZ8Obsfq
	Vg8Jff0RbHeP54RDEjSg8wsgKdMxHr9MDC5e0guY/QVJGwA1cqENfz0Uwnwe+vQzYs8=
X-Gm-Gg: AeBDiesdOF6D0e/co7oai3rUtSuUE+OcRpIAn0T9T44Kcqz3klxeLg6FdqCU+CAxvUv
	oEqtv+hNeYKZhHPjV2AZR1zqCFqLw5FzKC67s1GZaWBBxON2qaoxMgQNyk4uRGmozPzt97mKS9g
	8xeIhe3R/9bNHFtk2/YsR8q7G08qRL4Snc3dwuMtgSCjtiYwEPQbiLZ6Aw83rZhMTXQisMHoBrR
	sZunXAXgf1mvb/itW3StfZoe0A1J9KKt//orXZFGMpLF4ARkU+PnytDqkJWAMyCo+pC4+aXDRmL
	LJ61WKN+LIGkY3qx4GCKzX7mfVjwvIz5Eo6UIzrlo4WpmvCpyCighfVS963JduZtoyHq3Lzbfy/
	Fgdy5WuxfEpeKufJQM9mLf15p8l7yng0GJyTduEkC3WkS5kROe7LM3H9az/iREj4ysJ3hsqniQy
	EqT5Ob5OWtMdKVQ0r4NS6N49hcfbP9kPjmgJxZj2abpcoyrGS4+Ok1blbym+ZDfv3+Uoj8MEAVC
	7mF
X-Received: by 2002:a05:620a:3710:b0:8cd:8938:eff9 with SMTP id af79cd13be357-8e78f055e8dmr126437285a.1.1776388706847;
        Thu, 16 Apr 2026 18:18:26 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7b036bdc6sm21034785a.14.2026.04.16.18.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 18:18:26 -0700 (PDT)
From: Vineeth Pillai <vineeth@bitbyteword.org>
To: kunwu.chan@linux.dev,
	paulmck@kernel.org
Cc: dmaluka@chromium.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pbonzini@redhat.com,
	rcu@vger.kernel.org,
	seanjc@google.com,
	sonam.sanju@intel.com,
	sonam.sanju@intel.corp-partner.google.com,
	stable@vger.kernel.org,
	vineeth@bitbyteword.org
Subject: Re: [PATCH v2] KVM: irqfd: fix deadlock by moving synchronize_srcu  out of resampler_lock
Date: Thu, 16 Apr 2026 21:18:23 -0400
Message-ID: <20260417011825.158781-1-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <87add1dc9bb95dc50bc20ce5c8fbfe2999185dd3@linux.dev>
References: <87add1dc9bb95dc50bc20ce5c8fbfe2999185dd3@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Consolidating replies into one thread.

Hi Kunwu,

> One thing that is still unclear is dispatch behavior:
> `process_srcu` stays pending for a long time, while the same pwq dump shows idle workers.
>
> So the key question is: what prevents pending work from being dispatched on that pwq?
> Is it due to:
>   1) pwq stalled/hung state,
>   2) worker availability/affinity constraints,
>   3) or another dispatch-side condition?
>
> Also, for scope:
> - your crash instances consistently show the shutdown path
>   (irqfd_resampler_shutdown + synchronize_srcu),
> - while assign-path evidence, per current thread data, appears to come
>   from a separate stress case.

> A time-aligned dump with pwq state, pending/in-flight lists, and worker states
> should help clarify this.

I have a dmesg log showing this issue. This is from an automated stress
reboot test. The log is very similar to what Sonam shared.

<0>[  434.338427] BUG: workqueue lockup - pool cpus=5 node=0 flags=0x0 nice=0 stuck for 293s!
<6>[  434.339037] Showing busy workqueues and worker pools:
<6>[  434.339387] workqueue events: flags=0x100
<6>[  434.339667]   pwq 22: cpus=5 node=0 flags=0x0 nice=0 active=2 refcnt=3
<6>[  434.339691]     pending: 2*xhci_dbc_handle_events
<6>[  434.340512] workqueue events: flags=0x100
<6>[  434.340789]   pwq 2: cpus=0 node=0 flags=0x0 nice=0 active=1 refcnt=2
<6>[  434.340793]     pending: vmstat_shepherd
<6>[  434.341507]   pwq 22: cpus=5 node=0 flags=0x0 nice=0 active=45 refcnt=46
<6>[  434.341511]     pending: delayed_vfree_work, kernfs_notify_workfn, 5*destroy_super_work, 3*bpf_prog_free_deferred, 5*destroy_super_work, binder_deferred_func, bpf_prog_free_deferred, 25*destroy_super_work, drain_local_memcg_stock, update_stats_workfn, psi_avgs_work
<6>[  434.343578]   pwq 30: cpus=7 node=0 flags=0x0 nice=0 active=1 refcnt=2
<6>[  434.343582]     in-flight: 325:do_emergency_remount
<6>[  434.344376] workqueue events_unbound: flags=0x2
<6>[  434.344688]   pwq 34: cpus=0-7 node=0 flags=0x4 nice=0 active=2 refcnt=3
<6>[  434.344693]     in-flight: 339:fsnotify_connector_destroy_workfn fsnotify_connector_destroy_workfn
<6>[  434.345755]   pwq 34: cpus=0-7 node=0 flags=0x4 nice=0 active=2 refcnt=8
<6>[  434.345759]     in-flight: 153:fsnotify_mark_destroy_workfn BAR(3098) BAR(2564) BAR(2299) fsnotify_mark_destroy_workfn BAR(416) BAR(1116)
<6>[  434.347151] workqueue events_freezable: flags=0x104
<6>[  434.347590]   pwq 22: cpus=5 node=0 flags=0x0 nice=0 active=1 refcnt=2
<6>[  434.347595]     pending: pci_pme_list_scan
<6>[  434.348681] workqueue events_power_efficient: flags=0x180
<6>[  434.349221]   pwq 22: cpus=5 node=0 flags=0x0 nice=0 active=1 refcnt=2
<6>[  434.349226]     pending: check_lifetime
<6>[  434.350397] workqueue rcu_gp: flags=0x108
<6>[  434.350853]   pwq 22: cpus=5 node=0 flags=0x0 nice=0 active=3 refcnt=4
<6>[  434.350857]     pending: 3*process_srcu
<6>[  434.351918] workqueue slub_flushwq: flags=0x8
<6>[  434.352409]   pwq 22: cpus=5 node=0 flags=0x0 nice=0 active=1 refcnt=3
<6>[  434.352413]     pending: flush_cpu_slab BAR(1)
<6>[  434.353529] workqueue mm_percpu_wq: flags=0x8
<6>[  434.354087]   pwq 22: cpus=5 node=0 flags=0x0 nice=0 active=1 refcnt=2
<6>[  434.354092]     pending: vmstat_update
<6>[  434.355205] workqueue quota_events_unbound: flags=0xa
<6>[  434.355725]   pwq 34: cpus=0-7 node=0 flags=0x4 nice=0 active=1 refcnt=3
<6>[  434.355730]     in-flight: 354:quota_release_workfn BAR(325)
<6>[  434.356980] workqueue kvm-irqfd-cleanup: flags=0x0
<6>[  434.357582]   pwq 22: cpus=5 node=0 flags=0x0 nice=0 active=3 refcnt=4
<6>[  434.357586]     in-flight: 51:irqfd_shutdown ,3453:irqfd_shutdown ,3449:irqfd_shutdown
<6>[  434.359101] pool 22: cpus=5 node=0 flags=0x0 nice=0 hung=293s workers=11 idle: 282 154 3452 3451 3448 3450 3455 3454
<6>[  434.359989] pool 30: cpus=7 node=0 flags=0x0 nice=0 hung=0s workers=3 idle: 3460 332
<6>[  434.360539] pool 34: cpus=0-7 node=0 flags=0x4 nice=0 hung=0s workers=5 idle: 256 66

The relevant pwq is pwq 22. All three irqfd_shutdown workers are in-flight
but in D state. rcu_gp's process_srcu items are stuck pending.

Worker 51 (kworker/5:0) — blocked acquiring resampler_lock:
<6>[  440.576612] task:kworker/5:0     state:D stack:0     pid:51    tgid:51    ppid:2      task_flags:0x4208060 flags:0x00080000
<6>[  440.577379] Workqueue: kvm-irqfd-cleanup irqfd_shutdown
<6>[  440.578085]  <TASK>
<6>[  440.578337]  preempt_schedule_irq+0x4a/0x90
<6>[  440.583712]  __mutex_lock+0x413/0xe40
<6>[  440.583969]  irqfd_resampler_shutdown+0x23/0x150
<6>[  440.584288]  irqfd_shutdown+0x66/0xc0
<6>[  440.584546]  process_scheduled_works+0x219/0x450
<6>[  440.584864]  worker_thread+0x2a7/0x3b0
<6>[  440.585421]  kthread+0x230/0x270

Worker 3449 (kworker/5:4) — same, blocked acquiring resampler_lock:
<6>[  440.671294] task:kworker/5:4     state:D stack:0     pid:3449  tgid:3449  ppid:2      task_flags:0x4208060 flags:0x00080000
<6>[  440.672088] Workqueue: kvm-irqfd-cleanup irqfd_shutdown
<6>[  440.672662]  <TASK>
<6>[  440.673069]  schedule+0x5e/0xe0
<6>[  440.673708]  __mutex_lock+0x413/0xe40
<6>[  440.674059]  irqfd_resampler_shutdown+0x23/0x150
<6>[  440.674381]  irqfd_shutdown+0x66/0xc0
<6>[  440.674638]  process_scheduled_works+0x219/0x450
<6>[  440.674956]  worker_thread+0x2a7/0x3b0
<6>[  440.675308]  kthread+0x230/0x270

Worker 3453 (kworker/5:8) — holds resampler_lock, blocked waiting for SRCU GP:
<6>[  440.677368] task:kworker/5:8     state:D stack:0     pid:3453  tgid:3453  ppid:2      task_flags:0x4208060 flags:0x00080000
<6>[  440.678185] Workqueue: kvm-irqfd-cleanup irqfd_shutdown
<6>[  440.678720]  <TASK>
<6>[  440.679127]  schedule+0x5e/0xe0
<6>[  440.679354]  schedule_timeout+0x2e/0x130
<6>[  440.680084]  wait_for_common+0xf7/0x1f0
<6>[  440.680355]  synchronize_srcu_expedited+0x109/0x140
<6>[  440.681164]  irqfd_resampler_shutdown+0xf0/0x150
<6>[  440.681481]  irqfd_shutdown+0x66/0xc0
<6>[  440.681738]  process_scheduled_works+0x219/0x450
<6>[  440.682055]  worker_thread+0x2a7/0x3b0
<6>[  440.682403]  kthread+0x230/0x270

The sequence is: worker 3453 acquires resampler_lock, and calls
synchronize_srcu_expedited() while holding the lock. This queues
process_srcu on rcu_gp, then blocks waiting for the GP to complete.
Workers 51 and 3449 are blocked trying to acquire the same resampler_lock.

Regarding your dispatch question: all three workers are in D state, so
they have all called schedule() and wq_worker_sleeping() should have
decremented pool->nr_running to zero. With nr_running == 0 and
process_srcu in the worklist, needs_more_worker() should be true and an
idle worker should be woken via kick_pool() when process_srcu is enqueued.
Why none of the 8 idle workers end up dispatching process_srcu is not
entirely clear to me.

Moving the synchronize_srcu_expedited() does solve this issue, but it
is not exactly sure why the deadlock between irqfd-shutdown workers is
causing the work queue to stall.

The full dmesg is at: https://gist.github.com/vineethrp/883db560a4503612448db9b10e02a9b5

Hi Paul,

> Just to be clear, I am guessing that you have the workqueues counterpart
> to a fork bomb. However, if you are using a small finite number of
> workqueue handlers, then we need to make adjustments in SRCU, workqueues,
> or maybe SRCU's use of workqueues.

In this log, I am not seeing a workqueue being stressed out. There are
8 idle workers, but for some reason no worker is assigned to run process_srcu.
Not sure if its a work queue related race condition or if its working as
intended to not kick new workers if there are in-flight workers in D state.

> SRCU and RCU use their own workqueue, which no one else should be
> using (and that prohibition most definitely includes the irqfd workers).

kvm-irqfd-cleanup and rcu_gp while being separate workqueues, share the
same per-CPU pool(pwq 22). Both are CPU-bound: rcu_gp has flags=0x108
(WQ_UNBOUND|WQ_FREEZABLE) but its pwq for CPU 5 resolves to the same
per-CPU pool (pool 22, flags=0x0) as kvm-irqfd-cleanup (flags=0x0).
I think CPU-bound workqueues share the per-CPU pool regardless of being
separate workqueues and these two workqueues end up competing for the
same underlying pool's workers.

Making kvm-irqfd-cleanup unbound (WQ_UNBOUND) would place it on a
separate pool from rcu_gp, preventing this interference and fixing the
stall I guess.

Thanks,
Vineeth
