Return-Path: <SRS0=T7aT=4F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB66C34022
	for <rcu@archiver.kernel.org>; Mon, 17 Feb 2020 21:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F615207FD
	for <rcu@archiver.kernel.org>; Mon, 17 Feb 2020 21:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581975416;
	bh=Z3MjIfs82PU+SZJqaYgP0md1kb2zmhXzQIJP97cDfys=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=ppUDU68sSMeDUZJ47CY4MP0Jyn6AGsI7HubLv1+oG0FNSFyVWt9IOR38w6fv/1jFo
	 8y8B3h8xaZc2dHsJGMyU3+81mO/Bug8kMCd0irMZW4yt5e5QCtkg3pcESShwWpDlQ1
	 puhLuc/wHKsrmFEXLnLLP7Omq9ELxRj7FRToqIrM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbgBQVg4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 17 Feb 2020 16:36:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:40994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728935AbgBQVg4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 17 Feb 2020 16:36:56 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 525922070B;
        Mon, 17 Feb 2020 21:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581975415;
        bh=Z3MjIfs82PU+SZJqaYgP0md1kb2zmhXzQIJP97cDfys=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=eHuj2IElQrDCVE7vAgW19UJLaZkXkMyPRzO4U9ORoKQ2UMtGeMN72/kbMMZoK2Uss
         T1XRnD1rHjTzfMvX2Kp7JQJURbb+MiTBtngOspjcQyKmeBzdF5IvXqgucsaRfeLXr+
         gqtkmgcUeRpVjKOYe9PBTD5ubpurcXhK5OXlOpUY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 2B7C735227A8; Mon, 17 Feb 2020 13:36:55 -0800 (PST)
Date:   Mon, 17 Feb 2020 13:36:55 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH tip/core/rcu 06/30] rcu: Add WRITE_ONCE to rcu_node
 ->exp_seq_rq store
Message-ID: <20200217213655.GX2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200214235536.GA13364@paulmck-ThinkPad-P72>
 <20200214235607.13749-6-paulmck@kernel.org>
 <20200214224743.280772a7@oasis.local.home>
 <20200215105803.GY2935@paulmck-ThinkPad-P72>
 <20200217211135.GA207704@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217211135.GA207704@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Feb 17, 2020 at 04:11:35PM -0500, Joel Fernandes wrote:
> On Sat, Feb 15, 2020 at 02:58:03AM -0800, Paul E. McKenney wrote:
> > On Fri, Feb 14, 2020 at 10:47:43PM -0500, Steven Rostedt wrote:
> > > On Fri, 14 Feb 2020 15:55:43 -0800
> > > paulmck@kernel.org wrote:
> > > 
> > > > From: "Paul E. McKenney" <paulmck@kernel.org>
> > > > 
> > > > The rcu_node structure's ->exp_seq_rq field is read locklessly, so
> > > > this commit adds the WRITE_ONCE() to a load in order to provide proper
> > > > documentation and READ_ONCE()/WRITE_ONCE() pairing.
> > > > 
> > > > This data race was reported by KCSAN.  Not appropriate for backporting
> > > > due to failure being unlikely.
> > > > 
> > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > ---
> > > >  kernel/rcu/tree_exp.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > > > index d7e0484..85b009e 100644
> > > > --- a/kernel/rcu/tree_exp.h
> > > > +++ b/kernel/rcu/tree_exp.h
> > > > @@ -314,7 +314,7 @@ static bool exp_funnel_lock(unsigned long s)
> > > >  				   sync_exp_work_done(s));
> > > >  			return true;
> > > >  		}
> > > > -		rnp->exp_seq_rq = s; /* Followers can wait on us. */
> > > > +		WRITE_ONCE(rnp->exp_seq_rq, s); /* Followers can wait on us. */
> > > 
> > > Didn't Linus say this is basically bogus?
> > > 
> > > Perhaps just using it as documenting that it's read locklessly, but is
> > > it really needed?
> > 
> > Yes, Linus explicitly stated that WRITE_ONCE() is not required in
> > this case, but he also said that he was OK with it being there for
> > documentation purposes.
> 
> Just to add, PeterZ does approve of WRITE_ONCE() to prevent store-tearing
> where applicable.
> 
> And I have reproduced Will's example [1] with the arm64 Clang compiler
> shipping with the latest Android NDK just now. It does break up stores when
> writing zeroes to 64-bit valyes, this is a real problem which WRITE_ONCE()
> resolves. And I've verified GCC on arm64 does break up 64-bit immediate value
> writes without WRITE_ONCE().

That does sounds a bit on the required side!  ;-)

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> [1] https://lore.kernel.org/lkml/20190821103200.kpufwtviqhpbuv2n@willie-the-truck/
> 
> 
> > And within RCU, I -do- need it because I absolutely need to see if a
> > given patch introduced new KCSAN reports.  So I need it for the same
> > reason that I need the build to proceed without warnings.
> > 
> > Others who are working with less concurrency-intensive code might quite
> > reasonably make other choices, of course.  And my setting certain KCSAN
> > config options in my own builds doesn't inconvenience them, so we should
> > all be happy, right?  :-)
> > 
> > 							Thanx, Paul
> > 
> > > -- Steve
> > > 
> > > 
> > > 
> > > >  		spin_unlock(&rnp->exp_lock);
> > > >  		trace_rcu_exp_funnel_lock(rcu_state.name, rnp->level,
> > > >  					  rnp->grplo, rnp->grphi, TPS("nxtlvl"));
> > > 
