Return-Path: <SRS0=Owwk=YH=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C299EC4CECE
	for <rcu@archiver.kernel.org>; Mon, 14 Oct 2019 18:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95F6E20873
	for <rcu@archiver.kernel.org>; Mon, 14 Oct 2019 18:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Ekfrpz2a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731068AbfJNSAm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 14 Oct 2019 14:00:42 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39377 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730163AbfJNSAm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 14 Oct 2019 14:00:42 -0400
Received: by mail-pl1-f194.google.com with SMTP id s17so8331737plp.6
        for <rcu@vger.kernel.org>; Mon, 14 Oct 2019 11:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y6VSaW/7zntTN9DCrQRFt81obtl22iyO/4oFYY9k7ig=;
        b=Ekfrpz2aVmoS3IBXcf+BcLm5HlDb2HXZe9FhN/Z1OSz5oyUnWqjUYIm/w2ffATG35A
         gP042Xp4L896ahIGtgICWTN9wZOC5KqaGCrgUGYHH8gxlurb5Xzs3x2Yua8+Lll+oUpp
         ScPgFlBOXa9OAU+vkrQH1FimMJmUBKmHYfROM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y6VSaW/7zntTN9DCrQRFt81obtl22iyO/4oFYY9k7ig=;
        b=rpncIo/5AZk2AnhWpmV4jPfbvYQj1380xEz2/1rYncFjXkawqSfpuErPP69D9t+P72
         KGQ4SqV8bbhanWhF6MAKpf126LMTUT7L/3TZ/A7i9wLqISd8ULoP0P9+UlMS5c1KxzxB
         WYJFhH+Qcmi8jznOSGoP8VvpXD63vZ0s9ZC6NDKl5TyttaZ/lSab2FQvJ434cZpBR3rp
         cKwsZ2JldB2l0AaU4QqgM7GwsHs/I8sf3Qk309C7wl3HJy5FulAztd/1gkcUnIK+5f5a
         eYFj6Xapg2aE5dtqr+F5fyn9rRmnDJea7AVjERi79xqOw0XnfTrSpWcKufVqnuogFcOr
         +50g==
X-Gm-Message-State: APjAAAULlN3dmQAjxvioyRG9eoc6ljXwOjbQ08cvoCgQUzK0f01Q+W0T
        myhPnatpPgzM8Sve7IF7oSzoHQ==
X-Google-Smtp-Source: APXvYqzCarLPHGKQhcHkn9uapweNcBgKs9YufWWl2/E2cFfut7f6UBw27jU5LyIU4KsAZxSqsABTKA==
X-Received: by 2002:a17:902:6acb:: with SMTP id i11mr30347271plt.273.1571076040776;
        Mon, 14 Oct 2019 11:00:40 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q3sm25293990pgj.54.2019.10.14.11.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 11:00:40 -0700 (PDT)
Date:   Mon, 14 Oct 2019 14:00:39 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Marco Elver <elver@google.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: [PATCH] rcu: Fix data-race due to atomic_t copy-by-value
Message-ID: <20191014180039.GA89937@google.com>
References: <5da2509f.1c69fb81.bb59c.b8e2SMTPIN_ADDED_BROKEN@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5da2509f.1c69fb81.bb59c.b8e2SMTPIN_ADDED_BROKEN@mx.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Oct 09, 2019 at 05:57:43PM +0200, Marco Elver wrote:
> This fixes a data-race where `atomic_t dynticks` is copied by value. The
> copy is performed non-atomically, resulting in a data-race if `dynticks`
> is updated concurrently.
> 
> This data-race was found with KCSAN:
> ==================================================================
> BUG: KCSAN: data-race in dyntick_save_progress_counter / rcu_irq_enter
> 
> write to 0xffff989dbdbe98e0 of 4 bytes by task 10 on cpu 3:
>  atomic_add_return include/asm-generic/atomic-instrumented.h:78 [inline]
>  rcu_dynticks_snap kernel/rcu/tree.c:310 [inline]
>  dyntick_save_progress_counter+0x43/0x1b0 kernel/rcu/tree.c:984
>  force_qs_rnp+0x183/0x200 kernel/rcu/tree.c:2286
>  rcu_gp_fqs kernel/rcu/tree.c:1601 [inline]
>  rcu_gp_fqs_loop+0x71/0x880 kernel/rcu/tree.c:1653
>  rcu_gp_kthread+0x22c/0x3b0 kernel/rcu/tree.c:1799
>  kthread+0x1b5/0x200 kernel/kthread.c:255
>  <snip>
> 
> read to 0xffff989dbdbe98e0 of 4 bytes by task 154 on cpu 7:
>  rcu_nmi_enter_common kernel/rcu/tree.c:828 [inline]
>  rcu_irq_enter+0xda/0x240 kernel/rcu/tree.c:870
>  irq_enter+0x5/0x50 kernel/softirq.c:347
>  <snip>
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 7 PID: 154 Comm: kworker/7:1H Not tainted 5.3.0+ #5
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> Workqueue: kblockd blk_mq_run_work_fn
> ==================================================================
> 
> Signed-off-by: Marco Elver <elver@google.com>

