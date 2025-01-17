Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44771FF603;
	Fri, 17 Jan 2025 14:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737123083; cv=none; b=aHTIzIJ5Sw/x8+89ZEr4/IA/4LxSJ8N9hCFuXkOj92UdpuZjiOEEse6neBvC7RcZWJP5ilWvp1JPKiZrVrZmNAPSKq7ln55pcr4Z52fuyRp2vSDWzi2mqbdV2WdliYjn4X2D/aUOhaV9l6nCC59BEDSQaaMvWTkSdB8tykn6Ahs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737123083; c=relaxed/simple;
	bh=WjFCN57EJQ8qgLYM2SsVlty0Rup7xlO0R2wfiwVwHo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRq8FEFMs04b8lmACSwyTCS8p21ltZYnDm8ONs7cJ1KmJkAwuwVX5e4FMSIyTWGCEQzHa1G6gFI7C5U/2WouhfQqNcu4YhFmGe4Uve3RFUWalRYD1p3Vrjj2fEsVcbDsxegRdn1zRu+uzaN5h68uorewCGB9MiLvqoLuU5xF2ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A399i+Hu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A399i+Hu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D742C4CEDD;
	Fri, 17 Jan 2025 14:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737123083;
	bh=WjFCN57EJQ8qgLYM2SsVlty0Rup7xlO0R2wfiwVwHo8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A399i+HuLXg13oCrwC1mrYn5wPOJ+Cwkd1CVUCd3/jQ//qbnh/ikylf057u1g/qpq
	 Eo2M2+FgPixhHfir+rzpYkkTAEphNCesotGphpgHnngJTxBh9cuhsj8gPmB7osXpx+
	 rC5OLMmxHCwSdkMMYLuYRe3Hup1s/P3OxX+ytgaqrZm7efoMsPW0ycCZceU3A6wPp6
	 u8QmqrqxXcP+Ze4MhsKehtwFvmkSH64Ek35ATjc6F49bbTkm9VRhRgjFwmu0s88xoh
	 hqTGjTs1SfzX9HFeOE/0YLZg+AYalP2OF1zrd3yqckPz5UCuhR1yh7uclbNGMt19dr
	 eEbDl/zpFDrJw==
Date: Fri, 17 Jan 2025 15:11:20 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, vlad.wing@gmail.com,
	rcu@vger.kernel.org, boqun.feng@gmail.com, joel@joelfernandes.org,
	neeraj.upadhyay@amd.com, urezki@gmail.com,
	qiang.zhang1211@gmail.com, Cheng-Jui.Wang@mediatek.com,
	leitao@debian.org, kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>, paulmck@kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [PATCH 1/3 v3] hrtimers: Force migrate away hrtimers queued
 after CPUHP_AP_HRTIMERS_DYING
Message-ID: <Z4plCGNJddH-BDWE@localhost.localdomain>
References: <20241231170712.149394-1-frederic@kernel.org>
 <20241231170712.149394-2-frederic@kernel.org>
 <8734hjausb.ffs@tglx>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8734hjausb.ffs@tglx>

Le Thu, Jan 16, 2025 at 11:59:48AM +0100, Thomas Gleixner a écrit :
> On Tue, Dec 31 2024 at 18:07, Frederic Weisbecker wrote:
> > hrtimers are migrated away from the dying CPU to any online target at
> > the CPUHP_AP_HRTIMERS_DYING stage in order not to delay bandwidth timers
> > handling tasks involved in the CPU hotplug forward progress.
> >
> > However wake ups can still be performed by the outgoing CPU after
> > CPUHP_AP_HRTIMERS_DYING. Those can result again in bandwidth timers
> > being armed. Depending on several considerations (crystal ball
> > power management based election, earliest timer already enqueued, timer
> > migration enabled or not), the target may eventually be the current
> > CPU even if offline. If that happens, the timer is eventually ignored.
> >
> > The most notable example is RCU which had to deal with each an every of
> > those wake-ups by deferring them to an online CPU, along with related
> > workarounds:
> >
> > _ e787644caf76 (rcu: Defer RCU kthreads wakeup when CPU is dying)
> > _ 9139f93209d1 (rcu/nocb: Fix RT throttling hrtimer armed from offline CPU)
> > _ f7345ccc62a4 (rcu/nocb: Fix rcuog wake-up from offline softirq)
> >
> > The problem isn't confined to RCU though as the stop machine kthread
> > (which runs CPUHP_AP_HRTIMERS_DYING) reports its completion at the end
> > and performs a wake up that eventually arms the deadline server timer:
> 
> Where does it report the completion?

