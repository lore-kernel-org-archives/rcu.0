Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E17C433FE
	for <rcu@archiver.kernel.org>; Thu, 12 May 2022 03:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244489AbiELDFN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 11 May 2022 23:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244450AbiELDFJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 11 May 2022 23:05:09 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED1E1FE1F2
        for <rcu@vger.kernel.org>; Wed, 11 May 2022 20:05:08 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id k2so3467275qtp.1
        for <rcu@vger.kernel.org>; Wed, 11 May 2022 20:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rZAMLkDSz2UfdY/AqwPRElqLdOiMu3ZxjzKwUOJzmh4=;
        b=FEawNa57ren25RELKctNZipR4nrle5P4f62ZSPSmqimIpXMZhzZL8fNQuubHgkNHH9
         3YhrIQZZuyPKsRTS4kkMOCpT7wqQLcP5ww/SBCR1XcFUrFbrjee3AEA59UEN8V6GsuSa
         PuU5lSjrWrQIP41lwxaqXj/PJk4P6Ne5IY5AM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rZAMLkDSz2UfdY/AqwPRElqLdOiMu3ZxjzKwUOJzmh4=;
        b=ND1mIvN994B2kR91hQMMzylTAK2oEDuZllr/ePwbRkxDTZDK/SnkHGoDe6duQE4r9d
         xD5MlYrTXzOVmj1nTkhUQ60Hk1q3ThvGOvQ7EIVKUDaeGXo0UTh8DYBOEV+utwzbnP6a
         iiauN22SLqSTWgXPJwgKGIcKPWmmHBb7gn02VsiwKvJGYr1sic3j9gvYQKKWzvfaHNBS
         PycStxuBK2wu2eB9Mb8UVzznbn8KzQFjXOEuaO4Y2k1TCqdpS/1p5czY1TApF/W9C+oI
         zP+1if2LsobgJcJRptTyI/vRqfxd3r8+cgtOt0+NTqlInkhWHcZrOrpiuF28N5VvPZkJ
         ngOg==
X-Gm-Message-State: AOAM530Ix+2oXRNSI0C8ZSKcnZ+iaZxdX7xiYYChDs3YNozAReh+L1t6
        o/Zp7EN9xffDwnHqW4R1Jt4IFt7Gr7GwkQ==
X-Google-Smtp-Source: ABdhPJyaLEwkQ6xzAUPMoregPIWuyFIXyOQKu1SbM2u5iFKQiwp9aExGwRWpIV/PJRBqqLnH7ul8SQ==
X-Received: by 2002:a05:622a:110c:b0:2f3:d347:6f8d with SMTP id e12-20020a05622a110c00b002f3d3476f8dmr20297078qty.403.1652324707964;
        Wed, 11 May 2022 20:05:07 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (29.46.245.35.bc.googleusercontent.com. [35.245.46.29])
        by smtp.gmail.com with ESMTPSA id h124-20020a376c82000000b0069fc13ce203sm2270334qkc.52.2022.05.11.20.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 20:05:07 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [RFC v1 09/14] lib: Move call_rcu() to call_rcu_lazy()
Date:   Thu, 12 May 2022 03:04:37 +0000
Message-Id: <20220512030442.2530552-10-joel@joelfernandes.org>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
In-Reply-To: <20220512030442.2530552-1-joel@joelfernandes.org>
References: <20220512030442.2530552-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Move radix-tree and xarray to call_rcu_lazy(). This is required to
prevent callbacks triggering RCU machinery too quickly and too often,
which adds more power to the system.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 lib/radix-tree.c | 2 +-
 lib/xarray.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index b3afafe46fff..1526dc9e1d93 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -305,7 +305,7 @@ void radix_tree_node_rcu_free(struct rcu_head *head)
 static inline void
 radix_tree_node_free(struct radix_tree_node *node)
 {
-	call_rcu(&node->rcu_head, radix_tree_node_rcu_free);
+	call_rcu_lazy(&node->rcu_head, radix_tree_node_rcu_free);
 }
 
 /*
diff --git a/lib/xarray.c b/lib/xarray.c
index 6f47f6375808..29d6abf6b1ff 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -255,7 +255,7 @@ static void xa_node_free(struct xa_node *node)
 {
 	XA_NODE_BUG_ON(node, !list_empty(&node->private_list));
 	node->array = XA_RCU_FREE;
-	call_rcu(&node->rcu_head, radix_tree_node_rcu_free);
+	call_rcu_lazy(&node->rcu_head, radix_tree_node_rcu_free);
 }
 
 /*
-- 
2.36.0.550.gb090851708-goog

