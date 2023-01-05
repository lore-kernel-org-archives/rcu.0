Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044BEC54EF0
	for <rcu@archiver.kernel.org>; Thu,  5 Jan 2023 00:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbjAEA0i (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 4 Jan 2023 19:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240385AbjAEA0S (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 4 Jan 2023 19:26:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBA84A976;
        Wed,  4 Jan 2023 16:25:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BAF961892;
        Thu,  5 Jan 2023 00:24:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9609EC433A0;
        Thu,  5 Jan 2023 00:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672878290;
        bh=yDaJ2kiBgiBxalJElJRwgXxKwM8lnJrHfQVXCUrdp/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=POh+aTc0KBd14nDPvnvVh+qNPHOgWKCdws+JM7+YA9e5ldb2YMcBdkaJeuHrcaOu+
         b02yUkMtL/6uKXhJeKJ+6ZTiMtptY6LdXJqwRtAC4q9kFBsX/AylOdXq4kBiw+At9W
         DdjIf19BQcep8goojS2CIhVzRCMpl4TxPJDOcxm5SkqkHyTAn4BpmQWUrwKnRJDii1
         qiNaOwdB7LpnXAWmLEL/HfTxNAC8y2cyDdf5DWlckjcQFpVgLYn8QqpGr9PjYCcxVX
         JCetQLtt1i2Aqm5whmgV/dA/Ico7yfOv8D+zJGQTQGWg0M+GrrixlUTbIaaHeTW9rA
         hVW4WBSiot9Qw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id ECD5E5C1ADF; Wed,  4 Jan 2023 16:24:49 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 6/8] rcu/kvfree: Use READ_ONCE() when access to krcp->head
Date:   Wed,  4 Jan 2023 16:24:46 -0800
Message-Id: <20230105002448.1768892-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105002441.GA1768817@paulmck-ThinkPad-P17-Gen-1>
References: <20230105002441.GA1768817@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

The need_offload_krc() function is now lock-free, which gives the
compiler freedom to load old values from plain C-language loads from
the kfree_rcu_cpu struture's ->head pointer.  This commit therefore
applied READ_ONCE() to these loads.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 735312f78e980..02551e0e11328 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3165,7 +3165,7 @@ need_offload_krc(struct kfree_rcu_cpu *krcp)
 		if (!list_empty(&krcp->bulk_head[i]))
 			return true;
 
-	return !!krcp->head;
+	return !!READ_ONCE(krcp->head);
 }
 
 static void
@@ -3206,7 +3206,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
 		// in that case the monitor work is rearmed.
 		if ((!list_empty(&krcp->bulk_head[0]) && list_empty(&krwp->bulk_head_free[0])) ||
 			(!list_empty(&krcp->bulk_head[1]) && list_empty(&krwp->bulk_head_free[1])) ||
-				(krcp->head && !krwp->head_free)) {
+				(READ_ONCE(krcp->head) && !krwp->head_free)) {
 
 			// Channel 1 corresponds to the SLAB-pointer bulk path.
 			// Channel 2 corresponds to vmalloc-pointer bulk path.
-- 
2.31.1.189.g2e36527f23

