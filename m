Return-Path: <SRS0=LJ8s=4C=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D858C3B1BF
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5317E24650
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581723571;
	bh=zhQ9T0XsdpW7S5BU0y1FMF0n1EHkblrpesxn6byY79Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WYxSX7hYS6xOOOOiu9znWthLKtnpq5cEDiUqTtRIfk4LcwHq49hxS2dQUf325BMUG
	 yu0QJYMmH0ckKNJmsO5HU1Ys4gWkrwKyhtrWh6mOjeVCY1EImTcMHz5IVixwfuDCq6
	 SCq2OIkZwkra9BCvdqE965bN9hkQy1JXZ805at38=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgBNXja (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:39:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:60150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727957AbgBNXja (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 18:39:30 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86F8E24677;
        Fri, 14 Feb 2020 23:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581723570;
        bh=zhQ9T0XsdpW7S5BU0y1FMF0n1EHkblrpesxn6byY79Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2doby36SVd5u9ga7Or3ovJqql21vE3gX6btLMjvhfWFlKZKcT3MeE76ORL6QSKN+G
         wDh/dRHb/rMitKi0pdWbbZyStxSHp5ichNTKgx9GqMyyrhdFYu+tyA6VYoBHxegLj3
         MJsgsOFyC5hWLSc97FwCyVpUqrM7ULv6WGttZa3U=
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
Subject: [PATCH tip/core/rcu 6/9] doc/RCU/rcu: Use absolute paths for non-rst files
Date:   Fri, 14 Feb 2020 15:39:00 -0800
Message-Id: <20200214233903.12916-6-paulmck@kernel.org>
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
 Documentation/RCU/rcu.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/RCU/rcu.rst b/Documentation/RCU/rcu.rst
index a1dd71d..2a830c5 100644
--- a/Documentation/RCU/rcu.rst
+++ b/Documentation/RCU/rcu.rst
@@ -75,7 +75,7 @@ Frequently Asked Questions
 - I hear that RCU is patented?  What is with that?
 
   Yes, it is.  There are several known patents related to RCU,
-  search for the string "Patent" in RTFP.txt to find them.
+  search for the string "Patent" in Documentation/RCU/RTFP.txt to find them.
   Of these, one was allowed to lapse by the assignee, and the
   others have been contributed to the Linux kernel under GPL.
   There are now also LGPL implementations of user-level RCU
@@ -88,5 +88,5 @@ Frequently Asked Questions
 
 - Where can I find more information on RCU?
 
-  See the RTFP.txt file in this directory.
+  See the Documentation/RCU/RTFP.txt file.
   Or point your browser at (http://www.rdrop.com/users/paulmck/RCU/).
-- 
2.9.5