I believe Paul has already queued this, but anyway I have reviewed it as well
and it LGTM.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


> ---
>  include/trace/events/rcu.h |  4 ++--
>  kernel/rcu/tree.c          | 11 ++++++-----
>  2 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
> index 694bd040cf51..fdd31c5fd126 100644
> --- a/include/trace/events/rcu.h
> +++ b/include/trace/events/rcu.h
> @@ -442,7 +442,7 @@ TRACE_EVENT_RCU(rcu_fqs,
>   */
>  TRACE_EVENT_RCU(rcu_dyntick,
>  
> -	TP_PROTO(const char *polarity, long oldnesting, long newnesting, atomic_t dynticks),
> +	TP_PROTO(const char *polarity, long oldnesting, long newnesting, int dynticks),
>  
>  	TP_ARGS(polarity, oldnesting, newnesting, dynticks),
>  
> @@ -457,7 +457,7 @@ TRACE_EVENT_RCU(rcu_dyntick,
>  		__entry->polarity = polarity;
>  		__entry->oldnesting = oldnesting;
>  		__entry->newnesting = newnesting;
> -		__entry->dynticks = atomic_read(&dynticks);
> +		__entry->dynticks = dynticks;
>  	),
>  
>  	TP_printk("%s %lx %lx %#3x", __entry->polarity,
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 81105141b6a8..62e59596a30a 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -576,7 +576,7 @@ static void rcu_eqs_enter(bool user)
>  	}
>  
>  	lockdep_assert_irqs_disabled();
> -	trace_rcu_dyntick(TPS("Start"), rdp->dynticks_nesting, 0, rdp->dynticks);
> +	trace_rcu_dyntick(TPS("Start"), rdp->dynticks_nesting, 0, atomic_read(&rdp->dynticks));
>  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
>  	rdp = this_cpu_ptr(&rcu_data);
>  	do_nocb_deferred_wakeup(rdp);
> @@ -649,14 +649,15 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
>  	 * leave it in non-RCU-idle state.
>  	 */
>  	if (rdp->dynticks_nmi_nesting != 1) {
> -		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nmi_nesting, rdp->dynticks_nmi_nesting - 2, rdp->dynticks);
> +		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nmi_nesting, rdp->dynticks_nmi_nesting - 2,
> +				  atomic_read(&rdp->dynticks));
>  		WRITE_ONCE(rdp->dynticks_nmi_nesting, /* No store tearing. */
>  			   rdp->dynticks_nmi_nesting - 2);
>  		return;
>  	}
>  
>  	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
> -	trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nmi_nesting, 0, rdp->dynticks);
> +	trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nmi_nesting, 0, atomic_read(&rdp->dynticks));
>  	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
>  
>  	if (irq)
> @@ -743,7 +744,7 @@ static void rcu_eqs_exit(bool user)
>  	rcu_dynticks_task_exit();
>  	rcu_dynticks_eqs_exit();
>  	rcu_cleanup_after_idle();
> -	trace_rcu_dyntick(TPS("End"), rdp->dynticks_nesting, 1, rdp->dynticks);
> +	trace_rcu_dyntick(TPS("End"), rdp->dynticks_nesting, 1, atomic_read(&rdp->dynticks));
>  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
>  	WRITE_ONCE(rdp->dynticks_nesting, 1);
>  	WARN_ON_ONCE(rdp->dynticks_nmi_nesting);
> @@ -827,7 +828,7 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
>  	}
>  	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
>  			  rdp->dynticks_nmi_nesting,
> -			  rdp->dynticks_nmi_nesting + incby, rdp->dynticks);
> +			  rdp->dynticks_nmi_nesting + incby, atomic_read(&rdp->dynticks));
>  	WRITE_ONCE(rdp->dynticks_nmi_nesting, /* Prevent store tearing. */
>  		   rdp->dynticks_nmi_nesting + incby);
>  	barrier();
> -- 
> 2.23.0.581.g78d2f28ef7-goog
> 
> 
