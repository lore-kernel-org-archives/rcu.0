Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFD7C4321E
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 469BF611C6
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbhIOXfG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Sep 2021 19:35:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232918AbhIOXfE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Sep 2021 19:35:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 401B961209;
        Wed, 15 Sep 2021 23:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631748825;
        bh=SplYcZndHtdlCQNxDRBVeAdKGzl7hGLHOYtmfOIi+ZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iZ/vZ94hwEMUk2FPKlrA3H1ogd9XdCSVEED0nx2nR0iu5j7IC6HG0qCN97tqkgsmH
         OiSipwQK5SXiLess4+o8OY+MRFlfmW1vyIZ8lnvmukrHzqVkRlXGHoLfzFHo1yqjKd
         dt9ZOYUdBJF805jyDqU0xJ8gB2WUl4etIH6CJENBks7gUd29kmvNVVrY8QEQbRM2Jj
         vBEnwuKsoseXrbe2z3WD4Gz5X8zGNxTMtDTnWMzxw7v+6x/Fu+6hgf2VgxY6/2y3ME
         a/njso13mjH5ZUUOxm9Rx4QRzIbWHBHf1b4lhqM783yd+33QvFYigI18X6IJGp2ZRT
         qxLCDwJGeC1IA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C8F075C0AD4; Wed, 15 Sep 2021 16:33:44 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 08/14] rcu: Move rcu_dynticks_eqs_online() to rcu_cpu_starting()
Date:   Wed, 15 Sep 2021 16:33:37 -0700
Message-Id: <20210915233343.3906738-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210915233305.GA3906641@paulmck-ThinkPad-P17-Gen-1>
References: <20210915233305.GA3906641@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The purpose of rcu_dynticks_eqs_online() is to adjust the ->dynticks
counter of an incoming CPU when required.  It is currently invoked
from rcutree_prepare_cpu(), which runs before the incoming CPU is
running, and thus on some other CPU.  This makes the per-CPU accesses in
rcu_dynticks_eqs_online() iffy at best, and it all "works" only because
the running CPU cannot possibly be in dyntick-idle mode, which means
that rcu_dynticks_eqs_online() never has any effect.

It is currently OK for rcu_dynticks_eqs_online() to have no effect, but
only because the CPU-offline process just happens to leave ->dynticks in
the correct state.  After all, if ->dynticks were in the wrong state on a
just-onlined CPU, rcutorture would complain bitterly the next time that
CPU went idle, at least in kernels built with CONFIG_RCU_EQS_DEBUG=y,
for example, those built by rcutorture scenario TREE04.  One could
argue that this means that rcu_dynticks_eqs_online() is unnecessary,
however, removing it would make the CPU-online process vulnerable to
slight changes in the CPU-offline process.

One could also ask why it is safe to move the rcu_dynticks_eqs_online()
call so late in the CPU-online process.  Indeed, there was a time when it
would not have been safe, which does much to explain its current location.
However, the marking of a CPU as online from an RCU perspective has long
since moved from rcutree_prepare_cpu() to rcu_cpu_starting(), and all
that is required is that ->dynticks be set correctly by the time that
the CPU is marked as online from an RCU perspective.  After all, the RCU
grace-period kthread does not check to see if offline CPUs are also idle.
(In case you were curious, this is one reason why there is quiescent-state
reporting as part of the offlining process.)

This commit therefore moves the call to rcu_dynticks_eqs_online() from
rcutree_prepare_cpu() to rcu_cpu_starting(), this latter being guaranteed
to be running on the incoming CPU.  The call to this function must of
course be placed before this rcu_cpu_starting() announces this CPU's
presence to RCU.

Reported-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e6e1b9281530..801075e36515 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4129,7 +4129,6 @@ int rcutree_prepare_cpu(unsigned int cpu)
 	rdp->n_force_qs_snap = READ_ONCE(rcu_state.n_force_qs);
 	rdp->blimit = blimit;
 	rdp->dynticks_nesting = 1;	/* CPU not up, no tearing. */
-	rcu_dynticks_eqs_online();
 	raw_spin_unlock_rcu_node(rnp);		/* irqs remain disabled. */
 
 	/*
@@ -4249,6 +4248,7 @@ void rcu_cpu_starting(unsigned int cpu)
 	mask = rdp->grpmask;
 	WRITE_ONCE(rnp->ofl_seq, rnp->ofl_seq + 1);
 	WARN_ON_ONCE(!(rnp->ofl_seq & 0x1));
+	rcu_dynticks_eqs_online();
 	smp_mb(); // Pair with rcu_gp_cleanup()'s ->ofl_seq barrier().
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext | mask);
-- 
2.31.1.189.g2e36527f23

