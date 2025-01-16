Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAA21DE3DD;
	Thu, 16 Jan 2025 11:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737025208; cv=none; b=V/fM1CEbuKOLLgjHbpgpdXbPg+nXrW4/73Re3q58BhH96F8+Y6+fR9hoDENOLGcnP35I9O5u1iT4P+bgK8BK5HWqozPTgrCvdnl4RET3zX3qqhq2rQH7SfFkoSDO2R5+Jb0/BXczK0Dy4uc7S49Q0c9VZ++5SH19JKrxwWCFPk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737025208; c=relaxed/simple;
	bh=/8TGwvrY68nRkDHZaTVuPAvP2r9Ox7QzVbiYn2mFs4Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=myd2DnsPZwlnCBzpKTNTEefgeuKGL5F5gqiUaXYfczL3vgGZ1mE1t86mKQfenSybcJyRrAIAvXTBxQgeiBnG+rOO8Y+SufIwhU0mg3X0Y2eJGIgCN18yAZMXGoHF08Ymehmbxe78eQMJ33pcF56x+p0GyFKK8QoOfoPAqtz1by8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fPXqoSKQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iU1/e01q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fPXqoSKQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iU1/e01q"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737025204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6F8gIrmDYnrJwjZmWUXPJKPkbPyJsZ031mMI99w7gFY=;
	b=fPXqoSKQreZpG+O+si+Iu807fu0dOHjpBxnqnI1XRZtEJShJ4USiw2zIJAtwltUzslrMq9
	bEfFPiQI4pIY7dN2o1O5TCMJwEYoLkXcyKzafyM1+KE1Fkw8l9yQeq2CPD9zQSX01YgPQN
	pRCb4j3bBFQgXmVniVmSP8lE8HO1w6KcMqHBHugO+8RaJXmi1FkuQ8UH9Pnd5zahHTKFt4
	5ufrvRh/F71Yx8cCPXnKMuUjcmIwbl1aJDsP9wN1zddbaNiTR+H27v1ca+BbyjtJy/+1JD
	AybGPdQJvd1D2x/gVtSadm3w5C+2ZJb60xKDmKSfB/k9AzrcxWOGg1zempHzWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737025204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6F8gIrmDYnrJwjZmWUXPJKPkbPyJsZ031mMI99w7gFY=;
	b=iU1/e01qrUi6VwHLSXs5HLlzuXYPulI8psHNzhXWMbBQpemeoNbk7GeILsFhmCmokOA6ps
	yxWKqEK9CswdQgCw==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Frederic Weisbecker
 <frederic@kernel.org>, vlad.wing@gmail.com, rcu@vger.kernel.org,
 boqun.feng@gmail.com, joel@joelfernandes.org, neeraj.upadhyay@amd.com,
 urezki@gmail.com, qiang.zhang1211@gmail.com, Cheng-Jui.Wang@mediatek.com,
 leitao@debian.org, kernel-team@meta.com, Usama Arif
 <usamaarif642@gmail.com>, paulmck@kernel.org, Anna-Maria Behnsen
 <anna-maria@linutronix.de>
Subject: Re: [PATCH 1/3 v3] hrtimers: Force migrate away hrtimers queued
 after CPUHP_AP_HRTIMERS_DYING
In-Reply-To: <20241231170712.149394-2-frederic@kernel.org>
References: <20241231170712.149394-1-frederic@kernel.org>
 <20241231170712.149394-2-frederic@kernel.org>
Date: Thu, 16 Jan 2025 11:59:48 +0100
Message-ID: <8734hjausb.ffs@tglx>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Dec 31 2024 at 18:07, Frederic Weisbecker wrote:
> hrtimers are migrated away from the dying CPU to any online target at
> the CPUHP_AP_HRTIMERS_DYING stage in order not to delay bandwidth timers
> handling tasks involved in the CPU hotplug forward progress.
>
> However wake ups can still be performed by the outgoing CPU after
> CPUHP_AP_HRTIMERS_DYING. Those can result again in bandwidth timers
> being armed. Depending on several considerations (crystal ball
> power management based election, earliest timer already enqueued, timer
> migration enabled or not), the target may eventually be the current
> CPU even if offline. If that happens, the timer is eventually ignored.
>
> The most notable example is RCU which had to deal with each an every of
> those wake-ups by deferring them to an online CPU, along with related
> workarounds:
>
> _ e787644caf76 (rcu: Defer RCU kthreads wakeup when CPU is dying)
> _ 9139f93209d1 (rcu/nocb: Fix RT throttling hrtimer armed from offline CPU)
> _ f7345ccc62a4 (rcu/nocb: Fix rcuog wake-up from offline softirq)
>
> The problem isn't confined to RCU though as the stop machine kthread
> (which runs CPUHP_AP_HRTIMERS_DYING) reports its completion at the end
> and performs a wake up that eventually arms the deadline server timer:

