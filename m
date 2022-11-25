Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBB6C46467
	for <rcu@archiver.kernel.org>; Fri, 25 Nov 2022 13:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiKYNzO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 25 Nov 2022 08:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiKYNzN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 25 Nov 2022 08:55:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54431AD8F;
        Fri, 25 Nov 2022 05:55:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51DB36245A;
        Fri, 25 Nov 2022 13:55:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4754C433C1;
        Fri, 25 Nov 2022 13:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669384511;
        bh=ALLACmzXC6lYKmELWY0sATEsOCq01HNEAVNMSA5sSNU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PWrTou2xJP0lqm6s5QPAORWmW0j8jfCxhnCMQeUbEiz3F0QA3AxuIpCRAkk6inw5p
         wEDcwPD1DlhwzX8kvszAKdvuVCvPhw+Dvkee6PRXx0kK9u+EG71tWNxOce0XX/WyOg
         6I9TlVrT6Ds+SlvRt/8s1gXR8efW9OiazXwJwX0Uv8GBHlUx1UHellIjcY/tApFMOz
         gDfyGplUPEmCE0qcRmw1AyGPAcsYOKjecreO+qjAWsISQvsifq0uCCqmBnvsbWZ5t0
         rjDY9oLXtHLIKgJe9vsrsBRNCqBRUkXaON89nIoi4DeUIM2KnFGrAvr8TNoTR9jDFa
         POLinGPxc460Q==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org
Subject: [PATCH 2/3] rcu-tasks: Remove preemption disablement around srcu_read_[un]lock() calls
Date:   Fri, 25 Nov 2022 14:54:59 +0100
Message-Id: <20221125135500.1653800-3-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221125135500.1653800-1-frederic@kernel.org>
References: <20221125135500.1653800-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Ever since the following commit:

	5a41344a3d83 ("srcu: Simplify __srcu_read_unlock() via this_cpu_dec()")

SRCU doesn't rely anymore on preemption to be disabled in order to
modify the per-CPU counter. And even then it used to be done from the API
itself.

Therefore and after checking further, it appears to be safe to remove
the preemption disablement around __srcu_read_[un]lock() in
exit_tasks_rcu_start() and exit_tasks_rcu_finish()

Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Suggested-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tasks.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 7deed6135f73..9a8114114b48 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1008,9 +1008,7 @@ EXPORT_SYMBOL_GPL(show_rcu_tasks_classic_gp_kthread);
  */
 void exit_tasks_rcu_start(void) __acquires(&tasks_rcu_exit_srcu)
 {
-	preempt_disable();
 	current->rcu_tasks_idx = __srcu_read_lock(&tasks_rcu_exit_srcu);
-	preempt_enable();
 }
 
 /*
@@ -1022,9 +1020,7 @@ void exit_tasks_rcu_finish(void) __releases(&tasks_rcu_exit_srcu)
 {
 	struct task_struct *t = current;
 
-	preempt_disable();
 	__srcu_read_unlock(&tasks_rcu_exit_srcu, t->rcu_tasks_idx);
-	preempt_enable();
 	exit_tasks_rcu_finish_trace(t);
 }
 
-- 
2.25.1

