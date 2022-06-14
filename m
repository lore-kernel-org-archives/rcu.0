Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F769C433EF
	for <rcu@archiver.kernel.org>; Tue, 14 Jun 2022 12:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356298AbiFNMGo (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 14 Jun 2022 08:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356279AbiFNMGn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 14 Jun 2022 08:06:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3927449918
        for <rcu@vger.kernel.org>; Tue, 14 Jun 2022 05:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655208402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=dHLuawh8kg+YdtEzlsZqTBbBt0oMgGN79bcCX6rKiAc=;
        b=ECwDnG7JUkIfh5RVx4xpD5T6NvwQbXAW6NEz0d/j2W1Uj10flJC7kB3iJ1uRNB3YXTMsje
        AHtKdQE3ypReh+zDxVKqp8xoPzlYTb3JQZ+Rmfj0MNgINrzJ1FxZUTCTfFPfQg4CatLtgY
        JFr0LTYPUQVXbCsgaT9YHjxw5I6EMYs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-574-pZqMxAf_NYO9zd7ysHN97A-1; Tue, 14 Jun 2022 08:06:39 -0400
X-MC-Unique: pZqMxAf_NYO9zd7ysHN97A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F12A485A588;
        Tue, 14 Jun 2022 12:06:37 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.186])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C65CB10725;
        Tue, 14 Jun 2022 12:06:36 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-rcu] rcu-tasks: Use delayed_work to delay rcu_tasks_verify_self_tests()
Date:   Tue, 14 Jun 2022 08:06:20 -0400
Message-Id: <20220614120620.1202389-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Commit 2585014188d5 ("rcu-tasks: Be more patient for RCU Tasks
boot-time testing") fixes false positive rcu_tasks verification check
failure by repeating the test once every second until timeout using
schedule_timeout_uninterruptible().

Since rcu_tasks_verify_selft_tests() is called from do_initcalls()
as a late_initcall, this has the undesirable side effect of perhaps
delaying other late_initcall's queued after it by a second or more.
Fix this by using delayed_work to repeat the verification check instead.

Fixes: 2585014188d5 ("rcu-tasks: Be more patient for RCU Tasks boot-time testing")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/rcu/tasks.h | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index fcbd0ec33c86..e151cd5ae2bc 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1832,6 +1832,11 @@ static void rcu_tasks_initiate_self_tests(void)
 #endif
 }
 
+/*
+ * Return:  0 - test passed
+ *	    1 - test failed, but have not timed out yet
+ *	   -1 - test failed and timed out
+ */
 static int rcu_tasks_verify_self_tests(void)
 {
 	int ret = 0;
@@ -1847,16 +1852,40 @@ static int rcu_tasks_verify_self_tests(void)
 				ret = -1;
 				break;
 			}
-			schedule_timeout_uninterruptible(1);
+			ret = 1;
+			break;
 		}
 	}
 
-	if (ret)
+	if (ret < 0)
 		WARN_ON(1);
 
 	return ret;
 }
-late_initcall(rcu_tasks_verify_self_tests);
+
+/*
+ * Repeat the rcu_tasks_verify_self_tests() call once every second until the
+ * test passes or has timed out.
+ */
+static struct delayed_work rcu_tasks_verify_work;
+static void rcu_tasks_verify_work_fn(struct work_struct *work __maybe_unused)
+{
+	int ret = rcu_tasks_verify_self_tests();
+
+	if (ret <= 0)
+		return;
+
+	/* Test fails but not timed out yet, reschedule another check */
+	schedule_delayed_work(&rcu_tasks_verify_work, HZ);
+}
+
+static int rcu_tasks_verify_schedule_work(void)
+{
+	INIT_DELAYED_WORK(&rcu_tasks_verify_work, rcu_tasks_verify_work_fn);
+	rcu_tasks_verify_work_fn(NULL);
+	return 0;
+}
+late_initcall(rcu_tasks_verify_schedule_work);
 #else /* #ifdef CONFIG_PROVE_RCU */
 static void rcu_tasks_initiate_self_tests(void) { }
 #endif /* #else #ifdef CONFIG_PROVE_RCU */
-- 
2.31.1

