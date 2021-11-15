Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3700C433EF
	for <rcu@archiver.kernel.org>; Mon, 15 Nov 2021 05:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88F6063211
	for <rcu@archiver.kernel.org>; Mon, 15 Nov 2021 05:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhKOFSs (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 15 Nov 2021 00:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhKOFSr (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 15 Nov 2021 00:18:47 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A788C061746;
        Sun, 14 Nov 2021 21:15:52 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id n8so13460073plf.4;
        Sun, 14 Nov 2021 21:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=hIrvNhGsPhjcKIW4xpU7r2rbnljhi2zaf1zTu0BzsXI=;
        b=iocw93ERE37v3Cw9RitacZsDvIZ5FXxMTFWRR6rWJ1Ds5qvfdxEi+8PwQKcFJgyuHG
         4FNvLJipkZqTU/dZFmdmF88BbCmhZoyAcI49e5CrJs5pKws0uZhgSA91ZUUJJsJgPrCI
         hsRp/VCLpd+1Ssr7KfAz/xWGh1r4WYmU95l3+eWr3c7DBvQt+3SuEy14saRh2yEA8SlV
         oanYf0eXy2LZth/bHk0v+6vpXWaz7kagtkM0q/h2w7EVRZyNN+EVPSOnYowegQP+LD+J
         pFCZ5XrvGFgpWTWNyUKxSNV5nXaRnwtus1bDLSoKOND+pca+WAZ4qgAaWdWcgbEwOut3
         ra9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hIrvNhGsPhjcKIW4xpU7r2rbnljhi2zaf1zTu0BzsXI=;
        b=Y3o1cInCQBjece0noV2wZvbMkCSYMdosZFZZ8wtpCoTpLGx8lnnG7kdczQwsUnoib9
         M75gYiHt4vfSaSLn81E+JzkpQIjzlKz56Gt2J0Aail8ocX53tKFrhmten8/3Yf3IjFl/
         ZNQO01yNzXElL4/yiezp0Tw6Sc2pMjodTEIjaUXcXXYs427HTNd+Q4VBEEsjEVMHez5z
         Hgij0MNy1xdV/tlYDrtrSSvdcsWSYf+1LvM34YZKXmibV/8bP/tQcys/S8/PkzpYUMMl
         xLolYkp2mFq6ka6t+aZw3cv3N8hyntiqoehuxtB9LOaAq3KIHmXT/nJ2bk9ZWx4Pnw/k
         THCg==
X-Gm-Message-State: AOAM532wFUpwYl/KUONj9WTLKYWtY+4rK3mKc948Z0hmq6QrG40kBAHZ
        aiYvgzjJ5i9Q3+se17i89HfrJqF0Opw=
X-Google-Smtp-Source: ABdhPJyvn10RhilZCw2JT3nFcVCM8beJPnujlprrl6cTlgBIocM1MWBH4dFgfN8+sSpkYCRxbHi46w==
X-Received: by 2002:a17:90b:1a86:: with SMTP id ng6mr61289006pjb.142.1636953351801;
        Sun, 14 Nov 2021 21:15:51 -0800 (PST)
Received: from BJ-zhangqiang.qcraft.lan ([137.59.101.13])
        by smtp.gmail.com with ESMTPSA id y28sm13619739pfa.208.2021.11.14.21.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 21:15:51 -0800 (PST)
From:   Zqiang <qiang.zhang1211@gmail.com>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH] rcu: Avoid boost task running on isolated cpus
Date:   Mon, 15 Nov 2021 13:15:46 +0800
Message-Id: <20211115051546.12476-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

If the nohz_full is enabled, when the boost task be created,
the cpus_allowed_ptr be set housekeeping_cpumask(HK_FLAG_KTHREAD),
however when the rcu_boost_kthread_setaffinity() be called, the
original affinity will be changed, the isolated cpus should be
considered again.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 kernel/rcu/tree_plugin.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 5199559fbbf0..87e7ebbdb12e 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1204,8 +1204,9 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
 		if ((mask & leaf_node_cpu_bit(rnp, cpu)) &&
 		    cpu != outgoingcpu)
 			cpumask_set_cpu(cpu, cm);
+	cpumask_and(cm, cm, housekeeping_cpumask(HK_FLAG_RCU));
 	if (cpumask_weight(cm) == 0)
-		cpumask_setall(cm);
+		cpumask_copy(cm, housekeeping_cpumask(HK_FLAG_RCU));
 	set_cpus_allowed_ptr(t, cm);
 	free_cpumask_var(cm);
 }
-- 
2.17.1

