Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426B0C2BB85
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17A262076D
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586972028;
	bh=vqAfZeawoazWH71QWkK0Ywudv0dR15fO75VLbA0OJnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fYMr74pka26Dy4EI4UViVRdzZKwdG3y8kJqF/re2yKLJNyYlQERa2oRH3UOFOz8bk
	 KbJSwU99c/oktPm0/MejLFPrMnSaoD/CcwnBkxVTL74cd86pOLc64jwa/SsgzbfITs
	 5yrjCYX5b9/p/xLFhXqCbzsReFlIYUnrC+5hEP9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411129AbgDORdm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:33:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:45968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411120AbgDORbE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 13:31:04 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E25B621655;
        Wed, 15 Apr 2020 17:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586971864;
        bh=vqAfZeawoazWH71QWkK0Ywudv0dR15fO75VLbA0OJnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OyBBZVbzl1kvOAZgBBlYUTC7OC5Q1Cl/+mxQu6Z5tN6eXxhXDwmjv8E+wPwYQWe/z
         V7q8Xgx6Dw899rdmTqTsQrR2ioWDbdw7SPa74Wnon9yFU9Y/e8mq1Dpbt+vf0ouPS9
         Lpdu88rDoTldrcGgOd5QAoGkEWsK14JIt7BzCm5c=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 07/18] rcutorture: Right-size TREE10 CPU consumption
Date:   Wed, 15 Apr 2020 10:30:49 -0700
Message-Id: <20200415173100.9927-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415173037.GA9768@paulmck-ThinkPad-P72>
References: <20200415173037.GA9768@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The number of CPUs is tuned to allow "4*CFLIST TREE10" on a large system,
up from "3*CFLIST TREE10" previously.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/TREE10 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE10 b/tools/testing/selftests/rcutorture/configs/rcu/TREE10
index 2debe78..7311f84 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE10
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE10
@@ -1,5 +1,5 @@
 CONFIG_SMP=y
-CONFIG_NR_CPUS=100
+CONFIG_NR_CPUS=56
 CONFIG_PREEMPT_NONE=y
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
-- 
2.9.5

