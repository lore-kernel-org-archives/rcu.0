Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17249C433EF
	for <rcu@archiver.kernel.org>; Wed, 10 Nov 2021 14:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 005BC60FE3
	for <rcu@archiver.kernel.org>; Wed, 10 Nov 2021 14:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbhKJOnU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 10 Nov 2021 09:43:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54864 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232270AbhKJOnQ (ORCPT
        <rfc822;rcu@vger.kernel.org>); Wed, 10 Nov 2021 09:43:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636555228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TxyMGoTd5/NHD/FGs3+rb5vAPhbBxjETUOea50bibwk=;
        b=NDdB3XwIb9vMrGo/Pc6/QtHqkObb+QPwhhUgr20jtmLwgQzvfKHnIFJ8+GSJ7InwW9PQmc
        3WFOSb6WRcoc09EKqTMWw9AFM6Cqz4nCUvkMGUtwoBZg257ffFnd+Ul0l3qeuUqfi06WNL
        cdLOcLbqD+c0Ohx2m5b5oQkRZ4k4O10=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-O46LHHWsMdOpbLDAp9ZqUg-1; Wed, 10 Nov 2021 09:40:24 -0500
X-MC-Unique: O46LHHWsMdOpbLDAp9ZqUg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32BC28EA40A;
        Wed, 10 Nov 2021 14:40:21 +0000 (UTC)
Received: from wcosta.com (ovpn-116-123.gru2.redhat.com [10.97.116.123])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 610A960C05;
        Wed, 10 Nov 2021 14:40:14 +0000 (UTC)
From:   Wander Lairson Costa <wander@redhat.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org (open list:TORTURE-TEST MODULES),
        rcu@vger.kernel.org (open list:READ-COPY UPDATE (RCU))
Cc:     Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH v3 1/1] rcutorture: Avoid soft lockup during cpu stall
Date:   Wed, 10 Nov 2021 11:37:45 -0300
Message-Id: <20211110143745.468361-2-wander@redhat.com>
In-Reply-To: <20211110143745.468361-1-wander@redhat.com>
References: <20211110143745.468361-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

If we use the module stall_cpu option, we may get a soft lockup warning
in case we also don't pass the stall_cpu_block option.

Introduce the stall_no_softlockup option to avoid a soft lockup on
cpu stall even if we don't use the stall_cpu_block option.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 kernel/rcu/rcutorture.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 36a273589a35..bc854f935548 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -46,6 +46,7 @@
 #include <linux/oom.h>
 #include <linux/tick.h>
 #include <linux/rcupdate_trace.h>
+#include <linux/nmi.h>
 
 #include "rcu.h"
 
@@ -112,6 +113,8 @@ torture_param(int, shutdown_secs, 0, "Shutdown time (s), <= zero to disable.");
 torture_param(int, stall_cpu, 0, "Stall duration (s), zero to disable.");
 torture_param(int, stall_cpu_holdoff, 10,
 	     "Time to wait before starting stall (s).");
+torture_param(bool, stall_no_softlockup, false,
+	     "Avoid softlockup warning during cpu stall.");
 torture_param(int, stall_cpu_irqsoff, 0, "Disable interrupts while stalling.");
 torture_param(int, stall_cpu_block, 0, "Sleep while stalling.");
 torture_param(int, stall_gp_kthread, 0,
@@ -2085,6 +2088,8 @@ static int rcu_torture_stall(void *args)
 #else
 				schedule_timeout_uninterruptible(HZ);
 #endif
+			} else if (stall_no_softlockup) {
+				touch_softlockup_watchdog();
 			}
 		if (stall_cpu_irqsoff)
 			local_irq_enable();
-- 
2.27.0

