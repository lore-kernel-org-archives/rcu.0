Return-Path: <SRS0=7B7l=BU=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640EFC433E0
	for <rcu@archiver.kernel.org>; Mon, 10 Aug 2020 20:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 234C22073A
	for <rcu@archiver.kernel.org>; Mon, 10 Aug 2020 20:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597093017;
	bh=pum/l0HZs+kYzU3nToNYXCbY1WcpAwrT1CrspgU1jXY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=OkbvKsYtsiXjVVzE/wrY0fhZsw8V2QhIH1b60uWmuTbnxloHNJbv19cYKDLkNNbB+
	 GK21eqJfNqWBecqUyQq3oCne93BkzhSBWYa5K1oyBZuwo9RfeuuMJxIC94ZSMQUofU
	 P6gviyKl4a2wS+ObbnBaGiPRN5e2T1PmAKhWSXcU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgHJU44 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 10 Aug 2020 16:56:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:49734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbgHJU44 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 10 Aug 2020 16:56:56 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D80B20716;
        Mon, 10 Aug 2020 20:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597093015;
        bh=pum/l0HZs+kYzU3nToNYXCbY1WcpAwrT1CrspgU1jXY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tKm15NRiXzWMySEGdhssl0BukbdYKt/AJVy91KvXvmuA8mihfBAteoT3MGn2wh/EB
         kKbKVje9DyeNu18RWZ4GpQXjUw9HxXomk8N3xWGhQduo6/gKrQA5owDzuY4Ak4iIhL
         iXdKaxSPvGTSA/ffzlX3p8FORoJOnnKAqi9zLv68=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 50DDD35228C7; Mon, 10 Aug 2020 13:56:55 -0700 (PDT)
Date:   Mon, 10 Aug 2020 13:56:55 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        neeraju@codeaurora.org, peterz@infradead.org,
        Randy Dunlap <rdunlap@infradead.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, tglx@linutronix.de,
        vineethrp@gmail.com
Subject: Re: [PATCH v4 3/5] rcu/tree: Make FQS complaining about offline CPU
 more aggressive
Message-ID: <20200810205655.GA17709@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200807170722.2897328-1-joel@joelfernandes.org>
 <20200807170722.2897328-4-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807170722.2897328-4-joel@joelfernandes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Aug 07, 2020 at 01:07:20PM -0400, Joel Fernandes (Google) wrote:
> The FQS loop detecting that an offline CPU has not yet reported a
> quiescent state, is a serious problem. The current interaction between
> RCU quiescent-state reporting and CPU-hotplug operations means that the
> FQS loop should never find that an offline CPU (by RCU's understanding
> of what is offline or not) has not yet reported a quiescent state.
> 
> First, the outgoing CPU explicitly reports a quiescent state if needed
> in rcu_report_dead().  Second, the race where the CPU is leaving just as
> RCU is initializing a new grace period is handled by an explicit check
> for this condition in rcu_gp_init().  Third, the CPU's leaf rcu_node
> structure's ->lock serializes these modifications and checks.
> 
> At the moment, the FQS loop detections this anomaly but only reports it
> after a second has elapsed.
> 
> This commit therefore makes the warning more aggressive such that we fail
> immediately when the FQS loop scan happens and bring the problem to
> everyone's attention.
> 
> Light testing with TREE03 and hotplug shows no warnings. Converted the
> warning as well to WARN_ON_ONCE() to reduce log spam.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Looks good, queued, thank you!

I did a bit of editing as shown below.  Please let me know if I messed
anything up.

							Thanx, Paul

------------------------------------------------------------------------

commit 61b82b349d0089120a9705240ece6ecf2b176fd5
Author: Joel Fernandes (Google) <joel@joelfernandes.org>
Date:   Fri Aug 7 13:07:20 2020 -0400

    rcu: Make FQS more aggressive in complaining about offline CPUs
    
    The RCU grace-period kthread's force-quiescent state (FQS) loop should
    never see an offline CPU that has not yet reported a quiescent state.
    After all, the offline CPU should have reported a quiescent state
    during the CPU-offline process, or, failing that, by rcu_gp_init()
    if it ran concurrently with either the CPU going offline or the last
    task on a leaf rcu_node structure exiting its RCU read-side critical
    section while all CPUs corresponding to that structure are offline.
    The FQS loop should therefore complain if it does see an offline CPU
    that has not yet reported a quiescent state.
    
    And it does, but only once the grace period has been in force for a
    full second.  This commit therefore makes this warning more aggressive,
    so that it will trigger as soon as the condition makes its appearance.
    
    Light testing with TREE03 and hotplug shows no warnings.  This commit
    also converts the warning to WARN_ON_ONCE() in order to stave off possible
    log spam.
    
    Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 59e1943..f79827b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1215,13 +1215,28 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 		return 1;
 	}
 
-	/* If waiting too long on an offline CPU, complain. */
-	if (!(rdp->grpmask & rcu_rnp_online_cpus(rnp)) &&
-	    time_after(jiffies, rcu_state.gp_start + HZ)) {
+	/*
+	 * Complain if a CPU that is considered to be offline from RCU's
+	 * perspective has not yet reported a quiescent state.  After all,
+	 * the offline CPU should have reported a quiescent state during
+	 * the CPU-offline process, or, failing that, by rcu_gp_init()
+	 * if it ran concurrently with either the CPU going offline or the
+	 * last task on a leaf rcu_node structure exiting its RCU read-side
+	 * critical section while all CPUs corresponding to that structure
+	 * are offline.  This added warning detects bugs in any of these
+	 * code paths.
+	 *
+	 * The rcu_node structure's ->lock is held here, which excludes
+	 * the relevant portions the CPU-hotplug code, the grace-period
+	 * initialization code, and the rcu_read_unlock() code paths.
+	 *
+	 * For more detail, please refer to the "Hotplug CPU" section
+	 * of RCU's Requirements documentation.
+	 */
+	if (WARN_ON_ONCE(!(rdp->grpmask & rcu_rnp_online_cpus(rnp)))) {
 		bool onl;
 		struct rcu_node *rnp1;
 
-		WARN_ON(1);  /* Offline CPUs are supposed to report QS! */
 		pr_info("%s: grp: %d-%d level: %d ->gp_seq %ld ->completedqs %ld\n",
 			__func__, rnp->grplo, rnp->grphi, rnp->level,
 			(long)rnp->gp_seq, (long)rnp->completedqs);
