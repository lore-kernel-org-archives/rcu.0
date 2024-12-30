Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F772AD3B;
	Mon, 30 Dec 2024 12:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735561173; cv=none; b=BRPE0gAaZFJ0h2FtGZgu7CN4/UkaRT2bGs9XFXomNPG2GIuH4OXWdPKcZvwoo1X5bTjLUVcqFDGjYk9ug4VPuzDW1pDEBvlbdItGpN2VPBNZr/t+XzpFJLnn/vEug6T3c9ANxVljJrTFaK2JAgD0c9jpXtaOG4+CXxLJcMAWSb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735561173; c=relaxed/simple;
	bh=bqxkORNJpaq+JoiMiXJH3P/qEkky9C3elR9JDcB0aEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XRgXoIQWOS9Hi5wfCb7LCFkcrboxXJEGiPd5DmkG8Q109nj3a1SzmS92oQLRsHzgLFq+Hx+tU+F9VCKaI2fTp8gXBVYqgPq7TOpBk2fBv071xwF83npOxN3sM5IPPIo56bzYXA6Kl5gNVrRTKlWan3tIO/XaOVNuQsP6sEQSRHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAWa5OjP; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAWa5OjP"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-436a39e4891so10839605e9.1;
        Mon, 30 Dec 2024 04:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735561169; x=1736165969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QWWkSbN6NUgUXBwI7RU6jCg/T5wPCSv0GAcMbUD2UN8=;
        b=hAWa5OjPojvD//SwpW1DydUE9meqaoGeq14ROoMiQpOzKnSUVJiHweBRvP6ugyjXuU
         fdDwOjUpy2DUZT9e7HFZmshJ0+ZRF9X8rtFvUW9WVO85w/zzPoxKDZUMwsonjeFBKvjH
         98V8ai8IT5V3bWSzwRUr8WP4wSw2K1gS0Gsbs8b/de9FBuKYKbAwLBHbsEP4UCCKLRIF
         C3fKZGAD2ESZ7QxW3g3yJPRjfpRTGSmVVZMKrOZdLSsy2Go2KPEXpqmFjQYMGAlNy8WI
         OaeY4uZ5a+BRqWYdE7ORhRuHNnceav2l5/QArG7MQ4EgErjlxpg2rDYcONBus7t4jj2V
         BRCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735561169; x=1736165969;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QWWkSbN6NUgUXBwI7RU6jCg/T5wPCSv0GAcMbUD2UN8=;
        b=qgkXI/fPFdc+YK1jwkH8If+LK6NzBIDiOlYVigIX0Y9yJY7I3mSJxwHNgLHt7KE4nx
         hy2AKtRHNW2HcZVo3pFuJPloM+DGSr4hbzTD1pFrBLvH1RFAqiGZeu799gHdtSo1lKJL
         9riEbglljO6XL39x2c0uQ1/aRANObi+fyZ78fI3ooDkPCQfLgwLujWseSHEh6WFeimyh
         x8jxeyEiF7CUNJe8QHQ6nqm2DeuF5Z9PNEYQu9DdvAA4BcW8CHen1DVucWoqv/0xwmcc
         Zh7UrZDjw3g16qK/Q8z3N0TVJ9149Gsc99P/8foPs3lbF970JRlLWxz7jfDVq2HgEreo
         w34A==
X-Forwarded-Encrypted: i=1; AJvYcCWxXSgXlH+BOdLPr+dqE/KsH7lnr5YC47uvtx6THYIiWjYkjI/m6Vy76He0UdyarnoV+TQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDCQAKy72ptuWlY4J8jQ6e4JBV9lx90btf99npfgFV4a/MIEbN
	QqcGNIklbSnoBafSLgkQGqTMW1OZZiwv8wthiCX2UtH4YN9WPIRD
X-Gm-Gg: ASbGncvpfTUHKpVvqdbSB++aZqw2Xx6d4cmpkuh6r74PSMjcP5ZmwK580qjzBF4YFTM
	zSN9oGqt18Jq2FSx+hEb1GW2EsDzMf9bC2qbkuzesPsOcFXbMeh8sp1zG8g/Bs2BfOmX7JqyXeB
	mo4MshbdK7aNquWFhOHktQW7PaQLtttJZzRBMBNwAH0rnDzvylp9+ipZCRLMdKGSVkXKRugn6L+
	x+YjMdcQv4GgU7seNnE0h7L+WGQmpvIJaM4iCcKeCR6oF60vS1Vz3F7yw86kRRWOUPYvbRWrXuj
	bgegaoobedc9TBsOuYHwgPHU6OE1wcYqpJq4nU6kcTo4BRFr4g==
