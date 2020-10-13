Return-Path: <SRS0=rUw8=DU=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4592AC433E7
	for <rcu@archiver.kernel.org>; Tue, 13 Oct 2020 12:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06B342080A
	for <rcu@archiver.kernel.org>; Tue, 13 Oct 2020 12:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602590488;
	bh=SAVn8enQ4C4UTfYln5jnWV4ibLgb6yze8aWC+I7yQmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wiq2cQisuM6jolWSvgeP8JE89QHAbrBtL5L/cHS+xI/oV1Cwh1PZsf5VFp7ib+Bnq
	 iVvlLoRzw8k17tkF3KAj1p+0zW+Ae+luC8E4zJ7W98lLE3VW+AZrazBaLNN+mPaBS9
	 F+B7XK+4ugRDWZYp7tj9Rk5KpQ9NcO+TptXFdHGQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgJMMBI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 13 Oct 2020 08:01:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:58022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727439AbgJMLym (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 13 Oct 2020 07:54:42 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C7D92227E;
        Tue, 13 Oct 2020 11:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602590080;
        bh=SAVn8enQ4C4UTfYln5jnWV4ibLgb6yze8aWC+I7yQmM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zBP9gwsjjN4sbW/yfD6L2YmZt8h2Vo+v6uUVD2fnRhkilVtkIy7qNu4K4eKxAx/At
         Uuc84ALKoCOxUBtakZNNxK/LwxJGyhsJOEFDKWAb08K6TzKVYUKyHQ8c9ZD0mnz+wS
         OAw9VhbiRFTIJ9/xTsG1x4Gy3r+P4WQabS2C++cU=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSIt5-006CWW-Oj; Tue, 13 Oct 2020 13:54:39 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: [PATCH v6 70/80] rcu/tree: docs: document bkvcache new members at struct kfree_rcu_cpu
Date:   Tue, 13 Oct 2020 13:54:25 +0200
Message-Id: <6dd0804d6fd567f11e4c6efb767e91acca659d1f.1602589096.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602589096.git.mchehab+huawei@kernel.org>
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Changeset 53c72b590b3a ("rcu/tree: cache specified number of objects")
added new members for struct kfree_rcu_cpu, but didn't add the
corresponding at the kernel-doc markup, as repoted when doing
"make htmldocs":
	./kernel/rcu/tree.c:3113: warning: Function parameter or member 'bkvcache' not described in 'kfree_rcu_cpu'
	./kernel/rcu/tree.c:3113: warning: Function parameter or member 'nr_bkv_objs' not described in 'kfree_rcu_cpu'

So, move the description for bkvcache to kernel-doc, and add a
description for nr_bkv_objs.

Fixes: 53c72b590b3a ("rcu/tree: cache specified number of objects")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 kernel/rcu/tree.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f78ee759af9c..03c54c3478b7 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3022,6 +3022,12 @@ struct kfree_rcu_cpu_work {
  * @monitor_todo: Tracks whether a @monitor_work delayed work is pending
  * @initialized: The @rcu_work fields have been initialized
  * @count: Number of objects for which GP not started
+ * @bkvcache:
+ *	A simple cache list that contains objects for reuse purpose.
+ *	In order to save some per-cpu space the list is singular.
+ *	Even though it is lockless an access has to be protected by the
+ *	per-cpu lock.
+ * @nr_bkv_objs: number of allocated objects at @bkvcache.
  *
  * This is a per-CPU structure.  The reason that it is not included in
  * the rcu_data structure is to permit this code to be extracted from
@@ -3037,14 +3043,6 @@ struct kfree_rcu_cpu {
 	bool monitor_todo;
 	bool initialized;
 	int count;
-
-	/*
-	 * A simple cache list that contains objects for
-	 * reuse purpose. In order to save some per-cpu
-	 * space the list is singular. Even though it is
-	 * lockless an access has to be protected by the
-	 * per-cpu lock.
-	 */
 	struct llist_head bkvcache;
 	int nr_bkv_objs;
 };
-- 
2.26.2

