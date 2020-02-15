Return-Path: <SRS0=vfTc=4D=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC97C35242
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 00:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3FB4222C4
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 00:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581725037;
	bh=NqHPv1+Dz9zT/DxiPA3nxqlyLqVX3ckZlN6LBOYdu7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bb0UqJQfP+qttFVj9GCbxVRaP7z0HAb1IptXUQQL8DXV0VKFHhOW8u6xWdCyj+qYm
	 eiQnwrk6SxC8w24X6YcboLQYmMDCb2J+dbd4uEbT7kevkoPgC+rJD0qjDHjwkMDWzO
	 b9JKHOWv0vzezuXRZv0/uVJUvZNNbZ6Iith9YIdU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbgBOAD5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:03:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:39344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727212AbgBOAD4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 19:03:56 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1B392465D;
        Sat, 15 Feb 2020 00:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581725036;
        bh=NqHPv1+Dz9zT/DxiPA3nxqlyLqVX3ckZlN6LBOYdu7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r9YKWvIUDOQYSB+4FO2OEMVvwlSO134hh6VHwj8zqmIoUB/sH2J/RqbY2yEq9/6cl
         y92BFwsXCHVJh6XsyKoTim4ULF9aXzR5UVD/NTeWBRdLjGtKO9NE62C7Yb7Z4MuS6m
         FCPJ2mey1yf6OQpSyHPtB7wJGMQTjiiwmg08DnhQ=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 4/4] locktorture: Forgive apparent unfairness if CPU hotplug
Date:   Fri, 14 Feb 2020 16:03:37 -0800
Message-Id: <20200215000337.14667-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200215000312.GA14585@paulmck-ThinkPad-P72>
References: <20200215000312.GA14585@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

If CPU hotplug testing is enabled, a lock might appear to be maximally
unfair just because one of the CPUs was offline almost all the time.
This commit therefore forgives unfairness if CPU hotplug testing was
enabled.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/locking/locktorture.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 5baf904..5efbfc6 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -704,7 +704,8 @@ static void __torture_print_stats(char *page,
 	page += sprintf(page,
 			"%s:  Total: %lld  Max/Min: %ld/%ld %s  Fail: %d %s\n",
 			write ? "Writes" : "Reads ",
-			sum, max, min, max / 2 > min ? "???" : "",
+			sum, max, min,
+			!onoff_interval && max / 2 > min ? "???" : "",
 			fail, fail ? "!!!" : "");
 	if (fail)
 		atomic_inc(&cxt.n_lock_torture_errors);
-- 
2.9.5

