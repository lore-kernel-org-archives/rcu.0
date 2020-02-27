Return-Path: <SRS0=5+Ir=4P=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7F3C4BA3B
	for <rcu@archiver.kernel.org>; Thu, 27 Feb 2020 09:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A54D82467F
	for <rcu@archiver.kernel.org>; Thu, 27 Feb 2020 09:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqnCB4Er"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgB0JJC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 27 Feb 2020 04:09:02 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32853 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbgB0JJC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 27 Feb 2020 04:09:02 -0500
Received: by mail-pg1-f195.google.com with SMTP id 6so1145935pgk.0;
        Thu, 27 Feb 2020 01:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7vaQ7QjOo9Se0T2Q2xPF6qY4GtLPfQLgWURgHlmpa9Y=;
        b=BqnCB4Er3oF2o5IN15+LOkwinBZOxRYQCo4EGX4oH8xeUB3MwJlgFCg0L3JYst45O+
         JjF6DLkrtqxrp1CK6/ZTiH66sUENhhaOtWYn1Fg5LLgLpaGCRMTIzI2hTQsAwzaCyvR3
         wfUt+qTC5Na9npr0JTClPBcasifIOadGEk+jWZq3DJr2jkRJX4PyuOs/9RFq2MX8Xkw0
         KnlTUleiOIqAuQTBfiUCdshOoMA1H90YnZ3IFxLuSBymdnsuVjERa/hXH5sSiHj699Aj
         ArXDa8oedb8rQ6UG4ZcQ3/3qgayXymHOajWKPfM3ndyqoePz1bd2IYR5bdrBar50E5e0
         gF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7vaQ7QjOo9Se0T2Q2xPF6qY4GtLPfQLgWURgHlmpa9Y=;
        b=pkvLTGGYcWjqWHsXyqcNYy0Jvhzvb8eZM8IbYmoR/KSJafbuTNInVCq4d8IsKbRpr2
         4xUtM5BcMvYWuVGk6/GJHQJ2NJZUh9KBfFsLGzH8BcI6mYTw+nxmUWH0pVCKQz2Q9Hal
         EmHKYgl5WIkNP9LbXGkuCxZBj/v7lgtKLh8QKSCerjPNZFM30K8QYYdiApfmBRhSZXnd
         YeVC9viDNNDDN/6kmTvwwMbo3BuThg59Pgc3rG2igm/bwFhqV2BELzkmPdIZM5Wt20o7
         nM9oK3Z4QP/avmsYrOVNY8sjn8mvrtHSbLAdmhoeeNFNg9fQT2H6h5pNaD0gRuvPBiem
         5RXg==
X-Gm-Message-State: APjAAAWkPPUGMTKOXW5UJtl4gSTsFGFlDhSwcd9UWbNyMeW6PWgfj/59
        YDgpSc+F+m2Ncf64my7Qlkc=
X-Google-Smtp-Source: APXvYqwrD+o+y8bKo8X5wlJp0Eqfc4ggjlZK8W2rxPa0DGLux+knPP2Ho1qR7dnimC3gqRBfj2k2eA==
X-Received: by 2002:a65:6715:: with SMTP id u21mr2984536pgf.17.1582794541092;
        Thu, 27 Feb 2020 01:09:01 -0800 (PST)
Received: from localhost.localdomain ([103.46.201.26])
        by smtp.gmail.com with ESMTPSA id 3sm5700096pjg.27.2020.02.27.01.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 01:09:00 -0800 (PST)
From:   Aman Sharma <amanharitsh123@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        amanharitsh123 <amanharitsh123@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Linux-kernel-mentees] [PATCH v2] doc: Convert to checklist.txt to checklist.rst
Date:   Thu, 27 Feb 2020 14:38:54 +0530
Message-Id: <20200227090854.18207-1-amanharitsh123@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225183916.4555-1-amanharitsh123@gmail.com>
References: <20200225183916.4555-1-amanharitsh123@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: amanharitsh123 <amanharitsh123@gmail.com>

This patch converts checklist.txt to checklist.rst and
adds it to index.rst

Signed-off-by: Aman Sharma <amanharitsh123@gmail.com>
---
 Documentation/RCU/{checklist.txt => checklist.rst} | 8 +++++---
 Documentation/RCU/index.rst                        | 1 +
 2 files changed, 6 insertions(+), 3 deletions(-)
 rename Documentation/RCU/{checklist.txt => checklist.rst} (99%)

diff --git a/Documentation/RCU/checklist.txt b/Documentation/RCU/checklist.rst
similarity index 99%
rename from Documentation/RCU/checklist.txt
rename to Documentation/RCU/checklist.rst
index e98ff261a438..50fd557b9acd 100644
--- a/Documentation/RCU/checklist.txt
+++ b/Documentation/RCU/checklist.rst
@@ -1,5 +1,7 @@
-Review Checklist for RCU Patches
+.. _checklist_doc: 
 
+Review Checklist for RCU Patches
+================================
 
 This document contains a checklist for producing and reviewing patches
 that make use of RCU.  Violating any of the rules listed below will
@@ -442,8 +444,8 @@ over a rather long period of time, but improvements are always welcome!
 
 	You instead need to use one of the barrier functions:
 
-	o	call_rcu() -> rcu_barrier()
-	o	call_srcu() -> srcu_barrier()
+	-	call_rcu() -> rcu_barrier()
+	-	call_srcu() -> srcu_barrier()
 
 	However, these barrier functions are absolutely -not- guaranteed
 	to wait for a grace period.  In fact, if there are no call_rcu()
diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
index 81a0a1e5f767..d60eb4ba2cd0 100644
--- a/Documentation/RCU/index.rst
+++ b/Documentation/RCU/index.rst
@@ -10,6 +10,7 @@ RCU concepts
    arrayRCU
    rcubarrier
    rcu_dereference
+   checklist
    whatisRCU
    rcu
    listRCU
-- 
2.20.1

