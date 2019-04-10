Return-Path: <SRS0=7kaP=SM=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BC4C10F11
	for <rcu@archiver.kernel.org>; Wed, 10 Apr 2019 19:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728122082E
	for <rcu@archiver.kernel.org>; Wed, 10 Apr 2019 19:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="mAmKGVVl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfDJTIk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:08:40 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33497 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfDJTIj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 10 Apr 2019 15:08:39 -0400
Received: by mail-pg1-f195.google.com with SMTP id k19so2127595pgh.0
        for <rcu@vger.kernel.org>; Wed, 10 Apr 2019 12:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8MLZ+t6ETSfRle4Yyv8Mm0sNY1lMjkcgD31AFFbnzGI=;
        b=mAmKGVVliYohNshCebOGyJXdNnT43u/87bX4lv2U011EPP6yc131xXdOTkqgDjm7OR
         2bBlnuIERechK8bCubXNkOWMRumNUdgt/9mPfTGKuHJ+7KCMx2nAqUC68Jsdy/0tPqwS
         jLDL2n2QsVXVNPSoaq/CxBzgKixt98UA2PBTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8MLZ+t6ETSfRle4Yyv8Mm0sNY1lMjkcgD31AFFbnzGI=;
        b=GwtXyprGN49+IOd2hQpqDiy1i+f/IYBeC6zPavK7MnzNhPrS+dzINVhxYLqDVTD36Z
         xp2eGFVihtUOyTpl+lS0vMekBh7EDiw236KbjuWEC8xiCoZj8Lt0l0RVZ1D8SgyLS1Wd
         /KI11XqKEG0Hs4AzmeOJfwOP/I7Uc9pb+G1uuAJLncahHOmbj0AFpYAWX2/+GeZlDwkw
         WZiFiUFW1hf58F7GTGd8EcGoXmtCNxGBF89r3h+kDbHv/onSq1uw2mTv2BseVurtrD6s
         pPxxaQX827tAFlXD+81HyCmG3rfzjZhHjX3LjQqsx+BjnlP5abgKF74Bstzl8dJZ11cn
         I8AQ==
X-Gm-Message-State: APjAAAXg5iEeLUfblZM+cMlfImXPxGWHiiDQx1bQHlIDqdNqobBDHvNj
        qPgzS6hnwIYh7qmj2k1zdTh3Zw==
X-Google-Smtp-Source: APXvYqzDqdN+0RxHkfe+U3K1sjSDbZdx15C05NwTwL+PwOR4SFz+tMlJS5PgpUFZ+icJYUk6Tsp7zQ==
X-Received: by 2002:a62:1a0d:: with SMTP id a13mr45887924pfa.198.1554923318525;
        Wed, 10 Apr 2019 12:08:38 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v15sm52243547pff.105.2019.04.10.12.08.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 12:08:37 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        paulmck@linux.vnet.ibm.com, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        keescook@chromium.org, Jessica Yu <jeyu@kernel.org>
Subject: [PATCH v2 1/3] module: Prepare for addition of new ro_after_init sections
Date:   Wed, 10 Apr 2019 15:08:21 -0400
Message-Id: <20190410190823.109172-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

For the purposes of hardening modules by adding sections to
ro_after_init sections, prepare for addition of new ro_after_init
entries which we do in future patches. Create a table to which new
entries could be added later. This makes it less error prone and reduce
code duplication.

Cc: paulmck@linux.vnet.ibm.com
Cc: rostedt@goodmis.org
Cc: mathieu.desnoyers@efficios.com
Cc: rcu@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com
Cc: kernel-team@android.com
Suggested-by: keescook@chromium.org
Reviewed-by: keescook@chromium.org
Acked-by: rostedt@goodmis.org
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---
 kernel/module.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 524da609c884..1acddb93282a 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3300,11 +3300,27 @@ static bool blacklisted(const char *module_name)
 }
 core_param(module_blacklist, module_blacklist, charp, 0400);
 
+/*
+ * Mark ro_after_init section with SHF_RO_AFTER_INIT so that
+ * layout_sections() can put it in the right place.
+ * Note: ro_after_init sections also have SHF_{WRITE,ALLOC} set.
+ */
+static char *ro_after_init_sections[] = {
+	".data..ro_after_init",
+
+	/*
+	 * __jump_table structures are never modified, with the exception of
+	 * entries that refer to code in the __init section, which are
+	 * annotated as such at module load time.
+	 */
+	"__jump_table",
+};
+
 static struct module *layout_and_allocate(struct load_info *info, int flags)
 {
 	struct module *mod;
 	unsigned int ndx;
-	int err;
+	int err, i;
 
 	err = check_modinfo(info->mod, info, flags);
 	if (err)
@@ -3319,23 +3335,12 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
 	/* We will do a special allocation for per-cpu sections later. */
 	info->sechdrs[info->index.pcpu].sh_flags &= ~(unsigned long)SHF_ALLOC;
 
-	/*
-	 * Mark ro_after_init section with SHF_RO_AFTER_INIT so that
-	 * layout_sections() can put it in the right place.
-	 * Note: ro_after_init sections also have SHF_{WRITE,ALLOC} set.
-	 */
-	ndx = find_sec(info, ".data..ro_after_init");
-	if (ndx)
-		info->sechdrs[ndx].sh_flags |= SHF_RO_AFTER_INIT;
-	/*
-	 * Mark the __jump_table section as ro_after_init as well: these data
-	 * structures are never modified, with the exception of entries that
-	 * refer to code in the __init section, which are annotated as such
-	 * at module load time.
-	 */
-	ndx = find_sec(info, "__jump_table");
-	if (ndx)
-		info->sechdrs[ndx].sh_flags |= SHF_RO_AFTER_INIT;
+	/* Set sh_flags for read-only after init sections */
+	for (i = 0; ro_after_init_sections[i]; i++) {
+		ndx = find_sec(info, ro_after_init_sections[i]);
+		if (ndx)
+			info->sechdrs[ndx].sh_flags |= SHF_RO_AFTER_INIT;
+	}
 
 	/* Determine total sizes, and put offsets in sh_entsize.  For now
 	   this is done generically; there doesn't appear to be any
-- 
2.21.0.392.gf8f6787159e-goog

