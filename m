Return-Path: <SRS0=oLBG=C6=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE2AC43463
	for <rcu@archiver.kernel.org>; Mon, 21 Sep 2020 01:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8551320888
	for <rcu@archiver.kernel.org>; Mon, 21 Sep 2020 01:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="UKQ0cyg1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgIUBWI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 20 Sep 2020 21:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgIUBWE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 20 Sep 2020 21:22:04 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0013C0613CF
        for <rcu@vger.kernel.org>; Sun, 20 Sep 2020 18:22:03 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id q5so13465016qkc.2
        for <rcu@vger.kernel.org>; Sun, 20 Sep 2020 18:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sVeTc22l2Yk1++iDs1yD3RDP6qVn0kRlubPHnWoYwfY=;
        b=UKQ0cyg17UPDOQxX0IKs6/oYH6ICoTLY8ktXXVjaPWoAfWPZHvgqU92tfWPv7B4l3Y
         9OPFblk7kmiNEtRI2DFmUfi/Hc1LKMMOC9XNY0Qva3ftOjIpuBzhYaLJo/GCD6uNolk+
         Q2xJxzXM2/Rbdst9YVcgtHCD45XZuevdIyfU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sVeTc22l2Yk1++iDs1yD3RDP6qVn0kRlubPHnWoYwfY=;
        b=H0x/2sD9iw7daouMiBTT31G9wvRnvsZ8bSLAVFAB2nKrqfrPzEjuZeuiGObu1AK3uG
         WUhmR7/2BJHJD0jnoCxCpOFw28EM22PXpLO1tNoU3cRx73mGLDqPjtk9PbwD1TebA8CO
         /6cC2qmp7XP28/8hgCX0djKQD6DnYvguniz5yMQSNu5hNDTXg/ANoQXc+ztj198GLcsA
         hxeNDU8bFTEK2aZTyc4ijBvyOMeOcjdsZ6PuaZdys4Ji7eH4m+rwdzLBpDaimbv7zclK
         1ceSUbPiFlnat6SW1+ap1VofXFl4/Xnlh5RBE8iVboiE1wlZKYc1kk0oNhFidRHha/PA
         YRcw==
X-Gm-Message-State: AOAM530yrv1b5y6wBq+tSVLqUxzswhkFWYanIGfLE8PUWLGTpaAE5oji
        FQZwkyRB48d+wUd8tAAj4c6kFA==
X-Google-Smtp-Source: ABdhPJwzyAJEG9M68QHHaE64aAC7CGbk1CV9+tmUuo0qNXu8ncMma1htQvSvSCKU7lEYDAnmXWtQrg==
X-Received: by 2002:a37:474c:: with SMTP id u73mr45470844qka.45.1600651322970;
        Sun, 20 Sep 2020 18:22:02 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id l26sm7741951qki.62.2020.09.20.18.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 18:22:02 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neeraj.iitr10@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [RFC v5 5/5] rcu/segcblist: Remove useless rcupdate.h include
Date:   Sun, 20 Sep 2020 21:21:52 -0400
Message-Id: <20200921012152.2831904-6-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200921012152.2831904-1-joel@joelfernandes.org>
References: <20200921012152.2831904-1-joel@joelfernandes.org>
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
index 72b284f965aa..13f8f181521d 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -10,7 +10,6 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
-#include <linux/rcupdate.h>
 
 #include "rcu_segcblist.h"
 #include "rcu.h"
-- 
2.28.0.681.g6f77f65b4e-goog

