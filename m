Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A6AC433DF
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F1E120720
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592871761;
	bh=NmxDGhJY6IM9UnMU2hQ8YCQUZw8QAxbAQho/Brjluks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aH0k6m9KIM7rXH8J75YCbRutOtZxEEd9GeNMC0JXqPRGm4ZDdNCR96HOE42Vtzucr
	 q1qt/yvipkkd6fExPCX83uSwdhwkngD+eR0C1xou1lqHeerr6qvEQKgFdu2Dh06bqa
	 gJWYw3jsDXMtsrVB6Nm04+Kzsw0v53RN6mvsXXlw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731566AbgFWAWl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:22:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731560AbgFWAVw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:21:52 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7494220DD4;
        Tue, 23 Jun 2020 00:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592871712;
        bh=NmxDGhJY6IM9UnMU2hQ8YCQUZw8QAxbAQho/Brjluks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=19DudY9YYVTli6mgQVuYTT11m1gZ9xhEjWnHd2yjztmR4/8+tPT69iRFQANh1R+e9
         PLtwM380CnJtt1rgSJLbpuYZcrhDd1PoQFlDa1fWx+JCTtM4ME4JxlgT5p8caLK8lG
         WwmhQJWiHoE4BLh+grGpGdLEP8aGioUSdi2qXQq8=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 16/26] rcu: Mark rcu_nmi_enter() call to rcu_cleanup_after_idle() noinstr
Date:   Mon, 22 Jun 2020 17:21:37 -0700
Message-Id: <20200623002147.25750-16-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002128.GA25456@paulmck-ThinkPad-P72>
References: <20200623002128.GA25456@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The objtool complains about the call to rcu_cleanup_after_idle() from
rcu_nmi_enter(), so this commit adds instrumentation_begin() before that
call and instrumentation_end() after it.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 08e3648..67912ad 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -980,8 +980,11 @@ noinstr void rcu_nmi_enter(void)
 		rcu_dynticks_eqs_exit();
 		// ... but is watching here.
 
-		if (!in_nmi())
+		if (!in_nmi()) {
+			instrumentation_begin();
 			rcu_cleanup_after_idle();
+			instrumentation_end();
+		}
 
 		incby = 1;
 	} else if (!in_nmi()) {
-- 
2.9.5

