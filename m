Return-Path: <SRS0=5ltB=EL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E44C5517A
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CA2D20756
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604620106;
	bh=1/H3wW3U3WqFpcLj5GDy0TXJzyUIxyTZnrzzVXzfM9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qwbwiSHce21GwzgKOQFELjUyv+UGhGtLkmUsmbp/TNjMl+uS1YzRFrWC387pPXy0X
	 6G3dEP84VE98prtbo1/ZW6KwOvh4WeqPp1Wei21uKJLMEEX4AqX4VpyV7CBXTJfJJM
	 5e6IlSp9FitnDWCw7obi9s8fdLHmiD+FGqBuLidE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732789AbgKEXra (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Nov 2020 18:47:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:45930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732766AbgKEXr3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Nov 2020 18:47:29 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E04D02073A;
        Thu,  5 Nov 2020 23:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604620049;
        bh=1/H3wW3U3WqFpcLj5GDy0TXJzyUIxyTZnrzzVXzfM9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OUxFotAvs2Ht9ig3LqV5l/mbBTN5umCd5ip1+1bzkAx1f4DP1QyYlYJfojOIcQrCl
         uef5mXUZko4TJKXocQLcLWIT8wJgjfTo5Q9TbcFp3qX6MOau2BeaGjiAp+WUm+AckK
         uRUiuiwtTZPPVXsG9t2TRRuOYr6Avn6Vd/cgKLNg=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 20/28] rcutorture: Small code cleanups
Date:   Thu,  5 Nov 2020 15:47:11 -0800
Message-Id: <20201105234719.23307-20-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105234658.GA23142@paulmck-ThinkPad-P72>
References: <20201105234658.GA23142@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcu_torture_cleanup() function fails to NULL out the reader_tasks
pointer after freeing it and its fakewriter_tasks loop has redundant
braces.  This commit therefore cleans these up.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 4391d2f..e7d52fd 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2496,13 +2496,13 @@ rcu_torture_cleanup(void)
 			torture_stop_kthread(rcu_torture_reader,
 					     reader_tasks[i]);
 		kfree(reader_tasks);
+		reader_tasks = NULL;
 	}
 
 	if (fakewriter_tasks) {
-		for (i = 0; i < nfakewriters; i++) {
+		for (i = 0; i < nfakewriters; i++)
 			torture_stop_kthread(rcu_torture_fakewriter,
 					     fakewriter_tasks[i]);
-		}
 		kfree(fakewriter_tasks);
 		fakewriter_tasks = NULL;
 	}
-- 
2.9.5

