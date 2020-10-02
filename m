Return-Path: <SRS0=VPhX=DJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D1AC4727D
	for <rcu@archiver.kernel.org>; Fri,  2 Oct 2020 04:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 235D120796
	for <rcu@archiver.kernel.org>; Fri,  2 Oct 2020 04:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601613594;
	bh=zbG2iEh9bQFGJLHd+0KwxDAW/5RszvjdWnLdbMOPS7o=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=pFokuoargq42y7F8UrSqRSy5jf2d05ZLpFXiKdVtddpj2QeFQn4hN3H0m3w7S70tF
	 mh1MPvCJ+fp8g+W2jqG1Lp9SnrktotmGVhA4bwdawZTb2aCSUwSEAR6k29GtFeLJV0
	 q/QdvTH4D+2lb+TSAbrkJtr3Rn3aY+QNku89Ql3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbgJBEjw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 2 Oct 2020 00:39:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:54682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgJBEjv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 2 Oct 2020 00:39:51 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A4022072E;
        Fri,  2 Oct 2020 04:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601613591;
        bh=zbG2iEh9bQFGJLHd+0KwxDAW/5RszvjdWnLdbMOPS7o=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=YY/1Lv2sEiR77Cwbq80MBqwJ1oLz+9XHTJB0/Z7dwL9dRgnFHcV41OurKT/kmmV0q
         9adRNOXPEqCj5i8U/lxS7UtQvma7cZH0fJ/2/6g7Xv/YxkA5etImdpCSiuKcOX3wKT
         +mIhj1qqlt2JTWzSPB/r7HqERwFZ0cTdGLuO7r28=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D67563522B33; Thu,  1 Oct 2020 21:39:50 -0700 (PDT)
Date:   Thu, 1 Oct 2020 21:39:50 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/2] rcu/tree: Add a warning if CPU being onlined did not
 report QS already
Message-ID: <20201002043950.GG29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200929192928.3749502-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929192928.3749502-1-joel@joelfernandes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Sep 29, 2020 at 03:29:27PM -0400, Joel Fernandes (Google) wrote:
> Currently, rcu_cpu_starting() checks to see if the RCU core expects a
> quiescent state from the incoming CPU.  However, the current interaction
> between RCU quiescent-state reporting and CPU-hotplug operations should
> mean that the incoming CPU never needs to report a quiescent state.
> First, the outgoing CPU reports a quiescent state if needed.  Second,
> the race where the CPU is leaving just as RCU is initializing a new
> grace period is handled by an explicit check for this condition.  Third,
> the CPU's leaf rcu_node structure's ->lock serializes these checks.
> 
> This means that if rcu_cpu_starting() ever feels the need to report
> a quiescent state, then there is a bug somewhere in the CPU hotplug
> code or the RCU grace-period handling code.  This commit therefore
> adds a WARN_ON_ONCE() to bring that bug to everyone's attention.
> 
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Queued for testing and further review, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/tree.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 55d3700dd1e7..5efe0a98ea45 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4119,7 +4119,9 @@ void rcu_cpu_starting(unsigned int cpu)
>  	rcu_gpnum_ovf(rnp, rdp); /* Offline-induced counter wrap? */
>  	rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);
>  	rdp->rcu_onl_gp_flags = READ_ONCE(rcu_state.gp_flags);
> -	if (rnp->qsmask & mask) { /* RCU waiting on incoming CPU? */
> +
> +	/* An incoming CPU should never be blocking a grace period. */
> +	if (WARN_ON_ONCE(rnp->qsmask & mask)) { /* RCU waiting on incoming CPU? */
>  		rcu_disable_urgency_upon_qs(rdp);
>  		/* Report QS -after- changing ->qsmaskinitnext! */
>  		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
> -- 
> 2.28.0.709.gb0816b6eb0-goog
> 
