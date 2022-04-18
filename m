Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44ACAC433FE
	for <rcu@archiver.kernel.org>; Mon, 18 Apr 2022 22:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbiDRW4a (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 18 Apr 2022 18:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbiDRW42 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 18 Apr 2022 18:56:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8352C65B;
        Mon, 18 Apr 2022 15:53:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0906FB81135;
        Mon, 18 Apr 2022 22:53:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5DCFC385A1;
        Mon, 18 Apr 2022 22:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650322425;
        bh=aRxVUvdVuSvQxry8iFf6qzP+10KdC41EHHSuZ+WfK6M=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=i2/TvsLkq+AxsmWVqOcUxvJnNTNvk1k+quY3rfDGD4h6/wBwUoakvkybQ7BFMz8Vy
         jl98fnX0dN+JUurtYaka2ui4WKGVb6q/zQKX8rfie1a9zDEqBgMBGBWJNSalxHTiE8
         xZ3t+y25FdKFDPi+Sjq6I1Hyrnrww1jgZNuhdHe609+rbBzpfqwPHlw6Z81KCg8HMX
         lRB6OMSw6BIBX94TwkmEMaXsPhgx7DUh6trXkkz66ZnXMDV6hzKpiOZEyUmQXLuLYM
         48AGpzB2v5I7ETqOiNB2DMCHYY3f0Ie/9TU2iI4IzWf3Gm1L8nKwj7i0kQVh9J9w2Q
         2veBmgO53E0Xg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6AF825C04BD; Mon, 18 Apr 2022 15:53:45 -0700 (PDT)
Date:   Mon, 18 Apr 2022 15:53:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/11] Miscellaneous fixes for v5.19
Message-ID: <20220418225345.GA3945110@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series contains miscellaneous fixes:

1.	Clarify fill-the-gap comment in rcu_segcblist_advance().

2.	Fix rcu_preempt_deferred_qs_irqrestore() strict QS reporting.

3.	Check for jiffies going backwards.

4.	Provide boot-time timeout for CSD lock diagnostics.

5.	Add comments to final rcu_gp_cleanup() "if" statement.

6.	Print number of online CPUs in RCU CPU stall-warning messages.

7.	Fix preemption mode check on synchronize_rcu[_expedited](),
	courtesy of Frederic Weisbecker.

8.	Drop needless initialization of sdp in srcu_gp_start(), courtesy
	of Lukas Bulwahn.

9.	Check for successful spawn of ->boost_kthread_task, courtesy
	of Zqiang.

10.	rcu_sync: Fix comment to properly reflect rcu_sync_exit()
	behavior, courtesy of David Vernet.

11.	Use IRQ_WORK_INIT_HARD() to avoid rcu_read_unlock() hangs,
	courtesy of Zqiang.

						Thanx, Paul

------------------------------------------------------------------------

 b/Documentation/admin-guide/kernel-parameters.txt |   11 ++++++++
 b/kernel/rcu/rcu_segcblist.c                      |    8 +++---
 b/kernel/rcu/srcutree.c                           |    2 -
 b/kernel/rcu/sync.c                               |    2 -
 b/kernel/rcu/tree.c                               |   10 +++++++
 b/kernel/rcu/tree.h                               |    1 
 b/kernel/rcu/tree_plugin.h                        |    1 
 b/kernel/rcu/tree_stall.h                         |    8 +++---
 b/kernel/smp.c                                    |    7 +++--
 kernel/rcu/tree.c                                 |   29 +++++++++++++++++-----
 kernel/rcu/tree_plugin.h                          |   11 ++++++--
 11 files changed, 70 insertions(+), 20 deletions(-)
