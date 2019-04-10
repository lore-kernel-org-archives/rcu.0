Return-Path: <SRS0=7kaP=SM=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFF8C10F0E
	for <rcu@archiver.kernel.org>; Wed, 10 Apr 2019 01:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9CD2133D
	for <rcu@archiver.kernel.org>; Wed, 10 Apr 2019 01:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="FHQSlTRZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfDJBOc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 9 Apr 2019 21:14:32 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43845 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfDJBOc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 9 Apr 2019 21:14:32 -0400
Received: by mail-pl1-f195.google.com with SMTP id n8so284334plp.10
        for <rcu@vger.kernel.org>; Tue, 09 Apr 2019 18:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5twU0SQ7qeKqh0+CQCpWioa1s9Zf+6xNLzQqic9rlw4=;
        b=FHQSlTRZrxwWRPEy09RfK1EbzDl1zZ/P9DaKFB3KmUIfEkgu6OM3YJlfaFBN4rkxkl
         zSvWO+0TCb29HihZcJN1LzoQ7zSzMn+0Qq163kSLfVi8pivg9gruZWze/PBLZiriUT1/
         ISRaHB5ujKTs+R24ynJfXQsOp3PURKr+7ESkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5twU0SQ7qeKqh0+CQCpWioa1s9Zf+6xNLzQqic9rlw4=;
        b=K2UHFlSCeue3+r8dSJkaEFw8kkqeXzDBnRZpvQbdSIdda4FwMjAdyl2MLFdwtKxur6
         Kp1yzGDc81H9sa0PmXrkpqvYEROZ7j4tgDznPo49VvoEySeG1lqE/Dw5nOWrblsqI27T
         Qoa2wOH4ujmofSxdJrcub9D0dA/rlMt0rQ1ZcbKzZB2cJybXTK4Av5nYVRvfOAZxV/+D
         v7GuHUZM0OK8eMz4Z/1K5PEevwQhNit3vs8TqNQOrzsq7yqAvzPCL2ss4jAJK/x4SjUI
         4aGZFcBbU/NEwUXYOZBn2mQ45hO3PPevq0bg+UdvcYrhBASDERqhL2/Zmy7gWvnRNpbk
         GeCQ==
X-Gm-Message-State: APjAAAUZXLesBsOMT+JHNlymDV5qz7AM7s/hxmCZmvNDFKtonYgBkpGH
        GCiWbWp9RQ9aVS72bHfDhgHZXA==
X-Google-Smtp-Source: APXvYqzWxp9Z/Hj7HaokzBOYz+F4nLfRw5ZzJJ2S8R4un2zhiLFXnFe1Jd45s4Oi3qlLbH7oSko44Q==
X-Received: by 2002:a17:902:e391:: with SMTP id ch17mr41547333plb.196.1554858871788;
        Tue, 09 Apr 2019 18:14:31 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id d69sm1008867pfg.24.2019.04.09.18.14.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 18:14:31 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        paulmck@linux.vnet.ibm.com, keescook@chromium.org,
        Jessica Yu <jeyu@kernel.org>,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
        rostedt@goodmis.org
Subject: [PATCH 2/2] module: Make srcu_struct ptr array as read-only post init
Date:   Tue,  9 Apr 2019 21:14:18 -0400
Message-Id: <20190410011418.76408-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190410011418.76408-1-joel@joelfernandes.org>
References: <20190410011418.76408-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Since commit title ("srcu: Allocate per-CPU data for DEFINE_SRCU() in
modules"), modules that call DEFINE_{STATIC,}SRCU will have a new array
of srcu_struct pointers which is used by srcu code to initialize and
clean up these structures.

There is no reason for this array of pointers to be writable, and can
cause security or other hidden bugs. Mark these are read-only after the
module init has completed.

Suggested-by: paulmck@linux.vnet.ibm.com
Suggested-by: keescook@chromium.org
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---
 kernel/module.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/module.c b/kernel/module.c
index f9221381d076..ed1f2612aebc 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3301,7 +3301,7 @@ static bool blacklisted(const char *module_name)
 core_param(module_blacklist, module_blacklist, charp, 0400);
 
 /*
- * Mark ro_after_init section with SHF_RO_AFTER_INIT so that
+ * These are section names marked with SHF_RO_AFTER_INIT so that
  * layout_sections() can put it in the right place.
  * Note: ro_after_init sections also have SHF_{WRITE,ALLOC} set.
  */
@@ -3314,6 +3314,13 @@ static char *ro_after_init_sections[] = {
 	 * annotated as such at module load time.
 	 */
 	"__jump_table",
+
+	/*
+	 * Used for SRCU structures which need to be initialized/cleaned up
+	 * by the SRCU notifiers
+	 */
+	"___srcu_struct_ptrs",
+
 	NULL
 };
 
-- 
2.21.0.392.gf8f6787159e-goog

