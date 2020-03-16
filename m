Return-Path: <SRS0=IXig=5B=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B7AC0044D
	for <rcu@archiver.kernel.org>; Mon, 16 Mar 2020 15:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864D22051A
	for <rcu@archiver.kernel.org>; Mon, 16 Mar 2020 15:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="r0nS/dIG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731900AbgCPPr2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 16 Mar 2020 11:47:28 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45684 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731555AbgCPPr2 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 16 Mar 2020 11:47:28 -0400
Received: by mail-qk1-f194.google.com with SMTP id c145so26928497qke.12
        for <rcu@vger.kernel.org>; Mon, 16 Mar 2020 08:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GBys85i5HtZ0uNTaTkpVeMVABaxUVIjN4FUmfqqZy1s=;
        b=r0nS/dIGdJLY8p8ypQFWnQcAHRvMkWwFbr5l89AlpmhEDT4kMc8Qtdn//mOfu/kxHL
         /wdd2PLba3vXNP/LVJyLqtwN0d37w8AA3VBrrZ/TH+wq5mJ+6USQPY7oc8cMxBucxpDb
         MLJJbN0qZe5pVq+tz5wDuQVoiGlgzwObHKGWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GBys85i5HtZ0uNTaTkpVeMVABaxUVIjN4FUmfqqZy1s=;
        b=c8KBYhWYwrthOXEGKcOfhBVenLHdD5hYj+PgMOHuPvtUgMWuO5jCZxKcEVX9a2/F14
         7H2IwyZu5wLr5dIIbS/p3dcjPOQqvS7w8YSN+YV9gH90F2cuQvdPfP6QwEnwNkiJfwc4
         cpxMwKo6IvQVbqgMxkw+ioPxMUpEuk3vnNIc1AUAjmYqAxIRB+kGcqGbLJ0/U9j0r/LI
         2iVJuqqS7jOtjbjHuWv+umIBllCtXXGjS1KUdCsD+fdRUuBLK/tk0B7SEegirFvmWzYG
         PCEKN/plXYOax0Tzpp1w+eV8OciBpOI6pDf7TnTdExeClGZ2YlN1JGS+lOvAGVY5OK4X
         BCHg==
X-Gm-Message-State: ANhLgQ28Rtdpz+gAVatVRihUvpw3BAI6OSDcPh48O5qHC+3b6sR2pDeI
        5kaPiYhDeBNI0les98BJ312v7w==
X-Google-Smtp-Source: ADFU+vvV8P/2gCV8D2bb4sqQTrEDrxNocVSVcRCSeX0uBQUSyoZuFmrF1nfpJv5dCkc0jF5VP4xi8g==
X-Received: by 2002:a37:2c81:: with SMTP id s123mr292500qkh.284.1584373646996;
        Mon, 16 Mar 2020 08:47:26 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id m1sm63508qtk.16.2020.03.16.08.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 08:47:26 -0700 (PDT)
Date:   Mon, 16 Mar 2020 11:47:26 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH v1 3/6] rcu: rename
 rcu_invoke_kfree_callback/rcu_kfree_callback
Message-ID: <20200316154726.GF190951@google.com>
References: <20200315181840.6966-1-urezki@gmail.com>
 <20200315181840.6966-4-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315181840.6966-4-urezki@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Mar 15, 2020 at 07:18:37PM +0100, Uladzislau Rezki (Sony) wrote:
> Rename rcu_invoke_kfree_callback to rcu_invoke_kvfree_callback.
> Do the same with second trace event, that is rcu_kfree_callback,
> it becomes rcu_kvfree_callback. The reason is to be aligned with
> kvfree notation.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  include/trace/events/rcu.h | 8 ++++----
>  kernel/rcu/tiny.c          | 2 +-
>  kernel/rcu/tree.c          | 4 ++--
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
> index f9a7811148e2..0ee93d0b1daa 100644
> --- a/include/trace/events/rcu.h
> +++ b/include/trace/events/rcu.h
> @@ -506,13 +506,13 @@ TRACE_EVENT_RCU(rcu_callback,
>  
>  /*
>   * Tracepoint for the registration of a single RCU callback of the special
> - * kfree() form.  The first argument is the RCU type, the second argument
> + * kvfree() form.  The first argument is the RCU type, the second argument
>   * is a pointer to the RCU callback, the third argument is the offset
>   * of the callback within the enclosing RCU-protected data structure,
>   * the fourth argument is the number of lazy callbacks queued, and the
>   * fifth argument is the total number of callbacks queued.
>   */
> -TRACE_EVENT_RCU(rcu_kfree_callback,
> +TRACE_EVENT_RCU(rcu_kvfree_callback,
>  
>  	TP_PROTO(const char *rcuname, struct rcu_head *rhp, unsigned long offset,
>  		 long qlen),
> @@ -596,12 +596,12 @@ TRACE_EVENT_RCU(rcu_invoke_callback,
>  
>  /*
>   * Tracepoint for the invocation of a single RCU callback of the special
> - * kfree() form.  The first argument is the RCU flavor, the second
> + * kvfree() form.  The first argument is the RCU flavor, the second
>   * argument is a pointer to the RCU callback, and the third argument
>   * is the offset of the callback within the enclosing RCU-protected
>   * data structure.
>   */
> -TRACE_EVENT_RCU(rcu_invoke_kfree_callback,
> +TRACE_EVENT_RCU(rcu_invoke_kvfree_callback,
>  
>  	TP_PROTO(const char *rcuname, struct rcu_head *rhp, unsigned long offset),
>  
> diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> index 4b99f7b88bee..3dd8e6e207b0 100644
> --- a/kernel/rcu/tiny.c
> +++ b/kernel/rcu/tiny.c
> @@ -86,7 +86,7 @@ static inline bool rcu_reclaim_tiny(struct rcu_head *head)
>  
>  	rcu_lock_acquire(&rcu_callback_map);
>  	if (__is_kfree_rcu_offset(offset)) {
> -		trace_rcu_invoke_kfree_callback("", head, offset);
> +		trace_rcu_invoke_kvfree_callback("", head, offset);
>  		kvfree((void *)head - offset);
>  		rcu_lock_release(&rcu_callback_map);
>  		return true;
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 1c0a73616872..eef75cd210fd 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2720,7 +2720,7 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
>  	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
>  	rcu_segcblist_enqueue(&rdp->cblist, head);
>  	if (__is_kfree_rcu_offset((unsigned long)func))
> -		trace_rcu_kfree_callback(rcu_state.name, head,
> +		trace_rcu_kvfree_callback(rcu_state.name, head,
>  					 (unsigned long)func,
>  					 rcu_segcblist_n_cbs(&rdp->cblist));
>  	else
> @@ -2909,7 +2909,7 @@ static void kfree_rcu_work(struct work_struct *work)
>  		next = head->next;
>  		debug_rcu_head_unqueue(head);
>  		rcu_lock_acquire(&rcu_callback_map);
> -		trace_rcu_invoke_kfree_callback(rcu_state.name, head, offset);
> +		trace_rcu_invoke_kvfree_callback(rcu_state.name, head, offset);
>  
>  		if (!WARN_ON_ONCE(!__is_kfree_rcu_offset(offset)))
>  			kvfree((void *)head - offset);
> -- 
> 2.20.1
> 
