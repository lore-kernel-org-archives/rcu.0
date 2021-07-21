Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E783C63797
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6614E61285
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240008AbhGUT2X (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 15:28:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:43742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232262AbhGUT2U (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 15:28:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C011A6120D;
        Wed, 21 Jul 2021 20:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626898134;
        bh=+nYf4Bxlw57FVUj24UdQQXqO7Ral1zh5b+lo4zZK41k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EIjHrw3413G5iRP16uqRL2N3bGpci32FiqkLTUv6haHqrpNwu77DixwWAtQjnYXNz
         S8MWAObgGJCjtPcDAAa8AiraLMVyPV61/p1cvrKells6WPkJmG9n/bDUoyRxbmoBgD
         PYa70GVwWe40tkmIL3GuOCwqB+2cNhD2VzcOAUSI9iQnyvl0G2hgMDdnLIW50Z3uFr
         BmJ8KJl+I99fmCjtlI47QxybtiHPwx0Q7lqQS1bks+EhM8a3YikEMk/4yZoGqDUuyS
         UAA8hYjzNZzA1iHiFyiZx748tsvqDaHfVvbhaC6Ymfm7+NPvJtUI/3k6COjsgNETFr
         4kBNJvynawJwQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 895FE5C0A11; Wed, 21 Jul 2021 13:08:54 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Haocheng Xie <xiehaocheng.cn@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/5] docs: Fix a typo in Documentation/RCU/stallwarn.rst
Date:   Wed, 21 Jul 2021 13:08:51 -0700
Message-Id: <20210721200853.1175189-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721200806.GA950569@paulmck-ThinkPad-P17-Gen-1>
References: <20210721200806.GA950569@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Haocheng Xie <xiehaocheng.cn@gmail.com>

Add the missing ')' in the documentation.

Signed-off-by: Haocheng Xie <xiehaocheng.cn@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/stallwarn.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
index 1cc944aec46f2..f1c49c626e934 100644
--- a/Documentation/RCU/stallwarn.rst
+++ b/Documentation/RCU/stallwarn.rst
@@ -224,7 +224,7 @@ is the number that had executed since boot at the time that this CPU
 last noted the beginning of a grace period, which might be the current
 (stalled) grace period, or it might be some earlier grace period (for
 example, if the CPU might have been in dyntick-idle mode for an extended
-time period.  The number after the "/" is the number that have executed
+time period).  The number after the "/" is the number that have executed
 since boot until the current time.  If this latter number stays constant
 across repeated stall-warning messages, it is possible that RCU's softirq
 handlers are no longer able to execute on this CPU.  This can happen if
-- 
2.31.1.189.g2e36527f23

