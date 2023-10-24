Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5C1C25B6B
	for <rcu@archiver.kernel.org>; Tue, 24 Oct 2023 21:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbjJXVqt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 24 Oct 2023 17:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234984AbjJXVqs (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 24 Oct 2023 17:46:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F73D7F;
        Tue, 24 Oct 2023 14:46:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE7FC433C8;
        Tue, 24 Oct 2023 21:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698184005;
        bh=SWH3H5Xdn3J5BOiYP+tbzdRJbhkTqpBLrBJhKbzm4Fo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=usKGKhB8JfO8caii44hKkyfsLAu0qLEivqPpVb5HoIyzboKeu0t9NOqlr5pq7VhBt
         QA6eSDiSI63VG1CG6dLZo9glJsKFKPHBIK1xN/syP7JfBPcjUxlBYf1rMg/r+u788I
         gP/+BztEMPJ5FUutfZ6KmeUL3wrg42cVHmg0igQIQMnK0sI04vsAiAmmnvmziFhbEM
         zh4nYA71JTFaW6qLDN/S7uwATgtoGBwyhJuex65txdCp8/8IWlstvWppT4gc+fJyB4
         gcZ1zbzHYqU7Wy+743hSyHh2TLnFRa0PSdwqvwWaxOwLyC8AK3Db0MGYsps52afPoQ
         rn+mH6j3kFvkQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH 3/4] rcu/tasks-trace: Handle new PF_IDLE semantics
Date:   Tue, 24 Oct 2023 23:46:24 +0200
Message-ID: <20231024214625.6483-4-frederic@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024214625.6483-1-frederic@kernel.org>
References: <20231024214625.6483-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The commit:

	cff9b2332ab7 ("kernel/sched: Modify initial boot task idle setup")

has changed the semantics of what is to be considered an idle task in
such a way that the idle task of an offline CPU may not carry the
PF_IDLE flag anymore.

However RCU-tasks-trace tests the opposite assertion, still assuming
that idle tasks carry the PF_IDLE flag during their whole lifecycle.

Remove this assumption to avoid spurious warnings but keep the initial
test verifying that the idle task is the current task on any offline
CPU.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Fixes: cff9b2332ab7 ("kernel/sched: Modify initial boot task idle setup")
Suggested-by: Joel Fernandes <joel@joelfernandes.org>
Suggested-by: Paul E . McKenney" <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tasks.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index acf81efe5eff..4dd70f2af4af 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1552,7 +1552,7 @@ static int trc_inspect_reader(struct task_struct *t, void *bhp_in)
 	} else {
 		// The task is not running, so C-language access is safe.
 		nesting = t->trc_reader_nesting;
-		WARN_ON_ONCE(ofl && task_curr(t) && !is_idle_task(t));
+		WARN_ON_ONCE(ofl && task_curr(t) && (t != idle_task(task_cpu(t))));
 		if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB) && ofl)
 			n_heavy_reader_ofl_updates++;
 	}
-- 
2.41.0

