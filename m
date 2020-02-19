Return-Path: <SRS0=W0OP=4H=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2A6C3404D
	for <rcu@archiver.kernel.org>; Wed, 19 Feb 2020 03:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BDA624658
	for <rcu@archiver.kernel.org>; Wed, 19 Feb 2020 03:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="or6ekwik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgBSDbt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 18 Feb 2020 22:31:49 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:47079 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgBSDbt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 18 Feb 2020 22:31:49 -0500
Received: by mail-qk1-f193.google.com with SMTP id u124so21267777qkh.13
        for <rcu@vger.kernel.org>; Tue, 18 Feb 2020 19:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jHR/l6G5FEKGMJhTzgWx6Lx5s7Me/VCpIw5FaLdoEjA=;
        b=or6ekwiklAlNX8SKgSHr0xR2FDZTUR5ht8LBrn8aAlKiu+SefIuup7N9U8ZOZkLSpg
         ZEpV4XAPb8xs49yymfrh55OjRTmRvdKT8BLsL4T0ybQ50iY1LWguDmF4BavU9Ymu1S78
         3s50jjReQRxRyMxoSFP9peJPozJDmhbqTukSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jHR/l6G5FEKGMJhTzgWx6Lx5s7Me/VCpIw5FaLdoEjA=;
        b=a2UxWunKo119iMg2s/+KQ9Kd8mTHyNhApAq25BWm2eURRQRRT7ZHa8X3DeEOmgumeF
         vaOoCMgvm0IknToEe02vbTGKACEIhUTFXYb1MwXlkfb2tyQ2NUME+SVk1EgY7GqAZWov
         aoebGgj5X7hsvHj2wr4nmB4reY8PpIemPkK9rfygWRabCqIa+peSfmC+piwXnG7XE/QE
         ZwF9GaAAwr9UeKcMAEowrlsISRQ0E+wn0pB/OxghvqQPA7AfnZuauJKus4NrRYqrJsVN
         QYBdRb5xtliKH+Y9se9BHceJx4rY4ZVCYmGbEpWXl0ilur0KjpOTMIfijOzfciASd7Xl
         +kbA==
X-Gm-Message-State: APjAAAWcNk0HgihmoF0flOBTpiMjayRhtMy8WjYSDm/ddhX3JkVOIKh2
        M3rYT3bQr5CJu97kmEzO/R9Apw==
X-Google-Smtp-Source: APXvYqwgPAs38dxkial8Gm1edpOh6Av9hIBhnJLfYkPtJUxTy+RJYV4Fd83usTr6jDlHZFbdvJ8yDg==
X-Received: by 2002:a37:4dc1:: with SMTP id a184mr21909944qkb.62.1582083108373;
        Tue, 18 Feb 2020 19:31:48 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id l10sm357109qke.93.2020.02.18.19.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 19:31:47 -0800 (PST)
Date:   Tue, 18 Feb 2020 22:31:47 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH V2 1/7] rcu: use preempt_count to test whether scheduler
 locks is held
Message-ID: <20200219033147.GA103554@google.com>
References: <20191102124559.1135-1-laijs@linux.alibaba.com>
 <20191102124559.1135-2-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191102124559.1135-2-laijs@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Nov 02, 2019 at 12:45:53PM +0000, Lai Jiangshan wrote:
> Ever since preemption was introduced to linux kernel,
> irq disabled spinlocks are always held with preemption
> disabled. One of the reason is that sometimes we need
> to use spin_unlock() which will do preempt_enable()
> to unlock the irq disabled spinlock with keeping irq
> disabled. So preempt_count can be used to test whether
> scheduler locks is possible held.
> 
> CC: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>  kernel/rcu/tree_plugin.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 0982e9886103..aba5896d67e3 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -603,10 +603,14 @@ static void rcu_read_unlock_special(struct task_struct *t)
>  		      tick_nohz_full_cpu(rdp->cpu);
>  		// Need to defer quiescent state until everything is enabled.
>  		if (irqs_were_disabled && use_softirq &&
> -		    (in_interrupt() ||
> -		     (exp && !t->rcu_read_unlock_special.b.deferred_qs))) {
> +		    (in_interrupt() || (exp && !preempt_bh_were_disabled))) {
>  			// Using softirq, safe to awaken, and we get
>  			// no help from enabling irqs, unlike bh/preempt.
> +			// in_interrupt(): raise_softirq_irqoff() is
> +			// guaranteed not to not do wakeup
> +			// !preempt_bh_were_disabled: scheduler locks cannot
> +			// be held, since spinlocks are always held with
> +			// preempt_disable(), so the wakeup will be safe.

This means if preemption is disabled for any reason (other than scheduler
locks), such as acquiring an unrelated lock that is not held by the
scheduler, then the softirq would not be raised even if it was safe to
do so. From that respect, it seems a step back no?

thanks,

 - Joel


>  			raise_softirq_irqoff(RCU_SOFTIRQ);
>  		} else {
>  			// Enabling BH or preempt does reschedule, so...
> -- 
> 2.20.1
> 
