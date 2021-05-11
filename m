Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95736C433ED
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 694DB61606
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhEKW6v (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 18:58:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhEKW6v (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 18:58:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 614B561184;
        Tue, 11 May 2021 22:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620773864;
        bh=29BJ5jKwJmL1eYq5ancpxySsTkLb14sEcY447w50rMU=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=lRBFgrc8Unke7LA1xPcRJIeN38Bs0e3c/KzcegmkUoDoV+/bhBJ+fsrFu4ELedFaw
         820oAzGdwtVZIChiqXopFKdIiS6Cb+LPRBLKgv//epO7v4RKRzU68Ru1SBu047DkB2
         /4UA4QesMuJR76KxI6ml7Fkl3LgngrMsughi2YZBv1hUIheWNsqNjjUBydsz6LP9+R
         YqKAGs7RxTt552HeQjDBfSmvSW0DHE7+INWTT31CfN0QFh6QC2uMLuW+n4BuMBMeaX
         wny/lw48nSf+MR/QGBrFm/xaXZxQp9uja4qJG8upTm2TZP9Tot9cSKes7W1AnShpvp
         x84rRfeZCN6Yg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2756C5C0138; Tue, 11 May 2021 15:57:44 -0700 (PDT)
Date:   Tue, 11 May 2021 15:57:44 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/2] mem_dump_obj() updates for v5.14
Message-ID: <20210511225744.GA2893615@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series provides updates for the mem_dump_obj() functionality.

1.	Fix backtrace of objects to handle redzone adjustment, courtesy
	of Maninder Singh.

2.	Add Support for free path information of an object, courtesy of
	Maninder Singh.

						Thanx, Paul

------------------------------------------------------------------------

 b/mm/slab.h        |    1 +
 b/mm/slab_common.c |   12 +++++++++++-
 b/mm/slub.c        |    1 +
 b/mm/util.c        |    2 +-
 mm/slub.c          |    7 +++++++
 5 files changed, 21 insertions(+), 2 deletions(-)
