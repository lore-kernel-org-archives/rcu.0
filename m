Return-Path: <SRS0=Gqt/=DB=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE62C4346E
	for <rcu@archiver.kernel.org>; Thu, 24 Sep 2020 23:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB6BC23600
	for <rcu@archiver.kernel.org>; Thu, 24 Sep 2020 23:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600988401;
	bh=FnlDJ4w2Wp7B+ooR/U+JqMBTHrFYFwOTHlid0jHxpp0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=pjbTVblTZJ8esg0nOxT8J0NVbGUjow9+b496GSkEZ6YLod05muc0jilPTqpttjJaG
	 PtkEsayBSfWYMOydtxI638w80uKcI67EwgX6jw1nfCSXHF9b2PRqphjnJ2F0SF2Myj
	 itUWRWYFVLdaMtL9paxu/eXfs2GMTpwa7BIvCA3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgIXXAA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 24 Sep 2020 19:00:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbgIXXAA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 24 Sep 2020 19:00:00 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E75782344C;
        Thu, 24 Sep 2020 22:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600988399;
        bh=FnlDJ4w2Wp7B+ooR/U+JqMBTHrFYFwOTHlid0jHxpp0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BoKgzIPcUFGxxWG1d0l4lyQ9LcVunTMUK+FQSYmr9qH3iwtZ7pKeS49P3OGiw4mWW
         tgStj13sQxhdQGeFuZPs/3TZ3RAR53f/77sWn7BTAoGmHAuQTUtPu3SGJjX/fazSmd
         6yXWIW+X6fNRSRAhc0nmuaactMyCyyk7R8Iyfdpg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B2C9435230AC; Thu, 24 Sep 2020 15:59:59 -0700 (PDT)
Date:   Thu, 24 Sep 2020 15:59:59 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Clarify nocb kthreads naming in RCU_NOCB_CPU config
Message-ID: <20200924225959.GY29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <1600929250-20344-1-git-send-email-neeraju@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600929250-20344-1-git-send-email-neeraju@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Sep 24, 2020 at 12:04:10PM +0530, Neeraj Upadhyay wrote:
> Clarify the "x" in rcuox/N naming in RCU_NOCB_CPU config
> description.
> 
> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>

Applied with a few additional updates as shown below.  As always, please
let me know if I messed anything up.

							Thanx, Paul

------------------------------------------------------------------------

commit 8d1d776b4998896a6f8f4608edb0b258bd37ec9f
Author: Neeraj Upadhyay <neeraju@codeaurora.org>
Date:   Thu Sep 24 12:04:10 2020 +0530

    rcu: Clarify nocb kthreads naming in RCU_NOCB_CPU config
    
    This commit clarifies that the "p" and the "s" in the in the RCU_NOCB_CPU
    config-option description refer to the "x" in the "rcuox/N" kthread name.
    
    Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
    [ paulmck: While in the area, update description and advice. ]
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index b71e21f..cdc57b4 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -221,19 +221,23 @@ config RCU_NOCB_CPU
 	  Use this option to reduce OS jitter for aggressive HPC or
 	  real-time workloads.	It can also be used to offload RCU
 	  callback invocation to energy-efficient CPUs in battery-powered
-	  asymmetric multiprocessors.
+	  asymmetric multiprocessors.  The price of this reduced jitter
+	  is that the overhead of call_rcu() increases and that some
+	  workloads will incur significant increases in context-switch
+	  rates.
 
 	  This option offloads callback invocation from the set of CPUs
 	  specified at boot time by the rcu_nocbs parameter.  For each
 	  such CPU, a kthread ("rcuox/N") will be created to invoke
 	  callbacks, where the "N" is the CPU being offloaded, and where
-	  the "p" for RCU-preempt (PREEMPTION kernels) and "s" for RCU-sched
-	  (!PREEMPTION kernels).  Nothing prevents this kthread from running
-	  on the specified CPUs, but (1) the kthreads may be preempted
-	  between each callback, and (2) affinity or cgroups can be used
-	  to force the kthreads to run on whatever set of CPUs is desired.
-
-	  Say Y here if you want to help to debug reduced OS jitter.
+	  the "x" is "p" for RCU-preempt (PREEMPTION kernels) and "s" for
+	  RCU-sched (!PREEMPTION kernels).  Nothing prevents this kthread
+	  from running on the specified CPUs, but (1) the kthreads may be
+	  preempted between each callback, and (2) affinity or cgroups can
+	  be used to force the kthreads to run on whatever set of CPUs is
+	  desired.
+
+	  Say Y here if you need reduced OS jitter, despite added overhead.
 	  Say N here if you are unsure.
 
 config TASKS_TRACE_RCU_READ_MB
