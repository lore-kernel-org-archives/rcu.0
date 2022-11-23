Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1AAC4332F
	for <rcu@archiver.kernel.org>; Wed, 23 Nov 2022 18:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238924AbiKWSk2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 23 Nov 2022 13:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238244AbiKWSk1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 23 Nov 2022 13:40:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBF07EBD6
        for <rcu@vger.kernel.org>; Wed, 23 Nov 2022 10:40:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F034CB82284
        for <rcu@vger.kernel.org>; Wed, 23 Nov 2022 18:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F86C433D6;
        Wed, 23 Nov 2022 18:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669228822;
        bh=P6aEjpYl1G2UZ+qpGGSaI/2bk19KcksOVPdcB2E5i7I=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=vIc1QCDtNF2K19JJ+U02vVnbzcHbHFKLy6GVWv7nNUEbOQdOHWE0WUvHJuO480Tt7
         /qDsNLmGsYolspHJ98OFF3GK0hBa2Aj61tEBk3BBsAUeBhNqWfY9TaKguCmY8tp/dj
         wfI5AuBwuELavQFgNHkaOCiX/FBCgLR5Ow3w2s+x/aaSl3jlMI873uzblKgdWGfPCi
         itD+Ctc8MgeHby5/I7F5lHKcyq+vDe0eS19QyaNiu++ZjdepbpycTIF48t9Wec2XT7
         VuKVh56ArOkrg7fML0S6PnBGGsidbismqzjEhAUtedsqhQZI0h0aI/yyxqTiOTwM7V
         Q3XED+3bDS2Cg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 59D4E5C0A3F; Wed, 23 Nov 2022 10:40:22 -0800 (PST)
Date:   Wed, 23 Nov 2022 10:40:22 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 2/2] srcu: Remove needless updating of srcu_have_cbs in
 srcu_gp_end()
Message-ID: <20221123184022.GC4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221120034014.7390-1-kernelfans@gmail.com>
 <20221120034014.7390-3-kernelfans@gmail.com>
 <20221122011916.GT4001@paulmck-ThinkPad-P17-Gen-1>
 <Y3ydcMAkqpCGNosw@piliu.users.ipa.redhat.com>
 <20221122144549.GH4001@paulmck-ThinkPad-P17-Gen-1>
 <Y34gLXdlr2ppvL4J@piliu.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y34gLXdlr2ppvL4J@piliu.users.ipa.redhat.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 23, 2022 at 09:29:17PM +0800, Pingfan Liu wrote:
> On Tue, Nov 22, 2022 at 06:45:49AM -0800, Paul E. McKenney wrote:
> > On Tue, Nov 22, 2022 at 05:59:12PM +0800, Pingfan Liu wrote:
> > > On Mon, Nov 21, 2022 at 05:19:16PM -0800, Paul E. McKenney wrote:
> > > > On Sun, Nov 20, 2022 at 11:40:14AM +0800, Pingfan Liu wrote:
> > > > > At present, snp->srcu_have_cbs[idx] is updated by either
> > > > > srcu_funnel_gp_start() or srcu_gp_end().
> > > > > 
> > > > > But as the code changes, now, srcu_funnel_gp_start() is called with srcu
> > > > > read lock held. And its input parameter s, s = rcu_seq_snap(&ssp->srcu_gp_seq),
> > > > > whose counter field always proceeds that of the srcu_gp_seq by one or two.
> > > > > 
> > > > > If the seq snap only proceeds by one, the state machine should be in
> > > > > state SRCU_STATE_IDLE, the held srcu read lock will prevent the state
> > > > > machine from moving ahead. So when srcu_gp_end() updates
> > > > > snp->srcu_have_cbs[idx], the idx must be the past idx for
> > > > > srcu_funnel_gp_start() that is cared by nobody.
> > > > > 
> > > > > So removing the unnecessary updating in srcu_gp_end().
> > > > 
> > > > This looks plausible, good eyes!
> > > > 
> > > > But is there a debug check that could verify that this is unnecessary?
> > > > Logical reasoning is all well and good, but the actual system always
> > > > wins arguments.  ;-)
> > > > 
> > > 
> > > Agree. Reasoning may miss some ground and render a wrong result.
> > > 
> > > But it is a little hard to demonstrate the past idx is not accessed. I
> > > will go on to figure a way out.
> > 
> > On a 64-bit system especially, it should be easy to generate a pattern
> > that never actually occurs.  Even on a 32-bit system, aren't there bit
> > patterns in the low-order bits that never occur?
> > 
> > Wouldn't it be possible to check for those?
> 
> I had thought about that way, but that means a write and cache invalid.

Which would be one reason to do it only within kernels built with
CONFIG_PROVE_RCU=y.  In addition, this write occurs only rarely, so its
effect on overall performance should be extremely small.

> While on the other way, I still rely on the logic to add some check
> code, which should be avoided.

The eternal vulnerabilty of logic is that it is always based on
assumptions, which cannot be proven correct, only invalidated.  ;-)

> Finally, I turn back to the way which you suggested. But I have a new
> plan for this patch. So I will send out V2 for the other two patches.
> 
> As for this one, it will come in the next series.

Looking forward to seeing it, then.

							Thanx, Paul

> Thanks,
> 
> 	Pingfan
> 
> 
> > 							Thanx, Paul
> > 
> > > Thanks,
> > > 
> > > 	Pingfan
> > > 
> > > > 							Thanx, Paul
> > > > 
> > > > > Test info:
> > > > >   Running "tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 10h --configs 18*SRCU-P"
> > > > > without any failure.
> > > > > 
> > > > > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > > > > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > > > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > > > Cc: Frederic Weisbecker <frederic@kernel.org>
> > > > > Cc: Josh Triplett <josh@joshtriplett.org>
> > > > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > > > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > > > To: rcu@vger.kernel.org
> > > > > ---
> > > > >  kernel/rcu/srcutree.c | 2 --
> > > > >  1 file changed, 2 deletions(-)
> > > > > 
> > > > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > > > index 7df59fc8073e..c54d6c04751f 100644
> > > > > --- a/kernel/rcu/srcutree.c
> > > > > +++ b/kernel/rcu/srcutree.c
> > > > > @@ -783,8 +783,6 @@ static void srcu_gp_end(struct srcu_struct *ssp)
> > > > >  			last_lvl = snp >= ssp->level[rcu_num_lvls - 1];
> > > > >  			if (last_lvl)
> > > > >  				cbs = ss_state < SRCU_SIZE_BIG || snp->srcu_have_cbs[idx] == gpseq;
> > > > > -			snp->srcu_have_cbs[idx] = gpseq;
> > > > > -			rcu_seq_set_state(&snp->srcu_have_cbs[idx], 1);
> > > > >  			sgsne = snp->srcu_gp_seq_needed_exp;
> > > > >  			if (srcu_invl_snp_seq(sgsne) || ULONG_CMP_LT(sgsne, gpseq))
> > > > >  				WRITE_ONCE(snp->srcu_gp_seq_needed_exp, gpseq);
> > > > > -- 
> > > > > 2.31.1
> > > > > 