Right, that's cpu_stop_signal_done()

> 
> >            WARNING: CPU: 94 PID: 588 at kernel/time/hrtimer.c:1086 hrtimer_start_range_ns+0x289/0x2d0
> >            CPU: 94 UID: 0 PID: 588 Comm: migration/94 Not tainted
> >            Stopper: multi_cpu_stop+0x0/0x120 <- stop_machine_cpuslocked+0x66/0xc0
> >            RIP: 0010:hrtimer_start_range_ns+0x289/0x2d0
> >            Call Trace:
> >             ? __warn+0xcf/0x1b0
> >             ? hrtimer_start_range_ns+0x289/0x2d0
> >             ? hrtimer_start_range_ns+0x186/0x2d0
> >             start_dl_timer+0xfc/0x150
> >             enqueue_dl_entity+0x367/0x640
> >             dl_server_start+0x53/0xa0
> >             enqueue_task_fair+0x363/0x460
> >             enqueue_task+0x3c/0x200
> >             ttwu_do_activate+0x94/0x240
> >             try_to_wake_up+0x315/0x600
> >             complete+0x4b/0x80
> 
> You trimmed the backtrace at the wrong end. You left all the useless
> register gunk around, but removed the call chain leading up to the
> completion. :)
> 
> I assume it's the complete in stomp_machine() ....

Bah! Indeed, lemme fix that...

> > +/*
> > + * If the current CPU is offline and timers have been already
> > + * migrated away, make sure not to enqueue locally and perform
> > + * a remote retrigger as a last resort.
> > + */
> > +static void enqueue_hrtimer_offline(struct hrtimer *timer,
> > +				    struct hrtimer_clock_base *base,
> > +				    const enum hrtimer_mode mode)
> > +{
> > +#ifdef CONFIG_HOTPLUG_CPU
> > +	struct hrtimer_cpu_base *new_cpu_base, *old_cpu_base, *this_cpu_base;
> > +	struct hrtimer_clock_base *new_base;
> > +	int cpu;
> > +
> > +	old_cpu_base = base->cpu_base;
> > +	this_cpu_base = this_cpu_ptr(&hrtimer_bases);
> > +
> > +	if (old_cpu_base == this_cpu_base || !old_cpu_base->online) {
> > +		WARN_ON_ONCE(hrtimer_callback_running(timer));
> > +		cpu = cpumask_any_and(cpu_online_mask,
> > +				      housekeeping_cpumask(HK_TYPE_TIMER));
> > +		new_cpu_base = &per_cpu(hrtimer_bases, cpu);
> > +		new_base = &new_cpu_base->clock_base[base->index];
> > +		WRITE_ONCE(timer->base, &migration_base);
> > +		raw_spin_unlock(&old_cpu_base->lock);
> > +		raw_spin_lock(&new_cpu_base->lock);
> > +		WRITE_ONCE(timer->base, new_base);
> > +	} else {
> > +		new_base = base;
> > +		new_cpu_base = new_base->cpu_base;
> > +		cpu = new_cpu_base->cpu;
> > +	}
> > +
> > +	if (enqueue_hrtimer(timer, new_base, mode))
> > +		smp_call_function_single_async(cpu, &new_cpu_base->csd);
> 
> Duh. This reimplementation of switch_hrtimer_base() is really aweful. We
> can be smarter than that. Untested patch below.

Indeed, and I tried to "fix" switch_hrtimer_base() but didn't managed to do
it properly. Looks like you did :-)

But I have a few comments:

