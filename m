Return-Path: <SRS0=T7aT=4F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAD9C35254
	for <rcu@archiver.kernel.org>; Mon, 17 Feb 2020 12:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC80620725
	for <rcu@archiver.kernel.org>; Mon, 17 Feb 2020 12:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i+f+hHeC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgBQMj1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 17 Feb 2020 07:39:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56366 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbgBQMj1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 17 Feb 2020 07:39:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IIpOmEB3A0357qhgGhhncaosuY31N7yX0gm83o8Xgi4=; b=i+f+hHeCnXrUHPRGfcrQvNIk6q
        daH4/g6Y7MdvLEm+CalG5XsK00TVtZ+i2Md3cJhlUA/utM9iP9peYR3tU3hJMIz+0vW/G29DLSzGN
        Zc1Ha97usEs/j3yGWbcINJlyDmVPFXDZY+NW+VyNOoKOkAqE2AuvRrglKkBN4b8ZIYX/2VVJzljGH
        vimGod0LaEL263CM0nFSLOlXT4JLJqk86mMpqEPVskiQRpz4naihIseIvPFhCrvybrWuA7X2483Bq
        CNc0qWeUcgWeBkDD5C5y2wuikQPDkgG/0ZyUSqMcB/QuzrxuRRafSb+tdB6/eM+gnJsDyaf1q4oXg
        0DTNeHsA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3ffr-0004F8-6C; Mon, 17 Feb 2020 12:38:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ACF0D300EBB;
        Mon, 17 Feb 2020 13:37:00 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EB64D29E09C26; Mon, 17 Feb 2020 13:38:51 +0100 (CET)
Date:   Mon, 17 Feb 2020 13:38:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, rostedt@goodmis.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 1/3] rcu-tasks: *_ONCE() for
 rcu_tasks_cbs_head
Message-ID: <20200217123851.GR14914@hirez.programming.kicks-ass.net>
References: <20200215002446.GA15663@paulmck-ThinkPad-P72>
 <20200215002520.15746-1-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200215002520.15746-1-paulmck@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Feb 14, 2020 at 04:25:18PM -0800, paulmck@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> The RCU tasks list of callbacks, rcu_tasks_cbs_head, is sampled locklessly
> by rcu_tasks_kthread() when waiting for work to do.  This commit therefore
> applies READ_ONCE() to that lockless sampling and WRITE_ONCE() to the
> single potential store outside of rcu_tasks_kthread.
> 
> This data race was reported by KCSAN.  Not appropriate for backporting
> due to failure being unlikely.

What failure is possible here? AFAICT this is (again) one of them
load-complare-against-constant-discard patterns that are impossible to
mess up.

> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  kernel/rcu/update.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index 6c4b862..a27df76 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -528,7 +528,7 @@ void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func)
>  	rhp->func = func;
>  	raw_spin_lock_irqsave(&rcu_tasks_cbs_lock, flags);
>  	needwake = !rcu_tasks_cbs_head;
> -	*rcu_tasks_cbs_tail = rhp;
> +	WRITE_ONCE(*rcu_tasks_cbs_tail, rhp);
>  	rcu_tasks_cbs_tail = &rhp->next;
>  	raw_spin_unlock_irqrestore(&rcu_tasks_cbs_lock, flags);
>  	/* We can't create the thread unless interrupts are enabled. */
> @@ -658,7 +658,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
>  		/* If there were none, wait a bit and start over. */
>  		if (!list) {
>  			wait_event_interruptible(rcu_tasks_cbs_wq,
> -						 rcu_tasks_cbs_head);
> +						 READ_ONCE(rcu_tasks_cbs_head));
>  			if (!rcu_tasks_cbs_head) {
>  				WARN_ON(signal_pending(current));
>  				schedule_timeout_interruptible(HZ/10);
> -- 
> 2.9.5
> 
