Return-Path: <SRS0=7kaP=SM=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D05C10F0E
	for <rcu@archiver.kernel.org>; Wed, 10 Apr 2019 01:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE1F2133D
	for <rcu@archiver.kernel.org>; Wed, 10 Apr 2019 01:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="QebYh4I7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfDJBO1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 9 Apr 2019 21:14:27 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45861 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfDJBO1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 9 Apr 2019 21:14:27 -0400
Received: by mail-pl1-f195.google.com with SMTP id bf11so277891plb.12
        for <rcu@vger.kernel.org>; Tue, 09 Apr 2019 18:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/wEJ9QgSWQExtL9FEwpxHdh0W+68e2Wgokpx5YSihvs=;
        b=QebYh4I7t0dRquzGgWE6N/9B3I9mO3IcMHH4lCVl4sIGFaGFgzqLcASk2GgTaspdfk
         bhDflTeIJrdzLm9sx6DDolubiVMgjz/3CT/2jVqlaAqNqPitPO/D5JIfsQase2VsXSF0
         En/LorP0XKMcx33bbK3X8Q8txKCW/XAmAB1mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/wEJ9QgSWQExtL9FEwpxHdh0W+68e2Wgokpx5YSihvs=;
        b=UaLl/ABWw+cPKiffvWuCzTOcv8rrvY4AguupK2dH0FdCa2Z2aJLvbJbz8pHBWOMsYk
         RQiMzjsx1Yi2vhTykz3VzsfG7s3OUwRVxuT0bSac9qQIrDQ1sXxNRj5urcJcystppVX8
         FoQfLnygxf/3IGI6dwTx4xHC6rjzm2fJxPBocB2Kpy1PxzpJVVXlsfKNthMzTwWqKA1F
         3q6UFGx6vGhz+lXcq9k+67QL5kBsJJHqmSJlGDz4P3ybYQVRhwd/3Cw+PmYsulT+/YiG
         M/mNAqUeoF3527K4f/ViSbphBNQLE8bRn6Hru1dlkSN8ovUNUO+weHKVNa1OQ5SH4UqG
         PJoQ==
X-Gm-Message-State: APjAAAVEe+YmSVr4tJIi0GuLgKsVLAj/guDJJMW0u5j/W7HRAMKzue1v
        UfEgg/8BKNDta3Hrf8222sIOkA==
X-Google-Smtp-Source: APXvYqxLlBL5FYJw5UICkZ/Jb2yPB/oD5tx+BWvugm8DYpfRursSQnHmjajv1STSNoynBQvKHREeLA==
X-Received: by 2002:a17:902:f084:: with SMTP id go4mr39263903plb.235.1554858866306;
        Tue, 09 Apr 2019 18:14:26 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id d69sm1008867pfg.24.2019.04.09.18.14.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 18:14:25 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        paulmck@linux.vnet.ibm.com, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        keescook@chromium.org, Jessica Yu <jeyu@kernel.org>
Subject: [PATCH 1/2] module: Prepare for addition of new ro_after_init sections
Date:   Tue,  9 Apr 2019 21:14:17 -0400
Message-Id: <20190410011418.76408-1-joel@joelfernandes.org>
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
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---
 kernel/module.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 524da609c884..f9221381d076 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3300,11 +3300,28 @@ static bool blacklisted(const char *module_name)
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
+	NULL
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
@@ -3319,23 +3336,12 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
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

