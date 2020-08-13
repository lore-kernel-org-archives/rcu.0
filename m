Return-Path: <SRS0=6iKH=BX=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B4AC433DF
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 00:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 219E0207F7
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 00:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R9nc3Mp3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgHMAu6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 12 Aug 2020 20:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgHMAu5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 12 Aug 2020 20:50:57 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06684C061383
        for <rcu@vger.kernel.org>; Wed, 12 Aug 2020 17:50:57 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id v4so4320700ljd.0
        for <rcu@vger.kernel.org>; Wed, 12 Aug 2020 17:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vlHf+a4mGhCdk+UYxFz/OqFUSiAsQ7AiTGfEFJXHYQY=;
        b=R9nc3Mp3hvc1m4R1kNjfKo7rSH1kLDjzop+FIJ79lpJRXFOvjRODtMe3mqZOFHcV9i
         2hz/P+Aux9IakO9j6/Dw8SuomlqNdXPkSScu87DZMXZMEwn2K7cPfHJbduhSp56Yg/yM
         +ClSsDDZwG5+Ol4SbwZ8WrCTDKle4kKs4434R6syQOFgddO/uDqCdE3otRRd7S4rGmey
         2G5UFgsomHT0uqpMauFPwO6E6dvGzyxhCL6eV78wfN0dLeN0noM8ClyYLLaEQ8/Zzq0w
         FgPJIIhELAxf3tYiSug2OfkYPn7N2jaz8w4OLMBtJGDLtIuU9W4kDrydK0baieZ7iVfd
         x25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vlHf+a4mGhCdk+UYxFz/OqFUSiAsQ7AiTGfEFJXHYQY=;
        b=j2+A26A6cjGSPHG7iqgKXdRhXN1pYpG1EkF1mpb86xyRve/U28B1LRgOtQipJAnx5c
         W+9R8GQ/nJT21HunCAW3tE2sC5BczHOaHRvUewq9Lkdr+IF69X7T0wybE7evOzniGR6n
         v4ote9J0Z22WCgmQxByjCPpC4tEW22dMBg6M2uC9lfuwzWm3CBOtrc3pi1oQKFgkayT3
         BOZlvBSBu9bKlt2D7p9Ixy3zDgrgGCA5eZCQmptFxQaCvlqNxJ4tOkRBaCRLgBpqMoy0
         1cQNqToXjcZsaRJqWYyan9ipvQVvaAx4X1Hx1+SpKOzjEZv6aXIzV5iflf5aRPe2Lu2/
         9E2Q==
X-Gm-Message-State: AOAM530l0vmob6YjEET7+2p+ZQT3QTi2YciBRb+Q1SL8nixSfS5VXtpK
        FVVei8k8uDXYkz4kx6uDMIMCwx3FfSEJ6TnkG7YCFQ==
X-Google-Smtp-Source: ABdhPJyxvFythoOBU/+pbpCAVblp6FC9nhxZ7FTSwBpNXVdPfQf8hkQz8zYJoWkS/1Dc5Z3s6vcJJ1mf3SAMZjQS66M=
X-Received: by 2002:a2e:9f4c:: with SMTP id v12mr723237ljk.139.1597279853268;
 Wed, 12 Aug 2020 17:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200812225632.GA19759@paulmck-ThinkPad-P72> <20200812225732.20068-6-paulmck@kernel.org>
In-Reply-To: <20200812225732.20068-6-paulmck@kernel.org>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 13 Aug 2020 02:50:27 +0200
Message-ID: <CAG48ez3WyDBLPs8cBt3-3HGJ_xvAg0-JPZRDP1mf1eLmPjSvPA@mail.gmail.com>
Subject: Re: [PATCH tip/core/rcu 06/12] rcu: Do full report for .need_qs for
 strict GPs
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, dipankar@in.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Aug 13, 2020 at 12:57 AM <paulmck@kernel.org> wrote:
> The rcu_preempt_deferred_qs_irqrestore() function is invoked at
> the end of an RCU read-side critical section (for example, directly
> from rcu_read_unlock()) and, if .need_qs is set, invokes rcu_qs() to
> report the new quiescent state.  This works, except that rcu_qs() only
> updates per-CPU state, leaving reporting of the actual quiescent state
> to a later call to rcu_report_qs_rdp(), for example from within a later
> RCU_SOFTIRQ instance.  Although this approach is exactly what you want if
> you are more concerned about efficiency than about short grace periods,
> in CONFIG_RCU_STRICT_GRACE_PERIOD=y kernels, short grace periods are
> the name of the game.
>
> This commit therefore makes rcu_preempt_deferred_qs_irqrestore() directly
> invoke rcu_report_qs_rdp() in CONFIG_RCU_STRICT_GRACE_PERIOD=y, thus
> shortening grace periods.

Ooh, I'm very happy about this series! :)

> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 7ed55c5..1761ff4 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -459,8 +459,12 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
>                 return;
>         }
>         t->rcu_read_unlock_special.s = 0;
> -       if (special.b.need_qs)
> -               rcu_qs();
> +       if (special.b.need_qs) {
> +               if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
> +                       rcu_report_qs_rdp(rdp->cpu, rdp);

Not an issue with this patch specifically, but: I'm looking at
rcu_report_qs_rdp(), and some of the parts that I do vaguely
understand look a bit off to me.

rcu_report_qs_rdp() is given a CPU number as first argument, but never
actually uses that argument. (And the only existing caller also passes
in rdp->cpu, just like this patch.) I guess that argument can go away?

The comment above rcu_report_qs_rdp() claims that it "must be called
from the specified CPU", but there is a branch in there that
specifically checks whether that is true ("if (rdp->cpu ==
smp_processor_id())"). As far as I can tell, rcu_report_qs_rdp() is,
as the comment says, indeed never invoked with another CPU's rcu_data
(only invoked via rcu_core() -> rcu_check_quiescent_state() ->
rcu_report_qs_rdp(), and rcu_core() looks up "rdp =
raw_cpu_ptr(&rcu_data)"). So perhaps if there is a check for whether
rdp belongs to the current CPU, that check should have a WARN_ON(), or
something like that, since it indicates that the API contract
specified in the comment was violated?
