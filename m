Return-Path: <SRS0=j/BQ=SN=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C898AC282CE
	for <rcu@archiver.kernel.org>; Thu, 11 Apr 2019 20:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F8F2146F
	for <rcu@archiver.kernel.org>; Thu, 11 Apr 2019 20:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="lxz7mY/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfDKUYu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:24:50 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41785 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbfDKUYs (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 11 Apr 2019 16:24:48 -0400
Received: by mail-pg1-f193.google.com with SMTP id f6so4036144pgs.8
        for <rcu@vger.kernel.org>; Thu, 11 Apr 2019 13:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0XAAoJMQYYHBabtYZU8wXhfvLmJ0BpLBYplGunmAPog=;
        b=lxz7mY/51X26t6FEaF+gANwsZdHfNVP/G0wjZmEjLrBLmsROq89ZfO4DpRvBaaKIOu
         SRJbBQ+OC/vhmuJ8V8kEgTAuwQq9CNE0hgaJPc0l4OULeoyY+62PRF326uYRI8EbDLFK
         cxtwwzozUSGqdwBOjghgylmn33ED7nCZ0Ge+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0XAAoJMQYYHBabtYZU8wXhfvLmJ0BpLBYplGunmAPog=;
        b=DRIPxFZopHOlC+NgrPMbQTz+YnzlseUTeHqaxKCmAyVrnw6M8rpnWNZ2aMLuxydmGL
         mvdQZ4RdbtzXLltX05QO/F9JDXTp3tP8QJey1VFrIivwL1k2OxhZ2CudESzs2wssDyGM
         o6GuPEkoYTfIoFA2RkdjHWT4LcjqEU8DxV0EDfiDgSgMaDCxntNOOOouwZc4TsT7CtZF
         AH7JS9BADV4Hml3b6cSbRHVgAkjuGOlNnF3t0OvZV1bqbc2leYwZRnbsl3OEH9uxoN8S
         8sUC376S8ZDtRgllnWtucHiSzcOcTPtvTtZINaamGCfik1Da5ohTvW8mdVVkFZfVjLqt
         07JA==
X-Gm-Message-State: APjAAAW15RjlsQIZmC3k1V72kCJeJSlf5ob3mWmoHQ1FUY4AVnkuOZbx
        9kURGY9PHk6Dq6H1b0w8JYNsfw==
X-Google-Smtp-Source: APXvYqxOSqHn39xQQXfMLHPaX1VnjfvUKDkXLMBJxgK/E3tSuHlnNTxfaLnLnPCcKEX4s6LK1Ft+TA==
X-Received: by 2002:a63:2c09:: with SMTP id s9mr44830837pgs.411.1555014287981;
        Thu, 11 Apr 2019 13:24:47 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id w68sm54335927pfb.176.2019.04.11.13.24.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 13:24:47 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        paulmck@linux.vnet.ibm.com, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH] module: Make srcu_struct ptr array as read-only
Date:   Thu, 11 Apr 2019 16:24:21 -0400
Message-Id: <20190411202421.131779-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Since commit title ("srcu: Allocate per-CPU data for DEFINE_SRCU() in
modules"), modules that call DEFINE_{STATIC,}SRCU will have a new array
of srcu_struct pointers, which is used by srcu code to initialize and
clean up these structures and save valuable per-cpu reserved space.

There is no reason for this array of pointers to be writable, and can
cause security or other hidden bugs. Mark these are read-only after the
module init has completed.

Tested with the following diff to ensure array not writable:

(diff is a bit reduced to avoid patch command getting confused)
 a/kernel/module.c
 b/kernel/module.c
  -3506,6 +3506,14  static noinline int do_init_module [snip]
 	rcu_assign_pointer(mod->kallsyms, &mod->core_kallsyms);
 #endif
 	module_enable_ro(mod, true);
+
+	if (mod->srcu_struct_ptrs) {
+		// Check if srcu_struct_ptrs access is possible
+		char x = *(char *)mod->srcu_struct_ptrs;
+		*(char *)mod->srcu_struct_ptrs = 0;
+		*(char *)mod->srcu_struct_ptrs = x;
+	}
+
 	mod_tree_remove_init(mod);
 	disable_ro_nx(&mod->init_layout);
 	module_arch_freeing_init(mod);

Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: paulmck@linux.vnet.ibm.com
Cc: rostedt@goodmis.org
Cc: mathieu.desnoyers@efficios.com
Cc: rcu@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com
Cc: kernel-team@android.com
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---
This single patch superceded the patches at:
https://lore.kernel.org/patchwork/patch/1060298/
https://lore.kernel.org/patchwork/patch/1060298/

 include/linux/srcutree.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 8af1824c46a8..9cfcc8a756ae 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -123,7 +123,7 @@ struct srcu_struct {
 #ifdef MODULE
 # define __DEFINE_SRCU(name, is_static)					\
 	is_static struct srcu_struct name;				\
-	struct srcu_struct *__srcu_struct_##name			\
+	struct srcu_struct * const __srcu_struct_##name			\
 		__section("___srcu_struct_ptrs") = &name
 #else
 # define __DEFINE_SRCU(name, is_static)					\
-- 
2.21.0.392.gf8f6787159e-goog
