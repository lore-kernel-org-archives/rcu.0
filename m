Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E272C433DB
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 01:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAC4722CF6
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 01:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbhAFBSc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Jan 2021 20:18:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:60152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbhAFBSc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Jan 2021 20:18:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D197F22D6F;
        Wed,  6 Jan 2021 01:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609895871;
        bh=gLFu+KgQ4ck58W8mpBbjs74dHggSLHFYOf67lC5Cr3I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uif8275PxW3KW/QFDS83CgQMCU8FRKEU74nYX24qobr0YhgYZ7Yat4jReuiCK9xBh
         i2YhNYMtxbwPSP2nctigH6YbL9EHvPP42z7n4AhQv1bDlpgkCM4iaD6Rpft217gQeM
         2gvHLjq0fM20fgLr+R5SvOuMyQO/NTD8LhDDoKtxXhLS7hcAM9f8OqYKU0O0iOKm23
         0cgFCUzXLXc33Bd59PYlhfBTutUNy5MGTRj+Tw3ykxsa/fSdwlhsKm0LVNmmVxH9zR
         zn5XseL8WDdomGn1DZ2EBqGN74Y/x2nXYZZDlu0+ykt3uYsXOk0fbCMuOMDvcJcq2A
         EF1wttLK4d63g==
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        linux-mm@kvack.org
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        ming.lei@redhat.com, axboe@kernel.dk, kernel-team@fb.com,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH mm,percpu_ref,rcu 2/6] mm: Make mem_dump_obj() handle NULL and zero-sized pointers
Date:   Tue,  5 Jan 2021 17:17:46 -0800
Message-Id: <20210106011750.13709-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106011603.GA13180@paulmck-ThinkPad-P72>
References: <20210106011603.GA13180@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit makes mem_dump_obj() call out NULL and zero-sized pointers
specially instead of classifying them as non-paged memory.

Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: <linux-mm@kvack.org>
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 mm/util.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/util.c b/mm/util.c
index da46f9d..92f23d2 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -997,7 +997,12 @@ int __weak memcmp_pages(struct page *page1, struct page *page2)
 void mem_dump_obj(void *object)
 {
 	if (!virt_addr_valid(object)) {
-		pr_cont(" non-paged (local) memory.\n");
+		if (object == NULL)
+			pr_cont(" NULL pointer.\n");
+		else if (object == ZERO_SIZE_PTR)
+			pr_cont(" zero-size pointer.\n");
+		else
+			pr_cont(" non-paged (local) memory.\n");
 		return;
 	}
 	if (kmem_valid_obj(object)) {
-- 
2.9.5

