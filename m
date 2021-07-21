Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520FCC6377C
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 21:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EF2561363
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 21:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhGUUYI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 16:24:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:34852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229930AbhGUUYH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 16:24:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5963661285;
        Wed, 21 Jul 2021 21:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626901483;
        bh=KCVmElLnyJJDyLi/tiwKtNc0ccGtyECFx6O/8bB8cao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yy0jVeOKoJ5Pdl7iuq0y98eojBqrxJ1+E/yUD13mCfue/zc9bWRTWYqxWtmGLh455
         NJeCPPmvu58Rd30clinfDJ/WfRuwrP/aafJnAJAAkmzf72y8Uwgn1VcT9tpsbg6pV/
         7ERJiCQlt55wKfc4V5fUsPdq4EUif9u2fZh0E/uoAbEk3KxJlmVHRP4XED/bKJYM8g
         EQhju0VK97FcVY6AGPLn/bh2lNurTEuyUWAdsTdhfoeNjsS6asaNb9XOAU2MJ351NZ
         jeqknLVeHjvkSMQJ4pViC2R+VfWi5WGj6hXAiIL3wepF1F6i2onQ2uiwCVcKy8xJ1W
         sXR6AFmGT/RQQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2B1865C0BF4; Wed, 21 Jul 2021 14:04:43 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 5/7] locktorture: Count lock readers
Date:   Wed, 21 Jul 2021 14:04:39 -0700
Message-Id: <20210721210441.796995-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721210421.GA788053@paulmck-ThinkPad-P17-Gen-1>
References: <20210721210421.GA788053@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Currently, the lock_is_read_held variable is bool, so that a reader sets
it to true just after lock acquisition and then to false just before
lock release.  This works in a rough statistical sense, but can result
in false negatives just after one of a pair of concurrent readers has
released the lock.  This approach does have low overhead, but at the
expense of the setting to true potentially never leaving the reader's
store buffer, thus resulting in an unconditional false negative.

This commit therefore converts this variable to atomic_t and makes
the reader use atomic_inc() just after acquisition and atomic_dec()
just before release.  This does increase overhead, but this increase is
negligible compared to the 10-microsecond lock hold time.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/locking/locktorture.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 313d5e613fbe6..7c5a4a087cc73 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -59,7 +59,7 @@ static struct task_struct **writer_tasks;
 static struct task_struct **reader_tasks;
 
 static bool lock_is_write_held;
-static bool lock_is_read_held;
+static atomic_t lock_is_read_held;
 static unsigned long last_lock_release;
 
 struct lock_stress_stats {
@@ -682,7 +682,7 @@ static int lock_torture_writer(void *arg)
 		if (WARN_ON_ONCE(lock_is_write_held))
 			lwsp->n_lock_fail++;
 		lock_is_write_held = true;
-		if (WARN_ON_ONCE(lock_is_read_held))
+		if (WARN_ON_ONCE(atomic_read(&lock_is_read_held)))
 			lwsp->n_lock_fail++; /* rare, but... */
 
 		lwsp->n_lock_acquired++;
@@ -717,13 +717,13 @@ static int lock_torture_reader(void *arg)
 			schedule_timeout_uninterruptible(1);
 
 		cxt.cur_ops->readlock(tid);
-		lock_is_read_held = true;
+		atomic_inc(&lock_is_read_held);
 		if (WARN_ON_ONCE(lock_is_write_held))
 			lrsp->n_lock_fail++; /* rare, but... */
 
 		lrsp->n_lock_acquired++;
 		cxt.cur_ops->read_delay(&rand);
-		lock_is_read_held = false;
+		atomic_dec(&lock_is_read_held);
 		cxt.cur_ops->readunlock(tid);
 
 		stutter_wait("lock_torture_reader");
@@ -998,7 +998,6 @@ static int __init lock_torture_init(void)
 		}
 
 		if (nreaders_stress) {
-			lock_is_read_held = false;
 			cxt.lrsa = kmalloc_array(cxt.nrealreaders_stress,
 						 sizeof(*cxt.lrsa),
 						 GFP_KERNEL);
-- 
2.31.1.189.g2e36527f23