Where does it report the completion?

>            WARNING: CPU: 94 PID: 588 at kernel/time/hrtimer.c:1086 hrtimer_start_range_ns+0x289/0x2d0
>            CPU: 94 UID: 0 PID: 588 Comm: migration/94 Not tainted
>            Stopper: multi_cpu_stop+0x0/0x120 <- stop_machine_cpuslocked+0x66/0xc0
>            RIP: 0010:hrtimer_start_range_ns+0x289/0x2d0
>            Call Trace:
>             ? __warn+0xcf/0x1b0
>             ? hrtimer_start_range_ns+0x289/0x2d0
>             ? hrtimer_start_range_ns+0x186/0x2d0
>             start_dl_timer+0xfc/0x150
>             enqueue_dl_entity+0x367/0x640
>             dl_server_start+0x53/0xa0
>             enqueue_task_fair+0x363/0x460
>             enqueue_task+0x3c/0x200
>             ttwu_do_activate+0x94/0x240
>             try_to_wake_up+0x315/0x600
>             complete+0x4b/0x80

You trimmed the backtrace at the wrong end. You left all the useless
register gunk around, but removed the call chain leading up to the
completion. :)

I assume it's the complete in stomp_machine() ....

> Instead of providing yet another bandaid to work around the situation,
> fix it from hrtimers infrastructure instead: always migrate away a
> timer to an online target whenever it is enqueued from an offline CPU.

