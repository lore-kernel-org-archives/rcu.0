Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF37C6377B
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDED460725
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbhGUT5p (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 15:57:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:56332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231787AbhGUT5p (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 15:57:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 963AB61241;
        Wed, 21 Jul 2021 20:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626899901;
        bh=PiwE8bKHOYIPDLz77rhdrSex9XbZaPhjXnqWpREoRi8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QJ87wJCjgVjV0PUFaVOqbZ5aCFWyMxaK5hJJkEehaAjffSU8D8kw8SaphPc4qRgmt
         HjDh8/6XeTPdOa4wJLYK09s/s2kVXCtQQpz3D+voIFhujLwDgjJabVpxuUf22twwfN
         PWwOd5Tt8T0M4RtyzP3c5pIVrC9dDbimz9UP3pnr9bqnKnbc39eeIFIU0tBF+db9in
         w9/22B135Dv84EDrb8w5gGnTnCeci3bHKcqM+QMEilb3aja6h+d8h8rjo7bjEUg3++
         yqaxc2Z/u6/Preed3KgN4Dsq20Ot0Swg1V/ajY6sEBN+FdpZ4PLzXqFHRQUNMiM+NZ
         RIDOOBJZvbmnQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5D5E25C0A2D; Wed, 21 Jul 2021 13:38:21 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 4/5] rcu-tasks: Fix synchronize_rcu_rude() typo in comment
Date:   Wed, 21 Jul 2021 13:38:17 -0700
Message-Id: <20210721203818.3398345-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721203758.GA3386731@paulmck-ThinkPad-P17-Gen-1>
References: <20210721203758.GA3386731@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This commit replaces the fictitious synchronize_rcu_rude() function with
its real-world synchronize_rcu_tasks_rude() counterpart.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 1cece5e9be9a9..f9f52daacd1c5 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -643,8 +643,8 @@ void exit_tasks_rcu_finish(void) { exit_tasks_rcu_finish_trace(current); }
 //
 // "Rude" variant of Tasks RCU, inspired by Steve Rostedt's trick of
 // passing an empty function to schedule_on_each_cpu().  This approach
-// provides an asynchronous call_rcu_tasks_rude() API and batching
-// of concurrent calls to the synchronous synchronize_rcu_rude() API.
+// provides an asynchronous call_rcu_tasks_rude() API and batching of
+// concurrent calls to the synchronous synchronize_rcu_tasks_rude() API.
 // This invokes schedule_on_each_cpu() in order to send IPIs far and wide
 // and induces otherwise unnecessary context switches on all online CPUs,
 // whether idle or not.
-- 
2.31.1.189.g2e36527f23

