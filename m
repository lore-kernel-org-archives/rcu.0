Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED6DC433E1
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D0E92075A
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592872749;
	bh=I+NZCn0MAwuqXE0tzWF8t/GelpyWpqmRYj1vo4Id5+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XIppJdtmvo8pPLB/v7olMvsmqd2Khc5ZoXstJzn/r2NMMwKgLeUpi0k9YuJqlbTN5
	 +TQ/hKlXyBJKS2MrVlmnr0fd1xDPCZfKmtDv2qdHjpzdX9njdCXCe/jFh6EtfyP4D/
	 3j/Z9zFtYNNzBCoIhSxZJC+6yzw0fe7uQw/nmhHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732047AbgFWAhz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:37:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:33540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731637AbgFWAhz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:37:55 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E34620890;
        Tue, 23 Jun 2020 00:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872674;
        bh=I+NZCn0MAwuqXE0tzWF8t/GelpyWpqmRYj1vo4Id5+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w8QfaFPbW2abxRWYQ+MeW6brHvOXjkMyuk+iYDRPfXMzDjYkvLJJgDATxbwAEHF2X
         cY1XP7TMX5HRL7f8ajp7N+3CLflw9zAIgBSLA/EEh3WXHdu6zDPz91GhFc72u5kFDp
         BpaAO3jdDQWAkBsd4Z7hXDm8bjL278VWFv8zlcyk=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Zou Wei <zou_wei@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 03/23] locktorture: Use true and false to assign to bool variables
Date:   Mon, 22 Jun 2020 17:37:32 -0700
Message-Id: <20200623003752.26872-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623003731.GA26717@paulmck-ThinkPad-P72>
References: <20200623003731.GA26717@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Zou Wei <zou_wei@huawei.com>

This commit fixes the following coccicheck warnings:

kernel/locking/locktorture.c:689:6-10: WARNING: Assignment of 0/1 to bool variable
kernel/locking/locktorture.c:907:2-20: WARNING: Assignment of 0/1 to bool variable
kernel/locking/locktorture.c:938:3-20: WARNING: Assignment of 0/1 to bool variable
kernel/locking/locktorture.c:668:2-19: WARNING: Assignment of 0/1 to bool variable
kernel/locking/locktorture.c:674:2-19: WARNING: Assignment of 0/1 to bool variable
kernel/locking/locktorture.c:634:2-20: WARNING: Assignment of 0/1 to bool variable
kernel/locking/locktorture.c:640:2-20: WARNING: Assignment of 0/1 to bool variable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/locking/locktorture.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 5efbfc6..8ff6f50 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -631,13 +631,13 @@ static int lock_torture_writer(void *arg)
 		cxt.cur_ops->writelock();
 		if (WARN_ON_ONCE(lock_is_write_held))
 			lwsp->n_lock_fail++;
-		lock_is_write_held = 1;
+		lock_is_write_held = true;
 		if (WARN_ON_ONCE(lock_is_read_held))
 			lwsp->n_lock_fail++; /* rare, but... */
 
 		lwsp->n_lock_acquired++;
 		cxt.cur_ops->write_delay(&rand);
-		lock_is_write_held = 0;
+		lock_is_write_held = false;
 		cxt.cur_ops->writeunlock();
 
 		stutter_wait("lock_torture_writer");
@@ -665,13 +665,13 @@ static int lock_torture_reader(void *arg)
 			schedule_timeout_uninterruptible(1);
 
 		cxt.cur_ops->readlock();
-		lock_is_read_held = 1;
+		lock_is_read_held = true;
 		if (WARN_ON_ONCE(lock_is_write_held))
 			lrsp->n_lock_fail++; /* rare, but... */
 
 		lrsp->n_lock_acquired++;
 		cxt.cur_ops->read_delay(&rand);
-		lock_is_read_held = 0;
+		lock_is_read_held = false;
 		cxt.cur_ops->readunlock();
 
 		stutter_wait("lock_torture_reader");
@@ -686,7 +686,7 @@ static int lock_torture_reader(void *arg)
 static void __torture_print_stats(char *page,
 				  struct lock_stress_stats *statp, bool write)
 {
-	bool fail = 0;
+	bool fail = false;
 	int i, n_stress;
 	long max = 0, min = statp ? statp[0].n_lock_acquired : 0;
 	long long sum = 0;
@@ -904,7 +904,7 @@ static int __init lock_torture_init(void)
 
 	/* Initialize the statistics so that each run gets its own numbers. */
 	if (nwriters_stress) {
-		lock_is_write_held = 0;
+		lock_is_write_held = false;
 		cxt.lwsa = kmalloc_array(cxt.nrealwriters_stress,
 					 sizeof(*cxt.lwsa),
 					 GFP_KERNEL);
@@ -935,7 +935,7 @@ static int __init lock_torture_init(void)
 		}
 
 		if (nreaders_stress) {
-			lock_is_read_held = 0;
+			lock_is_read_held = false;
 			cxt.lrsa = kmalloc_array(cxt.nrealreaders_stress,
 						 sizeof(*cxt.lrsa),
 						 GFP_KERNEL);
-- 
2.9.5

