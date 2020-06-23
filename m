Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D4FC433DF
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6190208B8
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592871718;
	bh=WsPggT1GQk7FhVlxqPY2V/TwO4RZGy9PKukXKLCaOak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OY2VYM3fGNnU97DM2eJdXrYOBsITHNH5DMbQ8wr7Ur9imEjbgEc2F3RD3JABhRV7u
	 ZnkP8ssjbmSvj9D6xrPrdm9v7ifzKV1huYzJWTri29zQv9SzZQDz6Uu9ETwKWW59sq
	 T6owv10/fLzw5JcE099nAq4pJaevowhUMhGLvHGU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731452AbgFWAV6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:21:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:48132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731590AbgFWAVz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:21:55 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5361920C09;
        Tue, 23 Jun 2020 00:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592871714;
        bh=WsPggT1GQk7FhVlxqPY2V/TwO4RZGy9PKukXKLCaOak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V4sJDvlYjmZWoY6dtcPFyFzG0KNOWiJ7o0txVrx/Q8vW3jOnD3k4+oS01uFgpO+pO
         dXqJyCJWtmcGogvm+4+9MsiIABqXbhNt6CXtORSQ2AfYfKFb9XSDQjevgt6pc/kqk+
         sNvDW2tuPSUSOt+XSOsaK8ZkknvTwVIK9IdIOHYI=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 25/26] rcu: Remove KCSAN stubs
Date:   Mon, 22 Jun 2020 17:21:46 -0700
Message-Id: <20200623002147.25750-25-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002128.GA25456@paulmck-ThinkPad-P72>
References: <20200623002128.GA25456@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

KCSAN is now in mainline, so this commit removes the stubs for the
data_race(), ASSERT_EXCLUSIVE_WRITER(), and ASSERT_EXCLUSIVE_ACCESS()
macros.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e7161e0..6422870 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -67,19 +67,6 @@
 #endif
 #define MODULE_PARAM_PREFIX "rcutree."
 
-#ifndef data_race
-#define data_race(expr)							\
-	({								\
-		expr;							\
-	})
-#endif
-#ifndef ASSERT_EXCLUSIVE_WRITER
-#define ASSERT_EXCLUSIVE_WRITER(var) do { } while (0)
-#endif
-#ifndef ASSERT_EXCLUSIVE_ACCESS
-#define ASSERT_EXCLUSIVE_ACCESS(var) do { } while (0)
-#endif
-
 /* Data structures. */
 
 /*
-- 
2.9.5

