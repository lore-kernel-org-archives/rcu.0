Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3FCC388F7
	for <rcu@archiver.kernel.org>; Fri, 13 Nov 2020 12:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDE4F2224F
	for <rcu@archiver.kernel.org>; Fri, 13 Nov 2020 12:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCDUV+sK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgKMMOj (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 13 Nov 2020 07:14:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:48218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgKMMOc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 13 Nov 2020 07:14:32 -0500
Received: from localhost.localdomain (unknown [176.167.84.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDE7722252;
        Fri, 13 Nov 2020 12:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605269672;
        bh=DVMPK24VCB0SQGkgTrq1ZNTC4um6INRYVz5UW+rJ0Ek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oCDUV+sKoul43k/KcBhKbtuJVmp5h0v3bQ7NuPrZpLDrprDmN8KKG9cPQ5gzBznMz
         i4CK23Z1X9Yzz8SDaHX2gF6d6xLSZ3kHfzwfm1Dz1TO8ldPVRhSmLcjtQKd9IiVUkO
         r3aDlSuP1HNrWme6fWZ7xM+4KmzY7ycPMavHIwS0=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org
Subject: [PATCH 16/19] rcutorture: Export nocb (de)offloading functions
Date:   Fri, 13 Nov 2020 13:13:31 +0100
Message-Id: <20201113121334.166723-17-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113121334.166723-1-frederic@kernel.org>
References: <20201113121334.166723-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

("rcutorture: Test runtime toggling of CPUs' callback offloading") should
be moved on top of this pile and include this fixup.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/tree_plugin.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index b68714e5ce64..ada4b875e489 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2397,6 +2397,7 @@ int rcu_nocb_cpu_deoffload(int cpu)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(rcu_nocb_cpu_deoffload);
 
 static int __rcu_nocb_rdp_offload(struct rcu_data *rdp)
 {
@@ -2472,6 +2473,7 @@ int rcu_nocb_cpu_offload(int cpu)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(rcu_nocb_cpu_offload);
 
 
 void __init rcu_init_nohz(void)
-- 
2.25.1

