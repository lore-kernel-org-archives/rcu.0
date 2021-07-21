Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D250C6377A
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BD8861003
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbhGUTzY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 15:55:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:55346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229803AbhGUTzY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 15:55:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67C9861222;
        Wed, 21 Jul 2021 20:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626899760;
        bh=d7MLmEAZoAC9YBSM2uGtWULidWyIt2xJ4yM4+K3XYI0=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=cIKmIkzT/EHFdulB4dkruvWhXydY97C3pdNF5ofNqDhooobSpkCnhDM27mO5jC/m7
         jEKdoA+Czw6oDV/1hg/1sj7nnoBtTkaqHGoOPST193/DbKUwt3hQdYL/tHD+HWm5kb
         9APk66yAo0Lp4ZIRP+Ka/qOf5fHfO2uCitHCgaEn+66a0wTKehelIbmSzmmimJ2mBX
         NTDuNfUtC7nuAsU2z1rXBfCuGLr0J3Jtk+wlx7gVJFZRrqj7ow8rLL47FA2ojpgDS/
         +tQYOtW5jZwY8zjiQkN/EJ7wZOoNfP5v03vGJkaQWlevPOORlrZGvN9ViIeleEp0+W
         TO0D/FvNlJKWw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 27F275C09A4; Wed, 21 Jul 2021 13:36:00 -0700 (PDT)
Date:   Wed, 21 Jul 2021 13:36:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH nolibc 0/2] nolibc commits for v5.15
Message-ID: <20210721203600.GA3360826@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series contains nolibc updates:

1.	include: nolibc: Fix a typo occured to occurred in the file
	nolibc.h, courtesy of Bhaskar Chowdhury.

2.	Implement msleep(), courtesy of Mark Brown.

						Thanx, Paul

------------------------------------------------------------------------

 b/tools/include/nolibc/nolibc.h |    2 +-
 tools/include/nolibc/nolibc.h   |   13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)
