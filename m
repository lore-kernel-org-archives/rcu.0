Return-Path: <SRS0=7kaP=SM=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCBCC10F14
	for <rcu@archiver.kernel.org>; Wed, 10 Apr 2019 19:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA0B2075B
	for <rcu@archiver.kernel.org>; Wed, 10 Apr 2019 19:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="gCuYSH03"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfDJT5a (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:57:30 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34841 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfDJT53 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 10 Apr 2019 15:57:29 -0400
Received: by mail-pl1-f193.google.com with SMTP id w24so2054604plp.2
        for <rcu@vger.kernel.org>; Wed, 10 Apr 2019 12:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s1KvMENHKJ+ARGp1Ak4XYk6a1UqyuJod6EXXmWFSMt8=;
        b=gCuYSH03rd2bfZfsXnJ+sf8RlAg6S8HoJ5JjqU+Zl/5+O0UlykXyfQCOeNcTUCaSR7
         6KNEjmqFrBVBBTO/0d485a41D1MP58vlbCrmYQincc9PoLW9MTuRfAdx7OyNyTQEbmh0
         smzNx1G68PwHw5YZpbUN3UtxvRAc4eRBOPJFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s1KvMENHKJ+ARGp1Ak4XYk6a1UqyuJod6EXXmWFSMt8=;
        b=RqAmgm+UspyOfArKJpVXtFMs5ruRl/5ns7pIEqJ/fKtE91+jkEkJJ9lvEYMiy6Z2Ys
         ZG60A0dWzFmJyWvVBd0G4qM/wO2c6vF3/Vikg2BC2gBUYThknJrd9xXaedXqZKjRn+at
         g8ryjDh9wFrZ/OgSTHvbgRzolNCYpoKqC4P0dAjTBvmduUMgKXRXxvUR+G+9QxMnwfjP
         9djh+NFgHiT3c1d2Fbdq14xkFvzrlfYbT6cU9Vkr1tqh9wpqpi9a5aBaxzkeg+rI70cH
         FAp7adYB1wN8jqsC+3fFSETYkjS5UMOpI/5nSOxIAt21TqHCrs7SJ8EUP5luF9pYqCAJ
         hapg==
X-Gm-Message-State: APjAAAWNCw7fr/yRS0+gPmBAvl4EmRyh2BvKmV2b9r39CDgRF4pcGfoI
        l8tOa0fgfiA6TDImiScBxlxHAQ==
X-Google-Smtp-Source: APXvYqx4UxF9E1rsmi7wYsghu/PXp1ymRPB3Mm4BYcwhDNZS9gsM2QmW9kWzaEw/StarCjaCmGV6RA==
X-Received: by 2002:a17:902:32b:: with SMTP id 40mr23706308pld.204.1554926248212;
        Wed, 10 Apr 2019 12:57:28 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v12sm48703375pfe.148.2019.04.10.12.57.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 12:57:27 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        paulmck@linux.vnet.ibm.com, keescook@chromium.org,
        Jessica Yu <jeyu@kernel.org>,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
        rostedt@goodmis.org
Subject: [PATCH v3 2/3] module: Make srcu_struct ptr array as read-only post init
Date:   Wed, 10 Apr 2019 15:57:07 -0400
Message-Id: <20190410195708.162185-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190410195708.162185-1-joel@joelfernandes.org>
References: <20190410195708.162185-1-joel@joelfernandes.org>
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
Acked-by: keescook@chromium.org
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/module.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/module.c b/kernel/module.c
index 42e4e289d6c7..8b9631e789f0 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3314,6 +3314,12 @@ static const char * const ro_after_init_sections[] = {
 	 * annotated as such at module load time.
 	 */
 	"__jump_table",
+
+	/*
+	 * Used for SRCU structures which need to be initialized/cleaned up
+	 * by the SRCU notifiers
+	 */
+	"___srcu_struct_ptrs",
 };
 
 static struct module *layout_and_allocate(struct load_info *info, int flags)
-- 
2.21.0.392.gf8f6787159e-goog

