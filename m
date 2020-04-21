Return-Path: <SRS0=neSi=6F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C6AC55185
	for <rcu@archiver.kernel.org>; Tue, 21 Apr 2020 17:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3E362070B
	for <rcu@archiver.kernel.org>; Tue, 21 Apr 2020 17:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587488711;
	bh=A/gl9GiSINDqJ4PJGJrHlgv4JPVRUB394Q+IiwjdxOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u1pWxB+MUrIvnzHrcqz5e2KL/O86kWygeZUWcUp2uYcJmvlsLnt5hKqJqknOLULMU
	 J0x+Eqaw4BE6TW+k2hKADMf5Wbg+1qPrQUa+JHz4wlOy+NEkTXP8N0SSlNgpZypuhT
	 IxQlnD0WZmPlBWcowMJyN18SjF9o2NY6wSSPFQn0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbgDUREP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 21 Apr 2020 13:04:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbgDUREO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 21 Apr 2020 13:04:14 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA0812070B;
        Tue, 21 Apr 2020 17:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587488654;
        bh=A/gl9GiSINDqJ4PJGJrHlgv4JPVRUB394Q+IiwjdxOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=phBRWglMXtPcapPsj8eK7SRF7NlC1RIOXhbVo/a/GezVoyXq/28PllUsa3njugwmv
         jUKsJIXiNdjfeVBAT5kVHzJ9lSg5I56PjcVy0qwHCFLRCzFUU6xoigXfiDBXvzW1AW
         FMNRqUxuJIZEkxb3w66+CZ7kisqQgKipjbnZQem4=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jQwJg-00CmLe-42; Tue, 21 Apr 2020 19:04:12 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH 03/10] docs: RCU: convert lockdep.txt to ReST
Date:   Tue, 21 Apr 2020 19:04:04 +0200
Message-Id: <1ebc0a13f0710a080c2b6f59f546e3c8b60f17b3.1587488137.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1587488137.git.mchehab+huawei@kernel.org>
References: <cover.1587488137.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

- Add a SPDX header;
- Adjust document title;
- Mark literal blocks as such;
- Add it to RCU/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/RCU/index.rst                    |  1 +
 Documentation/RCU/{lockdep.txt => lockdep.rst} | 12 ++++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)
 rename Documentation/RCU/{lockdep.txt => lockdep.rst} (96%)

diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
index 430a37132b2c..fa7a2a8949b7 100644
--- a/Documentation/RCU/index.rst
+++ b/Documentation/RCU/index.rst
@@ -11,6 +11,7 @@ RCU concepts
 
    arrayRCU
    checklist
+   lockdep
    lockdep-splat
    rcubarrier
    rcu_dereference
diff --git a/Documentation/RCU/lockdep.txt b/Documentation/RCU/lockdep.rst
similarity index 96%
rename from Documentation/RCU/lockdep.txt
rename to Documentation/RCU/lockdep.rst
index 89db949eeca0..f1fc8ae3846a 100644
--- a/Documentation/RCU/lockdep.txt
+++ b/Documentation/RCU/lockdep.rst
@@ -1,4 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========================
 RCU and lockdep checking
+========================
 
 All flavors of RCU have lockdep checking available, so that lockdep is
 aware of when each task enters and leaves any flavor of RCU read-side
@@ -8,7 +12,7 @@ tracking to include RCU state, which can sometimes help when debugging
 deadlocks and the like.
 
 In addition, RCU provides the following primitives that check lockdep's
-state:
+state::
 
 	rcu_read_lock_held() for normal RCU.
 	rcu_read_lock_bh_held() for RCU-bh.
@@ -63,7 +67,7 @@ checking of rcu_dereference() primitives:
 The rcu_dereference_check() check expression can be any boolean
 expression, but would normally include a lockdep expression.  However,
 any boolean expression can be used.  For a moderately ornate example,
-consider the following:
+consider the following::
 
 	file = rcu_dereference_check(fdt->fd[fd],
 				     lockdep_is_held(&files->file_lock) ||
@@ -82,7 +86,7 @@ RCU read-side critical sections, in case (2) the ->file_lock prevents
 any change from taking place, and finally, in case (3) the current task
 is the only task accessing the file_struct, again preventing any change
 from taking place.  If the above statement was invoked only from updater
-code, it could instead be written as follows:
+code, it could instead be written as follows::
 
 	file = rcu_dereference_protected(fdt->fd[fd],
 					 lockdep_is_held(&files->file_lock) ||
@@ -105,7 +109,7 @@ false and they are called from outside any RCU read-side critical section.
 
 For example, the workqueue for_each_pwq() macro is intended to be used
 either within an RCU read-side critical section or with wq->mutex held.
-It is thus implemented as follows:
+It is thus implemented as follows::
 
 	#define for_each_pwq(pwq, wq)
 		list_for_each_entry_rcu((pwq), &(wq)->pwqs, pwqs_node,
-- 
2.25.2