> @@ -208,6 +211,13 @@ struct hrtimer_cpu_base *get_target_base
>  	if (static_branch_likely(&timers_migration_enabled) && !pinned)
>  		return &per_cpu(hrtimer_bases, get_nohz_timer_target());
>  #endif
> +#ifdef CONFIG_HOTPLUG_CPU
> +	if (unlikely(!base->online)) {
> +		int cpu = cpumask_any_and(cpu_online_mask, housekeeping_cpumask(HK_TYPE_TIMER));
> +
> +		return &per_cpu(hrtimer_bases, cpu);
> +	}
> +#endif

This should be at the beginning of get_target_base(), otherwise the target may
end up being the local one.


>  	return base;
>  }
>  
> @@ -254,7 +264,7 @@ switch_hrtimer_base(struct hrtimer *time
>  		raw_spin_unlock(&base->cpu_base->lock);
>  		raw_spin_lock(&new_base->cpu_base->lock);
>  
> -		if (new_cpu_base != this_cpu_base &&
> +		if (new_cpu_base != this_cpu_base && this_cpu_base->online &&
>  		    hrtimer_check_target(timer, new_base)) {
>  			raw_spin_unlock(&new_base->cpu_base->lock);
>  			raw_spin_lock(&base->cpu_base->lock);

This forget the case where the elected remote target is the same as the old one,
but its next event is after the timer. In that case this default to local, even
if it is offline.

How about this? (untested yet)

diff --git a/include/linux/hrtimer_defs.h b/include/linux/hrtimer_defs.h
index c3b4b7ed7c16..84a5045f80f3 100644
--- a/include/linux/hrtimer_defs.h
+++ b/include/linux/hrtimer_defs.h
@@ -125,6 +125,7 @@ struct hrtimer_cpu_base {
 	ktime_t				softirq_expires_next;
 	struct hrtimer			*softirq_next_timer;
 	struct hrtimer_clock_base	clock_base[HRTIMER_MAX_CLOCK_BASES];
+	call_single_data_t		csd;
 } ____cacheline_aligned;
 
 
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 80fe3749d2db..248330e02da7 100644
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
@@ -111,7 +113,8 @@ DEFINE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases) =
 			.clockid = CLOCK_TAI,
 			.get_time = &ktime_get_clocktai,
 		},
-	}
+	},
+	.csd = CSD_INIT(retrigger_next_event, NULL)
 };
 
 static const int hrtimer_clock_to_base_table[MAX_CLOCKS] = {
@@ -124,6 +127,14 @@ static const int hrtimer_clock_to_base_table[MAX_CLOCKS] = {
 	[CLOCK_TAI]		= HRTIMER_BASE_TAI,
 };
 
+static inline bool hrtimer_base_is_online(struct hrtimer_cpu_base *base)
+{
+	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
+		return true;
+	else
+		return likely(base->online);
+}
+
 /*
  * Functions and macros which are different for UP/SMP systems are kept in a
  * single place
@@ -183,27 +194,55 @@ struct hrtimer_clock_base *lock_hrtimer_base(const struct hrtimer *timer,
 }
 
 /*
- * We do not migrate the timer when it is expiring before the next
- * event on the target cpu. When high resolution is enabled, we cannot
- * reprogram the target cpu hardware and we would cause it to fire
- * late. To keep it simple, we handle the high resolution enabled and
- * disabled case similar.
+ * Check if the elected target is suitable considering its next
+ * event and the hotplug state of the current CPU.
+ *
+ * If the elected target is remote and its next event is after the timer
+ * to queue, then a remote reprogram is necessary. However there is no
+ * guarantee the IPI handling the operation would arrive in time to meet
+ * the high resolution deadline. In this case the local CPU becomes a
+ * preferred target, unless it is offline.
+ *
+ * High and low resolution modes are handled the same way for simplicity.
  *
  * Called with cpu_base->lock of target cpu held.
  */
-static int
-hrtimer_check_target(struct hrtimer *timer, struct hrtimer_clock_base *new_base)
+static bool
+hrtimer_suitable_target(struct hrtimer *timer,
+			struct hrtimer_clock_base *new_base,
+			struct hrtimer_cpu_base *new_cpu_base,
+			struct hrtimer_cpu_base *this_cpu_base)
 {
 	ktime_t expires;
 
+	/* The local CPU clockevent can be reprogrammed */
+	if (new_cpu_base == this_cpu_base)
+		return true;
+
+	/*
+	 * The offline local CPU can't be the default target if the
+	 * next remote target event is after this timer. Keep the
+	 * elected new base. An IPI will we issued to reprogram
+	 * it as a last resort.
+	 */
+	if (!hrtimer_base_is_online(this_cpu_base))
+		return true;
+
 	expires = ktime_sub(hrtimer_get_expires(timer), new_base->offset);
-	return expires < new_base->cpu_base->expires_next;
+
+	return expires >= new_base->cpu_base->expires_next;
 }
 
 static inline
 struct hrtimer_cpu_base *get_target_base(struct hrtimer_cpu_base *base,
 					 int pinned)
 {
+	if (!hrtimer_base_is_online(base)) {
+		int cpu = cpumask_any_and(cpu_online_mask, housekeeping_cpumask(HK_TYPE_TIMER));
+
+		return &per_cpu(hrtimer_bases, cpu);
+	}
+
 #if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
 	if (static_branch_likely(&timers_migration_enabled) && !pinned)
 		return &per_cpu(hrtimer_bases, get_nohz_timer_target());
@@ -211,6 +250,8 @@ struct hrtimer_cpu_base *get_target_base(struct hrtimer_cpu_base *base,
 	return base;
 }
 
+
+
 /*
  * We switch the timer base to a power-optimized selected CPU target,
  * if:
@@ -254,8 +295,8 @@ switch_hrtimer_base(struct hrtimer *timer, struct hrtimer_clock_base *base,
 		raw_spin_unlock(&base->cpu_base->lock);
 		raw_spin_lock(&new_base->cpu_base->lock);
 
-		if (new_cpu_base != this_cpu_base &&
-		    hrtimer_check_target(timer, new_base)) {
+		if (!hrtimer_suitable_target(timer, new_base, new_cpu_base,
+					     this_cpu_base)) {
 			raw_spin_unlock(&new_base->cpu_base->lock);
 			raw_spin_lock(&base->cpu_base->lock);
 			new_cpu_base = this_cpu_base;
@@ -264,8 +305,8 @@ switch_hrtimer_base(struct hrtimer *timer, struct hrtimer_clock_base *base,
 		}
 		WRITE_ONCE(timer->base, new_base);
 	} else {
-		if (new_cpu_base != this_cpu_base &&
-		    hrtimer_check_target(timer, new_base)) {
+		if (!hrtimer_suitable_target(timer, new_base,  new_cpu_base,
+					     this_cpu_base)) {
 			new_cpu_base = this_cpu_base;
 			goto again;
 		}
@@ -716,8 +757,6 @@ static inline int hrtimer_is_hres_enabled(void)
 	return hrtimer_hres_enabled;
 }
 
-static void retrigger_next_event(void *arg);
-
 /*
  * Switch to high resolution mode
  */
@@ -1206,6 +1245,7 @@ static int __hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
 				    u64 delta_ns, const enum hrtimer_mode mode,
 				    struct hrtimer_clock_base *base)
 {
+	struct hrtimer_cpu_base *this_cpu_base = this_cpu_ptr(&hrtimer_bases);
 	struct hrtimer_clock_base *new_base;
 	bool force_local, first;
 
@@ -1217,9 +1257,15 @@ static int __hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
 	 * and enforce reprogramming after it is queued no matter whether
 	 * it is the new first expiring timer again or not.
 	 */
-	force_local = base->cpu_base == this_cpu_ptr(&hrtimer_bases);
+	force_local = base->cpu_base == this_cpu_base;
 	force_local &= base->cpu_base->next_timer == timer;
 
+	/*
+	 * Don't force local queuing if this enqueue happens on a unplugged
+	 * CPU after hrtimer_cpu_dying() has been invoked.
+	 */
+	force_local &= this_cpu_base->online;
+
 	/*
 	 * Remove an active timer from the queue. In case it is not queued
 	 * on the current CPU, make sure that remove_hrtimer() updates the
@@ -1249,8 +1295,17 @@ static int __hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
 	}
 
 	first = enqueue_hrtimer(timer, new_base, mode);
-	if (!force_local)
-		return first;
+	if (!force_local) {
+		if (hrtimer_base_is_online(this_cpu_base))
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
