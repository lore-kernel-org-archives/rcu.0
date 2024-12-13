Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEBE2AD14;
	Fri, 13 Dec 2024 22:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128970; cv=none; b=NLkdPWJl7FNJXnC/SCaVjm/AIaq0L9eJAAGY5fjY463m4l8XuTMbb8kL5n+jo2wezZGr9kpZE1uA6Or9EZSPt4DpVoCa6KZ4xtMckOdV0Pwcwte/1FWlOgsh4RGo5OzXIG36lRyfJ5xhcP/qao2biTsk+5DkLF5+tp9o/BJuOsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128970; c=relaxed/simple;
	bh=+y+6Sxg8bBJD86S5RnQwTrKhEnCwkYLHgfLaG2AWTk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kcakpd6HGebkmWiC9nwrIrSZUf+hMWAgVYWmc2qy7BpJeFksbVduRQrnhn9XORs0OwbHHtP0vyerYek59mGyB75/QAJYBEv9nEyZKSgL+Dx0xgpu2XJKt+VHt6FVFNM8JLRpnscj0X8DCrR5ZUaaowXiYel++OFD+KoDTHwz3Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpqlYFki; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpqlYFki"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4907EC4CED0;
	Fri, 13 Dec 2024 22:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734128969;
	bh=+y+6Sxg8bBJD86S5RnQwTrKhEnCwkYLHgfLaG2AWTk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dpqlYFkikU0gm3AoOViNp1RCOXY7DzIO7gCKKZLfieEikUyHBw+gu1c5cYM0+5ARt
	 J2HGeAL3AfiJez7DMZGhrA+U2gg1CagBTtkxsE31WFufBHrp7Stxw2QBsrGd4bSOuI
	 1/QD/VK9uAC9+khSsU2+zhqPP5SC5xEKTexew/AXAGcz9RGQf3RECAruCKl6Bqq00H
	 RPXe6ugiMKVThooTrqlYjLSgn3I/10j+AycMEfRCDvf8yzKQoHMW3UhkbcbnoT7a1v
	 lf9H3aXT3EklgWpUODLLgQUlC1UcIHkUYL7XWPR2qvawfgLCtCAwaQlqHQiKAiAyXV
	 TrI/AMSsLevDg==
Date: Fri, 13 Dec 2024 23:29:26 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: tglx@linutronix.de, paulmck@kernel.org, vlad.wing@gmail.com,
	rcu@vger.kernel.org, boqun.feng@gmail.com,
	linux-kernel@vger.kernel.org, joel@joelfernandes.org,
	neeraj.upadhyay@amd.com, urezki@gmail.com,
	qiang.zhang1211@gmail.com, Cheng-Jui.Wang@mediatek.com,
	leitao@debian.org, kernel-team@meta.com
Subject: Re: [RFC 1/1] sched: defer completion task to online CPU
Message-ID: <Z1y1RtE_z0b8mP7B@pavilion.home>
References: <20241213203739.1519801-1-usamaarif642@gmail.com>
 <20241213203739.1519801-2-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241213203739.1519801-2-usamaarif642@gmail.com>

Le Fri, Dec 13, 2024 at 08:33:45PM +0000, Usama Arif a écrit :
> The following warning is being encountered at boot time:
> 
>            WARNING: CPU: 94 PID: 588 at kernel/time/hrtimer.c:1086 hrtimer_start_range_ns+0x289/0x2d0
>            Modules linked in:
>            CPU: 94 UID: 0 PID: 588 Comm: migration/94 Not tainted
>            Stopper: multi_cpu_stop+0x0/0x120 <- stop_machine_cpuslocked+0x66/0xc0
>            RIP: 0010:hrtimer_start_range_ns+0x289/0x2d0
>            Code: 41 5c 41 5d 41 5e 41 5f 5d e9 63 94 ea 00 0f 0b 48 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d e9 39 fc 15 01 0f 0b e9 c1 fd ff ff <0f> 0b 48 8b 45 00 e9 59 ff ff ff f3 0f 1e fa 65 8b 05 1d ec e8 7e
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
>             ? stop_two_cpus+0x2f0/0x2f0
>             cpu_stopper_thread+0xb1/0x120
>             ? smpboot_unregister_percpu_thread+0xc0/0xc0
>             smpboot_thread_fn+0xf7/0x150
>             kthread+0x121/0x130
>             ? kthread_blkcg+0x40/0x40
>             ret_from_fork+0x39/0x50
>             ? kthread_blkcg+0x40/0x40
>             ret_from_fork_asm+0x11/0x20
>             </TASK>
> 
> It looks like completion that requires an hrtimer is being scheduled on a
> CPU that is not yet completely online. There have been other issues with
> hrtimer that have been fixed recently [1]. A possible fix would be to
> defer the completion to be done by a CPU already online.
> This bug might have been introduced in [2].
> 
> [1] https://lore.kernel.org/all/20240913214205.12359-2-frederic@kernel.org/
> [2] https://lore.kernel.org/all/169972295552.3135.1094880886431606890.tip-bot2@tip-bot2/
> Reported-by: Vlad Poenaru <vlad.wing@gmail.com>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---
>  kernel/sched/completion.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
> index 3561ab533dd4..b79d0868f997 100644
> --- a/kernel/sched/completion.c
> +++ b/kernel/sched/completion.c
> @@ -30,6 +30,13 @@ void complete_on_current_cpu(struct completion *x)
>  	return complete_with_flags(x, WF_CURRENT_CPU);
>  }
>  
> +static void complete_ipi(void *arg)
> +{
> +	struct completion *x = arg;
> +
> +	complete_with_flags(x, 0);
> +}
> +
>  /**
>   * complete: - signals a single thread waiting on this completion
>   * @x:  holds the state of this particular completion
> @@ -44,7 +51,23 @@ void complete_on_current_cpu(struct completion *x)
>   */
>  void complete(struct completion *x)
>  {
> -	complete_with_flags(x, 0);
> +	int cpu = get_cpu();
> +
> +	/* The scheduler might queue an ignored hrtimer. Defer the wake up
> +	 * to an online CPU instead.
> +	 */
> +	if (unlikely(cpu_is_offline(cpu))) {
> +		int target;
> +
> +		target = cpumask_any_and(housekeeping_cpumask(HK_TYPE_RCU),
> +					 cpu_online_mask);
> +
> +		smp_call_function_single(target, complete_ipi, x, 1);
> +		put_cpu();
> +	} else {
> +		put_cpu();
> +		complete_with_flags(x, 0);
> +	}

Right, we are doing something similar with RCU (swake_up_one_oneline() for
example). But I've never been satisfied with that bandaid. And now it's
spreading.

Should we force switch_hrtimer_base() to designate an online CPU for unpinned
timers if the current one is offline? And then send a retrigger_next_event()
with smp_call_function_async() with some special care?

Thomas, does that sound like a good way out?

Thanks.

>  }
>  EXPORT_SYMBOL(complete);
>  
> -- 
> 2.43.5
> 
