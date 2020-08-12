Return-Path: <SRS0=nsBp=BW=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3DDC433E1
	for <rcu@archiver.kernel.org>; Wed, 12 Aug 2020 22:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E73FA22C9F
	for <rcu@archiver.kernel.org>; Wed, 12 Aug 2020 22:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597273081;
	bh=DUPTKQaPgAL9zzOR19QnDiQivFZngHJqQAG8BiElQhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K7/Jo+UQfwn7uP4K9JG/Rh/n2OFKxvK9vLAp3dCI30LD6M6ZGO6Lr3Ti5by4RdrNY
	 AvCq62Kx0Ecawi5Ovrd0SlcLGBvh7gb74Ti+yE6pXrrY9SH6R51k77sujsai07kOK0
	 Bx6I93nSZCdcHW/hQYDHoegRiDha7a/36qQlLbsE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgHLW5y (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 12 Aug 2020 18:57:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726505AbgHLW5g (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 12 Aug 2020 18:57:36 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4122621775;
        Wed, 12 Aug 2020 22:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597273056;
        bh=DUPTKQaPgAL9zzOR19QnDiQivFZngHJqQAG8BiElQhE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w5Gfp0qCZrg+RFxOikePKIV2+fZ++ElE3s6iWpyM1dsTxf2rhDx+t+hkeMyOGW4Ql
         WjylTG7ZKeP+xvhxaqv87iMoAUvgjJBorDlhUEaiTiJ10jAuoU5SucN9ETW/2das7f
         FDH8pym1Tps7mi7PxGJb0H0AVmYJjDmf6GO83t5s=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        elver@google.com, dvyukov@google.com,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 09/12] rcu: IPI all CPUs at GP end for strict GPs
Date:   Wed, 12 Aug 2020 15:57:29 -0700
Message-Id: <20200812225732.20068-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200812225632.GA19759@paulmck-ThinkPad-P72>
References: <20200812225632.GA19759@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, each CPU discovers the end of a given grace period on its
own time, which is again good for efficiency but bad for fast grace
periods, given that it is things like kfree() within the RCU callbacks
that will cause trouble for pointers leaked from RCU read-side critical
sections.  This commit therefore uses on_each_cpu() to IPI each CPU
after grace-period cleanup in order to inform each CPU of the end of
the old grace period in a timely manner, but only in kernels build with
CONFIG_RCU_STRICT_GRACE_PERIOD=y.

Reported-by Jann Horn <jannh@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a30d6f3..dd7af40 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2034,6 +2034,10 @@ static void rcu_gp_cleanup(void)
 			   rcu_state.gp_flags & RCU_GP_FLAG_INIT);
 	}
 	raw_spin_unlock_irq_rcu_node(rnp);
+
+	// If strict, make all CPUs aware of the end of the old grace period.
+	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
+		on_each_cpu(rcu_strict_gp_boundary, NULL, 0);
 }
 
 /*
-- 
2.9.5

