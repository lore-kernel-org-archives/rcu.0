Return-Path: <SRS0=TKtl=4N=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C283C35E01
	for <rcu@archiver.kernel.org>; Tue, 25 Feb 2020 18:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71ABC21744
	for <rcu@archiver.kernel.org>; Tue, 25 Feb 2020 18:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BE3s7hwK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731502AbgBYSjY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 25 Feb 2020 13:39:24 -0500
Received: from mail-pl1-f171.google.com ([209.85.214.171]:34804 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731439AbgBYSjX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 25 Feb 2020 13:39:23 -0500
Received: by mail-pl1-f171.google.com with SMTP id j7so158172plt.1;
        Tue, 25 Feb 2020 10:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P8swh48wfTLZuYv02RwLOZrF/pIWOZiF/oICtKiXMJc=;
        b=BE3s7hwKT6oHvUI0W48DjcFi/+3Hm2fY5rHl1CjxQYcS3UXiBjlQrNiwrts0qBdgSB
         j1gHofmQS/zw6Ow8MGCGQbrJ6pYOzQn90TkBw5kVQMF29L74lTeFJz4BjauMjqwRLf2X
         Dxil8Dcz1j3AbCnF0KEKSQ6gXAx5uODlCKBGh6XHZhgGlhBajcLIXZ+01G4onRqFQC5S
         9EC6Tnp7y1l+A7yekcWnRJDUZ4RQGGYs7CWGdtFB4p2fMkE4fatO4YIEowrnXuUhArzp
         Lq98HT7Ge/L87abL8+It18Av1Iudc9SKBC8ibN4Fwt7X9Y88Ipe1fEahDJYWuuAU9uOu
         WKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P8swh48wfTLZuYv02RwLOZrF/pIWOZiF/oICtKiXMJc=;
        b=fCHgPHfkU/1t40RjXXovjIymU9tPktYWSiayfP3hC5+OvQVPiJQdbs6Y1HViyKdNs9
         uh1vmk5A6RR+tz7f1OIB7qAnh+TuM0dToexpC+JGAWtJdwmfeBVxiE8NJkuJ3kyJWJs8
         47LXscySUMwn2CDCUzyk04KHPEOBeH27EJZG9fsAB0ntAEBqY3cC5dC1cHYEF0yyIN3x
         75bOIFwcDRL3buQHnZMlnanMQqNK+V0+VG9/CCdK+e9pxHeUGTQNm0UA97euzOGjdEIl
         w9afgcJSJly5yHQJ7NTAQNuTEobuecj9p7zatnAKM9FTQQNhHCGmksCOwksijRpwNS3Q
         He3g==
X-Gm-Message-State: APjAAAWk38VSdppr/EX64hwV4rBhxLIaMMDtXFCSHs1c/zmCmUarIcLX
        hTEk3Joq6hep30FpAL87Y1s=
X-Google-Smtp-Source: APXvYqyApWD8VybffrlZ5mdReiC24DM6E2uK/QjrEZU40b4xruIxjMwwS+Yey6Aplb1bHaeECPA3bw==
X-Received: by 2002:a17:90a:cc04:: with SMTP id b4mr369278pju.136.1582655962841;
        Tue, 25 Feb 2020 10:39:22 -0800 (PST)
Received: from localhost.localdomain ([103.46.201.207])
        by smtp.gmail.com with ESMTPSA id 13sm17803325pfi.78.2020.02.25.10.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 10:39:22 -0800 (PST)
From:   amanharitsh123 <amanharitsh123@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] doc: Convert to checklist.txt to checklist.rst
Date:   Wed, 26 Feb 2020 00:09:16 +0530
Message-Id: <20200225183916.4555-1-amanharitsh123@gmail.com>
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
index e98ff261a438..49bf7862c950 100644
--- a/Documentation/RCU/checklist.txt
+++ b/Documentation/RCU/checklist.rst
@@ -1,5 +1,7 @@
-Review Checklist for RCU Patches
+.. checklist doc:
 
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