X-Google-Smtp-Source: AGHT+IGKNA0jK/Jqze63QM8xAZjJ9UFNQqyixfrue7mBMNsfePHoP2oMUT/luYGODz6lkThu+36ibQ==
X-Received: by 2002:a5d:584d:0:b0:385:e0d6:fb73 with SMTP id ffacd0b85a97d-38a221fa9cdmr28784850f8f.15.1735561169042;
        Mon, 30 Dec 2024 04:19:29 -0800 (PST)
Received: from ?IPV6:2a02:6b67:d752:5f00:c46:86ac:45ea:7590? ([2a02:6b67:d752:5f00:c46:86ac:45ea:7590])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c832b32sm29491373f8f.23.2024.12.30.04.19.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2024 04:19:28 -0800 (PST)
Message-ID: <3ba35452-7822-40e7-908d-aec9d322b9d0@gmail.com>
Date: Mon, 30 Dec 2024 12:19:28 +0000
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3 v2] hrtimers: Force migrate away hrtimers queued after
 CPUHP_AP_HRTIMERS_DYING
To: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, vlad.wing@gmail.com,
 rcu@vger.kernel.org, boqun.feng@gmail.com, joel@joelfernandes.org,
 neeraj.upadhyay@amd.com, urezki@gmail.com, qiang.zhang1211@gmail.com,
 Cheng-Jui.Wang@mediatek.com, leitao@debian.org, kernel-team@meta.com,
 paulmck@kernel.org, Anna-Maria Behnsen <anna-maria@linutronix.de>
