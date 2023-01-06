Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA63EC3DA7A
	for <rcu@archiver.kernel.org>; Fri,  6 Jan 2023 12:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjAFMv3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 6 Jan 2023 07:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjAFMv2 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 6 Jan 2023 07:51:28 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9DD1ADB8
        for <rcu@vger.kernel.org>; Fri,  6 Jan 2023 04:51:26 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id b3so1836604lfv.2
        for <rcu@vger.kernel.org>; Fri, 06 Jan 2023 04:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VRkNgPU9Z0vuXvRCyDjiBL7MgDxi1pBgzHic6defyP4=;
        b=dU1SK6f05Q9HD62jZhE4rldG2q7S+j3MfO2ck6cVSyE7Vbm/XIp3iPG1aLw4Na1awJ
         wymng/OM0Q+i5PxgubeGkSzXd23FMywFVAyHMPzhz+zbWphUL+YeO+yPY+jR3Mea90Md
         kJfkoE3U1E0LdFCc6LLaffGWZ9uWlbLLTe5+D1H0WKjKlwenQ5rB8gOFZvAvyCh3/i/o
         KYxCBP4kKNvrSfA8ckl4RJyBn8pBUE2AoJM1Q/iJdLXTuUYdchMUiYmzVKPW6VIXbohp
         nGrjiC/FIHYVdVMFbZWoFWhco9HGQcmGjT3/mwCZMmbaZsJH6/X0KNR7cNn/5SpWjn8L
         d2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VRkNgPU9Z0vuXvRCyDjiBL7MgDxi1pBgzHic6defyP4=;
        b=CDinrcTuY04qoM4MACxPcpAKFE/F8MFLLZEUn9I+euhwCrZQBNg1VVHXEf+oaN7JEa
         DxHq5Xh+vpgfJjMNzr4Lr4GslP49wuHcbEWPG3AXraG91PWpqbOAebWUgiL5kp+RY6ry
         zCeO0ao6OY7OURR+aUqzsnadeMjLzalI7Z/IvPebY+ivPSWQMOW+tA9BHqBEEGGafKP0
         wA/HYhDEoql2jbIXl0nSYJDlbMY/6eeov+iP2osq0d5BiOFGHcx1so7UyfwiOtcwX9ip
         +XZjeLvt+YgsRtzvC+pEQ3lwAS5Ok7acHmyvFQpG+JgJv01R7b+JchH3BEMRy67ly+NH
         lm7A==
X-Gm-Message-State: AFqh2kq/mKPTCbDlKSHDZdkuBe/JIPv6oxGq4S6Y5a4y5tNeaG+EBECA
        aWO4hOQ8RpxqUm0O3yb4BMvFeqyRrAqlwMzZDg==
X-Google-Smtp-Source: AMrXdXvoSKa9Z1kNow0rnX9LY8bAVzlRw0Fpfkkyyc76Nk9sMLTmfbZVaPUuQpEOGb/e8bCDAk3L0ei8vhB+KiDEcsw=
X-Received: by 2002:a05:6512:6ce:b0:4cb:3df9:b23b with SMTP id
 u14-20020a05651206ce00b004cb3df9b23bmr692075lff.308.1673009485147; Fri, 06
 Jan 2023 04:51:25 -0800 (PST)
MIME-Version: 1.0
References: <20221223130228.40737-1-kernelfans@gmail.com> <20230104204318.GJ4028633@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20230104204318.GJ4028633@paulmck-ThinkPad-P17-Gen-1>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Fri, 6 Jan 2023 20:51:13 +0800
Message-ID: <CAFgQCTvWT4Xdx8-vVBAYG+CBcx6YHBVd1jEhD01BQuJTvjCPmw@mail.gmail.com>
Subject: Re: [PATCH] srcu: Add comments for srcu_size_state
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jan 5, 2023 at 4:43 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Fri, Dec 23, 2022 at 09:02:28PM +0800, Pingfan Liu wrote:
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Frederic Weisbecker <frederic@kernel.org>,
> > Cc: Josh Triplett <josh@joshtriplett.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: "Zhang, Qiang1" <qiang1.zhang@intel.com>
> > To: rcu@vger.kernel.org
>
> Queued, thank you!
>
> After the inevitable wordsmithing, it appears as follows.  Could you

