Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD03C54E76
	for <rcu@archiver.kernel.org>; Thu,  5 Jan 2023 00:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbjAEAKC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 4 Jan 2023 19:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbjAEAKB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 4 Jan 2023 19:10:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB7543A16;
        Wed,  4 Jan 2023 16:09:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2552F6189F;
        Thu,  5 Jan 2023 00:09:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F23AC433A0;
        Thu,  5 Jan 2023 00:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672877397;
        bh=b7i4mGR/FuXTcyH6kks7yRlm8D/4PuTAENFbH1OA8wg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OMSOFYzS1xnbA9wpLTLSK1S80Tuk4cu339hnuEsXF0+nH7/4n/hUt/Chf/1xHIyDo
         +nk9Dr2r9VtlWYWW6eXzeNYN0FA4fDj48PnsTo+CyEFWqdx7wjzns2MOcUYrmGCk1t
         dRHwCf3vzxS89y9huoBaTMhHzyVu0iffvG+YSqAYvTC9AbXwz/QDK9Lfq/HnnkaQfa
         /hcIOtO+PMVEwjdAyJOE9zOfYz6nraJkpEYVtqE0G1IBMN8YbsMdY4WpO08pZj8dXG
         O7ylODSJe9rn3XGLIU/wjRPKEC6bupjyrNm6ay65AXWZHphd/SPhW9Ppt2jZsQOmQh
         KEW6zDE4YF63w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D2EB75C1C5D; Wed,  4 Jan 2023 16:09:56 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 09/15] doc: Update UP.rst
Date:   Wed,  4 Jan 2023 16:09:49 -0800
Message-Id: <20230105000955.1767218-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105000945.GA1767128@paulmck-ThinkPad-P17-Gen-1>
References: <20230105000945.GA1767128@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This commit updates UP.rst to reflect changes over the past few years,
including the advent of userspace RCU libraries for constrained systems.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/UP.rst | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/RCU/UP.rst b/Documentation/RCU/UP.rst
index e26dda27430c8..8b20fd45f2558 100644
--- a/Documentation/RCU/UP.rst
+++ b/Documentation/RCU/UP.rst
@@ -38,7 +38,7 @@ by having call_rcu() directly invoke its arguments only if it was called
 from process context.  However, this can fail in a similar manner.
 
 Suppose that an RCU-based algorithm again scans a linked list containing
-elements A, B, and C in process contexts, but that it invokes a function
+elements A, B, and C in process context, but that it invokes a function
 on each element as it is scanned.  Suppose further that this function
 deletes element B from the list, then passes it to call_rcu() for deferred
 freeing.  This may be a bit unconventional, but it is perfectly legal
@@ -59,7 +59,8 @@ Example 3: Death by Deadlock
 Suppose that call_rcu() is invoked while holding a lock, and that the
 callback function must acquire this same lock.  In this case, if
 call_rcu() were to directly invoke the callback, the result would
-be self-deadlock.
+be self-deadlock *even if* this invocation occurred from a later
+call_rcu() invocation a full grace period later.
 
 In some cases, it would possible to restructure to code so that
 the call_rcu() is delayed until after the lock is released.  However,
@@ -85,6 +86,14 @@ Quick Quiz #2:
 
 :ref:`Answers to Quick Quiz <answer_quick_quiz_up>`
 
+It is important to note that userspace RCU implementations *do*
+permit call_rcu() to directly invoke callbacks, but only if a full
+grace period has elapsed since those callbacks were queued.  This is
+the case because some userspace environments are extremely constrained.
+Nevertheless, people writing userspace RCU implementations are strongly
+encouraged to avoid invoking callbacks from call_rcu(), thus obtaining
+the deadlock-avoidance benefits called out above.
+
 Summary
 -------
 
-- 
2.31.1.189.g2e36527f23

