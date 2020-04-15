Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503A1C2BA19
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DD3920774
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586974788;
	bh=kCdqRFRnqQGwm3UJqLKfxqSt2M7ow+SLUnbqAULlRe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y+vQu6Z0BfCmWvrsk333piW/2L0Oy3M/ijepH6LgZHHjlFuv73ZToajwA7D0IU0L4
	 X1qUtkol4peHt/YKf8tY0prmQ54kjbSQh5jr6Mb9jP9eu/EvvTyoO6rl6jFPN/9lQN
	 YtY2XtLtKqI93ur1BwjsCHdh5UV0eSkyq0S1vSiI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441072AbgDOSTq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 14:19:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:36994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436625AbgDOSTo (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 14:19:44 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6FC820787;
        Wed, 15 Apr 2020 18:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586974784;
        bh=kCdqRFRnqQGwm3UJqLKfxqSt2M7ow+SLUnbqAULlRe0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=etuvI54MC6WtQBQnRK6c/ipkOgCh1B/Jl//4uu+YdHEin7GLGRlE2aBuEH6CsAMEN
         4BSC8LRhs4fCc3Zrlk6EUFuRKraiuhaIVJ03uPhC+t1wbOjji8iSsDpOS2Mmn7fY9Z
         EZHch9CSeS/+bjxjtLm+bh2tm8jiG92J/MyEja2g=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 tip/core/rcu 02/38] rcu-tasks: Use context-switch hook for PREEMPT=y kernels
Date:   Wed, 15 Apr 2020 11:19:05 -0700
Message-Id: <20200415181941.11653-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415181856.GA11037@paulmck-ThinkPad-P72>
References: <20200415181856.GA11037@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, the PREEMPT=y version of rcu_note_context_switch() does not
invoke rcu_tasks_qs(), and we need it to in order to keep RCU Tasks
Trace's IPIs down to a dull roar.  This commit therefore enables this
hook.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 088e84e..4f34c32 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -331,6 +331,8 @@ void rcu_note_context_switch(bool preempt)
 	rcu_qs();
 	if (rdp->exp_deferred_qs)
 		rcu_report_exp_rdp(rdp);
+	if (!preempt)
+		rcu_tasks_qs(current);
 	trace_rcu_utilization(TPS("End context switch"));
 }
 EXPORT_SYMBOL_GPL(rcu_note_context_switch);
-- 
2.9.5

