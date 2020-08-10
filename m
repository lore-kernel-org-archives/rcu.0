Return-Path: <SRS0=7B7l=BU=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA41C433DF
	for <rcu@archiver.kernel.org>; Mon, 10 Aug 2020 18:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82F0C20829
	for <rcu@archiver.kernel.org>; Mon, 10 Aug 2020 18:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597082810;
	bh=skTlBedsUdXXwu9qhOnpSxT61c1G3PJ8Hnx8e7a0Hjs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=ifhD3EHUeicC8DYx1RZuo0DwN+oxiCCE//09Swh4MsbEdaJO8WdsLiXQlo+efo+Gm
	 99o1jyrebWUkLQuFGIW4ru4TxIX6IeFzsv46g5gzi6OhHtYAYQlgQcgEqINCMWXV1t
	 uNYTCYFLeS0c7hobhipz1+j9y5No8aoOviGvHbjE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgHJSGu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 10 Aug 2020 14:06:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:47148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728050AbgHJSGt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 10 Aug 2020 14:06:49 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 468B82080C;
        Mon, 10 Aug 2020 18:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597082808;
        bh=skTlBedsUdXXwu9qhOnpSxT61c1G3PJ8Hnx8e7a0Hjs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=0ARIYGRrgnTHwYQhxwiFRe5qenPjQcsrzk/QazsEeJ/eG8JKtZ+FwqQzdMRlr/vHK
         VmqdD2rQBPk5aEDjGbC0sw2Gmdkafz9YXdDU9i4mGSdR2ily3vVKB3hPtzc9y1WEYT
         M9GYTZtEq6WEEdZROLE0uhCkXFHaf+WdH/wfKm3g=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E7BB235228C7; Mon, 10 Aug 2020 11:06:47 -0700 (PDT)
Date:   Mon, 10 Aug 2020 11:06:47 -0700
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
Subject: Re: [PATCH v4 2/5] rcu/tree: Clarify comments about FQS loop
 reporting quiescent states
Message-ID: <20200810180647.GN4295@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200807170722.2897328-1-joel@joelfernandes.org>
 <20200807170722.2897328-3-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807170722.2897328-3-joel@joelfernandes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Aug 07, 2020 at 01:07:19PM -0400, Joel Fernandes (Google) wrote:
> At least since v4.19, the FQS loop no longer reports quiescent states
> for offline CPUs unless it is an emergency.
> 
> This commit therefore fixes the comment in rcu_gp_init() to match the
> current code.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index a49fa3b60faa..2fb66cdbfa25 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1701,9 +1701,11 @@ static bool rcu_gp_init(void)
>  
>  	/*
>  	 * Apply per-leaf buffered online and offline operations to the
> -	 * rcu_node tree.  Note that this new grace period need not wait
> -	 * for subsequent online CPUs, and that quiescent-state forcing
> -	 * will handle subsequent offline CPUs.
> +	 * rcu_node tree. Note that this new grace period need not wait for
> +	 * subsequent online CPUs, and that RCU hooks in the CPU offlining
> +	 * path, when combined with checks in this function, will handle CPUs
> +	 * that are currently going offline or that go offline later. Refer to
> +	 * RCU's Requirements documentation about hotplug requirements as well.
>  	 */
>  	rcu_state.gp_state = RCU_GP_ONOFF;
>  	rcu_for_each_leaf_node(rnp) {

Very good!  I pulled this in with light edits as shown below.
Please let me know if I messed something up.

							Thanx, Paul

------------------------------------------------------------------------

commit a6117399840b963f90cc5322ef9ea7c52de639b2
Author: Joel Fernandes (Google) <joel@joelfernandes.org>
Date:   Fri Aug 7 13:07:19 2020 -0400

    rcu/tree: Clarify comments about FQS loop reporting quiescent states
    
    Since at least v4.19, the FQS loop no longer reports quiescent states
    for offline CPUs except in emergency situations.
    
    This commit therefore fixes the comment in rcu_gp_init() to match the
    current code.
    
    Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index bcc6160..59e1943 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1730,10 +1730,13 @@ static bool rcu_gp_init(void)
 	raw_spin_unlock_irq_rcu_node(rnp);
 
 	/*
-	 * Apply per-leaf buffered online and offline operations to the
-	 * rcu_node tree.  Note that this new grace period need not wait
-	 * for subsequent online CPUs, and that quiescent-state forcing
-	 * will handle subsequent offline CPUs.
+	 * Apply per-leaf buffered online and offline operations to
+	 * the rcu_node tree. Note that this new grace period need not
+	 * wait for subsequent online CPUs, and that RCU hooks in the CPU
+	 * offlining path, when combined with checks in this function,
+	 * will handle CPUs that are currently going offline or that will
+	 * go offline later.  Please also refer to "Hotplug CPU" section
+	 * of RCU's Requirements documentation.
 	 */
 	rcu_state.gp_state = RCU_GP_ONOFF;
 	rcu_for_each_leaf_node(rnp) {
