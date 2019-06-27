Return-Path: <SRS0=YNYv=U2=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF31C48BD6
	for <rcu@archiver.kernel.org>; Thu, 27 Jun 2019 13:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DFDB20828
	for <rcu@archiver.kernel.org>; Thu, 27 Jun 2019 13:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="crqFv+rk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfF0Nmo (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 27 Jun 2019 09:42:44 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37838 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfF0Nmn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 27 Jun 2019 09:42:43 -0400
Received: by mail-pg1-f196.google.com with SMTP id 25so1054137pgy.4
        for <rcu@vger.kernel.org>; Thu, 27 Jun 2019 06:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BtdsLOtQbtH6zKyvscmgyhI/GvHwrfKtnH8oDV0gzA8=;
        b=crqFv+rkJGDvzPMA/Ahg1xqSMWqLhFPoHEEyOLgiWFVafqwomj8WEtbgq8URsrg+sV
         5Up3Co9q5LvlHbYBRqeZx0a+7JqHN02Pp4T8xzj07t0UBYw0oTRiOxbmjOcN91cOrD4f
         DIA6KLXQaf1oktcFJEGPrL6hzP9DhCqRzaGLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BtdsLOtQbtH6zKyvscmgyhI/GvHwrfKtnH8oDV0gzA8=;
        b=hAWCPzcfGArH4HtNnn87tZ2U6NmHx/rKzNzRTNyGw3OmZuPefx7kgdZZACLbUrz4Fy
         g+M8BQYph6yGlISPAVk8XZLH9/23ab0eMCkMybNuQmwfIYhNM3eHTL+1j6L0U6Jxwcwf
         z0fqrHD7C+P62WevqHbgayghTkH+TH2TimXfXVBY0jIh3LzSWUE7kpiBPw3GrdhSQV2u
         mkLrNFh73zXjoXsu8XAaAopwKAW7PQc8l+glQeuGBTgXT5sN/7jkxazu0/E5mwEre8YA
         Y0bV/iU3i/OURIzbBFDpb8c7C8dngKXWeksrMBFD0B5Oi5nc5MRtGlIPAFTM0O5zgMOq
         T/lw==
X-Gm-Message-State: APjAAAWt14/7f3MlLHEzysSJU2TlHsZrgxeapONH0B0flvQx+b56IaD9
        ZCRucGAgU8VBvrKIv1An1hwTzQ==
X-Google-Smtp-Source: APXvYqwvunFjpo4rQbmx8qfoCMvtne65a1y5eBzNzjKK9wQZrE/fgEsLypXFRUL03I7VFEiGY2PvPw==
X-Received: by 2002:a63:c5:: with SMTP id 188mr3916108pga.108.1561642963015;
        Thu, 27 Jun 2019 06:42:43 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id h11sm3471957pfn.170.2019.06.27.06.42.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 06:42:42 -0700 (PDT)
Date:   Thu, 27 Jun 2019 09:42:40 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     paulmck@linux.ibm.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com
Subject: Re: [PATCH v2] rcu: Change return type of
 rcu_spawn_one_boost_kthread()
Message-ID: <20190627134240.GB215968@google.com>
References: <1561619266-8850-1-git-send-email-byungchul.park@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561619266-8850-1-git-send-email-byungchul.park@lge.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jun 27, 2019 at 04:07:46PM +0900, Byungchul Park wrote:
> Hello,
> 
> I tested if the WARN_ON_ONCE() is fired with my box and it was ok.

Looks pretty safe to me and nice clean up!

Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>

 - Joel

> 
> Thanks,
> Byungchul
> 
> Changes from v1
> -. WARN_ON_ONCE() on failing to create rcu_boost_kthread.
> -. Changed title and commit message a bit.
> 
> ---8<---
> From 7100fcf82202f063f70f45def208ea5198412f5a Mon Sep 17 00:00:00 2001
> From: Byungchul Park <byungchul.park@lge.com>
> Date: Thu, 27 Jun 2019 15:58:10 +0900
> Subject: [PATCH v2] rcu: Change return type of rcu_spawn_one_boost_kthread()
> 
> The return value of rcu_spawn_one_boost_kthread() is not used any
> longer. Change return type of that function from int to void.
> 
> Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> ---
>  kernel/rcu/tree_plugin.h | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 1102765..3c8444e 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -1131,7 +1131,7 @@ static void rcu_preempt_boost_start_gp(struct rcu_node *rnp)
>   * already exist.  We only create this kthread for preemptible RCU.
>   * Returns zero if all is well, a negated errno otherwise.
>   */
> -static int rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
> +static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
>  {
>  	int rnp_index = rnp - rcu_get_root();
>  	unsigned long flags;
> @@ -1139,25 +1139,24 @@ static int rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
>  	struct task_struct *t;
>  
>  	if (!IS_ENABLED(CONFIG_PREEMPT_RCU))
> -		return 0;
> +		return;
>  
>  	if (!rcu_scheduler_fully_active || rcu_rnp_online_cpus(rnp) == 0)
> -		return 0;
> +		return;
>  
>  	rcu_state.boost = 1;
>  	if (rnp->boost_kthread_task != NULL)
> -		return 0;
> +		return;
>  	t = kthread_create(rcu_boost_kthread, (void *)rnp,
>  			   "rcub/%d", rnp_index);
> -	if (IS_ERR(t))
> -		return PTR_ERR(t);
> +	if (WARN_ON_ONCE(IS_ERR(t)))
> +		return;
>  	raw_spin_lock_irqsave_rcu_node(rnp, flags);
>  	rnp->boost_kthread_task = t;
>  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  	sp.sched_priority = kthread_prio;
>  	sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
>  	wake_up_process(t); /* get to TASK_INTERRUPTIBLE quickly. */
> -	return 0;
>  }
>  
>  static void rcu_cpu_kthread_setup(unsigned int cpu)
> @@ -1265,7 +1264,7 @@ static void __init rcu_spawn_boost_kthreads(void)
>  	if (WARN_ONCE(smpboot_register_percpu_thread(&rcu_cpu_thread_spec), "%s: Could not start rcub kthread, OOM is now expected behavior\n", __func__))
>  		return;
>  	rcu_for_each_leaf_node(rnp)
> -		(void)rcu_spawn_one_boost_kthread(rnp);
> +		rcu_spawn_one_boost_kthread(rnp);
>  }
>  
>  static void rcu_prepare_kthreads(int cpu)
> @@ -1275,7 +1274,7 @@ static void rcu_prepare_kthreads(int cpu)
>  
>  	/* Fire up the incoming CPU's kthread and leaf rcu_node kthread. */
>  	if (rcu_scheduler_fully_active)
> -		(void)rcu_spawn_one_boost_kthread(rnp);
> +		rcu_spawn_one_boost_kthread(rnp);
>  }
>  
>  #else /* #ifdef CONFIG_RCU_BOOST */
> -- 
> 1.9.1
> 
