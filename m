Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7007C433E0
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A3FE20720
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592871738;
	bh=r3YQlkrypRFAwl8abpt+y6+ctUtgkovtXQKlmEun+L8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H6gi3hjHZQzuBmBUAgUCC6gT7DfPVt3fM7x1nRzqI7t2vTMYQeK0eo5WPOT3Mwezj
	 KSa8vsN/x7vEz4JM0c3gobFQHlgPMltHC38U3biJgmWgnKqBNwgChcdwNJBeXuWDFU
	 kwzMiBUJqcwJmPopyTr2wb0j+hPQerBpjE2JCvVo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731607AbgFWAV4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:21:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:48154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731591AbgFWAVz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:21:55 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23F7F20874;
        Tue, 23 Jun 2020 00:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592871714;
        bh=r3YQlkrypRFAwl8abpt+y6+ctUtgkovtXQKlmEun+L8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vNlndGzevWypBHYfeC6hrByKn5ZpdU8V/wpVeINe2+jB/oanP5XaSsLrFgixKEMJN
         RUV8AnvdRp0iY6HV26nuET9MDQlaLKOOfMRhQO1YR7DcVwF6kC6bw9zP43G7HC84ar
         EMa2dG0QC210S6IWRsjE6ZHHkebIjwochbydNrRM=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 24/26] rcu: fix some kernel-doc warnings
Date:   Mon, 22 Jun 2020 17:21:45 -0700
Message-Id: <20200623002147.25750-24-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002128.GA25456@paulmck-ThinkPad-P72>
References: <20200623002128.GA25456@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

There are some kernel-doc warnings:

	./kernel/rcu/tree.c:2915: warning: Function parameter or member 'count' not described in 'kfree_rcu_cpu'
	./include/linux/rculist.h:517: warning: bad line:                           [@right ][node2 ... ]
	./include/linux/rculist.h:2: WARNING: Unexpected indentation.

Move the comment for "count" to the kernel-doc markup and add
a missing "*" on one kernel-doc continuation line.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rculist.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index df587d1..7eed65b 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -512,7 +512,7 @@ static inline void hlist_replace_rcu(struct hlist_node *old,
  * @right: The hlist head on the right
  *
  * The lists start out as [@left  ][node1 ... ] and
-                          [@right ][node2 ... ]
+ *                        [@right ][node2 ... ]
  * The lists end up as    [@left  ][node2 ... ]
  *                        [@right ][node1 ... ]
  */
-- 
2.9.5

