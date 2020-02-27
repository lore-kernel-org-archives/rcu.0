Return-Path: <SRS0=5+Ir=4P=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABDCC11D3D
	for <rcu@archiver.kernel.org>; Thu, 27 Feb 2020 17:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E413124691
	for <rcu@archiver.kernel.org>; Thu, 27 Feb 2020 17:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqlqA9ZQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbgB0R10 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 27 Feb 2020 12:27:26 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45672 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbgB0R10 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 27 Feb 2020 12:27:26 -0500
Received: by mail-pg1-f196.google.com with SMTP id m15so19460pgv.12;
        Thu, 27 Feb 2020 09:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nu4qWyGXEitkgI8n8p9Q8iibxQxSQ0j2p8JZ5tAMehw=;
        b=NqlqA9ZQ0XHJZn2GauKocLVfMdbLajOtWemmVYWblroy1YxjX8ukY/Z7VTn9mAe6/Q
         tBUtT6JLtx7HsSQWrcR39pygIY2q4UPXtGEEqq6PDepFp0cBfvD9zDhEmPDO7Z7tBv2N
         8pu7RtEg3tGvAjArQ9XBIyQaEDCJQvfkogWd2KhOLgvFmRmYzehPJjb/v6z8lYAZWJCZ
         7SNlix8NtONm5bIR2avyWGP7ofcA4sffVMQYNvPIhPX1pxQLoCkYOLM4KZYdYnqjwnBX
         3cD0F2Na1MAwgETQw8aS/3COzev4Bhtaa0IM700eIul4/h+mCt+MjUnjWvPc29ohXdVB
         naug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nu4qWyGXEitkgI8n8p9Q8iibxQxSQ0j2p8JZ5tAMehw=;
        b=N9blowM/QbzcGmfZ/0IZfqwpZoAggEDrf4Lu3U3BxFqKtsfSgV3ypuhp4OkKV3JI6O
         FnaGuv2Vj4o1zuYq0EZCbQW8O+OSjGKuuJCJEqSIIngZYqFAZub4pVdgT5L1QlBelYAH
         pkVoVCDC0o9a26eQyI0jjtT/ZsvP39WLX3ufPK1S+2JRm8l1FOcJ9iWW6oH3ahtrXRgF
         Ye/ScRVQulO6Y5evRmIp05IWJ4CRA0Y2cxwAO3TpBxYv/4AZt2WqjByII+QSnxyqKkQ1
         LR5ap6n24/iiYkWoE61KlZr764OSIIanIel+b11aEyRfLSJpXCdBIjtUyH5Knqij3wan
         xnkg==
X-Gm-Message-State: APjAAAWCXlqpZn8OiCEMkHTM2P7iT4ysXdedmMVmaYyFCeI8pYMd0y58
        eKIiD9+bhUTV7AD79TrsaPQ=
X-Google-Smtp-Source: APXvYqxTraK0soDcR29iTCztQotzJJ+fayOOisQNUhuUn/qARzTiXgh7Zsw5Sn0p9ALeLFGO2lcJdA==
X-Received: by 2002:a62:5547:: with SMTP id j68mr83320pfb.6.1582824443753;
        Thu, 27 Feb 2020 09:27:23 -0800 (PST)
Received: from localhost.localdomain ([103.46.201.150])
        by smtp.gmail.com with ESMTPSA id b15sm7865783pft.58.2020.02.27.09.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 09:27:22 -0800 (PST)
From:   amanharitsh123 <amanharitsh123@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        amanharitsh123@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Linux-kernel-mentees] [PATCH v2] doc: Convert to checklist.txt to checklist.rst
Date:   Thu, 27 Feb 2020 22:56:24 +0530
Message-Id: <20200227172625.4976-1-amanharitsh123@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This patch converts checklist.txt to checklist.rst and
adds it to index.rst

Signed-off-by: Aman Sharma <amanharitsh123@gmail.com>
Signed-off-by: amanharitsh123 <amanharitsh123@gmail.com>
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

