Return-Path: <SRS0=vfTc=4D=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE87C352A3
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 03:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D8820873
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 03:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgBODxJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 22:53:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:52892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727642AbgBODxI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 22:53:08 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A404220718;
        Sat, 15 Feb 2020 03:53:06 +0000 (UTC)
Date:   Fri, 14 Feb 2020 22:53:05 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel@joelfernandes.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH tip/core/rcu 22/30] rcu: Don't flag non-starting GPs
 before GP kthread is running
Message-ID: <20200214225305.48550d6a@oasis.local.home>
In-Reply-To: <20200214235607.13749-22-paulmck@kernel.org>
References: <20200214235536.GA13364@paulmck-ThinkPad-P72>
        <20200214235607.13749-22-paulmck@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, 14 Feb 2020 15:55:59 -0800
paulmck@kernel.org wrote:

> @@ -1252,10 +1252,10 @@ static bool rcu_future_gp_cleanup(struct rcu_node *rnp)
>   */
>  static void rcu_gp_kthread_wake(void)
>  {
> -	if ((current == rcu_state.gp_kthread &&
> +	if ((current == READ_ONCE(rcu_state.gp_kthread) &&
>  	     !in_irq() && !in_serving_softirq()) ||
>  	    !READ_ONCE(rcu_state.gp_flags) ||
> -	    !rcu_state.gp_kthread)
> +	    !READ_ONCE(rcu_state.gp_kthread))
>  		return;

This looks buggy. You have two instances of
READ_ONCE(rcu_state.gp_thread), which means they can be different. Is
that intentional?

-- Steve
