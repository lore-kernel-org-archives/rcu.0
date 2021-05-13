Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5ECC433ED
	for <rcu@archiver.kernel.org>; Thu, 13 May 2021 06:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82AD961435
	for <rcu@archiver.kernel.org>; Thu, 13 May 2021 06:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbhEMGzd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 13 May 2021 02:55:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:52366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230063AbhEMGzc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 13 May 2021 02:55:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4018261438;
        Thu, 13 May 2021 06:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620888863;
        bh=1OXVj5XLjoFZLo+5zoS0/K1s4R3ap0lwj4wbH7hBkzE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cQ0cVM7xdyrQSN7xZcgyZVD32ddxWB0DGY+hgJb2CB2TMaD+/xVLtLhB8vGOSOBcD
         ZMGWEhTr4EPCWm8GGF4BQVKVR+3uZOrlFXKaKIDRdZi+gv/j34VyeOdvE/+oM2ab6z
         KjF0in4ftSlRLNs5sIK/ZPZMHUmLfbl7x0E2nzcaWuhh18tN/4nz7mFmCHuxnztdRN
         3Jfike8jaONzgT3Ipd27TZjULydsRKljFhsFWZHI6FajkjakQezM0M5QrwWHcEm960
         mZ2mTFcHk1SJ2YUc98aNHl7VomhA9zDjhas3twf1sv40yBZ95Zvni5AiMefxP4jBCI
         /uFbgo/ClXhyg==
Date:   Thu, 13 May 2021 15:54:17 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH tip/core/rcu 3/4] rcu-tasks: Make ksoftirqd provide RCU
 Tasks quiescent states
Message-Id: <20210513155417.93ab2299139ba35025ec8ef7@kernel.org>
In-Reply-To: <20210512182747.3445812-4-paulmck@kernel.org>
References: <20210512182747.3445812-4-paulmck@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul,

On Wed, 12 May 2021 11:27:46 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> Heavy networking load can cause a CPU to execute continuously and
> indefinitely within ksoftirqd, in which case there will be no voluntary
> task switches and thus no RCU-tasks quiescent states.  This commit
> therefore causes the exiting rcu_softirq_qs() to provide an RCU-tasks
> quiescent state.
> 
> This of course means that __do_softirq() and its callers cannot be
> invoked from within a tracing trampoline.

I would like to confirm that you mean "tracing trampoline" here is
the code on the trampoline buffer, not the handler code which is
invoked from the trampoline buffer but it is protected by preempt_disable(),
am I understand correctly?

Thank you,

> 
> Reported-by: Toke Høiland-Jørgensen <toke@redhat.com>
> Tested-by: Toke Høiland-Jørgensen <toke@redhat.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  kernel/rcu/tree.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 8e78b2430c16..f4daa4e60b14 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -242,6 +242,7 @@ void rcu_softirq_qs(void)
>  {
>  	rcu_qs();
>  	rcu_preempt_deferred_qs(current);
> +	rcu_tasks_qs(current, false);
>  }
>  
>  /*
> -- 
> 2.31.1.189.g2e36527f23
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
