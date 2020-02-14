Return-Path: <SRS0=LJ8s=4C=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD763C35242
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B262187F
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581724622;
	bh=1yDXmByJHJbyc+OIOoTWc6Bsev1BIwFRB6ZTOt2JdzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a2onEgDWPWUInJtTG18k3sLICGZ4mYElmP6wo7xm+cuDUbE09LPoWZapA2NtPD5OP
	 gSPhDqrBQQIYqPdMmlp3JUmyBesQBMyIcuGHDSmRGfK0K7RfyyIg5Hp4BUNjsLnZnE
	 iSK9l1lqqy5TMX6U73AUxeq/TRgw2KwRWY8HKqto=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgBNX47 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:56:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:36780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbgBNX46 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 18:56:58 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E19BB222C4;
        Fri, 14 Feb 2020 23:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581724618;
        bh=1yDXmByJHJbyc+OIOoTWc6Bsev1BIwFRB6ZTOt2JdzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1BdvWyYP31xtBAs29lItWDDpBfERSaxW8qDQTi1Ca+/2DmLzL65cECe6YnFY/IRbc
         yo5MXYvoTU2ySTmOSAFkybCuggr78DC7auv9p3RqfzYEdPzTW4rsODgd8krfxfW+Bt
         R5D1F8Kz/Jymf7X6NYhOpkuNguuHlhjpoX29Z1AU=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        SeongJae Park <sjpark@amazon.de>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 13/30] rcu: Fix typos in beginning comments
Date:   Fri, 14 Feb 2020 15:55:50 -0800
Message-Id: <20200214235607.13749-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200214235536.GA13364@paulmck-ThinkPad-P72>
References: <20200214235536.GA13364@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 2 +-
 kernel/rcu/tree.c     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 657e6a7..7ddb29c 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -5,7 +5,7 @@
  * Copyright (C) IBM Corporation, 2006
  * Copyright (C) Fujitsu, 2012
  *
- * Author: Paul McKenney <paulmck@linux.ibm.com>
+ * Authors: Paul McKenney <paulmck@linux.ibm.com>
  *	   Lai Jiangshan <laijs@cn.fujitsu.com>
  *
  * For detailed explanation of Read-Copy Update mechanism see -
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 53946b1..a70f56b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1,12 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Read-Copy Update mechanism for mutual exclusion
+ * Read-Copy Update mechanism for mutual exclusion (tree-based version)
  *
  * Copyright IBM Corporation, 2008
  *
  * Authors: Dipankar Sarma <dipankar@in.ibm.com>
  *	    Manfred Spraul <manfred@colorfullife.com>
- *	    Paul E. McKenney <paulmck@linux.ibm.com> Hierarchical version
+ *	    Paul E. McKenney <paulmck@linux.ibm.com>
  *
  * Based on the original work by Paul McKenney <paulmck@linux.ibm.com>
  * and inputs from Rusty Russell, Andrea Arcangeli and Andi Kleen.
-- 
2.9.5

