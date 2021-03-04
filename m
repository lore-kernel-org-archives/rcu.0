Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0D6C433E0
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5005064EEE
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239112AbhCDBBR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:01:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:59070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244643AbhCDAdH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:33:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 995236146D;
        Thu,  4 Mar 2021 00:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614817946;
        bh=cLCs+G59xlMGXTRIsOv1QjE3JLJvBRxSRqQXIHtF/Dg=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=KyoACezl2UtMN2Qd0xEIjv5crweuxuaM8COm/bgMJFMpXLSaMtSaTHwoiANkXubuu
         rVjb62HyTgzkTOoGLwP02v3p6522MeNForWo7Y5sGtm3RNsEPYN6ihkCQgMwvUgHo5
         GHVWM6a+Ie7KXgDpv4jGpmFnjXOeu0ngyDCEOLh/SCr4DnbXnstoSege69UxhkOMlq
         gmDjXUboq1tOASObU7gPw2Jzcl3LMEpqGqLw8YNf2Jeq6om6PFjGHkcDITe323dsRn
         mptAsCWZsueHTF+2a1eQnAjLVEEVwSh5AHHh+afPOeLgNFJGmw4Yc1KCD+I0Z/MS/1
         JAY7lzsc9FxGw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6A0C03522591; Wed,  3 Mar 2021 16:32:26 -0800 (PST)
Date:   Wed, 3 Mar 2021 16:32:26 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/2] RCU Tasks updates for v5.13
Message-ID: <20210304003226.GA24261@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series contains a couple of updates for the RCU-tasks family:

1.	rcu-tasks: Rectify kernel-doc for struct rcu_tasks, courtesy of
	Lukas Bulwahn.

2.	rcu-tasks: Add block comment laying out RCU Tasks Trace design.

						Thanx, Paul

------------------------------------------------------------------------

 tasks.h |   40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)
