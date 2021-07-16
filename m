Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C677C07E95
	for <rcu@archiver.kernel.org>; Fri, 16 Jul 2021 06:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29A5C613E7
	for <rcu@archiver.kernel.org>; Fri, 16 Jul 2021 06:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbhGPG0K (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 16 Jul 2021 02:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbhGPG0H (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 16 Jul 2021 02:26:07 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646B3C061760
        for <rcu@vger.kernel.org>; Thu, 15 Jul 2021 23:23:13 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d12so8060087pfj.2
        for <rcu@vger.kernel.org>; Thu, 15 Jul 2021 23:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7xzgmBAMTKaWW+fbNYQ+L7b6kv6KG0i0qA+QcZiCEoI=;
        b=I3orhdAUR1175eZURxhfyAJ7CqobfiowaeAbvpi0ScsDi7od82tNTkpOsIEb5vuXc8
         uiJP08+iZjRudNpKVDVpC6LkhFZYlyh5DTRaP4y4/vl108u3qC4+z29trzopkkDxL6kS
         H3ruEBFeLwf7uY82Ofn/VXwN99zQQCXxhQiuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7xzgmBAMTKaWW+fbNYQ+L7b6kv6KG0i0qA+QcZiCEoI=;
        b=myuJzwr1re3wOaiFkQ+YKTwuG74QQHcZz+l5BnNu8hDT7zQu6GC+s4aRnWfZ6DEc5G
         /vrKEEEsa2lXMPEv0tqEOVXgr6ydK775BSTYWMf5J093ZRiagdDBYrJPynoN9lRBylFz
         q0JWlxqc8pX9V/dVD7JZOyPfsWKcB+UwHnWjjh3POiSlVyZRaHyY1uZnsu1GmxEuBzNw
         1IAHcaYPo5AU0WE4Dx3tlwPXSG11WbwzYQVQTPhcd5mBETrFEAIKTO5AuLs3RGgPtvmO
         fpPvsbQDIPUoLWQPfiagwp4r19j+j3N/GsdVVkF1dHeNOI011YxgD7z8Szn5KEOOO3uW
         apnA==
X-Gm-Message-State: AOAM530NEUlG69aI2IHOudEI59ifTgdJMbez76GbQab3v9Y8f9jHcJVC
        Mz+B+gRJtPvfH2s1thO4Dk5mZw==
X-Google-Smtp-Source: ABdhPJxlm5rRKo8YGCJc75HnetKVDPUTsWuJ7zBzLBP/3F472XDqMZCaxZFCoFMsG8oYEG/Wr6Zg4g==
X-Received: by 2002:a63:1d41:: with SMTP id d1mr8403424pgm.199.1626416592834;
        Thu, 15 Jul 2021 23:23:12 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:d1af:356e:50a6:75e8])
        by smtp.gmail.com with ESMTPSA id bj15sm7295551pjb.6.2021.07.15.23.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 23:23:12 -0700 (PDT)
Date:   Fri, 16 Jul 2021 15:23:07 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suleiman Souhlal <suleiman@google.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] rcu: call kvm_check_and_clear_guest_paused
 unconditionally
Message-ID: <YPEly3zNxNUjuc5i@google.com>
References: <20210716054113.1244529-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210716054113.1244529-1-senozhatsky@chromium.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On (21/07/16 14:41), Sergey Senozhatsky wrote:
> @@ -657,6 +657,13 @@ static void check_cpu_stall(struct rcu_data *rdp)
>  	unsigned long js;
>  	struct rcu_node *rnp;
>  
> +	/*
> +	 * If a virtual machine is stopped by the host it can look to
> +	 * the watchdog like an RCU stall. Check to see if the host
> +	 * stopped the vm.
> +	 */
> +	kvm_check_and_clear_guest_paused();
> +
>  	lockdep_assert_irqs_disabled();
>  	if ((rcu_stall_is_suppressed() && !READ_ONCE(rcu_kick_kthreads)) ||
>  	    !rcu_gp_in_progress())
> @@ -699,14 +706,6 @@ static void check_cpu_stall(struct rcu_data *rdp)
>  	    (READ_ONCE(rnp->qsmask) & rdp->grpmask) &&
>  	    cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
>  
> -		/*
> -		 * If a virtual machine is stopped by the host it can look to
> -		 * the watchdog like an RCU stall. Check to see if the host
> -		 * stopped the vm.
> -		 */
> -		if (kvm_check_and_clear_guest_paused())
> -			return;
> -
>  		/* We haven't checked in, so go dump stack. */
>  		print_cpu_stall(gps);
>  		if (READ_ONCE(rcu_cpu_stall_ftrace_dump))
> @@ -717,14 +716,6 @@ static void check_cpu_stall(struct rcu_data *rdp)
>  		   ULONG_CMP_GE(j, js + RCU_STALL_RAT_DELAY) &&
>  		   cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
>  
> -		/*
> -		 * If a virtual machine is stopped by the host it can look to
> -		 * the watchdog like an RCU stall. Check to see if the host
> -		 * stopped the vm.
> -		 */
> -		if (kvm_check_and_clear_guest_paused())
> -			return;
> -
>  		/* They had a few time units to dump stack, so complain. */
>  		print_other_cpu_stall(gs2, gps);
>  		if (READ_ONCE(rcu_cpu_stall_ftrace_dump))

This patch depends on
https://lore.kernel.org/lkml/20210716053405.1243239-1-senozhatsky@chromium.org/

If that x86/kvm patch lands, then we need to handle
PVCLOCK_GUEST_STOPPED in watchdogs.


In theory, this patch opens a small race window, if the VCPU gets preempted
after kvm_check_and_clear_guest_paused() (external interrupt, etc.)
But it's hard to tell how likely the problem is.
