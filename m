Return-Path: <SRS0=T7aT=4F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F04C34024
	for <rcu@archiver.kernel.org>; Mon, 17 Feb 2020 18:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4686824693
	for <rcu@archiver.kernel.org>; Mon, 17 Feb 2020 18:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581964342;
	bh=rvWTyaYeifjPqyUfCKPJ7kkPbaQPPWSrX34cC7WHYzA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=b/0QkrGnW7vO4ZkLMVz0070ScJgG4t79Fq/jomVE3kfoQLqjODG/Lztf4mt6zGkRc
	 3pN/LwsPwOtm82JAKgT4ytMKtLTIIp6SofNkwXEyeisqo4ePm8Xpj24+uMU4nF6ehL
	 sNUwDU8q6FsJBNcwbjfcoJar/oNOdiCH06OeUT38=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgBQScV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 17 Feb 2020 13:32:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:47706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbgBQScV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 17 Feb 2020 13:32:21 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E25724689;
        Mon, 17 Feb 2020 18:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581964341;
        bh=rvWTyaYeifjPqyUfCKPJ7kkPbaQPPWSrX34cC7WHYzA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dAROZkYWdkfyGo9BVUpJRwP4FNQYeRsiSbak30ehQKGHbQu9GMuWxYsTZMLZsNWlL
         PVkVBLV4PEA8jiiNczz5BY+PsNIDGdey+H/mx05ZCegrUkgx67Qqi85uF7Iqx1JqG8
         aI9r9c3Z6PvNOmo6X4DLh5Lm5eHwXktW+DFnvDVQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id CF02D352273C; Mon, 17 Feb 2020 10:32:20 -0800 (PST)
Date:   Mon, 17 Feb 2020 10:32:20 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, rostedt@goodmis.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 4/4] srcu: Add READ_ONCE() to srcu_struct
 ->srcu_gp_seq load
Message-ID: <20200217183220.GS2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200215002907.GA15895@paulmck-ThinkPad-P72>
 <20200215002932.15976-4-paulmck@kernel.org>
 <20200217124507.GT14914@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217124507.GT14914@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Feb 17, 2020 at 01:45:07PM +0100, Peter Zijlstra wrote:
> On Fri, Feb 14, 2020 at 04:29:32PM -0800, paulmck@kernel.org wrote:
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > The load of the srcu_struct structure's ->srcu_gp_seq field in
> > srcu_funnel_gp_start() is lockless, so this commit adds the requisite
> > READ_ONCE().
> > 
> > This data race was reported by KCSAN.
> 
> But is there in actual fact a data-race? AFAICT this code was just fine.

Now that you mention it, the lock is held at that point, isn't it?  So if
that READ_ONCE() actually does anything, there is a bug somewhere else.

Good catch, I will drop this patch, thank you!

							Thanx, Paul

> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  kernel/rcu/srcutree.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 119a373..90ab475 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -678,7 +678,7 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
> >  
> >  	/* If grace period not already done and none in progress, start it. */
> >  	if (!rcu_seq_done(&ssp->srcu_gp_seq, s) &&
> > -	    rcu_seq_state(ssp->srcu_gp_seq) == SRCU_STATE_IDLE) {
> > +	    rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)) == SRCU_STATE_IDLE) {
> >  		WARN_ON_ONCE(ULONG_CMP_GE(ssp->srcu_gp_seq, ssp->srcu_gp_seq_needed));
> >  		srcu_gp_start(ssp);
> >  		if (likely(srcu_init_done))
> > -- 
> > 2.9.5
> > 
