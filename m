Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB21C433DB
	for <rcu@archiver.kernel.org>; Sun, 28 Feb 2021 19:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CDE264D9C
	for <rcu@archiver.kernel.org>; Sun, 28 Feb 2021 19:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhB1Trq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 28 Feb 2021 14:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhB1Trq (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 28 Feb 2021 14:47:46 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0196C06174A
        for <rcu@vger.kernel.org>; Sun, 28 Feb 2021 11:47:05 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 18so13449242lff.6
        for <rcu@vger.kernel.org>; Sun, 28 Feb 2021 11:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MMGhfqYiZEhojDITAe7gf1ISPPPMD9G+wLG7bYFnP6k=;
        b=C4VuBaH/rv1tN3OjtW92vZ8fM0pLbMkRB9/Wuzy0Mz3hYUXiWjykCaNMnZCuXzRmSk
         r+v/biA/HhwjynBQt024ZjdDhlv0ju+QNkPwMiV6hE6T4aYqZC+HnLDlNiP7fvlKQKJ3
         cobRpymKdomTwStypYem9pMC3bCyiE7tdCldXyprr3dBT97TM4WBrZwrJGNov7xQ8g7a
         75mDZJt7mj166alZNy+z9Pzc22DEcDBJGpXjrdrqAD5xR+lml5+Mw1fBVmTcNWv12suM
         vBEgKNjk4iDXs5NvX/M86ZW6XDpzs5e+5xyXRgDNVmAMxl04BBWdmbnPvHUbVUfX/A5J
         kK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MMGhfqYiZEhojDITAe7gf1ISPPPMD9G+wLG7bYFnP6k=;
        b=DlYsG2iJCu1FNMUJMaM96c4rjyuvsiB08uHogAWOnBUGMTlieoeIp4cxtOlbzpJe5u
         KKSYdBOmKV4gRQshyHtvM3nyeKLWnNVVAUyE+yrOIXXY3CDuIZoghQUQk6pECtz2wrZe
         hp2Kiptf8RZBYeBWxp3zok2Fe8N3lxHgRMD2CVrlKVzeB6I0ky/mer6zLnP+ejWFokOr
         1xGtQR9R6Uvaw0qQJvet+LM0pqjZtrmM7qladfyiPIiHFLkUsW+KH/OqnOods12KPOha
         gE/I1vfGfWRItcwZKn312uLGgXWj3BjN33OHYG5rSQxaOE2jT0Z6yErJi7Lwubc1dyvH
         EEMA==
X-Gm-Message-State: AOAM53145pUFRMCcKdxfvc6EIzu4As7zPPuFHfKgs+J5P8ECQyUIaKD0
        qw8cmo7hq+9ejQqVyiFX8tk=
X-Google-Smtp-Source: ABdhPJwgNfYDLTTez6AW+eegxQQkvsR9LAf82rAGm+L+rJP03nH8BzbzlnTOVVOiToToNQNRJwW5Zg==
X-Received: by 2002:ac2:5cb3:: with SMTP id e19mr7474169lfq.444.1614541623581;
        Sun, 28 Feb 2021 11:47:03 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id c16sm2045676lfb.36.2021.02.28.11.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 11:47:02 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Sun, 28 Feb 2021 20:47:00 +0100
To:     Sangmoon Kim <sangmoon.kim@samsung.com>, neeraju@codeaurora.org,
        paulmck@kernel.org
Cc:     neeraju@codeaurora.org, jiangshanlai@gmail.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, paulmck@kernel.org,
        rcu@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v2] rcu/tree: Add a trace event for RCU stall warnings
Message-ID: <20210228194700.GA55724@pc638.lan>
References: <20210224151711.7823-1-sangmoon.kim@samsung.com>
 <CGME20210225041622epcas1p159a1f427882a90a4ca815b31114c52b6@epcas1p1.samsung.com>
 <20210225040612.9917-1-sangmoon.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225040612.9917-1-sangmoon.kim@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> The event allows us to trace the RCU stall when
