Return-Path: <SRS0=LF1p=UZ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EDBC48BD3
	for <rcu@archiver.kernel.org>; Wed, 26 Jun 2019 19:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677F4208E3
	for <rcu@archiver.kernel.org>; Wed, 26 Jun 2019 19:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4Mt4x5b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfFZTM5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 26 Jun 2019 15:12:57 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36649 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfFZTM5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 26 Jun 2019 15:12:57 -0400
Received: by mail-oi1-f195.google.com with SMTP id w7so2803219oic.3;
        Wed, 26 Jun 2019 12:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vVx7TN3uczpgALDm/meWiW2fhfm7Fz4RIlU9veMR/Ts=;
        b=a4Mt4x5b1JNzFApnUHFqyAMIt8lZnKFkdI0tqwXgLJTEpcPIUoQHSBR1f0IS7495CJ
         Y9TS/HfsmJsNuQ3KO38bpTpUo9UMm/uM9oh8RIlduziGgT9hidsxwG/QEGpO4igML94r
         BEjMSUItOq6Gsy2oIwc68IiSIjPZyOKO91AcBvEXvFDMvsug6TvINM7arj+r4bvRucUX
         Nzhv47zezHS0q4Wfya7uT87EJdEMA5tjW7wa7PbEygs866YRj7A0fg1CRWlOGHUfRz0J
         HlDXMZje8W3Ki6TDvLxZbpJ8dDfxIAuR6rJatkgnvmrmAUIUVxyZtYEPjwyPha5PM/av
         PzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vVx7TN3uczpgALDm/meWiW2fhfm7Fz4RIlU9veMR/Ts=;
        b=YOhTGvD2em8Sd6iAN4W5Ro0em3e82HaN7PeosEML9jBJ2ZN7d7LtKJwapiOAxsylXK
         s8jDo7v86Kbn2PlGycPvbpdV7m99iv7N/TH7edDlDarBJebXwtZoXbcT+n52Pp9D0ErH
         q4vQ6+0BUXQmGUzBPlQjk++QNmoNneXd3AOxN1oh0qV409DdlWQSMZpDB62UkU5YJ1Fq
         stu3HMvzO8zi2VDB2Poj0BKMXpH3EOk+pt6LgjWdx05LnpUVazWgQtHwE/YVW6J1FRk+
         50CB8JnMa3ulbzMmU91MAQklfSj+tV3cx9z41/LfRq5YfA6P+TrTsByHX4IIRaPh+9Ls
         ixoA==
X-Gm-Message-State: APjAAAXZGmJgx578Zi6emDyZ2CMU3X+sdbu/VXTpIRqpm25ZyZOD3CR0
        gPQSn0JRzTmavo+D9/QmYK0=
X-Google-Smtp-Source: APXvYqxtiB7T0O+uG6RCxolXaT4VMJHw8Vqh6amjzw7GdPjNNnGzA4mXxHdsyy5b8T8EnS+n7VC7rA==
X-Received: by 2002:aca:5050:: with SMTP id e77mr405386oib.52.1561576376294;
        Wed, 26 Jun 2019 12:12:56 -0700 (PDT)
Received: from rYz3n.attlocal.net ([2600:1700:210:3790::48])
        by smtp.googlemail.com with ESMTPSA id e16sm7886679oih.9.2019.06.26.12.12.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 12:12:55 -0700 (PDT)
From:   Jiunn Chang <c0d1n61at3@gmail.com>
To:     skhan@linuxfoundation.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        paulmck@linux.ibm.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, corbet@lwn.net
Subject: [Linux-kernel-mentees][PATCH v4 5/5] Documentation: RCU: Add TOC tree hooks
Date:   Wed, 26 Jun 2019 14:12:49 -0500
Message-Id: <20190626191249.21135-6-c0d1n61at3@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190625062627.26378-1-c0d1n61at3@gmail.com>
References: <20190625062627.26378-1-c0d1n61at3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Add TOC tree hooks for:
  - rcu
  - listRCU
  - UP

Signed-off-by: Jiunn Chang <c0d1n61at3@gmail.com>
---
 Documentation/RCU/index.rst | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/RCU/index.rst

diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
new file mode 100644
index 000000000000..340a9725676c
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
+   listRCU
+   UP
+
+.. only:: subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
-- 
2.22.0

