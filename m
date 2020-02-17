Return-Path: <SRS0=T7aT=4F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D76BC761A4
	for <rcu@archiver.kernel.org>; Mon, 17 Feb 2020 12:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5174720725
	for <rcu@archiver.kernel.org>; Mon, 17 Feb 2020 12:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mdlW35hN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgBQMpu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 17 Feb 2020 07:45:50 -0500
Received: from merlin.infradead.org ([205.233.59.134]:41862 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgBQMpt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 17 Feb 2020 07:45:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FelI1iG9O0CpNorqieVC1Sm3aQjwvDBCFxEQykU0JaM=; b=mdlW35hNjSoqGAmHrcq3Pl3S9I
        gVImasJMb74z/FdjbstMj7gbfhFrGVaProoFs/gOahV72Jb2VB6cl7cNKFwSy83qA3r5evh/U6+9r
        yX2UMSpvl/tzVViTfNxsExlzSlPmsmruCI/yKbvcpjHQ5hDTuy7GFkOrbovggmbRmkXrcNH+EwhXa
        6EQI+klkY6CStdM8djQVB3rJIMisuqhan+0ufImKSKLQOg3zvN3EeHBh99pL3kkG1wzhc5HvJ7gLp
        x18ymWk6lWZIqRr4bU7lrVqKlB8pSwvs+VSUtPXilvp07j3QnS/JLz7HMhoFx6qy3AKVFKq9das12
        hZhEhLUg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3flu-0003tS-Ag; Mon, 17 Feb 2020 12:45:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2B65E300EBB;
        Mon, 17 Feb 2020 13:43:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 538622B782E24; Mon, 17 Feb 2020 13:45:07 +0100 (CET)
Date:   Mon, 17 Feb 2020 13:45:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, rostedt@goodmis.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 4/4] srcu: Add READ_ONCE() to srcu_struct
 ->srcu_gp_seq load
Message-ID: <20200217124507.GT14914@hirez.programming.kicks-ass.net>
References: <20200215002907.GA15895@paulmck-ThinkPad-P72>
 <20200215002932.15976-4-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200215002932.15976-4-paulmck@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Feb 14, 2020 at 04:29:32PM -0800, paulmck@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> The load of the srcu_struct structure's ->srcu_gp_seq field in
> srcu_funnel_gp_start() is lockless, so this commit adds the requisite
> READ_ONCE().
> 
> This data race was reported by KCSAN.

But is there in actual fact a data-race? AFAICT this code was just fine.

> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  kernel/rcu/srcutree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 119a373..90ab475 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -678,7 +678,7 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
>  
>  	/* If grace period not already done and none in progress, start it. */
>  	if (!rcu_seq_done(&ssp->srcu_gp_seq, s) &&
> -	    rcu_seq_state(ssp->srcu_gp_seq) == SRCU_STATE_IDLE) {
> +	    rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)) == SRCU_STATE_IDLE) {
>  		WARN_ON_ONCE(ULONG_CMP_GE(ssp->srcu_gp_seq, ssp->srcu_gp_seq_needed));
>  		srcu_gp_start(ssp);
>  		if (likely(srcu_init_done))
> -- 
> 2.9.5
> 
