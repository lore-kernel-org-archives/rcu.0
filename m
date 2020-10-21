Return-Path: <SRS0=Ug6t=D4=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CF0C56201
	for <rcu@archiver.kernel.org>; Wed, 21 Oct 2020 19:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6981222E9
	for <rcu@archiver.kernel.org>; Wed, 21 Oct 2020 19:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="HdiigIUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504701AbgJUTIY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Oct 2020 15:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504695AbgJUTIX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Oct 2020 15:08:23 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507DDC0613D2
        for <rcu@vger.kernel.org>; Wed, 21 Oct 2020 12:08:23 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id c15so3041119qtc.2
        for <rcu@vger.kernel.org>; Wed, 21 Oct 2020 12:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mqpQ8VKwhCakuKl+8ZdrWs1pgorQAyuJMScy1hw3GSI=;
        b=HdiigIUU7wpMvysc+2FdMzdwy0L8epE8pNACz8W4jrAotJDvJpbJ7cyAk6FiykkBOQ
         xAY2fUAOLEIEkS/BX9/zJMvurv9BbMmyAdUtEtY1IfPb98Cg5bbd+d2eDYKmfLpipCPz
         bWU7EfjX6qMI2/zjjBu7KJY4dX+DJPmIGgdlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mqpQ8VKwhCakuKl+8ZdrWs1pgorQAyuJMScy1hw3GSI=;
        b=SAVngs6/CddfWkUJtjcEwugKwLWRqweZtpRO5+rl0jUby7mTy0SvGsYk9AfMeRm95E
         o4yGQWuRyD3rcoMIM6kAw41WOfcmeNhQF9tmY2TR1PLvc4KUjksUq8qC2Y30G5F4rXgp
         1VfqjJ9ITbHgZjP802e95665+Nchjgfmf7qIsC9HZrmkgVRtSdUME15O3gd4VAVSsw0m
         PeqU9o4pIZfTWEqf4K+Z6/7jkPgBLvO3nCFH3lKXb427yahtt4cW+h4iNYvmuf4sZS/y
         KC8WyYBzlg1PUZ+H5gf4J0zSp5U76qiWBQMuZ1e2ffaJtTN/wU5tDRP7hFq6nbxA7+vE
         6/GA==
X-Gm-Message-State: AOAM533NbJpMz+f8vviUBaoZgmbyf1g1v//0AVW6iHAoDFxi6siQfz7T
        yG82WHzOgo+WS5wECHUZJR9pbg==
X-Google-Smtp-Source: ABdhPJxiMBp9392GKZvHb5LXYrEPt9gX3rDiIYT25TvkHHWbyqF05/DANlgpV8tEJq5mQbp6Iz9UwA==
X-Received: by 2002:aed:35cb:: with SMTP id d11mr4532121qte.324.1603307302587;
        Wed, 21 Oct 2020 12:08:22 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id g11sm1913982qkl.30.2020.10.21.12.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 12:08:22 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: [PATCH v8 4/6] rcu/segcblist: Remove useless rcupdate.h include
Date:   Wed, 21 Oct 2020 15:08:11 -0400
Message-Id: <20201021190813.3005054-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201021190813.3005054-1-joel@joelfernandes.org>
References: <20201021190813.3005054-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcu_segcblist.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index b0aaa51e0ee6..19ff82b805fb 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -10,7 +10,6 @@
 #include <linux/cpu.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
-#include <linux/rcupdate.h>
 #include <linux/types.h>
 
 #include "rcu_segcblist.h"
-- 
2.29.0.rc1.297.gfa9743e501-goog

