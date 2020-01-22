Return-Path: <SRS0=0ICO=3L=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB84AC2D0DB
	for <rcu@archiver.kernel.org>; Wed, 22 Jan 2020 18:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886272465A
	for <rcu@archiver.kernel.org>; Wed, 22 Jan 2020 18:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bda7f3bY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgAVSMZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 22 Jan 2020 13:12:25 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38946 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgAVSMZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 22 Jan 2020 13:12:25 -0500
Received: by mail-pf1-f193.google.com with SMTP id q10so220674pfs.6;
        Wed, 22 Jan 2020 10:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=B+Ke+CwXs3xGZ3tbHutNH7xTsHS0Vqf+fEezUoTK8sI=;
        b=bda7f3bYbWYwtQeloFHRnTLyX8sWbVzc0HsDmPCfdsuO6Mf0xeo4BFdz2sBjCbjEuN
         EguKTtqCDNevzmVON+sBVBf12Jx2qNh5b8Z2wS+tpf7WkALZNGM0UMJAxr0sfNRfd+Qm
         pLdspVaoxFjnRIbWimsGCNPHbYz02TXLokZEhlUFfllw8Ybt1F/uFlLxjc/E20Ho2WYy
         k0detZwWRPpM6jedtLBm/FbrZkYQ/xsUqsi0BbMPAXqDn0TYqUvHVV+Z5PJUmLslZSqo
         RRFJRsCBnETN1spx0U+hqaG/upS/uCVQu0k66SUGr3MOc28mEWidc4lDucHBWhyVjYzr
         vksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B+Ke+CwXs3xGZ3tbHutNH7xTsHS0Vqf+fEezUoTK8sI=;
        b=nlQuIQmxXte5YVP1k9FmMmoCiRCX/MGaPaV8EbB4y5RedzcQQ538wQdq+aJmeMTros
         3PVXpmi3TpMCBdaRuOidox6A5CTPI1Dr0yW2T2dED9lum8W2qX1TTLUcFvgUMWGn6saj
         gCtHb2wVV+jNdDJetgq/cAF/LaeRMamup6CISUGU0OZYcGBdhzQ+A2ECjRK5+XPNHvvh
         Q3Y7SDavgR39fIBwEiiUL4OwugYCdKUtVaBYdzICYNUKfsASxU+8haKxy+gEtAmEnOmY
         w+gGIZVKrAC1JbY+E6VuM0tVlzbdaH0khGguMeSARH1ogR1PMuYx3Z8b1vyX1+qSLlK/
         9WQA==
X-Gm-Message-State: APjAAAVLT8VXLvjXQOwcUpNqhYJGdBNJVg1u+UshZbFx7yKvdSccoPpc
        LbAwuC41ZbHaFeaV7RsaXA==
X-Google-Smtp-Source: APXvYqxEMMqFZ6pi6+0X1WZIqS3erRAUcOz3R2ZqRGGwv2CMP7f+uwwCFdtTKvcplNBpEwBBCngHsg==
X-Received: by 2002:a62:1d52:: with SMTP id d79mr3688669pfd.144.1579716744488;
        Wed, 22 Jan 2020 10:12:24 -0800 (PST)
Received: from madhuparna-HP-Notebook.nitk.ac.in ([2402:3a80:1eee:fc60:1df1:6c1a:3227:9ec0])
        by smtp.gmail.com with ESMTPSA id k10sm4167646pjq.14.2020.01.22.10.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 10:12:23 -0800 (PST)
From:   madhuparnabhowmik10@gmail.com
To:     mingo@redhat.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        frextrite@gmail.com, rcu@vger.kernel.org, paulmck@kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Subject: [PATCH] sched.h: Annotate sighand_struct with __rcu
Date:   Wed, 22 Jan 2020 23:41:56 +0530
Message-Id: <20200122181156.27244-1-madhuparnabhowmik10@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

This patch fixes the following sparse errors:

kernel/fork.c:1511:9: error: incompatible types in comparison expression
kernel/exit.c:100:19: error: incompatible types in comparison expression
kernel/signal.c:1370:27: error: incompatible types in comparison expression

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
---
 include/linux/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index b511e178a89f..7a351360ad54 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -918,7 +918,7 @@ struct task_struct {
 
 	/* Signal handlers: */
 	struct signal_struct		*signal;
-	struct sighand_struct		*sighand;
+	struct sighand_struct __rcu		*sighand;
 	sigset_t			blocked;
 	sigset_t			real_blocked;
 	/* Restored if set_restore_sigmask() was used: */
-- 
2.17.1

