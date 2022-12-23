Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E662C4332F
	for <rcu@archiver.kernel.org>; Fri, 23 Dec 2022 13:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236235AbiLWNCs (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 23 Dec 2022 08:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236157AbiLWNCl (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 23 Dec 2022 08:02:41 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD67111C1D
        for <rcu@vger.kernel.org>; Fri, 23 Dec 2022 05:02:40 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 78so3279126pgb.8
        for <rcu@vger.kernel.org>; Fri, 23 Dec 2022 05:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lTOU42x9W3CL5H3Q629JzKhWUKdVOeEML1wan5qkTeI=;
        b=icvqwz8B85L3SAqxWF5rRsHZ683dNM924O9kEUzmMqocNdKljYGQNPPsVRykbuqSxn
         SYf7K/Vpqgm205PSbiXMDs4gR3YQDPRUOiblIofVZ5DWTcB0jMoTNzzTofWBxgqRkg+n
         2jPuMKMdXUotWqQFyiFsD+yt/wMLth7f1W74d9pjWIdKHyHfnVMtpWWKJ1MXU+pwVsxK
         txsxxER1DRgRKxBxaNLradlyeQ1T40UXM4KlU9pFB2z9BKeyI5Np07jj9CBu+eDN/r/k
         uyuUIYhzNr7mgwR1AOX1+tpmhNrWjz1HUzHsm9BSgmd2P2/uFYNXY+HFauRq+iH3/4b0
         NAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lTOU42x9W3CL5H3Q629JzKhWUKdVOeEML1wan5qkTeI=;
        b=Y9zcrvQQYlWGrAWZii0i/mT1jLn8EFskx4btWrM7o3cWExVhwuxjUEdLFJoIGv0Z1m
         e/tzlq1O5ok3zKM/5vHttPK5yKjq5DTyYPXaU8JDfk4YRIGgCkIYWdMXmtkayeG//R83
         UPBj+9rCjFYdTa0MAw/k95yJRVWEZk5YWbANmFsl1LP7ShziGdZq36bf2lCjCMFznNKa
         cEfvSs89zBwy3GAtAGk32xhWGr/2lqVtvlUljGboMX6PONnbtXpmyc4J2MeTJyUbx6qu
         WAV7/YngfAr7wdRLHALUENZPC/l1+aINWFOoaAA00KURhwP/rq3au33nKmb4RsbXmOf2
         3hXA==
X-Gm-Message-State: AFqh2kpThOX4qghIWuHMFoUxur3Vgs2OuT3CDD4YHWXzW888Hr8k7eUU
        FBxDqinyqWVYSOzamvlOr3EyLgJkZZpZ
X-Google-Smtp-Source: AMrXdXv0fL2NMAjlAqDhR8D7758y1QkNHyhpLwogMtDZZwjn9geUAtRtIwP0pp5n18E3a7TQYhb5Ag==
X-Received: by 2002:a62:6347:0:b0:56b:d328:5441 with SMTP id x68-20020a626347000000b0056bd3285441mr9218154pfb.11.1671800559758;
        Fri, 23 Dec 2022 05:02:39 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id a16-20020aa795b0000000b005765df21e68sm2579059pfk.94.2022.12.23.05.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 05:02:39 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     rcu@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>
Subject: [PATCH] srcu: Add comments for srcu_size_state
Date:   Fri, 23 Dec 2022 21:02:28 +0800
Message-Id: <20221223130228.40737-1-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Zhang, Qiang1" <qiang1.zhang@intel.com>
To: rcu@vger.kernel.org
---
 include/linux/srcutree.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index d4b7f3daf2f8..ee4f3ffa1cce 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -94,8 +94,16 @@ struct srcu_struct {
 /* Values for size state variable (->srcu_size_state). */
 #define SRCU_SIZE_SMALL		0
 #define SRCU_SIZE_ALLOC		1
+/* snp tree has been initialized */
 #define SRCU_SIZE_WAIT_BARRIER	2
+/* In this state, any srcu_barrier(), which considers the system not using snp
+ * tree, has finished.
+ */
 #define SRCU_SIZE_WAIT_CALL	3
+/*
+ * Before snp tree is used, there can be two GPs , each takes two seq snap values.
+ * Wait until CBS1 - CBS4 elapse so these callbacks finishes.
+ */
 #define SRCU_SIZE_WAIT_CBS1	4
 #define SRCU_SIZE_WAIT_CBS2	5
 #define SRCU_SIZE_WAIT_CBS3	6
-- 
2.31.1

