Return-Path: <SRS0=T7aT=4F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56FCC761A4
	for <rcu@archiver.kernel.org>; Mon, 17 Feb 2020 12:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9669320725
	for <rcu@archiver.kernel.org>; Mon, 17 Feb 2020 12:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UlXbNpkn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgBQMmt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 17 Feb 2020 07:42:49 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58714 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgBQMmt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 17 Feb 2020 07:42:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5zdmD/tRh0T6nvqIold9dp9SYMkW5fAoU/COsGQS5uY=; b=UlXbNpkn9WO4qTjaK0Bcl29DzL
        hkkUlQTzEUT5vD3E58v89R1iZFGtv5YftLLBoZKtSGGjzWV7d1jRbbf1kstbNXeTFgPgehp3VMfGR
        XPhVfx5TCVqC3zLV8PssFnYzKDkxD/aL+jywaq1ZJGDd5wn+dXkp6ywi2gPkx/lXw1D8QzbvH/vkK
        5t9YDpl6Kp9q6LgOSK50n3qOgvfTxMeYEp8I3e6degkk6IpCFWCneSs/olW3vAGGg0UgjShq2RxLe
        q84bx6DjdvFvr9mINTuTi7IQRBfo4QMHJyEJ/H/0OZrTqH4HJD93hkujF5CAVPrF+StCocNFBgipF
        u1fmwfUw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3fjN-00069E-SD; Mon, 17 Feb 2020 12:42:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 53B13300606;
        Mon, 17 Feb 2020 13:40:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BAA902B782E23; Mon, 17 Feb 2020 13:42:31 +0100 (CET)
Date:   Mon, 17 Feb 2020 13:42:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, rostedt@goodmis.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 1/4] srcu: Fix __call_srcu()/process_srcu()
 datarace
Message-ID: <20200217124231.GS14914@hirez.programming.kicks-ass.net>
References: <20200215002907.GA15895@paulmck-ThinkPad-P72>
 <20200215002932.15976-1-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200215002932.15976-1-paulmck@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Feb 14, 2020 at 04:29:29PM -0800, paulmck@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> The srcu_node structure's ->srcu_gp_seq_needed_exp field is accessed
> locklessly, so updates must use WRITE_ONCE().  This commit therefore
> adds the needed WRITE_ONCE() invocations.
> 
> This data race was reported by KCSAN.  Not appropriate for backporting
> due to failure being unlikely.

This does indeed look like there can be a failure; but this Changelog
fails to describe an actual problem.

> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  kernel/rcu/srcutree.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 657e6a7..b1edac9 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -550,7 +550,7 @@ static void srcu_gp_end(struct srcu_struct *ssp)
>  		snp->srcu_have_cbs[idx] = gpseq;
>  		rcu_seq_set_state(&snp->srcu_have_cbs[idx], 1);
>  		if (ULONG_CMP_LT(snp->srcu_gp_seq_needed_exp, gpseq))
> -			snp->srcu_gp_seq_needed_exp = gpseq;
> +			WRITE_ONCE(snp->srcu_gp_seq_needed_exp, gpseq);
>  		mask = snp->srcu_data_have_cbs[idx];
>  		snp->srcu_data_have_cbs[idx] = 0;
>  		spin_unlock_irq_rcu_node(snp);
> @@ -660,7 +660,7 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
>  		if (snp == sdp->mynode)
>  			snp->srcu_data_have_cbs[idx] |= sdp->grpmask;
>  		if (!do_norm && ULONG_CMP_LT(snp->srcu_gp_seq_needed_exp, s))
> -			snp->srcu_gp_seq_needed_exp = s;
> +			WRITE_ONCE(snp->srcu_gp_seq_needed_exp, s);
>  		spin_unlock_irqrestore_rcu_node(snp, flags);
>  	}
>  
> -- 
> 2.9.5
> 
