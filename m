Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF959C43460
	for <rcu@archiver.kernel.org>; Wed, 12 May 2021 18:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9069561453
	for <rcu@archiver.kernel.org>; Wed, 12 May 2021 18:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243091AbhELSdS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 12 May 2021 14:33:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:45170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355653AbhELS26 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 12 May 2021 14:28:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A27461412;
        Wed, 12 May 2021 18:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620844069;
        bh=NeA2ZA+zZivqWnB/DeB4W2Mu4E4V82Z7NupYtGJe37U=;
        h=From:To:Cc:Subject:Date:From;
        b=E28K7XvmpJP4XFqw8+zdisVpcEZxM/SeUco9W6giH3i2XZZRGxdvHBCcpiExAMBcE
         N1YbzJRxbOk1i3sJqDpNfvBy4L+RLfUF+V40ULBqCcjFXCooe6kIV58XM0sM6xY6DM
         6NQVxbtNwzG4iqaAQ+pgZqIybegetLFFZKqniofRMHP4xBiQAoET6/tBZqPK2xB5o1
         dXQ3SkTpgk2nB6CaGIqIiBQTxuPGyyvCa3CW/Yh3LO/4McnLtJblSIgeJkJ5xkuN3O
         7O40QKI9J79K9kEfoEvinc76DYFDrvr/pKJ0XRqLbJukfE2bIFrgTckgxriJ03ql9T
         Xo9Grj+wzsGHw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 00ED75C00DC; Wed, 12 May 2021 11:27:48 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/4] Tasks-RCU updates for v5.14
Date:   Wed, 12 May 2021 11:27:43 -0700
Message-Id: <20210512182747.3445812-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


Hello!

This series provides Tasks-RCU updates.  I am resending this as an
experiment in the use of the "git send-email" command's "--compose"
command-line argument, which some of yesterday's patch serieses indicate
that I should be using.  :-/

1.	rcu-tasks: Add block comment laying out RCU Tasks design.

2.	rcu-tasks: Add block comment laying out RCU Rude design.

3.	rcu-tasks: Make ksoftirqd provide RCU Tasks quiescent states.

4.	tasks-rcu: Make show_rcu_tasks_gp_kthreads() be static inline.

						Thanx, Paul

------------------------------------------------------------------------

 b/kernel/rcu/rcu.h   |    4 ++++
 b/kernel/rcu/tasks.h |   40 ++++++++++++++++++++++++++++++++++++++++
 b/kernel/rcu/tree.c  |    1 +
 kernel/rcu/tasks.h   |   10 +++++++---
 4 files changed, 52 insertions(+), 3 deletions(-)

