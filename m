Return-Path: <SRS0=9/AT=DW=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CBFC433E7
	for <rcu@archiver.kernel.org>; Thu, 15 Oct 2020 01:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5858222254
	for <rcu@archiver.kernel.org>; Thu, 15 Oct 2020 01:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="vBf29QhC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389304AbgJOBkK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 14 Oct 2020 21:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389103AbgJOBji (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 14 Oct 2020 21:39:38 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E676C0F26DC
        for <rcu@vger.kernel.org>; Wed, 14 Oct 2020 17:23:12 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id r4so2103321ioh.0
        for <rcu@vger.kernel.org>; Wed, 14 Oct 2020 17:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N/ZNnvzbGq/DSZwz2Oqmm2mNYApnomyZsW1QceVJnHk=;
        b=vBf29QhCSCugzZIJ6+AhdT2Gb2FsQy4HvRgWnls3139N4gErLXWttYaX/Ev4qCDmAo
         Yc9omVWFoOs3960IUshS4UbbFv8wgqVYthDcEY2D6OTfP6tgV3l2lK3kc/CpO47X2B7J
         QDyaULoChBlT0dEssdXSf3gmFq3gzRnVd+/co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N/ZNnvzbGq/DSZwz2Oqmm2mNYApnomyZsW1QceVJnHk=;
        b=p2jiWH4MsLZw7O/nVQtSS/ipmUpt0ENgcZh2SaXYImBa47jg/tvKs0AmzhoYSrf4Rw
         aqyoJLo6L4wMMlo4A0jcLZw6g3VViP6mvqbBir7sj5PDCMrruF2tD43lLHpIRlzD6qna
         P02kIENfk9tSojzjSPagyOII44OkAHovVdXB7txGXlMcSAgv//zwo3UgIKkyQkJXKra/
         B3wfJEwLa9iaF+iqwCsJgEoRG+qDUDXLDmG/L06F8wFxIqjxspbvOFRV+ySugnLrYb0N
         ZNYlplJ6K+U0gEPcyUb/vT8kZz5TkeMk16Z0Zr8GO8Sf7rmjxg95r1U8DOHpXa+MUiLV
         arNg==
X-Gm-Message-State: AOAM5317yl3oBpuIZEorTRmhH3uwk3EfA+J1ZkktsEzuvRShQdLe1QDs
        v07/HzWLLB23JgU+C304u4LvFg==
X-Google-Smtp-Source: ABdhPJydnmZUz7AgK8Mh5BtdbGQ+6k0J/j50suRV0PRydpmzG4IkWfdb6ev1wk3io1tPlXXy9AUR7g==
X-Received: by 2002:a05:6638:2395:: with SMTP id q21mr1515291jat.94.1602721391508;
        Wed, 14 Oct 2020 17:23:11 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id r4sm1075622ilc.32.2020.10.14.17.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 17:23:11 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: [PATCH v7 4/6] rcu/segcblist: Remove useless rcupdate.h include
Date:   Wed, 14 Oct 2020 20:22:59 -0400
Message-Id: <20201015002301.101830-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
In-Reply-To: <20201015002301.101830-1-joel@joelfernandes.org>
References: <20201015002301.101830-1-joel@joelfernandes.org>
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
index 2dccbd29cd3a..271d5d9d7f60 100644
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
2.28.0.1011.ga647a8990f-goog

