Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF52C43217
	for <rcu@archiver.kernel.org>; Tue, 29 Nov 2022 00:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbiK2All (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 28 Nov 2022 19:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234129AbiK2All (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 28 Nov 2022 19:41:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4D431363
        for <rcu@vger.kernel.org>; Mon, 28 Nov 2022 16:41:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D80AB810D2
        for <rcu@vger.kernel.org>; Tue, 29 Nov 2022 00:41:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD24C433D6;
        Tue, 29 Nov 2022 00:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669682497;
        bh=ceUcVowPshm5B9d/KCt9iSX1cxOOW+VlbBBFb3U6zzM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NXuwFZQKXjTIDUSVulujjta+P0oAjvkZ+6NW15OoIBy3Xnj+TP33nS7ojKP5pFmDu
         KKGQ4ShgsVQg3Narx5tkkDZep5+joKSg9vGMliBRG/xk8bUQeShgiEvaAeoTHurE2d
         iRbA2D6rm81DR8iaS+5s3/HAQAgXU1EGx6xoKX3BrX8J/Hy15QVguXTVWBiMXwXdWP
         kPqTr2G5gT5LmgbtvwKCgpCXjYUndvuUD82oXSeLgL0nJgLOKrmkzJWDBJNM0gXIIZ
         RgxIghKy7HgCV76q/aoc7ec0QYyb+aasszTtzhCoBLz1oBqDdwCJxvLqw41ACUMYKI
         gj5vKNOA+KK/w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 870165C0EBE; Mon, 28 Nov 2022 16:41:37 -0800 (PST)
Date:   Mon, 28 Nov 2022 16:41:37 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 1/3] srcu: Eliminate the requirement of
 SRCU_SIZE_WAIT_CALL
Message-ID: <20221129004137.GR4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221128082816.28518-1-kernelfans@gmail.com>
 <20221128082816.28518-2-kernelfans@gmail.com>
 <PH0PR11MB5880CEEA5D2CD0F7AF21E954DA139@PH0PR11MB5880.namprd11.prod.outlook.com>
 <Y4S/JLoILJZMCj9N@piliu.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4S/JLoILJZMCj9N@piliu.users.ipa.redhat.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Nov 28, 2022 at 10:01:08PM +0800, Pingfan Liu wrote:
> On Mon, Nov 28, 2022 at 08:40:22AM +0000, Zhang, Qiang1 wrote:
> > >The state SRCU_SIZE_WAIT_CALL is only used in srcu_gp_start_if_needed().
> > >And it is not needed. Because counter_wrap_check has guarantee that both
> > >srcu_gp_seq_needed and srcu_gp_seq_needed_exp are not far behind
> > >srcu_gp_seq and no false alarm will be raised by the statement in
> > >srcu_gp_start_if_needed()
> > >
> > >  ULONG_CMP_LT(sdp->srcu_gp_seq_needed, s)
> > >
> > >As a result, once if SRCU_SIZE_WAIT_BARRIER is seen, the tree snp can be
> > >used immediately, not need to wait for another srcu_gp_end() to update
> > >the srcu_gp_seq_needed and srcu_gp_seq_needed_exp to avoid false alarm.
> > >
> > >Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > >Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > >Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > >Cc: Frederic Weisbecker <frederic@kernel.org>
> > >Cc: Josh Triplett <josh@joshtriplett.org>
> > >Cc: Steven Rostedt <rostedt@goodmis.org>
> > >Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > >Cc: "Zhang, Qiang1" <qiang1.zhang@intel.com>
> > >To: rcu@vger.kernel.org
> > >---
> > > kernel/rcu/srcutree.c | 2 +-
> > > 1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > >diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > >index 1c304fec89c0..fe0759d89c2d 100644
> > >--- a/kernel/rcu/srcutree.c
> > >+++ b/kernel/rcu/srcutree.c
> > >@@ -1092,7 +1092,7 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
> > > 	check_init_srcu_struct(ssp);
> > > 	idx = srcu_read_lock(ssp);
> > > 	ss_state = smp_load_acquire(&ssp->srcu_size_state);
> > >-	if (ss_state < SRCU_SIZE_WAIT_CALL)
> > >+	if (ss_state < SRCU_SIZE_WAIT_BARRIER)
> > > 		sdp = per_cpu_ptr(ssp->sda, 0);
> > 
> > Hi Pingfan
> > 
> > should it be used get_boot_cpu_id() ?
> 
> I am not sure which branch to work on.

For RCU patches, the "dev" branch of the -rcu tree.

For more information, please see:

https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/rcutodo.html

							Thanx, Paul

> Thanks,
> 
> 	Pingfan
> 
> > Thanks
> > Zqiang
> > 
> > > 	else
> > > 		sdp = raw_cpu_ptr(ssp->sda);
> > >-- 
> > >2.31.1
> > >
