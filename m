Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66EDC433FE
	for <rcu@archiver.kernel.org>; Wed, 16 Nov 2022 17:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbiKPR1G (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 16 Nov 2022 12:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbiKPR0r (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 16 Nov 2022 12:26:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76796D2EE
        for <rcu@vger.kernel.org>; Wed, 16 Nov 2022 09:26:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30D19B81E05
        for <rcu@vger.kernel.org>; Wed, 16 Nov 2022 17:26:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86EEC433D7;
        Wed, 16 Nov 2022 17:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668619603;
        bh=NqNp0QCM+LgRUpqjiiYaitE+hXruPtxS/tc9W7jn+iE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=GSnBP+bBGOp1TPivrsoombGFyLUN0g5cO7yitYeP6CxID8XX6L3Y/dkRwe/JsNiIw
         dPsoVwVRuXFsFsxd3bpAkl24uqn/3mHyVfgeTuJHKjBhSPZ15XzhM3xZZwA9ZutPv2
         3OxSSZYne2WdPVZGajCWZsvkdbuW0rFzRH5YVpmtQkvQU2vjKYwtjE5DAlvOPige1q
         ZC6myzOfzv2T5ZC2zcqZeOexxrIIukBLqLrYJmyIMpM31YteFgmMNJZOcrqufgZuPx
         zmhlYiiKdO6lLKiuRTPC/GVKHr6UQNEdRiYfJSJbHrU+i9hSZ4c9yEonL8tqpCBTRR
         6aOtKqjUzB/7w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7C1AA5C0865; Wed, 16 Nov 2022 09:26:43 -0800 (PST)
Date:   Wed, 16 Nov 2022 09:26:43 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Pingfan Liu <kernelfans@gmail.com>, rcu@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 2/2] srcu: Fix the comparision in srcu_invl_snp_seq()
Message-ID: <20221116172643.GA1432130@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221116015244.10539-1-kernelfans@gmail.com>
 <20221116015244.10539-2-kernelfans@gmail.com>
 <20221116133437.GA816333@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116133437.GA816333@lothringen>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 16, 2022 at 02:34:37PM +0100, Frederic Weisbecker wrote:
> On Wed, Nov 16, 2022 at 09:52:44AM +0800, Pingfan Liu wrote:
> > A seq contains two fields: counter and state.
> > 
> > SRCU_SNP_INIT_SEQ is used as invalid initial value for srcu_node GP
> > sequence numbers. Hence srcu_invl_snp_seq() should compare both fields
> > of a seq.
> > 
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Josh Triplett <josh@joshtriplett.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > To: rcu@vger.kernel.org
> > ---
> >  kernel/rcu/srcutree.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 1c304fec89c0..725c82bb0a6a 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -154,7 +154,7 @@ static void init_srcu_struct_data(struct srcu_struct *ssp)
> >   */
> >  static inline bool srcu_invl_snp_seq(unsigned long s)
> >  {
> > -	return rcu_seq_state(s) == SRCU_SNP_INIT_SEQ;
> > +	return s == SRCU_SNP_INIT_SEQ;
> 
> Doesn't hurt and makes it less confusing as it doesn't suggest anymore
> there _might_ be a gp number behind.
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Good catch, thank you both!

My first reaction was that this patch was wrong, so I recorded the
results of my investigation in the commit log.  Please check below in
case I messed something up.

							Thanx, Paul

------------------------------------------------------------------------

commit 08d9c4f609afaf5c3032320d50f2bae4acdca314
Author: Pingfan Liu <kernelfans@gmail.com>
Date:   Wed Nov 16 09:52:44 2022 +0800

    srcu: Fix the comparision in srcu_invl_snp_seq()
    
    A grace-period sequence number contains two fields: counter and
    state.  SRCU_SNP_INIT_SEQ provides a guaranteed invalid value for
    grace-period sequence numbers in newly allocated srcu_node structures'
    ->srcu_have_cbs[] and ->srcu_gp_seq_needed_exp fields.  The point of the
    comparison in srcu_invl_snp_seq() is not to detect invalid grace-period
    sequence numbers in general, but rather to detect a newly allocated
    srcu_node structure whose ->srcu_have_cbs[] and ->srcu_gp_seq_needed_exp
    fields need to be brought into line with the srcu_struct structure's
    ->srcu_gp_seq field.
    
    This commit therefore causes srcu_invl_snp_seq() to compare both fields
    of the specified grace-period sequence number.
    
    Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
    Cc: Lai Jiangshan <jiangshanlai@gmail.com>
    Cc: "Paul E. McKenney" <paulmck@kernel.org>
    Cc: Josh Triplett <josh@joshtriplett.org>
    Cc: Steven Rostedt <rostedt@goodmis.org>
    Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    Cc: <rcu@vger.kernel.org>
    Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 16953784a0bdf..6af0312005801 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -154,7 +154,7 @@ static void init_srcu_struct_data(struct srcu_struct *ssp)
  */
 static inline bool srcu_invl_snp_seq(unsigned long s)
 {
-	return rcu_seq_state(s) == SRCU_SNP_INIT_SEQ;
+	return s == SRCU_SNP_INIT_SEQ;
 }
 
 /*
