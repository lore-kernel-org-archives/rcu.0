Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7380C432BE
	for <rcu@archiver.kernel.org>; Mon, 30 Aug 2021 18:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3E0E60ED8
	for <rcu@archiver.kernel.org>; Mon, 30 Aug 2021 18:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhH3Sh6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 30 Aug 2021 14:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhH3Sh5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 30 Aug 2021 14:37:57 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E90FC061575;
        Mon, 30 Aug 2021 11:37:03 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id n126so30002189ybf.6;
        Mon, 30 Aug 2021 11:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ii0b9Fx21Xdyizgs6EXsE8rlngH3blu02yWu6k9nxws=;
        b=TuR0iB+4YxQHFdVbezbAuD424i1re3w0RVDp4MLE1T70lDimCBbflr/JVgQQpAkm2D
         OPysocblJJWYJ2zz5U5LOhwDbfRaqZJAw9kTnrsggmMK6w7dGYnvJ57y/MOvR2DZIajy
         zPTzOa6261MSGgyPXmq0b23OZ3yTs2s3xjTiALVg+tYyoaDqc4iccFXA6j0nUaMPjie+
         rVG/t9aSRek9dTW3c3+pjt1mCA1v/X5NK08bLqT8zN6g1/m8UZzwhD9AXbsOFsFP6ynP
         /P0tcWDKkHDs6sI9OSVKQ8xFTaH2xng7cGxKcGy5ONj7gMHYFJX5HxQVvhwFDV7Fp8mE
         wWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ii0b9Fx21Xdyizgs6EXsE8rlngH3blu02yWu6k9nxws=;
        b=ny/sniXgxLcjwxbqlcbgz/Py/QiJVY+ZCpHF9QQHYCN/ok6rnyGb9hEi0Pm4E6y4DH
         +ceHqMc90lVFxjGxKvPxiOCkt8knZSO2+gRjH1uEvckTLC3nRTuvaSAQ8Ru9GbCFe1cj
         BHM0w7Vg3zeunq7hUYxDnuDcutl4zF0t/oLv4f+iGFpObjQxD3aIT1eEq3fNGHkdEJnH
         fYihBfwGGzY+uKUdOvrwAAkm55Hxk1F/VmwHFo04W2tI30TpfuumtLPf4pihWkrKz3lU
         XUPDueIf1cbYbbebFFSlPtzFB31P6BmnSkSQaL3sBHGouo/K9b/Zi75U8OKq1pZc8+ha
         dg+Q==
X-Gm-Message-State: AOAM532shEgzOihHly4x0+xaVhRYqjD7RD3lC4YeXVWpb/Hu3Qr5G8OA
        qG2gFJr4IGPhrNct0tZdDt6NHr3R4dCw5XEoVOxHHZmH
X-Google-Smtp-Source: ABdhPJz3IWn8JHD019+pef3dTq3T2FQ4+VzWJjOFG05xmYGWv3UzUv1YepMOs8Mn6LmS2rTb/z7if1dFbtCPPWRukM4=
X-Received: by 2002:a25:ac7:: with SMTP id 190mr24018066ybk.260.1630348622562;
 Mon, 30 Aug 2021 11:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210827022122.15816-1-longman@redhat.com> <20210827183455.GP4156@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20210827183455.GP4156@paulmck-ThinkPad-P17-Gen-1>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 30 Aug 2021 11:36:51 -0700
