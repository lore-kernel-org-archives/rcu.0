Return-Path: <SRS0=LJ8s=4C=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AB6C35242
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 990FE2072D
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581724596;
	bh=z/2snwWYS6lPAT5kl+oy5uQQY78M2650jQPM28iMAsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N6gavCVYDXokKJpA5C1Y6O+flMNHQyJ5xnUUZMq8IQgCWDeFspLfB0MukOiGytGig
	 Uozf2DWSBDJmL0AAhBhUauHEsZTS6/GqXYhsqtP3ik5OLa8C8VT38dVgUbK5ktUqUx
	 PqUF2ipWVCuGlSU0BYrm4BcasFRTEK9hWxiOcqFY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgBNX4c (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:56:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:36320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727959AbgBNX4c (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 18:56:32 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0EDB24673;
        Fri, 14 Feb 2020 23:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581724592;
        bh=z/2snwWYS6lPAT5kl+oy5uQQY78M2650jQPM28iMAsc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jVoVpijKzfWJfwVgLZ8uIEDZqcU/TeOsXZoqJxAVbY57RwRl8kABYpwhMF+l3KBMq
         zkTOFUs/dety0SyWSluV6bBkT3zsQgYt9Pvla0gEaB0aPDSMJOhKXHyxheUtmm9Q9d
         olGr3by9qSgbyp3TzcgMNUcJPnW8nn1XW8CE5W18=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 06/30] rcu: Add WRITE_ONCE to rcu_node ->exp_seq_rq store
Date:   Fri, 14 Feb 2020 15:55:43 -0800
Message-Id: <20200214235607.13749-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200214235536.GA13364@paulmck-ThinkPad-P72>
References: <20200214235536.GA13364@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcu_node structure's ->exp_seq_rq field is read locklessly, so
this commit adds the WRITE_ONCE() to a load in order to provide proper
documentation and READ_ONCE()/WRITE_ONCE() pairing.

This data race was reported by KCSAN.  Not appropriate for backporting
due to failure being unlikely.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index d7e0484..85b009e 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -314,7 +314,7 @@ static bool exp_funnel_lock(unsigned long s)
 				   sync_exp_work_done(s));
 			return true;
 		}
-		rnp->exp_seq_rq = s; /* Followers can wait on us. */
+		WRITE_ONCE(rnp->exp_seq_rq, s); /* Followers can wait on us. */
 		spin_unlock(&rnp->exp_lock);
 		trace_rcu_exp_funnel_lock(rcu_state.name, rnp->level,
 					  rnp->grplo, rnp->grphi, TPS("nxtlvl"));
-- 
2.9.5

