Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9D8C4332F
	for <rcu@archiver.kernel.org>; Wed, 16 Nov 2022 01:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbiKPBxG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 15 Nov 2022 20:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiKPBxG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 15 Nov 2022 20:53:06 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7499F25E9D
        for <rcu@vger.kernel.org>; Tue, 15 Nov 2022 17:53:05 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id l6so15243805pjj.0
        for <rcu@vger.kernel.org>; Tue, 15 Nov 2022 17:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5PFQw3gASQ8u6ODeevzPqt3Aa4BIDoBXiVp6keTbXpo=;
        b=qdNMhnNiaOEYAY0sB7s+m4HynGrkOtPjcLqQ+1/4DxAJtQ1KzqotyB698ft5LzUodi
         G4VEi72fvBRk7VwGSg1z9GlemClcPRbCI1eiolbHH6HAzjRuJkiAjG8kXYssh+3K3KQD
         KcKnHan99HfEfUiVdaTr2/j3LMOLqN6fYm2vRc+jwsFBuKrsVd+EzwjRsgDalO+/vwwX
         NDz0qQdB60Mmojxe3tcJiDyLVxdxQ22NDmBG7nXr17piVII+N2ksGE7hOhsFsvY2d7bH
         9jjpsjzOgNezbewxfhCk39M6K8fLncLtlWiwxmQskE/+Z8nq4cIs+F34SuskqFrKW5zH
         RQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5PFQw3gASQ8u6ODeevzPqt3Aa4BIDoBXiVp6keTbXpo=;
        b=5BTv1rrr3UmuMQRWV8egtzf/a1W9fCCTNZn+9fQCi4r1ZDK1c1tSoHtOP+45rvg2ji
         wGiEafEVUX96M8+LqQXM0WHWmhtNMOCGRNBsf+1GXMEswtpE6ORyLFUOiX6BEUYEozhx
         rB/2n9QanOdeVobBNIoXswWMcBJFg+AS5OvXMvMUx4RoFxIPh+0nPPdXBDHHYmx2QXqL
         GrVcggbTQcv0TDhcKyEfI0Z7e75aCjyVv19GBRJWy5xP7/zLMwOp+W00dQesjqip/oOg
         C0W2T0B2Bhy6Y+LCFW2pSMfXZsKGeRml/gFHKVmzhWl5C7OfVf6RLsBWqwZqR58J8Ihj
         hg4A==
X-Gm-Message-State: ANoB5pm6yBf3PxQiL0PwToQgPhbto1HT+2HHABA3mS7Y3xRrPe3aM60m
        NvjVi+UWFD3CnaAB2vWsq6xTx4XLtg==
X-Google-Smtp-Source: AA0mqf4krbTS0eNupkQSzkJ7soSk3uIx1RXGqIjj6pKygHhB98AZYyS6+cpi8TABdoUYXqv6U6tLLg==
X-Received: by 2002:a17:902:cf08:b0:188:ab16:2393 with SMTP id i8-20020a170902cf0800b00188ab162393mr6741148plg.87.1668563584420;
        Tue, 15 Nov 2022 17:53:04 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id mg24-20020a17090b371800b002071ee97923sm234217pjb.53.2022.11.15.17.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 17:53:03 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     rcu@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 1/2] srcu: Fix a misspelling in note
Date:   Wed, 16 Nov 2022 09:52:43 +0800
Message-Id: <20221116015244.10539-1-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: rcu@vger.kernel.org
---
 include/linux/srcutree.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index e3014319d1ad..f52820e88018 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -48,7 +48,7 @@ struct srcu_data {
 struct srcu_node {
 	spinlock_t __private lock;
 	unsigned long srcu_have_cbs[4];		/* GP seq for children having CBs, but only */
-						/*  if greater than ->srcu_gq_seq. */
+						/*  if greater than ->srcu_gp_seq. */
 	unsigned long srcu_data_have_cbs[4];	/* Which srcu_data structs have CBs for given GP? */
 	unsigned long srcu_gp_seq_needed_exp;	/* Furthest future exp GP. */
 	struct srcu_node *srcu_parent;		/* Next up in tree. */
-- 
2.31.1

