Return-Path: <SRS0=oVcv=UY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAC4C48BD4
	for <rcu@archiver.kernel.org>; Tue, 25 Jun 2019 06:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75E9620659
	for <rcu@archiver.kernel.org>; Tue, 25 Jun 2019 06:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pL5yEEIt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbfFYG0e (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 25 Jun 2019 02:26:34 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38769 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729294AbfFYG0e (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 25 Jun 2019 02:26:34 -0400
Received: by mail-ot1-f68.google.com with SMTP id d17so16125430oth.5
        for <rcu@vger.kernel.org>; Mon, 24 Jun 2019 23:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FB9Lib04nZIkk8LBuqaQDSnE0amd1ixpef0x72yXn4A=;
        b=pL5yEEIt5GQTzxCe2MFYz9yfVcV01VvaXbdpwbFHDPVizxze8/hPSCpmqoJZqLB+Mf
         LFFzGpbmDthAsk0cguIDilgwRZ0wBUHQUQBOKUQJOC0HrWWwDeAjHTLiOCxfmHRR9fW6
         cHpKHPaB+RxG8U8hN/Sib2rrqpWk3LqEfhlvrKNwOQy8ly/7tGghUZu+3OhN4Eg1USoD
         A+Rz2H3f+CcShmTqVYP/agG8atNedrG2BXyMq+DXVmLeToMvS2GrCwH35+9bcv7c4kbO
         kOFoKCQW1h8PmUfoXr7nYSOs9bsttRYS6Pxn/3qQjZXpTOBJ9FSCYMMmQw/mOi9F3UgG
         RE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FB9Lib04nZIkk8LBuqaQDSnE0amd1ixpef0x72yXn4A=;
        b=Z70lrkNPXgezu6Z6oVQiinp6MF0+M5H52Tjxrkl0H9NeIcXAmLfkzpgxeJ54ZBfUvQ
         T00fI/PTpgdU6m4ngn5e5cMJf5OKqn4ae4bttfa8ykU3C3f1SoltJK2NQRoISHGCuyml
         KC1iHC6fyMeFjOeZdVoQ9d5bYp0YLSE7uaAmmAGPF526Mt4R1K4Vm1REuEU0fYFX5lHi
         BAulN+1CbCh77AkaK6zdvRZ0vU+L/aZ5IlRj2XlOKx+SUnPD8gt7s2zLvBLT87QNFmm6
         ARI+ZOa3NbtFGb/M0s/tYHj7scsUz4duVfGp4zA1w1RsJWxb5hORBWQwGRETMcoY/aci
         gCJA==
X-Gm-Message-State: APjAAAXH9pViWDp6N2S6FbUFhCn+o2HfcWFseNgvs1mU0GSLBgVA0gV2
        uQVcJZcpU+yEZBzKKAchDK0=
X-Google-Smtp-Source: APXvYqylj54UvVrPtrvceTZHlTj5VRcjEKZFeCU8AC/lnCcIMXdn65rxZ/8Ql5QrcMA7pKCgTRNlhQ==
X-Received: by 2002:a9d:222c:: with SMTP id o41mr37154434ota.278.1561443993088;
        Mon, 24 Jun 2019 23:26:33 -0700 (PDT)
Received: from rYz3n.attlocal.net ([2600:1700:210:3790::48])
        by smtp.googlemail.com with ESMTPSA id e4sm5050183oti.64.2019.06.24.23.26.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 23:26:32 -0700 (PDT)
From:   Jiunn Chang <c0d1n61at3@gmail.com>
To:     skhan@linuxfoundation.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        rcu@vger.kernel.org, paulmck@linux.ibm.com, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org, corbet@lwn.net
Subject: [Linux-kernel-mentees][PATCH v3 6/6] Documentation: RCU: Add TOC tree hooks
Date:   Tue, 25 Jun 2019 01:26:27 -0500
Message-Id: <20190625062627.26378-7-c0d1n61at3@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190623081413.7095-1-c0d1n61at3@gmail.com>
References: <20190623081413.7095-1-c0d1n61at3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Add TOC tree hooks for:
  - rcu
  - list_rcu
  - up_rcu

Signed-off-by: Jiunn Chang <c0d1n61at3@gmail.com>
---
 Documentation/RCU/index.rst | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/RCU/index.rst

diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
new file mode 100644
index 000000000000..8349dd598bb8
--- /dev/null
+++ b/Documentation/RCU/index.rst
@@ -0,0 +1,19 @@
+.. _rcu_concepts:
+
+============
+RCU concepts
+============
+
+.. toctree::
+   :maxdepth: 1
+
+   rcu
+   list_rcu
+   up_rcu
+
+.. only:: subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
-- 
2.22.0

