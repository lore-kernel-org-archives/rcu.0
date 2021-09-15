Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90E7C433F5
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B007D6112E
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbhIOXe1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Sep 2021 19:34:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229769AbhIOXeY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Sep 2021 19:34:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D78960527;
        Wed, 15 Sep 2021 23:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631748785;
        bh=IB0nzsJWde7gkJ/M7LYqr9QL/W52pOYV0pio0OcOs6c=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=DDAEDl4+Txm0bxOmNXZCg44fXlLuDqu0sWZns82R8u0KmaMqbn7WGlZTws6i1e4SD
         vDD+hcur7s3Utl3TiTmyuPUXNnUKLfso67oNRR8KoMIrIfFd4PhoVK2vhUTwrGAh6M
         i2LP1gHyF1MXpTKxNgv1pllD43DHf4a+QGokjFa6aIpb5pUwYa9FXOY8PFN0j7oPU+
         7TEcGalTTZ7hZz9t8pkv/8HsLBOECZhTirfQ/kk/81Nk/Xk6gRgZAlPSSgbbV0jUpW
         5LomHEm8h0+zv/VGPY2AZJdHFrbHL0LbGAasGruYii/XMN5xVfv+ujPL83ia/xGRjz
         1v9qddxUyItyg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2E4AD5C054E; Wed, 15 Sep 2021 16:33:05 -0700 (PDT)
Date:   Wed, 15 Sep 2021 16:33:05 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH rcu 0/14] Miscellaneous fixes for v5.16
Message-ID: <20210915233305.GA3906641@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series provides miscellaneous fixes:

1.	Mark accesses to rcu_state.n_force_qs.

2.	rcu-nocb: Fix a couple of tree_nocb code-style nits.

3.	Eliminate rcu_implicit_dynticks_qs() local variable rnhqp.

4.	Eliminate rcu_implicit_dynticks_qs() local variable ruqp.

5.	Add another stall-warning root cause in stallwarn.rst.

6.	Fix undefined Kconfig macros, courtesy of Zhouyi Zhou.

7.	Comment rcu_gp_init() code waiting for CPU-hotplug operations.

8.	Move rcu_dynticks_eqs_online() to rcu_cpu_starting().

9.	Simplify rcu_report_dead() call to rcu_report_exp_rdp().

10.	Make rcutree_dying_cpu() use its "cpu" parameter.

11.	Make rcu_normal_after_boot writable again, courtesy of Juri Lelli.

12.	Make rcu update module parameters world-readable, courtesy of
	Juri Lelli.

13.	Fix existing exp request check in sync_sched_exp_online_cleanup(),
	courtesy of Neeraj Upadhyay.

14.	Avoid unneeded function call in rcu_read_unlock(), courtesy of
	Waiman Long.

						Thanx, Paul

------------------------------------------------------------------------

 b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst |   69 ++++------
 b/Documentation/RCU/stallwarn.rst                                       |   10 +
 b/arch/sh/configs/sdk7786_defconfig                                     |    1 
 b/arch/xtensa/configs/nommu_kc705_defconfig                             |    1 
 b/include/linux/rcupdate.h                                              |    3 
 b/kernel/rcu/rcutorture.c                                               |    2 
 b/kernel/rcu/tree.c                                                     |   10 -
 b/kernel/rcu/tree_exp.h                                                 |    1 
 b/kernel/rcu/tree_nocb.h                                                |    2 
 b/kernel/rcu/tree_plugin.h                                              |    3 
 b/kernel/rcu/update.c                                                   |    2 
 kernel/rcu/tree.c                                                       |   24 +--
 kernel/rcu/tree_exp.h                                                   |    2 
 kernel/rcu/update.c                                                     |    6 
 14 files changed, 67 insertions(+), 69 deletions(-)