Sorry for the poor English expression.

> please check it?  (And yes, it does take advantage of 100 columns.)
>

It looks better to me.

Thanks,

    Pingfan


>                                                         Thanx, Paul
>
> ------------------------------------------------------------------------
>
> commit 9c473f0ef9eb8f3ac76d8295cfb4065a738b07a1
> Author: Pingfan Liu <kernelfans@gmail.com>
> Date:   Wed Jan 4 12:29:01 2023 -0800
>
>     srcu: Add comments for srcu_size_state
>
>     The SRCU_SIZE_* names are not self-explanatory, so this commit therefore
>     adds comments to the definitions.
>
>     Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
>     Cc: Lai Jiangshan <jiangshanlai@gmail.com>
>     Cc: "Paul E. McKenney" <paulmck@kernel.org>
>     Cc: Frederic Weisbecker <frederic@kernel.org>,
>     Cc: Josh Triplett <josh@joshtriplett.org>
>     Cc: Steven Rostedt <rostedt@goodmis.org>
>     Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>     Cc: "Zhang, Qiang1" <qiang1.zhang@intel.com>
>     To: rcu@vger.kernel.org
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>
> diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> index 558057b517b74..a6910805f9c51 100644
> --- a/include/linux/srcutree.h
> +++ b/include/linux/srcutree.h
> @@ -92,16 +92,29 @@ struct srcu_struct {
>         struct lockdep_map dep_map;
>  };
>
> -/* Values for size state variable (->srcu_size_state). */
> -#define SRCU_SIZE_SMALL                0
> -#define SRCU_SIZE_ALLOC                1
> -#define SRCU_SIZE_WAIT_BARRIER 2
> -#define SRCU_SIZE_WAIT_CALL    3
> -#define SRCU_SIZE_WAIT_CBS1    4
> -#define SRCU_SIZE_WAIT_CBS2    5
> -#define SRCU_SIZE_WAIT_CBS3    6
> -#define SRCU_SIZE_WAIT_CBS4    7
> -#define SRCU_SIZE_BIG          8
> +// Values for size state variable (->srcu_size_state).  Once the state
> +// has been set to SRCU_SIZE_ALLOC, the grace-period code advances through
> +// this state machine one step per grace period until the SRCU_SIZE_BIG state
> +// is reached.  Otherwise, the state machine remains in the SRCU_SIZE_SMALL
> +// state indefinitely.
> +#define SRCU_SIZE_SMALL                0       // No srcu_node combining tree, ->node == NULL
> +#define SRCU_SIZE_ALLOC                1       // An srcu_node tree is being allocated, initialized,
> +                                       //  and then referenced by ->node.  It will not be used.
> +#define SRCU_SIZE_WAIT_BARRIER 2       // The srcu_node tree starts being used by everything
> +                                       //  except call_srcu(), especially by srcu_barrier().
> +                                       //  By the end of this state, all CPUs and threads
> +                                       //  are aware of this tree's existence.
> +#define SRCU_SIZE_WAIT_CALL    3       // The srcu_node tree starts being used by call_srcu().
> +                                       //  By the end of this state, all of the call_srcu()
> +                                       //  invocations that were running on a non-boot CPU
> +                                       //  and using the boot CPU's callback queue will have
> +                                       //  completed.
> +#define SRCU_SIZE_WAIT_CBS1    4       // Don't trust the ->srcu_have_cbs[] grace-period
> +#define SRCU_SIZE_WAIT_CBS2    5       //  sequence elements or the ->srcu_data_have_cbs[]
> +#define SRCU_SIZE_WAIT_CBS3    6       //  CPU-bitmask elements until all four elements of
> +#define SRCU_SIZE_WAIT_CBS4    7       //  each array have been initialized.
> +#define SRCU_SIZE_BIG          8       // The srcu_node combining tree is fully initialized
> +                                       //  and all aspects of it are being put to use.
>
>  /* Values for state variable (bottom bits of ->srcu_gp_seq). */
>  #define SRCU_STATE_IDLE                0
