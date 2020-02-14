Return-Path: <SRS0=LJ8s=4C=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77960C3B1BF
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456C5222C4
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581723590;
	bh=EGqHdSMVcis0FajqRimoIZpldCRfWEGPwvByc59d9A8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H0uBjbaQIZyu+r2W4EYE+8M/DxadDqZYSmmsEb4sELyE4Ha5AM8FHu4ipp2KIMLlQ
	 1RTRIzn5VCuOhsA7fibOBIO3RitDMhsB1rXzLSUu11/Jj6h6cFNhPtCpe9ayQvebNA
	 HyFvBg/F5sis2Jsflm2LAk1occJJWKBPd27mkixc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgBNXj2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:39:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:60054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728426AbgBNXj0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 18:39:26 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C85DB2467D;
        Fri, 14 Feb 2020 23:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581723566;
        bh=EGqHdSMVcis0FajqRimoIZpldCRfWEGPwvByc59d9A8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c0z7wqDsO/qtfMH+WM6e/I1otnMO61Gid4mrXyMm5cmMElkTH8ADpEQsFoEryGw2V
         rinkL4VqnYfxIkwDW9U8J5OwdZjPcqmSa7p/PgfQcSgL/MOk5YV40MrWM8qEM7sQOM
         dHv5F14w0wREiiSPvJBPp2vH1fjAz7zqvHFT9M4c=
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
Subject: [PATCH tip/core/rcu 5/9] doc/RCU/rcu: Use ':ref:' for links to other docs
Date:   Fri, 14 Feb 2020 15:38:59 -0800
Message-Id: <20200214233903.12916-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <@@@>
References: <@@@>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/rcu.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/RCU/rcu.rst b/Documentation/RCU/rcu.rst
index 8dfb437..a1dd71d 100644
--- a/Documentation/RCU/rcu.rst
+++ b/Documentation/RCU/rcu.rst
@@ -11,8 +11,8 @@ must be long enough that any readers accessing the item being deleted have
 since dropped their references.  For example, an RCU-protected deletion
 from a linked list would first remove the item from the list, wait for
 a grace period to elapse, then free the element.  See the
-Documentation/RCU/listRCU.rst file for more information on using RCU with
-linked lists.
+:ref:`Documentation/RCU/listRCU.rst <list_rcu_doc>` for more information on
+using RCU with linked lists.
 
 Frequently Asked Questions
 --------------------------
@@ -50,7 +50,7 @@ Frequently Asked Questions
 - If I am running on a uniprocessor kernel, which can only do one
   thing at a time, why should I wait for a grace period?
 
-  See the Documentation/RCU/UP.rst file for more information.
+  See :ref:`Documentation/RCU/UP.rst <up_doc>` for more information.
 
 - How can I see where RCU is currently used in the Linux kernel?
 
@@ -68,9 +68,9 @@ Frequently Asked Questions
 
 - Why the name "RCU"?
 
-  "RCU" stands for "read-copy update".  The file Documentation/RCU/listRCU.rst
-  has more information on where this name came from, search for
-  "read-copy update" to find it.
+  "RCU" stands for "read-copy update".
+  :ref:`Documentation/RCU/listRCU.rst <list_rcu_doc>` has more information on where
+  this name came from, search for "read-copy update" to find it.
 
 - I hear that RCU is patented?  What is with that?
 
-- 
2.9.5

