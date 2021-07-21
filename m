Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98748C6377A
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 712FF610CC
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbhGUT1a (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 15:27:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:43172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229463AbhGUT1a (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 15:27:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 722CD60FF1;
        Wed, 21 Jul 2021 20:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626898086;
        bh=CXxh0pKSjPe7qaAba216UHJNE/p2w5ab3VZx0P1x9J4=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=lZVKbF5WbUtODEtBzb9IKmRgGZHor43ANrnbkfNMAxbv4HIIUX/aBpzUYEyMcYJhG
         7Q9H9strU/iD+swPSeFtxKakt1BOSw9IUQIHyzoSZYst5AimVcfjkXXvS+bRwOVwX/
         zava1okXCpp7L5/cCNGmVh1AHqsQNt9Ftsj8p6AD/jSiH1w/Puvvdnt+sxdcsGSx1I
         jwCr+KS2HbZzG/SQeT9lH7/yep1M1NRZ+cy6BZaMn59WivxVgKDS6z8BSk8urDi2bf
         7ixVf8iMGuYDYzsPCz7U7QWFWWUT1kYmpKiGCfd5mcQjkxLjupKKCjcI3wPyN+c2bA
         vrzJYN6EE3lQw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3A4F35C09A4; Wed, 21 Jul 2021 13:08:06 -0700 (PDT)
Date:   Wed, 21 Jul 2021 13:08:06 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/5] Documentation updates for v5.15
Message-ID: <20210721200806.GA950569@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series provides documentation updates:

1.	Documentation/RCU: Fix emphasis markers, courtesy of Akira
	Yokosawa.

2.	Documentation/RCU: Fix nested inline markup, courtesy of Akira
	Yokosawa.

3.	Fix a typo in Documentation/RCU/stallwarn.rst, courtesy of
	Haocheng Xie.

4.	Add a quick quiz to explain further why we need
	smp_mb__after_unlock_lock(), courtesy of Frederic Weisbecker.

5.	Update stallwarn.rst with recent changes.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/RCU/stallwarn.rst                                         |   23 +++++--
 b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst |   29 ++++++++++
 b/Documentation/RCU/Design/Requirements/Requirements.rst                |    8 +-
 b/Documentation/RCU/checklist.rst                                       |   24 ++++----
 b/Documentation/RCU/rcu_dereference.rst                                 |    6 +-
 b/Documentation/RCU/stallwarn.rst                                       |    8 +-
 6 files changed, 69 insertions(+), 29 deletions(-)
