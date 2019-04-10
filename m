Return-Path: <SRS0=7kaP=SM=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF5FC10F14
	for <rcu@archiver.kernel.org>; Wed, 10 Apr 2019 19:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A1212075B
	for <rcu@archiver.kernel.org>; Wed, 10 Apr 2019 19:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="j912k9RY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfDJT5b (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:57:31 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36379 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfDJT5b (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 10 Apr 2019 15:57:31 -0400
Received: by mail-pf1-f195.google.com with SMTP id z5so2114235pfn.3
        for <rcu@vger.kernel.org>; Wed, 10 Apr 2019 12:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+zEMNc7324kqJ6udI8dxNG1UczLiZYFItO/G9LMbCUw=;
        b=j912k9RYViXXynkk1wOlbiUqGi5gVmM5St7S1BlBPu6+q2P3DgjDl+YznzwZDpy/hl
         gWY+3dwgbt6IfhjgUbx9m6jOM/d7OOe5psxO/7GbxrHFz+xE7v4Tf7xvwqhp0mhKs5VV
         MpzN1h19egcEapYxtfT1as9eY9rguCD4TJaF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+zEMNc7324kqJ6udI8dxNG1UczLiZYFItO/G9LMbCUw=;
        b=skUcWjD94VMYBdbHP7bfKA8wpGoQmuWHYb0xWCScoGXiGoX4X5oFDIp1txbj/FcSoI
         dRYF0IJUHbSHq3gylRo5UhZOxlo27Q+2tjzWHTEg61u0GrzB+eYWaqLSBQzAWMkFGzgj
         kIu9t3aHcDVxjNsi1sJ2rFYG5Y+WqFY3vhuK402nrjSugr/0RyOyNu/LJsst64c7xMhb
         pVhII8hSp3yokTXSgw7XSMu1LtM9/CKjXYZ+CjPeOInzacCMof5MowtSzq6lVFG0iQK8
         3c+H7y6ZjxbXq5T/RwK6fJzJ5NLp9+1Pm7AxNCmKWam9cCUa1JDx1HFUd8f7E66Cn0Za
         Tdnw==
X-Gm-Message-State: APjAAAWx9ZvD39zYADpbFoCmT0uXSc4vM27ytOviAA434wQKp1FBJ4oA
        XZ4hwSrc+r+yHTrhxJ+nSgICMQ==
X-Google-Smtp-Source: APXvYqxQvO0IbvL2miFcuCBLyOB0UE4xHrZeT7OhWqKm2iqMVPmm+uND50fcJC2SGWrV9EYsD8MM5Q==
X-Received: by 2002:a62:ee17:: with SMTP id e23mr45292744pfi.80.1554926250235;
        Wed, 10 Apr 2019 12:57:30 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v12sm48703375pfe.148.2019.04.10.12.57.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 12:57:29 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        paulmck@linux.vnet.ibm.com, keescook@chromium.org,
        mathieu.desnoyers@efficios.com, rostedt@goodmis.org,
        Jessica Yu <jeyu@kernel.org>,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        rcu@vger.kernel.org
Subject: [PATCH v3 3/3] module: Make __tracepoints_ptrs as read-only
Date:   Wed, 10 Apr 2019 15:57:08 -0400
Message-Id: <20190410195708.162185-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190410195708.162185-1-joel@joelfernandes.org>
References: <20190410195708.162185-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This series hardens the tracepoints in modules by making the array of
pointers referring to the tracepoints as read-only. This array is needed
during module unloading to verify that the tracepoint is quiescent.
There is no reason for the array to be to be writable after init, and
can cause security or other hidden bugs. Mark these as ro_after_init.

Suggested-by: paulmck@linux.vnet.ibm.com
Suggested-by: keescook@chromium.org
Suggested-by: mathieu.desnoyers@efficios.com
Cc: rostedt@goodmis.org
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/module.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/module.c b/kernel/module.c
index 8b9631e789f0..be980aaa8804 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3320,6 +3320,12 @@ static const char * const ro_after_init_sections[] = {
 	 * by the SRCU notifiers
 	 */
 	"___srcu_struct_ptrs",
+
+	/*
+	 * Array of tracepoint pointers used for checking if tracepoints are
+	 * quiescent during unloading.
+	 */
+	"__tracepoints_ptrs",
 };
 
 static struct module *layout_and_allocate(struct load_info *info, int flags)
-- 
2.21.0.392.gf8f6787159e-goog

