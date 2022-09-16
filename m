Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA085ECAAD8
	for <rcu@archiver.kernel.org>; Fri, 16 Sep 2022 22:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiIPWV4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 16 Sep 2022 18:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiIPWVz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 16 Sep 2022 18:21:55 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA961B8F10
        for <rcu@vger.kernel.org>; Fri, 16 Sep 2022 15:21:54 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id g23so12488677qtu.2
        for <rcu@vger.kernel.org>; Fri, 16 Sep 2022 15:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=/Z4HioIHNMXZQnpDiGaKlQH+R1i37jGb7DQ/+FG9DY4=;
        b=oUVC0QClHNlhxYz78lza87f+pSlzjYsLRu3OF8G6xytxs7gvHTGh7Y7rmJF3PEBsYj
         oAxNiqG1254EaTVfzSZWle42RZCslH+C0vjsPJYAmVvAg14jTeDKKfpIoQARQ0zX/oke
         VJIugZnJFWHS1CWs4KhMzTfBp5XFl+ngOAcuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=/Z4HioIHNMXZQnpDiGaKlQH+R1i37jGb7DQ/+FG9DY4=;
        b=BCzdzP2WMcWAYEBJZvznfsUsS8nsduPfy3CSoP/TIoKLXeGJ92SHJnHn8jaRhA99sl
         hgfPOskWTO9IpvDEXNvtlrTr3d7LP0kjE1NFR8K3igPKjXr6gHEJ3iQ20ri/3kn6qSTv
         rU8jTIbHkS8WDakPZMn/9Z8SSUxuZ40Swt6NJrWxmo8XKvKuRpZD5ERcQNUd4pRh+1Q6
         9NQPi5dYIq26oZ2ZC2b8DnMaOFaF+6eWtYDjHC3WFDZYMQ6+m6EPCXl8O19VDnlMSmJv
         ZUTlcAqQV9N6KICodXuLw8XH3/TwzQoQqMZt7EnVkdbZjmnNkoFo6rIJxvlamDstCaqP
         4afQ==
X-Gm-Message-State: ACrzQf1FcTlhjlmcmtLPQLqE6ehHEYyibp3Tp28lj5hBH1em293GFkeR
        eWHbbdBpEgLh81wM6u6ARGNkMw==
X-Google-Smtp-Source: AMsMyM7Q+Kg6EhID++gu/3/TvsOwzd5Eb/0EVG/vvc8+Rcm8fgjUCU65xPIAXEGd8MOBn4wV/DCmeQ==
X-Received: by 2002:a05:622a:1492:b0:35c:b7e6:12ef with SMTP id t18-20020a05622a149200b0035cb7e612efmr6481356qtx.94.1663366913808;
        Fri, 16 Sep 2022 15:21:53 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id l20-20020a05620a28d400b006ce1bfbd603sm7386322qkp.124.2022.09.16.15.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 15:21:53 -0700 (PDT)
Date:   Fri, 16 Sep 2022 22:21:53 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH rcu/next 2/3] rcu: Move trace_rcu_callback() before
 bypassing
Message-ID: <YyT3AfDnLxo3zbo1@google.com>
References: <20220915001419.55617-1-joel@joelfernandes.org>
 <20220915001419.55617-3-joel@joelfernandes.org>
 <20220916110949.GB25456@lothringen>
 <YyT2YlI9HK/Z2GPT@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyT2YlI9HK/Z2GPT@google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Sep 16, 2022 at 10:19:14PM +0000, Joel Fernandes wrote:
[...]
> >> +	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags))
> >> +		return; // Enqueued onto ->nocb_bypass, so just leave.
> >> +	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired
> >> ->nocb_lock.
> >> +	rcu_segcblist_enqueue(&rdp->cblist, head);
> >> +
> >>  	trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCBQueued"));
> >>  
> >>  	/* Go handle any RCU core processing required. */
> >
> > Two subtle changes induced here:
> >
> > * rcu_segcblist_n_cbs() is now read lockless. It's just tracing so no huge
> > deal
> >   but still, if this races with callbacks invocation, we may on some rare
> >   occasion
> >   read stale numbers on traces while enqueuing (think about rcu_top for
> >   example)
> 
> Actually I disagree with this point now. Changes to the number of callbacks
> in the main ->cblist can be lockless. It uses atomic on CONFIG_RCU_NOCB. On
> non CONFIG_RCU_NOCB, CB cannot be queued as interrupts will be disabled.
> 
> Also, in rcu_do_batch(), the count is manipulated after calling
> rcu_nocb_lock_irqsave(rdp, flags);
> 
> > * trace_rcu_callback() will now show the number of callbacks _before_
> > enqueuing
> >   instead of _after_. Not sure if it matters, but sometimes tools rely on
> >   trace
> >   events.
> 
> Yeah this is fixable and good point. So how about the below?
> 
> ---8<-----------------------
> 
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> Subject: [PATCH] rcu: Call trace_rcu_callback() also for bypass queuing
> 
> If any CB is queued into the bypass list, then trace_rcu_callback() does
> not show it. This makes it not clear when a callback was actually
> queued, as you only end up getting a trace_rcu_invoke_callback() trace.
> Fix it by calling the tracing function even for bypass queue.
> 
> Also, while at it, optimize the tracing so that rcu_state is not
> accessed here if tracing is disabled, because that's useless if we are
> not tracing. A quick inspection of the generated assembler shows that
> rcu_state is accessed even if the jump label for the tracepoint is
> disabled.
> 
> __trace_rcu_callback:
>         movq    8(%rdi), %rcx
>         movq    rcu_state+3640(%rip), %rax
>         movq    %rdi, %rdx
>         cmpq    $4095, %rcx
>         ja      .L3100
>         movq    192(%rsi), %r8
>         1:jmp .L3101 # objtool NOPs this
>         .pushsection __jump_table,  "aw"
>          .balign 8
>         .long 1b - .
>         .long .L3101 - .
>          .quad __tracepoint_rcu_kvfree_callback+8 + 2 - .
>         .popsection
> 
> With this change, the jump label check which is NOOPed is moved to the
> beginning of the function.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree.c | 31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 5ec97e3f7468..b64df55f7f55 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2728,6 +2728,23 @@ static void check_cb_ovld(struct rcu_data *rdp)
>  	raw_spin_unlock_rcu_node(rnp);
>  }
>  
> +/*
> + * Trace RCU callback helper, call after enqueuing callback.
> + * The ->cblist must be locked when called.

Also sorry for the spam, this comment is stale now so will delete this line.

