Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C19C54EE9
	for <rcu@archiver.kernel.org>; Fri, 16 Sep 2022 14:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiIPOOk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 16 Sep 2022 10:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiIPOOg (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 16 Sep 2022 10:14:36 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0977BE38
        for <rcu@vger.kernel.org>; Fri, 16 Sep 2022 07:14:33 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id y15so11408095ilq.4
        for <rcu@vger.kernel.org>; Fri, 16 Sep 2022 07:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=QNFZSe4GbpzS+rVNFtUw8lpciUWyyEDaNjxyASyO8Rc=;
        b=Hu9H0k6b984Iv+hHMavvvNSkLgrErYVN8Jv7FaBtTqk+DNRZRwXaQV1e3j90FwibfF
         MWpyDLgHs9o+iMfDryooIj29lc1tzyHOmCVDzA3qvN3KqGEytPgNuFfA31C1DW/l05t9
         22XX+HFJF9kIlqBVOvWBIdmwDhmuNqgBZkzJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=QNFZSe4GbpzS+rVNFtUw8lpciUWyyEDaNjxyASyO8Rc=;
        b=onOIBp2XLbccORI2zkRuEjS+zvTWIMJrPt1rnzPv6mXfVmV6q9cnvKDEWlwdMdJD/G
         SZEtrhKNJ/GV9DPxl48MMGRV3uD44YdZRBIP+Z1jjMDRqScTorPWJT7NLBwi8mN9lELN
         HQ5TGygHmmK0Dnk79+/ZNxgNmn3/LnIufCMvV9cq2ZHhmnQvRwG+SP43lHfK9XmZeNio
         yrJiCQ3UnUsOCbH7Rm7Uy4v93YunrB5k6WRqQTVtF7puahwcGOZ/CdyjwXnMfmEM5Cay
         LqHo2/Gmr2/Wzk1srLfj1gUzdgFiul+NyMgoUXaB/OCQov7BdD/13thgoxzbXb55fcpX
         HAsw==
X-Gm-Message-State: ACrzQf02G5PgouNSbNtfzQHZfXpbztcKWRNS1duV2NWrfOe0jOAHhTtt
        iOZKDA4upqaCoNicRkfspWxYfOSWQkHuEmzxNWCL6g==
X-Google-Smtp-Source: AMsMyM6R9gt3N97d94SnGg2DCtPXTUPrAT677M+rAGxkPjKuXF9vKLSyH1KwFMdzFx4eEZhQBL1lRaGQGIE37dH9NJ8=
X-Received: by 2002:a05:6e02:1c48:b0:2f1:db4b:66df with SMTP id
 d8-20020a056e021c4800b002f1db4b66dfmr2375027ilg.35.1663337672729; Fri, 16 Sep
 2022 07:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220915001419.55617-1-joel@joelfernandes.org>
 <20220915001419.55617-3-joel@joelfernandes.org> <20220916110949.GB25456@lothringen>
 <YySDvbF/BfDhy40H@google.com>
In-Reply-To: <YySDvbF/BfDhy40H@google.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 16 Sep 2022 10:14:21 -0400
Message-ID: <CAEXW_YQ0MGnuvOy-b3oaLfeiV1=U_FaQOigZuP=Nufqy+SB_nA@mail.gmail.com>
Subject: Re: [PATCH rcu/next 2/3] rcu: Move trace_rcu_callback() before bypassing
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Sep 16, 2022 at 10:10 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Fri, Sep 16, 2022 at 01:09:49PM +0200, Frederic Weisbecker wrote:
> > On Thu, Sep 15, 2022 at 12:14:18AM +0000, Joel Fernandes (Google) wrote:
> > > If any CB is queued into the bypass list, then trace_rcu_callback() does
> > > not show it. This makes it not clear when a callback was actually
> > > queued, as you only end up getting a trace_rcu_invoke_callback() trace.
> > > Fix it by moving trace_rcu_callback() before
> > > trace_rcu_nocb_try_bypass().
> > >
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > >  kernel/rcu/tree.c | 10 ++++++----
> > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 5ec97e3f7468..9fe581be8696 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -2809,10 +2809,7 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
> > >     }
> > >
> > >     check_cb_ovld(rdp);
> > > -   if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags))
> > > -           return; // Enqueued onto ->nocb_bypass, so just leave.
> > > -   // If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
> > > -   rcu_segcblist_enqueue(&rdp->cblist, head);
> > > +
> > >     if (__is_kvfree_rcu_offset((unsigned long)func))
> > >             trace_rcu_kvfree_callback(rcu_state.name, head,
> > >                                      (unsigned long)func,
> > > @@ -2821,6 +2818,11 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
> > >             trace_rcu_callback(rcu_state.name, head,
> > >                                rcu_segcblist_n_cbs(&rdp->cblist));
> > >
> > > +   if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags))
> > > +           return; // Enqueued onto ->nocb_bypass, so just leave.
> > > +   // If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
> > > +   rcu_segcblist_enqueue(&rdp->cblist, head);
> > > +
> > >     trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCBQueued"));
> > >
> > >     /* Go handle any RCU core processing required. */
> >
> > Two subtle changes induced here:
> >
> > * rcu_segcblist_n_cbs() is now read lockless. It's just tracing so no huge deal
> >   but still, if this races with callbacks invocation, we may on some rare occasion
> >   read stale numbers on traces while enqueuing (think about rcu_top for example)
> >
> > * trace_rcu_callback() will now show the number of callbacks _before_ enqueuing
> >   instead of _after_. Not sure if it matters, but sometimes tools rely on trace
> >   events.
> >
> > To avoid all that, how about a new trace_rcu_nocb_bypass() instead?
>
> Great points, thanks much and you rock. How about something like the
> following? That way we don't need to add yet another trace point:
>
> ---8<-----------------------
>
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> Subject: [PATCH v2] rcu: Call trace_rcu_callback() also for bypassing
>
> If any CB is queued into the bypass list, then trace_rcu_callback() does
> not show it. This makes it not clear when a callback was actually
> queued, as you only end up getting a trace_rcu_invoke_callback() trace.
> Fix it by calling the tracing function even for bypass queue.
>
> [Frederic: Hold lock while tracing]
>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 5ec97e3f7468..85609ccbb8ed 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2728,6 +2728,22 @@ static void check_cb_ovld(struct rcu_data *rdp)
>         raw_spin_unlock_rcu_node(rnp);
>  }
>
> +/*
> + * Trace RCU callback helper, call after enqueuing callback.
> + * The ->cblist must be locked when called.
> + */
> +static void trace_rcu_callback_locked(struct rcu_head *head,
> +                                     struct rcu_data *rdp)
> +{
> +       if (__is_kvfree_rcu_offset((unsigned long)head->func))
> +               trace_rcu_kvfree_callback(rcu_state.name, head,
> +                                        (unsigned long)head->func,
> +                                        rcu_segcblist_n_cbs(&rdp->cblist));
> +       else
> +               trace_rcu_callback(rcu_state.name, head,
> +                                  rcu_segcblist_n_cbs(&rdp->cblist));
> +}
> +
>  /**
>   * call_rcu() - Queue an RCU callback for invocation after a grace period.
>   * @head: structure to be used for queueing the RCU updates.
> @@ -2809,17 +2825,14 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
>         }
>
>         check_cb_ovld(rdp);
> -       if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags))
> +
> +       if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags)) {
> +               trace_rcu_callback_locked(head, rdp);

Never mind, this is still broken. I need to move the call site into
rcu_nocb_try_bypass() to be before where it releases the lock. I just
landed so I'll take a small break before getting back at it.

thanks,

 - Joel
