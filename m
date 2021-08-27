Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B1BC432BE
	for <rcu@archiver.kernel.org>; Fri, 27 Aug 2021 02:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C48A60F25
	for <rcu@archiver.kernel.org>; Fri, 27 Aug 2021 02:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243993AbhH0CW1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 26 Aug 2021 22:22:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41179 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231641AbhH0CW1 (ORCPT
        <rfc822;rcu@vger.kernel.org>); Thu, 26 Aug 2021 22:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630030898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=rSOjbuRdk1TZ49NvwDti2zU1kHapru68ruaxv+B72xg=;
        b=FMZbGbXHRL/rBJFMlRdgzKoKzXlymSgBAqcPXH6wmUcRXfX3eaMgbti++vTbChzY40EGhr
        T/4nw+CA5eTD+l3AEeWO9kdjEdjiM3Otw+i77jS69voTqUqAOM9t8rio9UFGgviDmdAPFo
        nx1jHiyG2syooj8tTHDqOBLIeyMpHsM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-skf5Qfs7Pg-EqMt6lcsStg-1; Thu, 26 Aug 2021 22:21:35 -0400
X-MC-Unique: skf5Qfs7Pg-EqMt6lcsStg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A1CC8015C7;
        Fri, 27 Aug 2021 02:21:33 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 57B245D9DC;
        Fri, 27 Aug 2021 02:21:28 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] rcu: Avoid unneeded function call in rcu_read_unlock()
Date:   Thu, 26 Aug 2021 22:21:22 -0400
Message-Id: <20210827022122.15816-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Since commit aa40c138cc8f3 ("rcu: Report QS for outermost
PREEMPT=n rcu_read_unlock() for strict GPs"). A real function call
rcu_read_unlock_strict() is added to the inlined rcu_read_unlock().
The rcu_read_unlock_strict() call is only needed if the performance
sagging CONFIG_RCU_STRICT_GRACE_PERIOD option is set. This config
option isn't set for most production kernels while the function call
overhead remains.

To provide a slight performance improvement, the
CONFIG_RCU_STRICT_GRACE_PERIOD config check is moved from
rcu_read_unlock_strict() to __rcu_read_unlock() so that the function
call can be compiled out in most cases.

Besides, the GPL exported rcu_read_unlock_strict() also impact the
the compilation of non-GPL kernel modules as rcu_read_unlock() is a
frequently used kernel API.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/rcupdate.h | 3 ++-
 kernel/rcu/tree_plugin.h | 3 +--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index d9680b798b21..945594770d57 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -71,7 +71,8 @@ static inline void __rcu_read_lock(void)
 static inline void __rcu_read_unlock(void)
 {
 	preempt_enable();
-	rcu_read_unlock_strict();
+	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
+		rcu_read_unlock_strict();
 }
 
 static inline int rcu_preempt_depth(void)
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index de1dc3bb7f70..7fa518bef15d 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -844,8 +844,7 @@ void rcu_read_unlock_strict(void)
 {
 	struct rcu_data *rdp;
 
-	if (!IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) ||
-	   irqs_disabled() || preempt_count() || !rcu_state.gp_kthread)
+	if (irqs_disabled() || preempt_count() || !rcu_state.gp_kthread)
 		return;
 	rdp = this_cpu_ptr(&rcu_data);
 	rcu_report_qs_rdp(rdp);
-- 
2.18.1

