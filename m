Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E509EB64DC
	for <rcu@archiver.kernel.org>; Tue, 13 Jun 2023 18:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239343AbjFMSYm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 13 Jun 2023 14:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238881AbjFMSYl (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 13 Jun 2023 14:24:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60421709;
        Tue, 13 Jun 2023 11:24:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF1526340C;
        Tue, 13 Jun 2023 18:24:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0319C433F2;
        Tue, 13 Jun 2023 18:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686680679;
        bh=Edls777YKMqINxfhwzexWbmVYJbfX6Dotujbh1uSNaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g8HivGphNlKC/BBPzZXi/F+QEtdGXeSaIEMGlnYZPhGe9/MX/ReZv2APD1N5QxYSY
         quMgGsWg1BjNQi/KfpR1o0rSbkzzU7yR8bfYVC59aGPBDmgdKMfgmyhiQwv7vABsW0
         8zReTYbeOO/RRLR7mUEbeFeZ2EGmtB6+KyaiiIVT+ZSQzCGQXKPkShwB6hv1FKClY9
         vg0DGwD5FPmm4ttLlXiIcVo6FCxCkeMAIhytJi1qVlDMtpYueIf2AoByOdp9qJwyPo
         G+Y9mRMdxeEdhXWmB72Ex7DFQXJrIj8tLkus/j7fE9i4fXyb4uISDS/g+zMjilyIII
         OecBzWPuCyTIA==
From:   SeongJae Park <sj@kernel.org>
To:     paulmck@kernel.org
Cc:     SeongJae Park <sj@kernel.org>, joel@joelfernandes.org,
        mmpgouride@gmail.com, corbet@lwn.net, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] Docs/RCU/rculist_nulls: Fix trivial coding style
Date:   Tue, 13 Jun 2023 18:24:31 +0000
Message-Id: <20230613182434.88317-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230613182434.88317-1-sj@kernel.org>
References: <20230613182434.88317-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Lookup example of non-hlist_nulls management is missing a semicolon, and
having inconsistent indentation (one line is using single space
indentation while others are using two spaces indentation).  Fix the
trivial issues.

Signed-off-by: SeongJae Park <sj@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 Documentation/RCU/rculist_nulls.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/RCU/rculist_nulls.rst b/Documentation/RCU/rculist_nulls.rst
index 9a734bf54b76..253ecd869fc2 100644
--- a/Documentation/RCU/rculist_nulls.rst
+++ b/Documentation/RCU/rculist_nulls.rst
@@ -26,7 +26,7 @@ algorithms:
 ::
 
   begin:
-  rcu_read_lock()
+  rcu_read_lock();
   obj = lockless_lookup(key);
   if (obj) {
     if (!try_get_ref(obj)) // might fail for free objects
@@ -68,8 +68,8 @@ And note the traditional hlist_for_each_entry_rcu() misses this smp_rmb()::
        pos && ({ prefetch(pos->next); 1; }) &&
        ({ tpos = hlist_entry(pos, typeof(*tpos), member); 1; });
        pos = rcu_dereference(pos->next))
-   if (obj->key == key)
-     return obj;
+    if (obj->key == key)
+      return obj;
   return NULL;
 
 Quoting Corey Minyard::
-- 
2.25.1

