Return-Path: <SRS0=5ltB=EL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143F8C55178
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF5FE20715
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604617817;
	bh=h9SU9vUbFz1ijbGCGqgEEi7VUhGXALuvKvMWjnAg/ic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZsNGaz2vx9vNe3gEE4/9Ob6UuW1YOPBdF1QLWxF66mwSnfGDwsI3Pwf1od2gjs5fk
	 2FA1updAEnmEerOK8bpCYJoZwlbHqiPBTHywFHUkOqKZR6PvWqXZMUt6suRxF7f6A6
	 XF1zddEjdHfkconmuMObI/kegp58HFG3rd1ERgb0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732542AbgKEXJ0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Nov 2020 18:09:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:34452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732441AbgKEXJZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Nov 2020 18:09:25 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B339217A0;
        Thu,  5 Nov 2020 23:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604617765;
        bh=h9SU9vUbFz1ijbGCGqgEEi7VUhGXALuvKvMWjnAg/ic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zKec6P5P48azcbUiknmOX3WIZdYMMiqstS8TE1SQEzl9+F2vYv1zg0yVSFFTqQM1V
         1BmyNveJ+TR3tv3//okfK0B8LqNRJDx5TH6UH4NkkoFsLmYDEWiG5KXQTgMw+G5iRP
         mECAIH9IMzPL5cfOoCjVx9gh7+RlNz2gp+bWjnrA=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Asif Rasheed <b00073877@aus.edu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 04/16] list.h: Update comment to explicitly note circular lists
Date:   Thu,  5 Nov 2020 15:09:09 -0800
Message-Id: <20201105230921.19017-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105230856.GA18904@paulmck-ThinkPad-P72>
References: <20201105230856.GA18904@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Asif Rasheed <b00073877@aus.edu>

The students in the Operating System Lecture Section at the
American University of Sharjah were confused by the header comment
in include/linux/list.h, which says "Simple doubly linked list
implementation".  This comment means "simple" as in "not complex",
but "simple" is often used in this context to mean "not circular".
This commit therefore avoids this ambiguity by explicitly calling out
"circular".

Signed-off-by: Asif Rasheed <b00073877@aus.edu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/list.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/list.h b/include/linux/list.h
index a18c87b..89bdc92 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -9,7 +9,7 @@
 #include <linux/kernel.h>
 
 /*
- * Simple doubly linked list implementation.
+ * Circular doubly linked list implementation.
  *
  * Some of the internal functions ("__xxx") are useful when
  * manipulating whole lists rather than single entries, as
-- 
2.9.5

