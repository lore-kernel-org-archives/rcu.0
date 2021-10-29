Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB34C433EF
	for <rcu@archiver.kernel.org>; Fri, 29 Oct 2021 09:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BEFA60FC0
	for <rcu@archiver.kernel.org>; Fri, 29 Oct 2021 09:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbhJ2JoX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 29 Oct 2021 05:44:23 -0400
Received: from mga04.intel.com ([192.55.52.120]:50907 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231617AbhJ2JoV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 29 Oct 2021 05:44:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10151"; a="229360042"
X-IronPort-AV: E=Sophos;i="5.87,192,1631602800"; 
   d="scan'208";a="229360042"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 02:41:50 -0700
X-IronPort-AV: E=Sophos;i="5.87,192,1631602800"; 
   d="scan'208";a="498845465"
Received: from rdutta-mobl3.gar.corp.intel.com (HELO lkp-bingo.ccr.corp.intel.com) ([10.255.31.247])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 02:41:46 -0700
From:   Li Zhijian <zhijianx.li@intel.com>
To:     dave@stgolabs.net, joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, paulmck@kernel.org,
        rostedt@goodmis.org, rcu@vger.kernel.org
Cc:     philip.li@intel.com, lizhijian@cn.fujitsu.com,
        jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        Li Zhijian <zhijianx.li@intel.com>
Subject: [PATCH 3/6] scftorture: remove unused SCFTORTOUT
Date:   Fri, 29 Oct 2021 17:40:26 +0800
Message-Id: <20211029094029.22501-4-zhijianx.li@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211029094029.22501-1-zhijianx.li@intel.com>
References: <20211029094029.22501-1-zhijianx.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

no one refers to it any more.

Signed-off-by: Li Zhijian <zhijianx.li@intel.com>
---
 kernel/scftorture.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index f60a7a240f91..5fb15492999b 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -38,9 +38,6 @@
 #define SCFTORT_STRING "scftorture"
 #define SCFTORT_FLAG SCFTORT_STRING ": "
 
-#define SCFTORTOUT(s, x...) \
-	pr_alert(SCFTORT_FLAG s, ## x)
-
 #define VERBOSE_SCFTORTOUT(s, x...) \
 	do { if (verbose) pr_alert(SCFTORT_FLAG s "\n", ## x); } while (0)
 
-- 
2.32.0