Message-ID: <CAEf4BzZ+OauJV_O5VDSM_WydA-xxLKcmx0vzT3P02CESzrJcnw@mail.gmail.com>
Subject: Re: [PATCH] rcu: Avoid unneeded function call in rcu_read_unlock()
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Waiman Long <longman@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Aug 27, 2021 at 11:34 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Thu, Aug 26, 2021 at 10:21:22PM -0400, Waiman Long wrote:
> > Since commit aa40c138cc8f3 ("rcu: Report QS for outermost
> > PREEMPT=n rcu_read_unlock() for strict GPs"). A real function call
> > rcu_read_unlock_strict() is added to the inlined rcu_read_unlock().
> > The rcu_read_unlock_strict() call is only needed if the performance
> > sagging CONFIG_RCU_STRICT_GRACE_PERIOD option is set. This config
> > option isn't set for most production kernels while the function call
> > overhead remains.
> >
> > To provide a slight performance improvement, the
> > CONFIG_RCU_STRICT_GRACE_PERIOD config check is moved from
> > rcu_read_unlock_strict() to __rcu_read_unlock() so that the function
> > call can be compiled out in most cases.
> >
> > Besides, the GPL exported rcu_read_unlock_strict() also impact the
> > the compilation of non-GPL kernel modules as rcu_read_unlock() is a
> > frequently used kernel API.
> >
> > Signed-off-by: Waiman Long <longman@redhat.com>
>
> Nice, and good eyes!!!
>
> I have queued this for v5.16, that is, not the upcoming merge window
> but the one after that.
>
> I did my usual wordsmithing, so please check the following in case I
> messed something up.  I intentionally omitted the EXPORT_SYMBOL_GPL()
> discussion because:
>
> 1.      Kernels built with CONFIG_PREEMPT=y have the same issue
>         with the __rcu_read_lock() and __rcu_read_unlock() functions.
>
> 2.      Many other RCU functions are EXPORT_SYMBOL_GPL() and have
>         been for almost two decades.
>
> But if someone does use RCU readers within CONFIG_PREEMPT=n kernels from
> a binary module, I will happily refer them to you for any RCU issues
> that they encounter.  ;-)
>
> I am also CCing the BPF guys in case my interpretation of the code in
> the BPF verifier is incorrect.
>

LGTM from the BPF side, nothing really changed about when
rcu_read_unlock_strict is an actual function vs no-op macro. It's also
important to minimize the number of function calls in the context of
recent LBR on-demand work done by Song, so this is a great
improvement!

>                                                         Thanx, Paul
>
> ------------------------------------------------------------------------
>
> commit 4a9f53b997b809c0256838e31c604aeeded2345a
> Author: Waiman Long <longman@redhat.com>
> Date:   Thu Aug 26 22:21:22 2021 -0400
>
>     rcu: Avoid unneeded function call in rcu_read_unlock()
>
>     Since commit aa40c138cc8f3 ("rcu: Report QS for outermost PREEMPT=n
>     rcu_read_unlock() for strict GPs") the function rcu_read_unlock_strict()
>     is invoked by the inlined rcu_read_unlock() function.  However,
>     rcu_read_unlock_strict() is an empty function in production kernels,
>     which are built with CONFIG_RCU_STRICT_GRACE_PERIOD=n.
>
>     There is a mention of rcu_read_unlock_strict() in the BPF verifier,
>     but this is in a deny-list, meaning that BPF does not care whether
>     rcu_read_unlock_strict() is ever called.
>
>     This commit therefore provides a slight performance improvement
>     by hoisting the check of CONFIG_RCU_STRICT_GRACE_PERIOD from
>     rcu_read_unlock_strict() into rcu_read_unlock(), thus avoiding the
>     pointless call to an empty function.
>
>     Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>     Cc: Andrii Nakryiko <andrii@kernel.org>
>     Signed-off-by: Waiman Long <longman@redhat.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 434d12fe2d4f..5e0beb5c5659 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -71,7 +71,8 @@ static inline void __rcu_read_lock(void)
>  static inline void __rcu_read_unlock(void)
>  {
>         preempt_enable();
> -       rcu_read_unlock_strict();
> +       if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
> +               rcu_read_unlock_strict();
>  }
>
>  static inline int rcu_preempt_depth(void)
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 7a4876a3a882..0b55c647ab80 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -814,8 +814,7 @@ void rcu_read_unlock_strict(void)
>  {
>         struct rcu_data *rdp;
>
> -       if (!IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) ||
> -          irqs_disabled() || preempt_count() || !rcu_state.gp_kthread)
> +       if (irqs_disabled() || preempt_count() || !rcu_state.gp_kthread)
>                 return;
>         rdp = this_cpu_ptr(&rcu_data);
>         rcu_report_qs_rdp(rdp);
