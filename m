Return-Path: <SRS0=OxHY=4G=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FBEC34031
	for <rcu@archiver.kernel.org>; Tue, 18 Feb 2020 21:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6936C22B48
	for <rcu@archiver.kernel.org>; Tue, 18 Feb 2020 21:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582062499;
	bh=WiwCNvyJt8cbbiANZODpyVDUSfy10IYL4YvpxXMSn94=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=nUy4kZqZ2sj21QtN/Om/Q3fzuhUkDWqAwdKBQgDBr3iZx0zvx4O5Xj8uKdSzjZ8n0
	 qWVw0yJUjkktTZyZOgeh5oHeJD7d66dq3iL7bRUOe30D9vLWQB1EAEhO0VGEaXwmMP
	 ZYScFA7YDZ1u6cBYFjqyOwDzmXIc+CE7Sa52Aw4o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgBRVsT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 18 Feb 2020 16:48:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:48752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727868AbgBRVsT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 18 Feb 2020 16:48:19 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99797206E2;
        Tue, 18 Feb 2020 21:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582062498;
        bh=WiwCNvyJt8cbbiANZODpyVDUSfy10IYL4YvpxXMSn94=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fme/q6nIBndVPOE9S/+MT4Im1evsayUsfqULw+kjhN65iDdWtejOcHK+PIydugRKa
         GsWcJNqqWNm0cBzwFSa3xh267On4LF1y04UZOeUCMna3rT7bJAg3zaYq/xXNGqgWQK
         kjxxM+IfH9b4BaqXBlmFfannJryAHNbZ6ZGIyeKU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 700173520856; Tue, 18 Feb 2020 13:48:18 -0800 (PST)
Date:   Tue, 18 Feb 2020 13:48:18 -0800
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
Message-ID: <20200218214818.GM2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200215002907.GA15895@paulmck-ThinkPad-P72>
 <20200215002932.15976-4-paulmck@kernel.org>
 <20200217124507.GT14914@hirez.programming.kicks-ass.net>
 <20200217183220.GS2935@paulmck-ThinkPad-P72>
 <20200217230657.GA8985@paulmck-ThinkPad-P72>
 <20200218114631.GY14914@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218114631.GY14914@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Feb 18, 2020 at 12:46:31PM +0100, Peter Zijlstra wrote:
> On Mon, Feb 17, 2020 at 03:06:57PM -0800, Paul E. McKenney wrote:
> > commit 52324a7b8a025f47a1a1a9fbd23ffe59fa764764
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Fri Jan 3 11:42:05 2020 -0800
> > 
> >     srcu: Hold srcu_struct ->lock when updating ->srcu_gp_seq
> >     
> >     A read of the srcu_struct structure's ->srcu_gp_seq field should not
> >     need READ_ONCE() when that structure's ->lock is held.  Except that this
> >     lock is not always held when updating this field.  This commit therefore
> >     acquires the lock around updates and removes a now-unneeded READ_ONCE().
> >     
> >     This data race was reported by KCSAN.
> >     
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Applied, thank you!

							Thanx, Paul

> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 119a373..c19c1df 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -450,7 +450,7 @@ static void srcu_gp_start(struct srcu_struct *ssp)
> >  	spin_unlock_rcu_node(sdp);  /* Interrupts remain disabled. */
> >  	smp_mb(); /* Order prior store to ->srcu_gp_seq_needed vs. GP start. */
> >  	rcu_seq_start(&ssp->srcu_gp_seq);
> > -	state = rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq));
> > +	state = rcu_seq_state(ssp->srcu_gp_seq);
> >  	WARN_ON_ONCE(state != SRCU_STATE_SCAN1);
> >  }
> >  
> > @@ -1130,7 +1130,9 @@ static void srcu_advance_state(struct srcu_struct *ssp)
> >  			return; /* readers present, retry later. */
> >  		}
> >  		srcu_flip(ssp);
> > +		spin_lock_irq_rcu_node(ssp);
> >  		rcu_seq_set_state(&ssp->srcu_gp_seq, SRCU_STATE_SCAN2);
> > +		spin_unlock_irq_rcu_node(ssp);
> >  	}
> >  
> >  	if (rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)) == SRCU_STATE_SCAN2) {
