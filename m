Return-Path: <SRS0=LJ8s=4C=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80426C35242
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55006206B6
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581724575;
	bh=8wL9duR92IPO4UUdO59/kTRTqjldWEuGEpHU9hPWJYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HgPXFZGwFhmko+NON/yuMkzFPNu+WouCk6qy8Lswv3PXnwBWTsfOr7zIbryaD5mP+
	 DA4pMlXMaz9eolQi1apS50thsc5Ci16hYue67TW5yEpabQAbJqUgXkDoOszmgf+oC5
	 uzOMVKHQbymcep7NGKyDQirOQiOiIF9CyUyaIPM4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgBNX4P (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:56:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:35960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727649AbgBNX4O (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 18:56:14 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 129462072D;
        Fri, 14 Feb 2020 23:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581724574;
        bh=8wL9duR92IPO4UUdO59/kTRTqjldWEuGEpHU9hPWJYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RN39NOH8zo/6Lm1SwB787WSRVokJ4J9Ahu8TXypP0WQ2nL3VokiOUrvkJ/lmYSOoJ
         15/dTjea+NGwKHMDmWeP/CjBCH2n+MWP3PdVRqOVsuBUY0Qq2P14SVNW1JcqPANTLg
         ILgeJ9Iqpa5bN7lmqrZcryAyECWfoRS/n66zFgqw=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 01/30] nfs: Fix nfs_access_get_cached_rcu() sparse error
Date:   Fri, 14 Feb 2020 15:55:38 -0800
Message-Id: <20200214235607.13749-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200214235536.GA13364@paulmck-ThinkPad-P72>
References: <20200214235536.GA13364@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

This patch fixes the following sparse error:
fs/nfs/dir.c:2353:14: error: incompatible types in comparison expression (different address spaces):
fs/nfs/dir.c:2353:14:    struct list_head [noderef] <asn:4> *
fs/nfs/dir.c:2353:14:    struct list_head *

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 fs/nfs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 1320288..55a29b0 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2383,7 +2383,7 @@ static int nfs_access_get_cached_rcu(struct inode *inode, const struct cred *cre
 	rcu_read_lock();
 	if (nfsi->cache_validity & NFS_INO_INVALID_ACCESS)
 		goto out;
-	lh = rcu_dereference(nfsi->access_cache_entry_lru.prev);
+	lh = rcu_dereference(list_tail_rcu(&nfsi->access_cache_entry_lru));
 	cache = list_entry(lh, struct nfs_access_entry, lru);
 	if (lh == &nfsi->access_cache_entry_lru ||
 	    cred_fscmp(cred, cache->cred) != 0)
-- 
2.9.5

