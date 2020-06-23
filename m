Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056F9C433E1
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF76920720
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592871886;
	bh=GcBg6ntwDJyu48eVyKptdQCgIvfOwSLRJBixW2jT1j0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tG+B84hC6m59iYEdRjses7SevFdOfR+0PEEsiYNrO2jVlEXGspnwmmGRsxyqw+cEn
	 rBavYsEtNMkIbx1BlAm7pDIjAbKvXYgNjO3rrUF+0ZsiNIF6oaiEicyhWXM+cnwhKv
	 5rp5Jr9WY8fNohqKy8xkp04CuHhustlrxpyIo7Ag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731656AbgFWAYq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:24:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731524AbgFWAYp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:24:45 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B8CC207F5;
        Tue, 23 Jun 2020 00:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592871885;
        bh=GcBg6ntwDJyu48eVyKptdQCgIvfOwSLRJBixW2jT1j0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HRmXScL7XIZrt43O5a9qVqFMgFtDIu8WXdV8N0Z/uHHisOtJRNj7Od35shy/QND+K
         S2dQK9kIgYZWJHxyqNKO3riSdR5MKTisWSTrDlTr9U40L1UNa+EXSjb1mKCSNCtR0r
         Af2sAx5G1rlpKoGpBwpAadZm6n9GTNOOEJ/C8y+4=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 3/5] rcu-tasks: Add #include of rcupdate_trace.h to update.c
Date:   Mon, 22 Jun 2020 17:24:41 -0700
Message-Id: <20200623002443.25954-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002423.GA25869@paulmck-ThinkPad-P72>
References: <20200623002423.GA25869@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Although this is in some strict sense unnecessary, it is good to allow
the compiler to compare the function declaration with its definition.
This commit therefore adds a #include of linux/rcupdate_trace.h to
kernel/rcu/update.c.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/update.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 84843ad..c0fea80 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -42,6 +42,7 @@
 #include <linux/kprobes.h>
 #include <linux/slab.h>
 #include <linux/irq_work.h>
+#include <linux/rcupdate_trace.h>
 
 #define CREATE_TRACE_POINTS
 
-- 
2.9.5

