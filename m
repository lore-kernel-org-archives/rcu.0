Return-Path: <SRS0=LAXB=AD=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A956C433E0
	for <rcu@archiver.kernel.org>; Mon, 22 Jun 2020 22:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4568E2075A
	for <rcu@archiver.kernel.org>; Mon, 22 Jun 2020 22:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592866437;
	bh=aniZpcUjMLL1QVC8MdE4cj/DV6qxXRy9tU6pZJwm1U8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=zoKbiYEqmd+XxH2PmD50yVDtyZRxQTfUKgDB8006nBQDq41jlYHw8xPkcIAeUTIYA
	 hNxRiqDKOuTN9I3QDnjAaVdijaVO4d4gZS1e9Y/AhCeUW6+iGjGRk4TYmWJNuvSJyT
	 IC2RQdYi7nI2Ex0ivv0rSqWt50QW25ETLTOn79y0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730970AbgFVWx5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 18:53:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730934AbgFVWx4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 18:53:56 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ED3720738;
        Mon, 22 Jun 2020 22:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592866436;
        bh=aniZpcUjMLL1QVC8MdE4cj/DV6qxXRy9tU6pZJwm1U8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dre2VRTHReSnQKn+Uw94A0GlJc3bXOZKkXpB7UtE/cAT7AOE83lUuFXpbq7V0msNV
         D0sprullDl5w6gObAHJc2wQqFc4ckZ/ybV5u36AzOQY/gakBd5bPHw8F8cRFztfi0/
         7Q/jggMpzehAw6GyNhMtwDrjT0Qe9n+8rMyVdr44=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5778A352306A; Mon, 22 Jun 2020 15:53:56 -0700 (PDT)
Date:   Mon, 22 Jun 2020 15:53:56 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/tree: Force quiescent state on callback overload
Message-ID: <20200622225356.GT9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <1592764647-2452-1-git-send-email-neeraju@codeaurora.org>
 <20200621195052.GF9247@paulmck-ThinkPad-P72>
 <94686c2e-b589-2598-e658-42f13cec1216@codeaurora.org>
 <20200622031325.GG9247@paulmck-ThinkPad-P72>
 <b72302b1-f49a-84fb-6bb9-75dd5f16bd2c@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b72302b1-f49a-84fb-6bb9-75dd5f16bd2c@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jun 22, 2020 at 09:16:24AM +0530, Neeraj Upadhyay wrote:
> Hi Paul,
> 
> On 6/22/2020 8:43 AM, Paul E. McKenney wrote:
> > On Mon, Jun 22, 2020 at 01:30:31AM +0530, Neeraj Upadhyay wrote:
> > > Hi Paul,
> > > 
> > > On 6/22/2020 1:20 AM, Paul E. McKenney wrote:
> > > > On Mon, Jun 22, 2020 at 12:07:27AM +0530, Neeraj Upadhyay wrote:
> > > > > On callback overload, we want to force quiescent state immediately,
> > > > > for the first and second fqs. Enforce the same, by including
> > > > > RCU_GP_FLAG_OVLD flag, in fqsstart check.
> > > > > 
> > > > > Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> > > > 
> > > > Good catch!
> > > > 
> > > > But what did you do to verify that this change does the right thing?
> > > > 
> > > > 						Thanx, Paul
> > > > 
> > > 
> > > I haven't done a runtime verification of this code path; I posted this,
> > > based on review of this code.
> > 
> > My concern is that under overload, the FQS scans would happen continuously
> > rather than accelerating only the first such scan in a given grace period.
> > This would of course result in a CPU-bound grace-period kthread, which
> > users might not be all that happy with.
> > 
> > Or am I missing something subtle that prevents this?
> 
> Looks like under overload, only the first and second scans are accelerated?
> 
>     gf = 0;
>     if (first_gp_fqs) {
>          first_gp_fqs = false;
>           gf = rcu_state.cbovld ? RCU_GP_FLAG_OVLD : 0;
>     }

Very good, it does sound like you understand this, and it matches my
analysis and passes light testing, so I queued this one.  I did improve
the commit log, please check below.  The added detail is helpful to people
(including ourselves, by the way) who might need to look at this commit
some time in the future.

If you have an x86 system lying around, running rcutorture is quite
straightforward.  Non-x86 systems can also run rcutorture, if nothing
else by using modprobe and rmmod as described here:

https://paulmck.livejournal.com/57769.html

The scripting described in the latter part of this document has worked
on ARMv8 and PowerPC, and might still work for all I know.

						Thanx, Paul

------------------------------------------------------------------------

commit 9482524d7dd0aea5d32a6efa2979223eea07c029
Author: Neeraj Upadhyay <neeraju@codeaurora.org>
Date:   Mon Jun 22 00:07:27 2020 +0530

    rcu/tree: Force quiescent state on callback overload
    
    On callback overload, it is necessary to quickly detect idle CPUs,
    and rcu_gp_fqs_check_wake() checks for this condition.  Unfortunately,
    the code following the call to this function does not repeat this check,
    which means that in reality no actual quiescent-state forcing, instead
    only a couple of quick and pointless wakeups at the beginning of the
    grace period.
    
    This commit therefore adds a check for the RCU_GP_FLAG_OVLD flag in
    the post-wakeup "if" statement in rcu_gp_fqs_loop().
    
    Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d0988a1..6226bfb 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1865,7 +1865,7 @@ static void rcu_gp_fqs_loop(void)
 			break;
 		/* If time for quiescent-state forcing, do it. */
 		if (!time_after(rcu_state.jiffies_force_qs, jiffies) ||
-		    (gf & RCU_GP_FLAG_FQS)) {
+		    (gf & (RCU_GP_FLAG_FQS | RCU_GP_FLAG_OVLD))) {
 			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
 					       TPS("fqsstart"));
 			rcu_gp_fqs(first_gp_fqs);