> +/*
> + * If the current CPU is offline and timers have been already
> + * migrated away, make sure not to enqueue locally and perform
> + * a remote retrigger as a last resort.
> + */
> +static void enqueue_hrtimer_offline(struct hrtimer *timer,
> +				    struct hrtimer_clock_base *base,
> +				    const enum hrtimer_mode mode)
> +{
> +#ifdef CONFIG_HOTPLUG_CPU
> +	struct hrtimer_cpu_base *new_cpu_base, *old_cpu_base, *this_cpu_base;
> +	struct hrtimer_clock_base *new_base;
> +	int cpu;
> +
> +	old_cpu_base = base->cpu_base;
> +	this_cpu_base = this_cpu_ptr(&hrtimer_bases);
> +
> +	if (old_cpu_base == this_cpu_base || !old_cpu_base->online) {
> +		WARN_ON_ONCE(hrtimer_callback_running(timer));
> +		cpu = cpumask_any_and(cpu_online_mask,
> +				      housekeeping_cpumask(HK_TYPE_TIMER));
> +		new_cpu_base = &per_cpu(hrtimer_bases, cpu);
> +		new_base = &new_cpu_base->clock_base[base->index];
> +		WRITE_ONCE(timer->base, &migration_base);
> +		raw_spin_unlock(&old_cpu_base->lock);
> +		raw_spin_lock(&new_cpu_base->lock);
> +		WRITE_ONCE(timer->base, new_base);
> +	} else {
> +		new_base = base;
> +		new_cpu_base = new_base->cpu_base;
> +		cpu = new_cpu_base->cpu;
> +	}
> +
> +	if (enqueue_hrtimer(timer, new_base, mode))
> +		smp_call_function_single_async(cpu, &new_cpu_base->csd);

Duh. This reimplementation of switch_hrtimer_base() is really aweful. We
can be smarter than that. Untested patch below.

Thanks,

        tglx
---
--- a/include/linux/hrtimer_defs.h
+++ b/include/linux/hrtimer_defs.h
@@ -125,6 +125,7 @@ struct hrtimer_cpu_base {
 	ktime_t				softirq_expires_next;
 	struct hrtimer			*softirq_next_timer;
 	struct hrtimer_clock_base	clock_base[HRTIMER_MAX_CLOCK_BASES];
+	call_single_data_t		csd;
 } ____cacheline_aligned;
 
 
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -58,6 +58,8 @@
 #define HRTIMER_ACTIVE_SOFT	(HRTIMER_ACTIVE_HARD << MASK_SHIFT)
 #define HRTIMER_ACTIVE_ALL	(HRTIMER_ACTIVE_SOFT | HRTIMER_ACTIVE_HARD)
 
+static void retrigger_next_event(void *arg);
+
 /*
  * The timer bases:
  *
@@ -111,7 +113,8 @@ DEFINE_PER_CPU(struct hrtimer_cpu_base,
 			.clockid = CLOCK_TAI,
 			.get_time = &ktime_get_clocktai,
 		},
-	}
+	},
+	.csd = CSD_INIT(retrigger_next_event, NULL)
 };
 
 static const int hrtimer_clock_to_base_table[MAX_CLOCKS] = {
@@ -208,6 +211,13 @@ struct hrtimer_cpu_base *get_target_base
 	if (static_branch_likely(&timers_migration_enabled) && !pinned)
 		return &per_cpu(hrtimer_bases, get_nohz_timer_target());
 #endif
+#ifdef CONFIG_HOTPLUG_CPU
+	if (unlikely(!base->online)) {
+		int cpu = cpumask_any_and(cpu_online_mask, housekeeping_cpumask(HK_TYPE_TIMER));
+
+		return &per_cpu(hrtimer_bases, cpu);
+	}
+#endif
 	return base;
 }
 
@@ -254,7 +264,7 @@ switch_hrtimer_base(struct hrtimer *time
 		raw_spin_unlock(&base->cpu_base->lock);
 		raw_spin_lock(&new_base->cpu_base->lock);
 
-		if (new_cpu_base != this_cpu_base &&
+		if (new_cpu_base != this_cpu_base && this_cpu_base->online &&
 		    hrtimer_check_target(timer, new_base)) {
 			raw_spin_unlock(&new_base->cpu_base->lock);
 			raw_spin_lock(&base->cpu_base->lock);
@@ -716,8 +726,6 @@ static inline int hrtimer_is_hres_enable
 	return hrtimer_hres_enabled;
 }
 
-static void retrigger_next_event(void *arg);
-
 /*
  * Switch to high resolution mode
  */
@@ -1206,6 +1214,7 @@ static int __hrtimer_start_range_ns(stru
 				    u64 delta_ns, const enum hrtimer_mode mode,
 				    struct hrtimer_clock_base *base)
 {
+	struct hrtimer_cpu_base *this_cpu_base = this_cpu_ptr(&hrtimer_bases);
 	struct hrtimer_clock_base *new_base;
 	bool force_local, first;
 
@@ -1217,10 +1226,16 @@ static int __hrtimer_start_range_ns(stru
 	 * and enforce reprogramming after it is queued no matter whether
 	 * it is the new first expiring timer again or not.
 	 */
-	force_local = base->cpu_base == this_cpu_ptr(&hrtimer_bases);
+	force_local = base->cpu_base == this_cpu_base;
 	force_local &= base->cpu_base->next_timer == timer;
 
 	/*
+	 * Don't force local queuing if this enqueue happens on a unplugged
+	 * CPU after hrtimer_cpu_dying() has been invoked.
+	 */
+	force_local &= this_cpu_base->online;
+
+	/*
 	 * Remove an active timer from the queue. In case it is not queued
 	 * on the current CPU, make sure that remove_hrtimer() updates the
 	 * remote data correctly.
@@ -1249,8 +1264,17 @@ static int __hrtimer_start_range_ns(stru
 	}
 
 	first = enqueue_hrtimer(timer, new_base, mode);
-	if (!force_local)
-		return first;
+	if (!force_local) {
+		if (likely(this_cpu_base->online))
+			return first;
+
+		if (first) {
+			struct hrtimer_cpu_base *new_cpu_base = new_base->cpu_base;
+
+			smp_call_function_single_async(new_cpu_base->cpu, &new_cpu_base->csd);
+		}
+		return 0;
+	}
 
 	/*
 	 * Timer was forced to stay on the current CPU to avoid


