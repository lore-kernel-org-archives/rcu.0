Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A82CECAAD3
	for <rcu@archiver.kernel.org>; Thu,  1 Sep 2022 22:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbiIAWSr (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 1 Sep 2022 18:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbiIAWSV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 1 Sep 2022 18:18:21 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975B359263
        for <rcu@vger.kernel.org>; Thu,  1 Sep 2022 15:18:09 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id l5so239084qtv.4
        for <rcu@vger.kernel.org>; Thu, 01 Sep 2022 15:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=dpVq45gOBHghNC476XxsHo12GSN2n+TlCs0w1yjI1G8=;
        b=LHvRA8QK5VFw/jrPAKHEmEEsl0L+oZGGdwvCDSEY1J7Zf3XW17vgFCaaiJ5p+DinkX
         JywVDBQDKWVZmOUD+PWJONyE7y3Pj72l2fcvyocgTGJqG/OsejHHXd4qGxJCj3m5m77v
         d3hMh3KrXjEdiRpUQMsxM9gI5WAwTmvMZcliE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=dpVq45gOBHghNC476XxsHo12GSN2n+TlCs0w1yjI1G8=;
        b=VyvqEBEZPAgFtTr1HrycJl7f2BCp//C3qX2a1M5tNgKqXQGda+ylZGJhl+sjpKe8T+
         Cy3lFn5O9XwysQEZvQh4z8Ny8QKHU6NylhkyVWwV43OMoy3w+s3qLLgttT+x6vtFJowF
         NzxnSElkF85tTonubR/ke9NYP8RBCwRO9euLrB/sFulJ97IYnAUF82v/M29cvbCoru2k
         3eeovpe0O/ChmTQkS0yX1Lprw9RBulXtoAtyUqZCJWtkqWVnARXBCX/DQQC8eXbpjWS8
         Jy3Icd8B7N+LAK+fTjVdW7nrpxK5if4i+5G41MGlIt9QLKLE2w2d848wwSiYNE4EkarY
         Uaig==
X-Gm-Message-State: ACgBeo2Bzqk+/W4lMQnUWpB0y+LGFX3XIUdNDrcBoBGDqeVvDcjMJ/7q
        Q2qbcNtzfPEPOR3r+8swbiHwvwjKONeDCQ==
X-Google-Smtp-Source: AA6agR5fwM2qBQofpQTaAhwXy9MXIukc637mu6NfIRAgZbUg8vF1uoX4k76JfSjiT21Y9vviNS6TMg==
X-Received: by 2002:ac8:4e4a:0:b0:343:7e05:d2a8 with SMTP id e10-20020ac84e4a000000b003437e05d2a8mr26201508qtw.67.1662070689060;
        Thu, 01 Sep 2022 15:18:09 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id s16-20020ac85290000000b0034305a91aaesm11060794qtn.83.2022.09.01.15.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 15:18:08 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, vineeth@bitbyteword.org,
        boqun.feng@gmail.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v5 16/18] lib: Move call_rcu() to call_rcu_lazy()
Date:   Thu,  1 Sep 2022 22:17:18 +0000
Message-Id: <20220901221720.1105021-17-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220901221720.1105021-1-joel@joelfernandes.org>
References: <20220901221720.1105021-1-joel@joelfernandes.org>
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
index 3c78e1e8b2ad..49c821b16acc 100644
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
index ea9ce1f0b386..230abc8045fe 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -257,7 +257,7 @@ static void xa_node_free(struct xa_node *node)
 {
 	XA_NODE_BUG_ON(node, !list_empty(&node->private_list));
 	node->array = XA_RCU_FREE;
-	call_rcu(&node->rcu_head, radix_tree_node_rcu_free);
+	call_rcu_lazy(&node->rcu_head, radix_tree_node_rcu_free);
 }
 
 /*
-- 
2.37.2.789.g6183377224-goog

