Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D2DCD80B9
	for <rcu@archiver.kernel.org>; Tue, 10 Oct 2023 11:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjJJL7w (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 10 Oct 2023 07:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjJJL7u (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 10 Oct 2023 07:59:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08936E4;
        Tue, 10 Oct 2023 04:59:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21591C433C7;
        Tue, 10 Oct 2023 11:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696939185;
        bh=GE9U3gvNzMf7JPUQGgbJUlMwcLomHVh99nCtJR5L1+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p2H6YDROt4PXAwVCp/EPXQHKwR+d0QbgGGGJxGRNfuIgFZrO0QTCFXlbzLZqN/Kky
         ym9Dzava8Lp2B5c43ipJ5Z9KHqGyK+6sxOpKypQ3iHvU3yiifIU1QuGmmtRz4ZOx++
         K0vmJCK80n/jG6HJvM/sYHd2LuAy8xuWEVt/5FE/Egyy+LuWhxzS0vv+mAhisN8Brv
         S3rR3w1qxQNAMnf8FHlN/P/qfJQYGXhu/ifLhEd5IGDW4/9ncKhZBBLGMbwQ6kJ2th
         XCjGLSF+9VVwj09CchQK5cNabuWYo+DRNA/CxAabUdhIN7SWZskcyxYJ8HFf8/nck+
         0W/nForttA74w==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 04/23] rcu: Include torture_sched_setaffinity() declaration
Date:   Tue, 10 Oct 2023 13:59:02 +0200
Message-Id: <20231010115921.988766-5-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010115921.988766-1-frederic@kernel.org>
References: <20231010115921.988766-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The prototype for torture_sched_setaffinity() will be moved to a
different header, which will need to be included from update.c to avoid
this W=1 warning:

kernel/rcu/update.c:529:6: error: no previous prototype for 'torture_sched_setaffinity' [-Werror=missing-prototypes]
  529 | long torture_sched_setaffinity(pid_t pid, const struct cpumask *in_mask)

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/update.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 19bf6fa3ee6a..9d3c2e6ba667 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -25,6 +25,7 @@
 #include <linux/interrupt.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/debug.h>
+#include <linux/torture.h>
 #include <linux/atomic.h>
 #include <linux/bitops.h>
 #include <linux/percpu.h>
-- 
2.34.1

