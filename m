Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FBFC43381
	for <rcu@archiver.kernel.org>; Tue, 12 Jan 2021 17:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CF1622285
	for <rcu@archiver.kernel.org>; Tue, 12 Jan 2021 17:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391048AbhALRb6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 12 Jan 2021 12:31:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:35470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390830AbhALRb5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 12 Jan 2021 12:31:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 129F422285;
        Tue, 12 Jan 2021 17:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610472677;
        bh=2rtS6uWKjT5K9+O0W2KiU057A8zn83RW2iQiRjNkKh0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ArdbvRuOb8ANvAEO/4CxXEx3o8mLWTZ7GLmTSam3S9RmkcnRryYRNeyTWl5nJlImw
         pnkX0oNcby+nRx8andK3xI0ukpVysDgA6k9hqRsBwfVUGdl1dywKDalWS3Pc1+qOPD
         Zi0atRm70E06ZccVJUhMYd1Fbwf6o46Oy0ml3JgLWZ2PsLWd9EIdKA++4A35RCvJzI
         PkofQ7mv152xpXWuCJK80OVpC+xnEI7jYnDVWV5II5oWXFHIHJeKUUyUQ4TKp5pgfB
         PrdsL/dWPz7Vqy/JFJLIzvd8VFnQgcDDH7yh1Rfu2DYge7ijoNTad4B7EBM8DPdMpQ
         CULUTq+Pkyx2g==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D3FA1352264C; Tue, 12 Jan 2021 09:31:16 -0800 (PST)
Date:   Tue, 12 Jan 2021 09:31:16 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Correct cpu offline trace in rcutree_dying_cpu
Message-ID: <20210112173116.GG2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <1610365558-8330-1-git-send-email-neeraju@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610365558-8330-1-git-send-email-neeraju@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jan 11, 2021 at 05:15:58PM +0530, Neeraj Upadhyay wrote:
> Correctly trace whether the outgoing cpu blocks current gp in
> rcutree_dying_cpu().
> 
> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>

Good catch, queued, thank you!  Please see below for my usual
wordsmithing, and please lat me know if I messed something up.

							Thanx, Paul

------------------------------------------------------------------------

commit ab6e7609e7590e1bb220ef6b0822a823dde46f6c
Author: Neeraj Upadhyay <neeraju@codeaurora.org>
Date:   Mon Jan 11 17:15:58 2021 +0530

    rcu: Fix CPU-offline trace in rcutree_dying_cpu
    
    The condition in the trace_rcu_grace_period() in rcutree_dying_cpu() is
    backwards, so that it uses the string "cpuofl" when the offline CPU is
    blocking the current grace period and "cpuofl-bgp" otherwise.  Given that
    the "-bgp" stands for "blocking grace period", this is at best misleading.
    This commit therefore switches these strings in order to correctly trace
    whether the outgoing cpu blocks the current grace period.
    
    Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index cc6b6fc..63c6dba 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2387,7 +2387,7 @@ int rcutree_dying_cpu(unsigned int cpu)
 
 	blkd = !!(rnp->qsmask & rdp->grpmask);
 	trace_rcu_grace_period(rcu_state.name, READ_ONCE(rnp->gp_seq),
-			       blkd ? TPS("cpuofl") : TPS("cpuofl-bgp"));
+			       blkd ? TPS("cpuofl-bgp") : TPS("cpuofl"));
 	return 0;
 }
 
