Return-Path: <SRS0=LJ8s=4C=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC587C47409
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B21F222C4
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581723590;
	bh=d7aA2/dlzT4P11O98+Hq8LXvNXxHYx3PBFm37240aW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lvNWddAqpc/2uqK1ENpwJtdVSb4D+MLGUqCQWgUiAqrzlM8JHethL+5kkxxwf6sQ0
	 hRwNnUa/UDlByiuGWQA3wsWFdTyaIF/HNoUr+cIy7GMvHDGLcuCD56uwTHOeh5gNuz
	 dvYmcopNeyqmS8us9evsg/V1hQTinqm1hjd/TWIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgBNXje (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:39:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:60236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727957AbgBNXje (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 18:39:34 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 612A924681;
        Fri, 14 Feb 2020 23:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581723573;
        bh=d7aA2/dlzT4P11O98+Hq8LXvNXxHYx3PBFm37240aW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XkEUzIIa1varV/S+0sAQd9SoB6+fRY0v94DpGgqe0GUzd7/C0MWcrvU+BYfftyaGq
         FPX+SiG7V93eWIMSHtIfCgGMJmVMWot8stBghj/O1dfhquulApOzqGtqWUff17lx/R
         WPvNN6CEy8MXhP5u1LMLCRtpdw3wbV5z4L85uOQY=
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
Subject: [PATCH tip/core/rcu 7/9] doc/RCU/rcu: Use https instead of http if possible
Date:   Fri, 14 Feb 2020 15:39:01 -0800
Message-Id: <20200214233903.12916-7-paulmck@kernel.org>
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
 Documentation/RCU/rcu.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/rcu.rst b/Documentation/RCU/rcu.rst
index 2a830c5..0e03c6e 100644
--- a/Documentation/RCU/rcu.rst
+++ b/Documentation/RCU/rcu.rst
@@ -79,7 +79,7 @@ Frequently Asked Questions
   Of these, one was allowed to lapse by the assignee, and the
   others have been contributed to the Linux kernel under GPL.
   There are now also LGPL implementations of user-level RCU
-  available (http://liburcu.org/).
+  available (https://liburcu.org/).
 
 - I hear that RCU needs work in order to support realtime kernels?
 
-- 
2.9.5

