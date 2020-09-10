Return-Path: <SRS0=F17Q=CT=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3087EC2D0A7
	for <rcu@archiver.kernel.org>; Thu, 10 Sep 2020 20:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D25E520829
	for <rcu@archiver.kernel.org>; Thu, 10 Sep 2020 20:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599771040;
	bh=/tExeEJ8/c6egD6eYM7a6JORIf/FIWn57CX8Gi2aybg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HJWc0G2Y1ke+wSTRvx+fYYTECUKTHGUGJ+9u52sOv47ybHM7S4gbRN3BblE++cqW9
	 bNM6BaIQETxwykXsTC1rZ7IW9MSnpP8ijQu5QIiVo7kjRwxKCM2+wIU75+rBneXqqG
	 k5v9aG6Eko5P9SgUL0wBNewQtbXu47NVHwVLNrK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgIJUuf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 10 Sep 2020 16:50:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbgIJUUz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 10 Sep 2020 16:20:55 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA31E20829;
        Thu, 10 Sep 2020 20:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599769254;
        bh=/tExeEJ8/c6egD6eYM7a6JORIf/FIWn57CX8Gi2aybg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=roXGE+6Xt6Mwihhx5z530lCw62JdFx6VElpEsu0GymwOH7QAweMrWprIO53dQiUnl
         ztzutQ8zt7YIFQLZokrzRI0USsQmJKrg2EWNkRfojvE5pZFa5EdRhnQrUx+Si9gk50
         ZJBkoBVW72eT+wolEfaKHTMi0b2HUPnQbuUOCujw=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        alexei.starovoitov@gmail.com, daniel@iogearbox.net,
        jolsa@redhat.com, bpf@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC tip/core/rcu 1/4] rcu-tasks: Mark variables static
Date:   Thu, 10 Sep 2020 13:20:49 -0700
Message-Id: <20200910202052.5073-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200910201956.GA24190@paulmck-ThinkPad-P72>
References: <20200910201956.GA24190@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The n_heavy_reader_attempts, n_heavy_reader_updates, and
n_heavy_reader_ofl_updates variables are not used outside of their
translation unit, so this commit marks them static.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 05d3e13..978508e 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -745,9 +745,9 @@ static DEFINE_PER_CPU(bool, trc_ipi_to_cpu);
 
 // The number of detections of task quiescent state relying on
 // heavyweight readers executing explicit memory barriers.
-unsigned long n_heavy_reader_attempts;
-unsigned long n_heavy_reader_updates;
-unsigned long n_heavy_reader_ofl_updates;
+static unsigned long n_heavy_reader_attempts;
+static unsigned long n_heavy_reader_updates;
+static unsigned long n_heavy_reader_ofl_updates;
 
 void call_rcu_tasks_trace(struct rcu_head *rhp, rcu_callback_t func);
 DEFINE_RCU_TASKS(rcu_tasks_trace, rcu_tasks_wait_gp, call_rcu_tasks_trace,
-- 
2.9.5

