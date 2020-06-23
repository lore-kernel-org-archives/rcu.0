Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EF2C433DF
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 346292053B
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592872328;
	bh=2w0aPu1EKrImKMpbqrUu8Lt1cixr3NH2U/MG/Se/7Ik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1FthvcqnbR0f2PML6HEyBbLrA/emC7cbyijbnrM5Rh/VqNXQEgHliX24UWTHumGyt
	 WNztxDoA9qv3RKxUQt1daiiSzeXPDnNpxnCRfiMKCiCnWE4BRbcH/ZoYKj90sIMqdH
	 ZTRJxDxZPpHrmOnClUmv9cfjlTogYN3hb22WtWAU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731944AbgFWAb7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:31:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:55360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731658AbgFWAaR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:30:17 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64F502083E;
        Tue, 23 Jun 2020 00:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872217;
        bh=2w0aPu1EKrImKMpbqrUu8Lt1cixr3NH2U/MG/Se/7Ik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JiHnrf6DPYsFkktcpoPraWo6iGpSI6lJfL4w2X447I2NcLcpbv3EQXomBu1iZkmt5
         Q6qU/q+yx+k4wfGRB2wheZMp+pD+wbjQ5GMlEfnrDQ6+tXufWU6lANpPco2DlCgUYd
         SkwXGTKqNegfO+DkeU2rwF5kpRJPkb4PeeZUodfo=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 11/30] refperf: Dynamically allocate thread-summary output buffer
Date:   Mon, 22 Jun 2020 17:29:54 -0700
Message-Id: <20200623003013.26252-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002941.GA26089@paulmck-ThinkPad-P72>
References: <20200623002941.GA26089@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, the buffer used to accumulate the thread-summary output is
fixed size, which will cause problems if someone decides to run on a large
number of PCUs.  This commit therefore dynamically allocates this buffer.

[ paulmck: Fix memory allocation as suggested by KASAN. ]
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refperf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index 75b9cce..fc940e3 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -301,9 +301,12 @@ u64 process_durations(int n)
 	int i;
 	struct reader_task *rt;
 	char buf1[64];
-	char buf[512];
+	char *buf;
 	u64 sum = 0;
 
+	buf = kmalloc(128 + nreaders * 32, GFP_KERNEL);
+	if (!buf)
+		return 0;
 	buf[0] = 0;
 	sprintf(buf, "Experiment #%d (Format: <THREAD-NUM>:<Total loop time in ns>)",
 		exp_idx);
@@ -322,6 +325,7 @@ u64 process_durations(int n)
 
 	PERFOUT("%s\n", buf);
 
+	kfree(buf);
 	return sum;
 }
 
-- 
2.9.5