References: <20241226233052.145450-1-frederic@kernel.org>
 <20241226233052.145450-2-frederic@kernel.org>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20241226233052.145450-2-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 26/12/2024 23:30, Frederic Weisbecker wrote:
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
> 
>            WARNING: CPU: 94 PID: 588 at kernel/time/hrtimer.c:1086 hrtimer_start_range_ns+0x289/0x2d0
>            Modules linked in:
>            CPU: 94 UID: 0 PID: 588 Comm: migration/94 Not tainted
>            Stopper: multi_cpu_stop+0x0/0x120 <- stop_machine_cpuslocked+0x66/0xc0
>            RIP: 0010:hrtimer_start_range_ns+0x289/0x2d0
>            Code: 41 5c 41 5d 41 5e 41 5f 5d e9 63 94 ea 00 0f 0b 48 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d e9 39 fc 15 01 0f 0b e9 c1 fd ff ff <0f> 0b 48 8b
> +45 00 e9 59 ff ff ff f3 0f 1e fa 65 8b 05 1d ec e8 7e
>            RSP: 0018:ffffc900019cbcc8 EFLAGS: 00010046
>            RAX: ffff88bf449a4c40 RBX: 0000000000000082 RCX: 0000000000000001
>            RDX: 0000000000000001 RSI: ffff88bf43224c80 RDI: ffff88bf449a4c40
>            RBP: ffff88bf449a4c80 R08: ffff888280970090 R09: 0000000000000000
>            R10: ffff88bf432252e0 R11: ffffffff811abf70 R12: ffff88bf449a4c40
>            R13: ffff88bf43234b28 R14: ffff88bf43224c80 R15: 0000000000000000
>            FS:  0000000000000000(0000) GS:ffff88bf44980000(0000) knlGS:0000000000000000
>            CR2: 0000000000000000 CR3: 000000404b230001 CR4: 0000000000770ef0
>            PKRU: 55555554
>            Call Trace:
>             <TASK>
>             ? __warn+0xcf/0x1b0
>             ? hrtimer_start_range_ns+0x289/0x2d0
>             ? report_bug+0x120/0x1a0
>             ? handle_bug+0x60/0x90
>             ? exc_invalid_op+0x1a/0x50
>             ? asm_exc_invalid_op+0x1a/0x20
>             ? register_refined_jiffies+0xb0/0xb0
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
> 
> Instead of providing yet another bandaid to work around the situation,
> fix it from hrtimers infrastructure instead: always migrate away a
> timer to an online target whenever it is enqueued from an offline CPU.
> 
> This will also allow to revert all the above RCU disgraceful hacks.
> 
> Reported-by: Reported-by: Vlad Poenaru <vlad.wing@gmail.com>
> Reported-by: Usama Arif <usamaarif642@gmail.com>
> Fixes: 5c0930ccaad5 ("hrtimers: Push pending hrtimers away from outgoing CPU earlier")
> Closes: 20241213203739.1519801-1-usamaarif642@gmail.com
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  include/linux/hrtimer_defs.h |  1 +
>  kernel/time/hrtimer.c        | 55 +++++++++++++++++++++++++++++++++---
>  2 files changed, 52 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/hrtimer_defs.h b/include/linux/hrtimer_defs.h
> index c3b4b7ed7c16..84a5045f80f3 100644
> --- a/include/linux/hrtimer_defs.h
> +++ b/include/linux/hrtimer_defs.h
> @@ -125,6 +125,7 @@ struct hrtimer_cpu_base {
>  	ktime_t				softirq_expires_next;
>  	struct hrtimer			*softirq_next_timer;
>  	struct hrtimer_clock_base	clock_base[HRTIMER_MAX_CLOCK_BASES];
> +	call_single_data_t		csd;
>  } ____cacheline_aligned;
>  
>  
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index 80fe3749d2db..e389a8ce28c8 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -58,6 +58,8 @@
>  #define HRTIMER_ACTIVE_SOFT	(HRTIMER_ACTIVE_HARD << MASK_SHIFT)
>  #define HRTIMER_ACTIVE_ALL	(HRTIMER_ACTIVE_SOFT | HRTIMER_ACTIVE_HARD)
>  
> +static void retrigger_next_event(void *arg);
> +
>  /*
>   * The timer bases:
>   *
> @@ -111,7 +113,8 @@ DEFINE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases) =
>  			.clockid = CLOCK_TAI,
>  			.get_time = &ktime_get_clocktai,
>  		},
> -	}
> +	},
> +	.csd = CSD_INIT(retrigger_next_event, NULL)
>  };
>  
>  static const int hrtimer_clock_to_base_table[MAX_CLOCKS] = {
> @@ -716,8 +719,6 @@ static inline int hrtimer_is_hres_enabled(void)
>  	return hrtimer_hres_enabled;
>  }
>  
> -static void retrigger_next_event(void *arg);
> -
>  /*
>   * Switch to high resolution mode
>   */
> @@ -1202,10 +1203,50 @@ hrtimer_update_softirq_timer(struct hrtimer_cpu_base *cpu_base, bool reprogram)
>  	hrtimer_reprogram(cpu_base->softirq_next_timer, reprogram);
>  }
>  
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

Should there be lockdep_assert_held(&old_cpu_base->lock) before this?
We are assuming enqueue_hrtimer_offline is being called with the lock held?

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
> +#endif
> +}
> +
> +

nits: An extra new line above, and it might be a personal preference, but
I think its better if there is an empty enqueue_hrtimer_offline function
in the else part of ifdef CONFIG_HOTPLUG_CPU instead of enclosing the body of the
function in the ifdef.


>  static int __hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
>  				    u64 delta_ns, const enum hrtimer_mode mode,
>  				    struct hrtimer_clock_base *base)
>  {
> +	struct hrtimer_cpu_base *this_cpu_base = this_cpu_ptr(&hrtimer_bases);
>  	struct hrtimer_clock_base *new_base;
>  	bool force_local, first;
>  
> @@ -1217,7 +1258,7 @@ static int __hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
>  	 * and enforce reprogramming after it is queued no matter whether
>  	 * it is the new first expiring timer again or not.
>  	 */
> -	force_local = base->cpu_base == this_cpu_ptr(&hrtimer_bases);
> +	force_local = base->cpu_base == this_cpu_base;
>  	force_local &= base->cpu_base->next_timer == timer;
>  
>  	/*
> @@ -1240,6 +1281,12 @@ static int __hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
>  
>  	hrtimer_set_expires_range_ns(timer, tim, delta_ns);
>  
> +	if (unlikely(!this_cpu_base->online)) {
> +		enqueue_hrtimer_offline(timer, base, mode);
> +		return 0;
> +	}
> +
> +
nit: extra new newline.

>  	/* Switch the timer base, if necessary: */
>  	if (!force_local) {
>  		new_base = switch_hrtimer_base(timer, base,

