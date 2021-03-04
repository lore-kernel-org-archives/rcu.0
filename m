Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F43C433E0
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3630564EEE
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237453AbhCDBBE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:01:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:47842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1450868AbhCDA0d (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:26:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 01FA964EA4;
        Thu,  4 Mar 2021 00:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614817566;
        bh=RFyFgCOO2PVG3BfXgbMMRevBVRlM+92l1UFvs60gVj8=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=sswxnH4KmR/hWpPICHdHLpgpS+mzBiIT+EvzdLpk9Q5qepqUPnU46W36nQ3NU/I6i
         hKyeVTru7ch1XVqLllFSvw0ugK3iA/KWaI2wxIvB3BcmB+Br2dVOvHztKr/9dE75Jv
         mxEckS8VnRF5LrT/liw+p49ucv0M59etK+IPc/Y+a1bUAg0U/vKXEHPB9UQcqcBBaO
         gUMrX5Hpb3lOD4m8nvAbfjieVMsID3g50CDgTJrsRLOJ1DFKZsq+bECaJTiCLjdHab
         hTb/sM35NSzt/aSRG5SrUXj9BH7q0Y0n3DXFSGYJqZDZN7zCRaUco3vkgFdnljhhbo
         nd793ZNe7389w==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B62C33522591; Wed,  3 Mar 2021 16:26:05 -0800 (PST)
Date:   Wed, 3 Mar 2021 16:26:05 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/3] Polling RCU grace-period interfaces for
 v5.13
Message-ID: <20210304002605.GA23785@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series provides additional polling interfaces for RCU, so that
an updater may initiate and poll for completion of an RCU grace period
despite never being invoked from a sleepable region of code.  These are
similar to the corresponding SRCU interfaces, give or take additional
restrictions to avoid deadlock with the scheduler.

1.	Provide polling interfaces for Tree RCU grace periods.

2.	Provide polling interfaces for Tiny RCU grace periods.

3.	Test start_poll_synchronize_rcu() and
	poll_state_synchronize_rcu().

						Thanx, Paul

------------------------------------------------------------------------

 include/linux/rcutiny.h |   11 ++++---
 include/linux/rcutree.h |    2 +
 kernel/rcu/rcutorture.c |   12 ++------
 kernel/rcu/tiny.c       |   40 +++++++++++++++++++++++++++
 kernel/rcu/tree.c       |   70 ++++++++++++++++++++++++++++++++++++++++++++----
 5 files changed, 116 insertions(+), 19 deletions(-)
