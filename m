Return-Path: <SRS0=LJ8s=4C=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D676C35242
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35279206B6
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581724590;
	bh=kwoRjwghjouGORVQT28JH43vJOyFgoRNW5ZaMzKqNck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cZPysaTRgoJWpW9J2ug44MK+LzoLSH04I3TtTXUbaAxbliKx9UBELeqWfvAQNIGHN
	 V7sELzNl9kLOhAwlRH3QKktfgrY42kMpYkg/F9WJk0BMk/LZX6BhXLDQI0nXeYJ9Qd
	 rRBtRBryUHLuL7Lfg5GTo4dTKjSfcPzhBHqm7GzE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgBNX43 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:56:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:36254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727959AbgBNX42 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 18:56:28 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29C3924650;
        Fri, 14 Feb 2020 23:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581724588;
        bh=kwoRjwghjouGORVQT28JH43vJOyFgoRNW5ZaMzKqNck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nJEbCip6ux14xv4+i8P9JHP4+p1FfxlAkMvhuMsGILswrsKiQPOxxoM1IgIGgmwyc
         bMxHMT2uEC9uNRgpJC3yVyRvMJy7ReJDqIgrySGAaiUNCiyBzCk48xDINTeaTkg3MG
         MIPrA9Beh1lj/sVSLyx5HAFaDEesEfOdu+xRjP/U=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 05/30] rcu: Add WRITE_ONCE() to rcu_node ->qsmask update
Date:   Fri, 14 Feb 2020 15:55:42 -0800
Message-Id: <20200214235607.13749-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200214235536.GA13364@paulmck-ThinkPad-P72>
References: <20200214235536.GA13364@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcu_node structure's ->qsmask field is read locklessly, so this
commit adds the WRITE_ONCE() to an update in order to provide proper
documentation and READ_ONCE()/WRITE_ONCE() pairing.

This data race was reported by KCSAN.  Not appropriate for backporting
due to failure being unlikely.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d91c915..bb57c24 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1881,7 +1881,7 @@ static void rcu_report_qs_rnp(unsigned long mask, struct rcu_node *rnp,
 		WARN_ON_ONCE(oldmask); /* Any child must be all zeroed! */
 		WARN_ON_ONCE(!rcu_is_leaf_node(rnp) &&
 			     rcu_preempt_blocked_readers_cgp(rnp));
-		rnp->qsmask &= ~mask;
+		WRITE_ONCE(rnp->qsmask, rnp->qsmask & ~mask);
 		trace_rcu_quiescent_state_report(rcu_state.name, rnp->gp_seq,
 						 mask, rnp->qsmask, rnp->level,
 						 rnp->grplo, rnp->grphi,
-- 
2.9.5

