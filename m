Return-Path: <SRS0=hk7p=Q3=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC42DC10F01
	for <rcu@archiver.kernel.org>; Wed, 20 Feb 2019 04:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB08A2183F
	for <rcu@archiver.kernel.org>; Wed, 20 Feb 2019 04:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="dFHd4JFJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730497AbfBTEJS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 19 Feb 2019 23:09:18 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41307 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730483AbfBTEJS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 19 Feb 2019 23:09:18 -0500
Received: by mail-qk1-f194.google.com with SMTP id u188so1119615qkh.8
        for <rcu@vger.kernel.org>; Tue, 19 Feb 2019 20:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=drfTJHzPts60OU2UVPCTk75mVYzRNAWN8AXkBD7SD4E=;
        b=dFHd4JFJYLQJ3HEvhUwYXW9ZIeJxyqGF6bYwovIxTGblGeWB5rpH5YbnuoSW9HHdbm
         xzXziNe4l2jWrIU+Bd4ybUsUBbSpfPY0iQ2ZeCfUv/rC2r4pvl68w26Z0VpVCnqQJJ6F
         6qVmAvq86ZwQJi8B2uWEZXBIRxIeakOQRBLOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=drfTJHzPts60OU2UVPCTk75mVYzRNAWN8AXkBD7SD4E=;
        b=AwuSPS89Wht9o9ximo5AjC0/65hNFufhIkTts3cpV9LU0RMlc5CKSCs+2/3eNb0mDz
         8TsK3PlxzFl2S3V4k+ovX4ECxAujpdG5eAE0RGGLEMwHRRM20ZeJ8ZrMhyNvIgaPw3By
         YoD60vwB9geqeIFY/DMrLQX7tFry7NhSrJVZNBIS9K5+MlRGTVyipExaR0Ac9nglTgVE
         1fjZmWGslA7x+JMijJOHqhN+ZO7fV+QryHMZY2bvaUzBkrPVJKCO7DUopeDlC1w+BnQA
         64CicPSN4YTGEbN2pKBDzG6EHBaIKW+qfsMxQHt5cKmrl2K8xILIFW5speoA/orIDajC
         veJQ==
X-Gm-Message-State: AHQUAuZF48q4YWXa6Bw3T+YoAju+tmYaRc7lGod5su/Axtv14O62cBHW
        zrnFjsG29Yj4QxYO7iqIh+O/2Q==
X-Google-Smtp-Source: AHgI3IaH4CEplsHv+VAwjqo8MdV31MVSffP5OvfYLw/+qybRWyhMcvmjpyoNFxX22Le708lKhOjfIQ==
X-Received: by 2002:aed:21cb:: with SMTP id m11mr5888083qtc.257.1550635757081;
        Tue, 19 Feb 2019 20:09:17 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id s19sm2024593qth.80.2019.02.19.20.09.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 20:09:16 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>, paulmck@linux.ibm.com
Subject: [RFC 5/5] rcuwait: Replace rcu_assign_pointer with smp_store_release
Date:   Tue, 19 Feb 2019 23:08:27 -0500
Message-Id: <20190220040827.136184-6-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190220040827.136184-1-joel@joelfernandes.org>
References: <20190220040827.136184-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Joel Fernandes <joel@joelfernandes.org>

This suppresses a sparse error generated to the recently added
rcu_assign_pointer sparse check:

>> kernel//locking/percpu-rwsem.c:162:9: sparse: error: incompatible
types in comparison expression (different address spaces)

Signed-off-by: Joel Fernandes <joel@joelfernandes.org>
---
 include/linux/rcuwait.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rcuwait.h b/include/linux/rcuwait.h
index 90bfa3279a01..da613efee45c 100644
--- a/include/linux/rcuwait.h
+++ b/include/linux/rcuwait.h
@@ -44,7 +44,7 @@ extern void rcuwait_wake_up(struct rcuwait *w);
 	 */                                                             \
 	WARN_ON(current->exit_state);                                   \
 									\
-	rcu_assign_pointer((w)->task, current);				\
+	smp_store_release(&((w)->task), current);			\
 	for (;;) {							\
 		/*							\
 		 * Implicit barrier (A) pairs with (B) in		\
-- 
2.21.0.rc0.258.g878e2cd30e-goog

