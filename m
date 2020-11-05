Return-Path: <SRS0=5ltB=EL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B068C388F7
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF30920A8B
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604617515;
	bh=I5a5KPl2FJ5tlrz5fqJ5ooGjRu4lzeDKhJcQL3nvlTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=frCX2YPt5IDdMd2/mpiBbkCS8T4wodWF4zUqAeZbzARJ/HqxGrIPPyNhz1jCwtK+d
	 aYT3DwvJRP3L634+xi+M5/SsAcNiuyGo2e4E4ZNbeDJHhlTWZU5jpyC77XaIOf38nY
	 6RDf4XEkPwd2e6onMwm3Efssg81TrLDlz21vCJCw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732537AbgKEXFP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Nov 2020 18:05:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:33458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732498AbgKEXFO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Nov 2020 18:05:14 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76870221FA;
        Thu,  5 Nov 2020 23:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604617513;
        bh=I5a5KPl2FJ5tlrz5fqJ5ooGjRu4lzeDKhJcQL3nvlTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EUvqTisi/xAB+ie1ykC0t4WBQeYCgDvKlDMAoIZaBp7e3Rh5KnsTCccck7iiZtcp3
         l+b21BHdbYipGJ8xvKHIb0U+h9HbzcJuDsW+ZO+lVReIKa6KOm13Br9CT5Y+/QJk74
         EBiXXq9DjIKjhWg/RMbremKuW9qJZJrFF2uzzHhc=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 3/4] docs: RCU: Requirements.rst: Fix a list block
Date:   Thu,  5 Nov 2020 15:05:09 -0800
Message-Id: <20201105230510.18660-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105230444.GA18574@paulmck-ThinkPad-P72>
References: <20201105230444.GA18574@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

As warned by Sphinx:
	.../Documentation/RCU/Design/Requirements/Requirements.rst:1959: WARNING: Unexpected indentation.

The list block is missing a space before it, making Sphinx to get
it wrong.  This commit therefore adds the missing space characters.

Fixes: 2a721e5f0b2c ("docs: Update RCU's hotplug requirements with a bit about design")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/Design/Requirements/Requirements.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 98557fe..9f36282 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -1954,6 +1954,7 @@ offline CPUs.  However, as a debugging measure, the FQS loop does splat
 if offline CPUs block an RCU grace period for too long.
 
 An offline CPU's quiescent state will be reported either:
+
 1.  As the CPU goes offline using RCU's hotplug notifier (``rcu_report_dead()``).
 2.  When grace period initialization (``rcu_gp_init()``) detects a
     race either with CPU offlining or with a task unblocking on a leaf
-- 
2.9.5

