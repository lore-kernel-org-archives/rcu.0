Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F90C001DC
	for <rcu@archiver.kernel.org>; Mon, 17 Jul 2023 18:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjGQSBQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 17 Jul 2023 14:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjGQSBO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 17 Jul 2023 14:01:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3A7E6F;
        Mon, 17 Jul 2023 11:01:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4C50611CA;
        Mon, 17 Jul 2023 18:01:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36057C433C9;
        Mon, 17 Jul 2023 18:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689616872;
        bh=DbRDqkDR7+Vdxt3VeUxm8chleSMkPylSYd1qg6TB8zI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QLwBXp7Crfow6M3KYd6+plxls68Ur0fT2Nkdatp/DZbVsRouOnFr70xUb3c/klwIu
         iTQeflgIKapQD0pB+6zg1GG3TLRV8h5ia2A1KLxkgz9z7fUVVWIzqMo8FnUM798Nvs
         ZbuxcS0w1aWy1kdI3aIswrMKMvVF1iulD9IhgKVm1p4roahptjOYrgcr/hNxlkmQxW
         Iftf0F3rrGtRO4y93Si7fcv3oxQV+sVNOBAJa3D3ZGc44/d+Ur0e7ii53kST26ZVwH
         QVaG9t9pLV+fO40Mykmp40T1/IqNDJNghiVkhh2aQYCtO81VFz8hRlPgYE30GdASqa
         n51GMMaiPGQ1A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D3F33CE04CD; Mon, 17 Jul 2023 11:01:11 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Alan Huang <mmpgouride@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/7] docs/RCU: Add the missing rcu_read_unlock()
Date:   Mon, 17 Jul 2023 11:01:05 -0700
Message-Id: <20230717180110.1097362-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <ee7a3e6b-eb1b-4413-b5c3-83b22f7271dd@paulmck-laptop>
References: <ee7a3e6b-eb1b-4413-b5c3-83b22f7271dd@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Alan Huang <mmpgouride@gmail.com>

We should exit the RCU read-side critical section before re-entering.

Signed-off-by: Alan Huang <mmpgouride@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/rculist_nulls.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/RCU/rculist_nulls.rst b/Documentation/RCU/rculist_nulls.rst
index 9a734bf54b76..0612a6387d8e 100644
--- a/Documentation/RCU/rculist_nulls.rst
+++ b/Documentation/RCU/rculist_nulls.rst
@@ -29,8 +29,10 @@ algorithms:
   rcu_read_lock()
   obj = lockless_lookup(key);
   if (obj) {
-    if (!try_get_ref(obj)) // might fail for free objects
+    if (!try_get_ref(obj)) { // might fail for free objects
+      rcu_read_unlock();
       goto begin;
+    }
     /*
     * Because a writer could delete object, and a writer could
     * reuse these object before the RCU grace period, we
-- 
2.40.1

