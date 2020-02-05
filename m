Return-Path: <SRS0=GK+O=3Z=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C92BC352A2
	for <rcu@archiver.kernel.org>; Wed,  5 Feb 2020 22:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C8B20730
	for <rcu@archiver.kernel.org>; Wed,  5 Feb 2020 22:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Ua+yzHj1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbgBEWSZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 5 Feb 2020 17:18:25 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39214 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgBEWSX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 5 Feb 2020 17:18:23 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so1451632plp.6
        for <rcu@vger.kernel.org>; Wed, 05 Feb 2020 14:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qEzN1Nr3XiQi/juytTwGJNmYcodSF75VNv82D15zU7s=;
        b=Ua+yzHj1ekndzoKgVM+Cn/Saemfiq/5aCzU0AqiDegTYL+yBN6eNkczqTqN8WOZeMd
         zL35aaPPF0e+FDHC/b6ZY6wpp8GJR156ImTOxzEoG0shGfwfHA61jAKyIDxqvTYkO/5r
         cfGmORe5BHpRIt6vygXshgtdd/eAzyMwW4iqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qEzN1Nr3XiQi/juytTwGJNmYcodSF75VNv82D15zU7s=;
        b=ePGL14SYB0Reo2Y3+qHTCe2toznRpHbOKVeYU8Vu2O4ZurR0C7yEwxoUKt+aEJGcjD
         4s1urGiHnI2vqtNve7lB/GiBF7pkthhB4qvVdui1lDFEJO4uoIj9ljVzREg96I7Xaeeg
         CpJTR1Y+cy8Tdl0vxjU3O+it3mJft5jSp4yCgARfxokU770d2rX9UiXTVp7rx1g3+UDU
         cHepPs250oZYz31tOM3uUNq8VXjzLPP7rF9YgyZLJPO09CZDSHRIqDeukOPovWbDITsZ
         TVeZMTOLqiPPGilxXcWWBXXcgfBTfomm6QYsg52H95PiRDlAXuhqhc/MgreUfpdKaOmA
         wHGg==
X-Gm-Message-State: APjAAAWAmWKClP0xHRnae1mtsxLKBUaU1U14o7rjp0NYBpTsp5l283Ln
        3jKK8pUQWKkbfNzMMQ1qbpKisQ==
X-Google-Smtp-Source: APXvYqzhxZD8M5KCGlAijeTHvdgak0YMZQr3fsBJ7lGFQAV0yMy3bVL0XHXViN3jIKW741NXe1kuVg==
X-Received: by 2002:a17:90a:e996:: with SMTP id v22mr403228pjy.53.1580941101745;
        Wed, 05 Feb 2020 14:18:21 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id r11sm787950pgi.9.2020.02.05.14.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 14:18:21 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, paulmck@kernel.org,
        frextrite@gmail.com, rcu@vger.kernel.org,
        madhuparnabhowmik04@gmail.com
Subject: [PATCH] kernel/trace: Use rcu_assign_pointer() for setting fgraph hash pointers
Date:   Wed,  5 Feb 2020 17:18:08 -0500
Message-Id: <20200205221808.54576-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

set_ftrace_early_graph() sets pointers without any explicit
release-barriers. Let us use rcu_assign_pointer() to ensure the same.

Note that ftrace_early_graph() calls ftrace_graph_set_hash() which does
do mutex_unlock(&ftrace_lock); which should imply a release barrier.
However it is better to not depend on it and just use
rcu_assign_pointer() which should also avoid sparse errors in the
future.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---
 kernel/trace/ftrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 959ded08dc13f..340d30557a10e 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5477,9 +5477,9 @@ static void __init set_ftrace_early_graph(char *buf, int enable)
 	}
 
 	if (enable)
-		ftrace_graph_hash = hash;
+		rcu_assign_pointer(ftrace_graph_hash, hash);
 	else
-		ftrace_graph_notrace_hash = hash;
+		rcu_assign_pointer(ftrace_graph_notrace_hash, hash);
 }
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 
-- 
2.25.0.341.g760bfbb309-goog

