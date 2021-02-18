Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9DFC43332
	for <rcu@archiver.kernel.org>; Thu, 18 Feb 2021 16:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F3996146D
	for <rcu@archiver.kernel.org>; Thu, 18 Feb 2021 16:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbhBRQnp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Feb 2021 11:43:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:43222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230299AbhBRPQh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Feb 2021 10:16:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A82F664E33;
        Thu, 18 Feb 2021 15:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613661354;
        bh=MyfFbfr3pNGHW7aF5apPLt2vI7LPbZ/mH6iNBNniVm4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ojh8k9zXSMwDmKBSlWGCV6XfaPgE1sNCgdjMsXcouq6f3dx7eQlTVyGtQ+m60+PE1
         HkZAvmAlTMgkMvkeXw5aymchPEHqRZE8/PQRCMt92hv4FNCQVPz5ZkLTFHd/ipcuwn
         oKMVvjKyDYrc1ZkKs5+hr7wjCK+KlLmnk3jJcGCqlVrYW9kfhSCzdVRMr0bA8kZ7SK
         inKJ/vVvGCW7ud346TKps/ticZn/uFlBjE6KnoVsiQnCjPf7Bq8AvvFEWzVjJLIpp9
         lqRyzTnwnYhf8PMdWvsrYsYSTQt6S6M5DlWUKZz1rdBkJlbq0KGSEG4yIe7rJg2l1A
         TkZvFtzOmZ05g==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5E9C435226A0; Thu, 18 Feb 2021 07:15:54 -0800 (PST)
Date:   Thu, 18 Feb 2021 07:15:54 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Michal Hocko <mhocko@suse.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH] kprobes: Fix to delay the kprobes jump optimization
Message-ID: <20210218151554.GQ2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <161365856280.719838.12423085451287256713.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161365856280.719838.12423085451287256713.stgit@devnote2>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Feb 18, 2021 at 11:29:23PM +0900, Masami Hiramatsu wrote:
> Commit 36dadef23fcc ("kprobes: Init kprobes in early_initcall")
> moved the kprobe setup in early_initcall(), which includes kprobe
> jump optimization.
> The kprobes jump optimizer involves synchronize_rcu_tasks() which
> depends on the ksoftirqd and rcu_spawn_tasks_*(). However, since
> those are setup in core_initcall(), kprobes jump optimizer can not
> run at the early_initcall().
> 
> To avoid this issue, make the kprobe optimization disabled in the
> early_initcall() and enables it in subsys_initcall().
> 
> Note that non-optimized kprobes is still available after
> early_initcall(). Only jump optimization is delayed.
> 
> Fixes: 36dadef23fcc ("kprobes: Init kprobes in early_initcall")
> Reported-by: Paul E. McKenney <paulmck@kernel.org>

Thank you, but the original report of a problem was from Sebastian
and the connection to softirq was Uladzislau.  So could you please
add these before (or even in place of) my Reported-by?

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reported-by: Uladzislau Rezki <urezki@gmail.com>

Other than that, looks good!

Acked-by: Paul E. McKenney <paulmck@kernel.org>

							Thanx, Paul

> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>  kernel/kprobes.c |   31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index d5a3eb74a657..779d8322e307 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -861,7 +861,6 @@ static void try_to_optimize_kprobe(struct kprobe *p)
>  	cpus_read_unlock();
>  }
>  
> -#ifdef CONFIG_SYSCTL
>  static void optimize_all_kprobes(void)
>  {
>  	struct hlist_head *head;
> @@ -887,6 +886,7 @@ static void optimize_all_kprobes(void)
>  	mutex_unlock(&kprobe_mutex);
>  }
>  
> +#ifdef CONFIG_SYSCTL
>  static void unoptimize_all_kprobes(void)
>  {
>  	struct hlist_head *head;
> @@ -2497,18 +2497,14 @@ static int __init init_kprobes(void)
>  		}
>  	}
>  
> -#if defined(CONFIG_OPTPROBES)
> -#if defined(__ARCH_WANT_KPROBES_INSN_SLOT)
> -	/* Init kprobe_optinsn_slots */
> -	kprobe_optinsn_slots.insn_size = MAX_OPTINSN_SIZE;
> -#endif
> -	/* By default, kprobes can be optimized */
> -	kprobes_allow_optimization = true;
> -#endif
> -
>  	/* By default, kprobes are armed */
>  	kprobes_all_disarmed = false;
>  
> +#if defined(CONFIG_OPTPROBES) && defined(__ARCH_WANT_KPROBES_INSN_SLOT)
> +	/* Init kprobe_optinsn_slots for allocation */
> +	kprobe_optinsn_slots.insn_size = MAX_OPTINSN_SIZE;
> +#endif
> +
>  	err = arch_init_kprobes();
>  	if (!err)
>  		err = register_die_notifier(&kprobe_exceptions_nb);
> @@ -2523,6 +2519,21 @@ static int __init init_kprobes(void)
>  }
>  early_initcall(init_kprobes);
>  
> +#if defined(CONFIG_OPTPROBES)
> +static int __init init_optprobes(void)
> +{
> +	/*
> +	 * Enable kprobe optimization - this kicks the optimizer which
> +	 * depends on synchronize_rcu_tasks() and ksoftirqd, that is
> +	 * not spawned in early initcall. So delay the optimization.
> +	 */
> +	optimize_all_kprobes();
> +
> +	return 0;
> +}
> +subsys_initcall(init_optprobes);
> +#endif
> +
>  #ifdef CONFIG_DEBUG_FS
>  static void report_probe(struct seq_file *pi, struct kprobe *p,
>  		const char *sym, int offset, char *modname, struct kprobe *pp)
> 
