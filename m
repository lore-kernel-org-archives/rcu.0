Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0241E1AAE1B;
	Thu, 19 Dec 2024 19:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734634832; cv=none; b=b1gqt2bGUOmwVL3b0XGgQuGasOcNP+oNtyIJfduD/Z6ZpRxqT4s4XPCAbctU8/xDpFnlKca45CNV8IYj6c3Y2cCIx0DKI5uYwVwnfZKnRZToukMR7Q9nEknBhmDM1r1etUkC6wa5Tr9naw1GSTxaqcD6ZYTvNAxDRuSK5EIEvyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734634832; c=relaxed/simple;
	bh=OL+QuBQE5DhczY0BR9AfcmzOtPTqVZJ67W3JYVuFR2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OehYHSDmsjmz+keV23UPkt+zwFhjSq3AZfiBrHfjjYxRiKkadEcU+llIjQZfMnjMRXxoK1iKZ/W3cKmJDyGGjmMquBZgUdjRK3P/huEvgS0slqsVnyLCW+7Y1/UKdyuvHeFPwE7GC/cVsN3czn037/JigVGC/c6E9hwaiCZQumc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUaYg/YY; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUaYg/YY"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385de9f789cso873295f8f.2;
        Thu, 19 Dec 2024 11:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734634816; x=1735239616; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=raqRb9mcyFM0hHwMpXtj14f7JtumHpups+3suVdjAEY=;
        b=aUaYg/YYh6Hl6aTD/ncKOYfl5a462xvcpxCAtbdANdVwtNRyR1h6geFrkec2Vyl5Ks
         h1LZLPHMVX7+lTdg2v8VycTs1te81zJPmsLdMPrvjgNKyFLIXq5/TWZpVcXCKUfEvkZh
         Aa+/6OBb9KvMad/NEsjK05umPAU/gKx+lMyEjyXFnWuxjKsCQjHw0N5BtlBQy7Gs0Znf
         vxXXxMtgG4lH5aTDmEUITDinULAGib+dISdztntROY6jenTkCLphb5zIG0u1pSkKCofF
         xbmfeL1MubHnZ9QTmUOYiOgDUbvqTfMMAS7YQMOtfgQhS2FBEl1lPBExtSzG9vTlkTfW
         0AaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734634816; x=1735239616;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=raqRb9mcyFM0hHwMpXtj14f7JtumHpups+3suVdjAEY=;
        b=A6abANs1sPZ8sLDu9vi5P+dWsJvF4dHNTkQliznp4PWn6a8FFMgRXoSWQrLe8as345
         S27fQgaxOuWfWKREILFmtvZi/mssVQDV3b63uvA8kofFohE/a2L9eR+2K3Sx0MqjxUBS
         Q7TC7HePSFLmSXNe9bxngDhRzDRIucEWElJp/zzmBmsikUBvMGSxpuHO6UerWlv4IG0K
         vlaVkXTOCd+zHI8MjaTgrGhKOO5oS/uxN/7PL3EztFS5N8bKv3MfsGHkpKhZJPjK7W9s
         rDxejJ0z9hZ5s3zjvcBrWJ7SmAQi5Ukk/KalIMwu7/Zai1tqUbLig5ahmbfz4V0hf5vu
         yTpw==
X-Forwarded-Encrypted: i=1; AJvYcCWBzzVhggSxxfdO2l0iVCzSQzZuZS4lWyVHnpNHFHpwiQLpYbXPxvRGKFWn/jjOTemJuws=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuMkQoCQrtTfg2JJN/rWTcBwwuXgZc3hFpgMCUhwGpKf7k2sBO
	JGQ5iOeYvTcS58koQBIlwYlTv+KG1t8hzTDf0GzpB6N8raYKeLf4oLvh5g==
X-Gm-Gg: ASbGncsr2TNzUHYR/hkhCCAH4hQRCZTJLCMSRVGoikz8pKBft1e5gsPMMY+/bzmegCt
	XHqAv/pB5BOCYSMv01sq6ca6Pg0ZDXInXkb+hd36GAzec7WowUk/vYLLgOhCfbkmIAEukWT0QuZ
	r/qpM1LmD5iNVE6V4J9nDPOQL/H+vNS1dtxaNt8K50oH+hDPi9Pa27etGYuNX6dzGittYNyBqke
	0zjDzQq5mHvwzek6NZZpqiDCbG9Rt9MMXW7IcxQ5gq0kG8fP7Mplb+9zjaYyBTa61IQJTZn41oa
	1s95h106zxAlKqx37HZZsPs5DwELJk0OfIFr5UAgcSgg0hrCi4I8
X-Google-Smtp-Source: AGHT+IFYMttT5MWSc8eBeZXyi68b+EdmWF+kF3G1FYAlpgjt1ZOpW9zzXQgt94IRdbC/dMm78EBvpA==
X-Received: by 2002:a5d:47c3:0:b0:385:e35e:9da8 with SMTP id ffacd0b85a97d-38a221f69e0mr174979f8f.18.1734634815816;
        Thu, 19 Dec 2024 11:00:15 -0800 (PST)
