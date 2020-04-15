Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D586C2BA19
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A0C4216FD
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586970622;
	bh=DLkM0qrgDfqYJeNxDYgrge38PQpL7c5CoQoaVrnSvAU=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=AYRxpn2AS5ygj9Yzr0aKgfOeDVE4rqVhLUuMV2vQgZxxZys/G/rAKwUU8NLqgSxbF
	 fADCOA2lmE86M3hj0lqEIlxRmVWzdMf3MPLYYj/XvCgT75BX47aU6lzs0DUuSuL0fU
	 /tSNLimrpbVHjBJdStDuhSVIdxHtFQApKU+rzN6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406314AbgDORKW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:10:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:41134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405975AbgDORKS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 13:10:18 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72A72214D8;
        Wed, 15 Apr 2020 17:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586970617;
        bh=DLkM0qrgDfqYJeNxDYgrge38PQpL7c5CoQoaVrnSvAU=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=URp+4Oeki+J2olm7TZ1D+p094+E/q/VE4p05GeRM4re/dkW6alKwIwoHL7uRX2VkV
         2474+7gZV0soxlxHxLCryy4K1HYhAf5F1D3tFE+SgU6obQ5elAai7mkDdJAU4vqvvM
         fmvNA8fhnwPpMyLiEBZAt1nD0Yb11sWw+S47N1Z4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1111B3522AD1; Wed, 15 Apr 2020 10:10:17 -0700 (PDT)
Date:   Wed, 15 Apr 2020 10:10:17 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/19] Miscellaneous fixes for v5.8
Message-ID: <20200415171017.GA7821@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series provides miscellaneous fixes.

1.	Add KCSAN stubs to tree.c.

2.	Add KCSAN stubs to srcutree.c.

3.	Mark rcu_state.ncpus to detect concurrent writes.

4.	Add *_ONCE() and data_race() to rcu_node ->exp_tasks and also
	add some needed locking.

5.	Add READ_ONCE and data_race() to rcu_node ->boost_tasks.

6.	Add data_race() to ->srcu_lock_count and ->srcu_unlock_count arrays.

7.	Add WRITE_ONCE() to rcu_node ->boost_tasks.

8.	Use data_race() for RCU CPU stall-warning prints.

9.	Make drm_dp_mst_dsc_aux_for_port() safe for old compilers.
	Hey, I have the hair color for it!!!  ;-)

10.	Expedite first two FQS scans under callback-overload conditions.

11.	Fix the (t=0 jiffies) false positive, courtesy of Zhaolong Zhang.

12.	Revert "rculist: Describe variadic macro argument in a
	Sphinx-compatible way" due to Sphinx now being able to handle
	the original description, courtesy of Jonathan Neuschäfer.

13.	Get rid of some doc warnings in update.c, courtesy of
	Mauro Carvalho Chehab.

14.	Mark rcu_state.gp_seq to detect more concurrent writes.

15.	Replace assigned pointer ret value by corresponding boolean value,
	courtesy of Jules Irenge.

16.	Replace 1 by true in use_softirq initialization, courtesy of
	Jules Irenge.

17.	Convert ULONG_CMP_GE() to time_after() for jiffy comparison.

18.	Convert rcu_initiate_boost() ULONG_CMP_GE() to time_after().

19.	Convert rcu_nohz_full_cpu() ULONG_CMP_LT() to time_before().

							Thanx, Paul

------------------------------------------------------------------------

 drivers/gpu/drm/drm_dp_mst_topology.c |    2 -
 include/linux/rculist.h               |    4 +--
 kernel/rcu/srcutree.c                 |   21 ++++++++++++++---
 kernel/rcu/tree.c                     |   41 ++++++++++++++++++++++++++++------
 kernel/rcu/tree.h                     |    1 
 kernel/rcu/tree_exp.h                 |   19 +++++++++------
 kernel/rcu/tree_plugin.h              |   21 +++++++++--------
 kernel/rcu/tree_stall.h               |   38 +++++++++++++++----------------
 kernel/rcu/update.c                   |   14 +++++------
 9 files changed, 103 insertions(+), 58 deletions(-)
