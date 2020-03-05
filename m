Return-Path: <SRS0=zrtj=4W=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39076C3F2D2
	for <rcu@archiver.kernel.org>; Thu,  5 Mar 2020 23:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C1A92073D
	for <rcu@archiver.kernel.org>; Thu,  5 Mar 2020 23:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583449517;
	bh=/uN/iTHL6I/M/EGCk/QkrLekpa8ZZrr3ESI5UAiygR0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=xQQ4FnQo1FnjtRzuZhXVQxxMawgvB3Hluu871gkgoOM+oBDJsghi73cL5NHP+jaOA
	 6SlQ//Z/J/nfxOBk95csyhs1sJD/Zt5NI9V4Xg4P+mXRmqMKQkWaba1RzxuI0KqEvf
	 vN1D736TWe1jgdg6na7h9qJ0dj6cgGXxHQWTJb1g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgCEXFQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Mar 2020 18:05:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:60034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbgCEXFQ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Mar 2020 18:05:16 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB0D420717;
        Thu,  5 Mar 2020 23:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583449515;
        bh=/uN/iTHL6I/M/EGCk/QkrLekpa8ZZrr3ESI5UAiygR0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tBOsVFr+IZkZ/paKK0QkacpYgr+JAFx1tGKGv6z/6qZLS4+l5qCjmcqXbiBJydcGY
         3FID+5vIxy7KZc4UBdaBJJwm2zkCSPBoUYEXKzu7T/ozzc+OKATTXuqyCDEnt1D3d+
         tQW/0IuJ6ryH4/zN6BJKppl+2HwTOL+EMlmLRvqg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 9779C3522806; Thu,  5 Mar 2020 15:05:15 -0800 (PST)
Date:   Thu, 5 Mar 2020 15:05:15 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zhaolong Zhang <zhangzl2013@126.com>
Cc:     Zhaolong Zhang <zhangzl2013@126.com.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Fix the (t=0 jiffies) false positive
Message-ID: <20200305230515.GN2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <1583394357-11767-1-git-send-email-zhangzl2013@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583394357-11767-1-git-send-email-zhangzl2013@126.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Mar 05, 2020 at 03:45:57PM +0800, Zhaolong Zhang wrote:
> Calculate 't' with the previously recorded 'gps' instead of 'gp_start'.
> 
> Signed-off-by: Zhaolong Zhang <zhangzl2013@126.com>

Good catch, thank you!

I had to apply this by hand.  My guess is that you developed against
mainline rather than the "dev" branch of the -rcu tree:

git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git

Or perhaps your email client corrupted the patch?

Regardless, please check the version below and let me know if I messed
anything up.

							Thanx, Paul

------------------------------------------------------------------------

commit 7dd581bbbcc00246fec35eda60add4b32200b0a0
Author: Zhaolong Zhang <zhangzl2013@126.com>
Date:   Thu Mar 5 14:56:11 2020 -0800

    rcu: Fix the (t=0 jiffies) false positive
    
    It is possible that an over-long grace period will end while the RCU
    CPU stall warning message is printing.  In this case, the estimate of
    the offending grace period's duration can be erroneous due to refetching
    of rcu_state.gp_start, which will now be the time of the newly started
    grace period.  Computation of this duration clearly needs to use the
    start time for the old over-long grace period, not the fresh new one.
    This commit avoids such errors by causing both print_other_cpu_stall() and
    print_cpu_stall() to reuse the value previously fetched by their caller.
    
    Signed-off-by: Zhaolong Zhang <zhangzl2013@126.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index b17cd9b..502b4dd 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -371,7 +371,7 @@ static void rcu_check_gp_kthread_starvation(void)
 	}
 }
 
-static void print_other_cpu_stall(unsigned long gp_seq)
+static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 {
 	int cpu;
 	unsigned long flags;
@@ -408,7 +408,7 @@ static void print_other_cpu_stall(unsigned long gp_seq)
 	for_each_possible_cpu(cpu)
 		totqlen += rcu_get_n_cbs_cpu(cpu);
 	pr_cont("\t(detected by %d, t=%ld jiffies, g=%ld, q=%lu)\n",
-	       smp_processor_id(), (long)(jiffies - rcu_state.gp_start),
+	       smp_processor_id(), (long)(jiffies - gps),
 	       (long)rcu_seq_current(&rcu_state.gp_seq), totqlen);
 	if (ndetected) {
 		rcu_dump_cpu_stacks();
@@ -442,7 +442,7 @@ static void print_other_cpu_stall(unsigned long gp_seq)
 	rcu_force_quiescent_state();  /* Kick them all. */
 }
 
-static void print_cpu_stall(void)
+static void print_cpu_stall(unsigned long gps)
 {
 	int cpu;
 	unsigned long flags;
@@ -467,7 +467,7 @@ static void print_cpu_stall(void)
 	for_each_possible_cpu(cpu)
 		totqlen += rcu_get_n_cbs_cpu(cpu);
 	pr_cont("\t(t=%lu jiffies g=%ld q=%lu)\n",
-		jiffies - rcu_state.gp_start,
+		jiffies - gps,
 		(long)rcu_seq_current(&rcu_state.gp_seq), totqlen);
 
 	rcu_check_gp_kthread_starvation();
@@ -546,7 +546,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
 	    cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
 
 		/* We haven't checked in, so go dump stack. */
-		print_cpu_stall();
+		print_cpu_stall(gps);
 		if (rcu_cpu_stall_ftrace_dump)
 			rcu_ftrace_dump(DUMP_ALL);
 
@@ -555,7 +555,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
 		   cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
 
 		/* They had a few time units to dump stack, so complain. */
-		print_other_cpu_stall(gs2);
+		print_other_cpu_stall(gs2, gps);
 		if (rcu_cpu_stall_ftrace_dump)
 			rcu_ftrace_dump(DUMP_ALL);
 	}
