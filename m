Return-Path: <SRS0=IXig=5B=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210FAC18E5B
	for <rcu@archiver.kernel.org>; Mon, 16 Mar 2020 15:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E41DC2051A
	for <rcu@archiver.kernel.org>; Mon, 16 Mar 2020 15:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="j9zyO+Pp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731685AbgCPPsw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 16 Mar 2020 11:48:52 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43454 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731875AbgCPPsw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 16 Mar 2020 11:48:52 -0400
Received: by mail-qk1-f193.google.com with SMTP id x18so6850254qki.10
        for <rcu@vger.kernel.org>; Mon, 16 Mar 2020 08:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XurdrTIrr9xQaIPprYsyVcQx7FmMjZZB/eYQB/VnuIM=;
        b=j9zyO+Pp0APRFZGMmJsa1YYnNX9Rg0QlgRJWqzN6a5ZZFLevRfvcFOaJUfy9GQ4k4Z
         mg0VC/ib0MMNRSy8wSRCmkNOkRssgtdyMqlHSwoiJRZEJiMIwMp0RN4zhtrE6dxQbpwh
         ykMcugAS01a9i/BJ33BTla5Jsktu9Kcg5eiJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XurdrTIrr9xQaIPprYsyVcQx7FmMjZZB/eYQB/VnuIM=;
        b=Mxxt29OpMxqzkqr+W+X1Qs/8UqftxefHVTpE1hM8dBuS27nemDKPAyZtDXZLXhqbyT
         euDZIZIG26at4u13apgw/M30vVxT9x+4aeOQgWfB3V2oIxPo1XVAMzQJONR00gTYD+Fs
         BMDd0vlwRDYRHOLSrbge5KpsCcQDoaJkrRnTHMMfp1HmXBd31U/Ow/W+b15YrJz1PXUE
         jJpGSzqVQNBIrWHI0HqHU86DK1mBa3tk0mnAJ48tgaG+xZFMp1e/UNPCsMFvFRznn9SI
         wolktuLUMZRYQ6RoCicPVeQwQiWFNU/btqsgxjWs2dJhXoI7DveX9TBfO7MZCSYkgvWv
         e0sA==
X-Gm-Message-State: ANhLgQ0mPaM+9x3/RWLnCIjlbLiZ1n8pF0KFcmLCQu0RUSSx9AT/XqM4
        yiuO0hpYcIgOyVf+kxT81o574A==
X-Google-Smtp-Source: ADFU+vuzzXmxnpTUeVbLFafj9YIBVVISf2aXvBqs4CSDGa40AcDcH5WrgiHjtvpfjk3hxJ7wfODm+A==
X-Received: by 2002:a37:987:: with SMTP id 129mr305727qkj.83.1584373731404;
        Mon, 16 Mar 2020 08:48:51 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id c12sm44657qtb.49.2020.03.16.08.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 08:48:51 -0700 (PDT)
Date:   Mon, 16 Mar 2020 11:48:50 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH v1 4/6] rcu: rename __is_kfree_rcu_offset() macro
Message-ID: <20200316154850.GG190951@google.com>
References: <20200315181840.6966-1-urezki@gmail.com>
 <20200315181840.6966-5-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315181840.6966-5-urezki@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Mar 15, 2020 at 07:18:38PM +0100, Uladzislau Rezki (Sony) wrote:
> Rename __is_kfree_rcu_offset to __is_kvfree_rcu_offset.
> All RCU paths use kvfree() now instead of kfree(), thus
> rename it.

This patch LGTM:
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  include/linux/rcupdate.h | 6 +++---
>  kernel/rcu/tiny.c        | 2 +-
>  kernel/rcu/tree.c        | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index bb270221dbdc..e4961631a44f 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -798,16 +798,16 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
>  
>  /*
>   * Does the specified offset indicate that the corresponding rcu_head
> - * structure can be handled by kfree_rcu()?
> + * structure can be handled by kvfree_rcu()?
>   */
> -#define __is_kfree_rcu_offset(offset) ((offset) < 4096)
> +#define __is_kvfree_rcu_offset(offset) ((offset) < 4096)
>  
>  /*
>   * Helper macro for kfree_rcu() to prevent argument-expansion eyestrain.
>   */
>  #define __kfree_rcu(head, offset) \
>  	do { \
> -		BUILD_BUG_ON(!__is_kfree_rcu_offset(offset)); \
> +		BUILD_BUG_ON(!__is_kvfree_rcu_offset(offset)); \
>  		kfree_call_rcu(head, (rcu_callback_t)(unsigned long)(offset)); \
>  	} while (0)
>  
> diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> index 3dd8e6e207b0..aa897c3f2e92 100644
> --- a/kernel/rcu/tiny.c
> +++ b/kernel/rcu/tiny.c
> @@ -85,7 +85,7 @@ static inline bool rcu_reclaim_tiny(struct rcu_head *head)
>  	unsigned long offset = (unsigned long)head->func;
>  
>  	rcu_lock_acquire(&rcu_callback_map);
> -	if (__is_kfree_rcu_offset(offset)) {
> +	if (__is_kvfree_rcu_offset(offset)) {
>  		trace_rcu_invoke_kvfree_callback("", head, offset);
>  		kvfree((void *)head - offset);
>  		rcu_lock_release(&rcu_callback_map);
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index eef75cd210fd..bb9544238396 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2719,7 +2719,7 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
>  		return; // Enqueued onto ->nocb_bypass, so just leave.
>  	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
>  	rcu_segcblist_enqueue(&rdp->cblist, head);
> -	if (__is_kfree_rcu_offset((unsigned long)func))
> +	if (__is_kvfree_rcu_offset((unsigned long)func))
>  		trace_rcu_kvfree_callback(rcu_state.name, head,
>  					 (unsigned long)func,
>  					 rcu_segcblist_n_cbs(&rdp->cblist));
> @@ -2911,7 +2911,7 @@ static void kfree_rcu_work(struct work_struct *work)
>  		rcu_lock_acquire(&rcu_callback_map);
>  		trace_rcu_invoke_kvfree_callback(rcu_state.name, head, offset);
>  
> -		if (!WARN_ON_ONCE(!__is_kfree_rcu_offset(offset)))
> +		if (!WARN_ON_ONCE(!__is_kvfree_rcu_offset(offset)))
>  			kvfree((void *)head - offset);
>  
>  		rcu_lock_release(&rcu_callback_map);
> -- 
> 2.20.1
> 
