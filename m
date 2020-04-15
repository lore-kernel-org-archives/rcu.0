Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4C1C3815B
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 666D12076D
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586972028;
	bh=tUs7MVqj8fYCeqe5q4ykyyDgjMAGfLwr4MXS7UQ0rFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=snamL5sQDuK49bJ+TjZba13w159QUntG4YV/+V89B7wimvfV/wOtxBw0MJGjyr1Vs
	 t9ybCrb9/4HO2dKR2V3kpDicg0LdVhIE361xkfo6V2nryRmmCHrAySJW35yNURn3eR
	 PhELYbhHmpO3uojQnI33fE7ln7xpZRgpqHcFzRZY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411324AbgDORdk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:33:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:46302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411128AbgDORbH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 13:31:07 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 495D92078B;
        Wed, 15 Apr 2020 17:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586971865;
        bh=tUs7MVqj8fYCeqe5q4ykyyDgjMAGfLwr4MXS7UQ0rFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z1y25YPeRyBNNdLdh1P4g7ENct67bxQHBpxwbbjJKZO/VqTff2ZOzSqUSVGYtHVb9
         3YJPmQV2ta07mCEl1QZhXbiAKMgTrXBfST7jhcMHw7bthdiARb9Cks6nnVCozSMdvC
         ZTbu8ZvorG1EKFsiEcHMkMQOhKS5iKymYaGLxIO4=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Jason Yan <yanaijie@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 11/18] rcutorture: Make rcu_fwds and rcu_fwd_emergency_stop static
Date:   Wed, 15 Apr 2020 10:30:53 -0700
Message-Id: <20200415173100.9927-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415173037.GA9768@paulmck-ThinkPad-P72>
References: <20200415173037.GA9768@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Jason Yan <yanaijie@huawei.com>

This commit fixes the following sparse warning:

kernel/rcu/rcutorture.c:1695:16: warning: symbol 'rcu_fwds' was not declared. Should it be static?
kernel/rcu/rcutorture.c:1696:6: warning: symbol 'rcu_fwd_emergency_stop' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 3d47dca..c7b7594b 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1721,8 +1721,8 @@ struct rcu_fwd {
 	unsigned long rcu_launder_gp_seq_start;
 };
 
-struct rcu_fwd *rcu_fwds;
-bool rcu_fwd_emergency_stop;
+static struct rcu_fwd *rcu_fwds;
+static bool rcu_fwd_emergency_stop;
 
 static void rcu_torture_fwd_cb_hist(struct rcu_fwd *rfp)
 {
-- 
2.9.5