Received: from ?IPV6:2001:16a2:df6e:a700:18a4:4b02:8c71:f6f4? ([2001:16a2:df6e:a700:18a4:4b02:8c71:f6f4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b442dasm59004515e9.42.2024.12.19.11.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 11:00:15 -0800 (PST)
Message-ID: <b2d31c28-96c4-4762-a0b4-686713bc6778@gmail.com>
Date: Thu, 19 Dec 2024 22:00:12 +0300
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hrtimers: Force migrate away hrtimers queued after
 CPUHP_AP_HRTIMERS_DYING
To: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, vlad.wing@gmail.com,
 rcu@vger.kernel.org, boqun.feng@gmail.com, joel@joelfernandes.org,
 neeraj.upadhyay@amd.com, urezki@gmail.com, qiang.zhang1211@gmail.com,
 Cheng-Jui.Wang@mediatek.com, leitao@debian.org, kernel-team@meta.com,
 paulmck@kernel.org, Anna-Maria Behnsen <anna-maria@linutronix.de>
References: <20241218165008.37820-1-frederic@kernel.org>
 <20241218165008.37820-2-frederic@kernel.org>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20241218165008.37820-2-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 18/12/2024 19:50, Frederic Weisbecker wrote:
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
> This will also allow us to revert all the above RCU disgraceful hacks.
> 
> Reported-by: Reported-by: Vlad Poenaru <vlad.wing@gmail.com>
> Reported-by: Usama Arif <usamaarif642@gmail.com>
> Fixes: 5c0930ccaad5 ("hrtimers: Push pending hrtimers away from outgoing CPU earlier")
> Closes: 20241213203739.1519801-1-usamaarif642@gmail.com
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  include/linux/hrtimer_defs.h |  1 +
>  kernel/time/hrtimer.c        | 60 +++++++++++++++++++++++++++++++-----
>  2 files changed, 54 insertions(+), 7 deletions(-)
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
> index 80fe3749d2db..48c0078d2c4f 100644
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
> @@ -761,6 +762,8 @@ static void retrigger_next_event(void *arg)
>  {
>  	struct hrtimer_cpu_base *base = this_cpu_ptr(&hrtimer_bases);
>  
> +	guard(raw_spinlock)(&base->lock);
> +
>  	/*
>  	 * When high resolution mode or nohz is active, then the offsets of
>  	 * CLOCK_REALTIME/TAI/BOOTTIME have to be updated. Otherwise the
> @@ -773,18 +776,17 @@ static void retrigger_next_event(void *arg)
>  	 * In the NOHZ case the update of the offset and the reevaluation
>  	 * of the next expiring timer is enough. The return from the SMP
>  	 * function call will take care of the reprogramming in case the
> -	 * CPU was in a NOHZ idle sleep.
> +	 * CPU was in a NOHZ idle sleep. base->lock must still be held to
> +	 * to release and synchronize against the csd unlock.
>  	 */
>  	if (!hrtimer_hres_active(base) && !tick_nohz_active)
>  		return;
>  
> -	raw_spin_lock(&base->lock);
>  	hrtimer_update_base(base);
>  	if (hrtimer_hres_active(base))
>  		hrtimer_force_reprogram(base, 0);
>  	else
>  		hrtimer_update_next_event(base);
> -	raw_spin_unlock(&base->lock);
>  }
>  
>  /*
> @@ -1202,10 +1204,48 @@ hrtimer_update_softirq_timer(struct hrtimer_cpu_base *cpu_base, bool reprogram)
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
> +}
> +
> +
>  static int __hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
>  				    u64 delta_ns, const enum hrtimer_mode mode,
>  				    struct hrtimer_clock_base *base)
>  {
> +	struct hrtimer_cpu_base *this_cpu_base = this_cpu_ptr(&hrtimer_bases);
>  	struct hrtimer_clock_base *new_base;
>  	bool force_local, first;
>  
> @@ -1217,7 +1257,7 @@ static int __hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
>  	 * and enforce reprogramming after it is queued no matter whether
>  	 * it is the new first expiring timer again or not.
>  	 */
> -	force_local = base->cpu_base == this_cpu_ptr(&hrtimer_bases);
> +	force_local = base->cpu_base == this_cpu_base;
>  	force_local &= base->cpu_base->next_timer == timer;
>  
>  	/*
> @@ -1240,6 +1280,12 @@ static int __hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
>  
>  	hrtimer_set_expires_range_ns(timer, tim, delta_ns);
>  
> +	if (unlikely(!this_cpu_base->online)) {
> +		enqueue_hrtimer_offline(timer, base, mode);

Thanks for the fix!

It looks good to me, maybe as a follow up, we could rename switch_hrtimer_base to 
enqueue_hrtimer_local? (or maybe something more appropriate)
There are now 2 different paths that switch hrtimer base (enqueue_hrtimer_offline and
switch_hrtimer_base).

> +		return 0;
> +	}
> +
> +
nit: extra new line above.
>  	/* Switch the timer base, if necessary: */
>  	if (!force_local) {
>  		new_base = switch_hrtimer_base(timer, base,