> sysctl_panic_on_rcu_stall is disabled.
> 
> The first parameter is the name of RCU flavour like other trace
> events. The second one shows us which function detected stalls.
> 
> The RCU stall is mainly caused by external factors such as interrupt
> handling or task scheduling or something else. Therefore, this event
> uses TRACE_EVENT macro, not dedicated one, so that someone interested
> in the RCU stall can use it without CONFIG_RCU_TRACE.
> 
> Signed-off-by: Sangmoon Kim <sangmoon.kim@samsung.com>
> ---
> Changes in v2:
>  - Move the tracepoints before printing out stall messages.
> 
>  include/trace/events/rcu.h | 28 ++++++++++++++++++++++++++++
>  kernel/rcu/tree_exp.h      |  1 +
>  kernel/rcu/tree_stall.h    |  2 ++
>  3 files changed, 31 insertions(+)
> 
> diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
> index 155b5cb43cfd..8476f3161bd0 100644
> --- a/include/trace/events/rcu.h
> +++ b/include/trace/events/rcu.h
> @@ -432,6 +432,34 @@ TRACE_EVENT_RCU(rcu_fqs,
>  		  __entry->cpu, __entry->qsevent)
>  );
>  
> +/*
> + * Tracepoint for RCU stall events. Takes a string identifying the RCU flavor
> + * and a string identifying which function detected the RCU stall as follows:
> + *
> + *	"StallDetected": Scheduler-tick detects other CPU's stalls.
> + *	"SelfDetected": Scheduler-tick detects a current CPU's stall.
> + *	"ExpeditedStall": Expedited grace period detects stalls.
> + */
> +TRACE_EVENT(rcu_stall_warning,
> +
> +	TP_PROTO(const char *rcuname, const char *msg),
> +
> +	TP_ARGS(rcuname, msg),
> +
> +	TP_STRUCT__entry(
> +		__field(const char *, rcuname)
> +		__field(const char *, msg)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->rcuname = rcuname;
> +		__entry->msg = msg;
> +	),
> +
> +	TP_printk("%s %s",
> +		  __entry->rcuname, __entry->msg)
> +);
> +
>  #endif /* #if defined(CONFIG_TREE_RCU) */
>  
>  /*
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 8760b6ead770..6e1ac5b41f69 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -521,6 +521,7 @@ static void synchronize_rcu_expedited_wait(void)
>  		if (rcu_stall_is_suppressed())
>  			continue;
>  		panic_on_rcu_stall();
> +		trace_rcu_stall_warning(rcu_state.name, TPS("ExpeditedStall"));
>  		pr_err("INFO: %s detected expedited stalls on CPUs/tasks: {",
>  		       rcu_state.name);
>  		ndetected = 0;
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 70d48c52fabc..ed50056a3c7b 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -488,6 +488,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
>  	 * See Documentation/RCU/stallwarn.rst for info on how to debug
>  	 * RCU CPU stall warnings.
>  	 */
> +	trace_rcu_stall_warning(rcu_state.name, TPS("StallDetected"));
>  	pr_err("INFO: %s detected stalls on CPUs/tasks:\n", rcu_state.name);
>  	rcu_for_each_leaf_node(rnp) {
>  		raw_spin_lock_irqsave_rcu_node(rnp, flags);
> @@ -554,6 +555,7 @@ static void print_cpu_stall(unsigned long gps)
>  	 * See Documentation/RCU/stallwarn.rst for info on how to debug
>  	 * RCU CPU stall warnings.
>  	 */
> +	trace_rcu_stall_warning(rcu_state.name, TPS("SelfDetected"));
>  	pr_err("INFO: %s self-detected stall on CPU\n", rcu_state.name);
>  	raw_spin_lock_irqsave_rcu_node(rdp->mynode, flags);
>  	print_cpu_stall_info(smp_processor_id());
> -- 
> 2.17.1
> 
One small nit, the patch is not cleanelly applied on latest dev
so it should be rebased unless Paul fixes it on his own :)

Anyway to me it looks OK.

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Vlad Rezki
