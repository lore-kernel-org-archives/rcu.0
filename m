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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6A9C48BD6
	for <rcu@archiver.kernel.org>; Tue, 25 Jun 2019 06:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B0B20659
	for <rcu@archiver.kernel.org>; Tue, 25 Jun 2019 06:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rDYa91e5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbfFYG0d (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 25 Jun 2019 02:26:33 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45104 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729294AbfFYG0d (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 25 Jun 2019 02:26:33 -0400
Received: by mail-ot1-f67.google.com with SMTP id x21so16039683otq.12
        for <rcu@vger.kernel.org>; Mon, 24 Jun 2019 23:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2vUzELrKkp/o7EPy8bRrjB4M7Uiho6195kbSfVyRNck=;
        b=rDYa91e5jStDKG87WPbMjeLk5nsqz9oSzpqYCreIXXKmCVeryIy9AcBSOsu4y2x8FF
         1DSOocIBfcqY8WwKoVGIteiVx2iHZvHafRn75aqwM/q7ezD0YrIuXH/TBEjQBxqArnQW
         +ywrKl3nxXWN8pXrFhfJTL0A7rdukWKOdfecM+8ISNw3K2pp62Jveo2BA8/e7dYn1WKJ
         PAryfEwJ+r5n1Ty8z36IfLK/p6natZgTNRczrfLAyEjnHXYWYVy/+dDoulzm/Z/VY1DD
         NwCXwhbOPlzW1kzIVWlQw3twwXEaLfyu2fRuhS+kda4yBe5TdaAY0d2Ru0DkgShuRSyV
         XP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2vUzELrKkp/o7EPy8bRrjB4M7Uiho6195kbSfVyRNck=;
        b=cG1M+oao8jvniKkfwTsGPkvlxAiRy5eCXEMfP7WUnC+uYzBZNBGV2ZaIpayKP+nBYZ
         D5vwcYyjzSMamkwBW2sb5Yp4PeC9+darcQc7bnWSQ8jDOH0bx2dWAEVaNa22U5I55jDJ
         0j/UI+FuXYJ3XmsoBrSgQseNTvh9nl3RcUIDtvy+MZERnCiXQ8ughU2DftPgEmpP6Puf
         jLPaJxPkip5WLHF6QCavmALwveQ/E4TDMPifiocyNTOaE2krxR3aI162KaNUtbY3J/AZ
         H8YQRcvlZ8+/0PIZcxQM2bZJgZI9XOe+4U2/Qc8PDIyZQn3b9oQWNOFm1Cmu6M4tNYRX
         cxfw==
X-Gm-Message-State: APjAAAWx89FTBpbuYHO+VKRTGmChsCNH4FtWs4n0pHk5CTM3E4SmFSwL
        Rvx6R7qLuaKuIalbUfQPTQE=
X-Google-Smtp-Source: APXvYqw+P/KaQHUgBWljaPc3ADGgLL0BTTLwEptS0TQQkMBVkLFIJRNUSleSAgHDkIOUm7rU95y1Tw==
X-Received: by 2002:a9d:7ccb:: with SMTP id r11mr52123384otn.80.1561443992389;
        Mon, 24 Jun 2019 23:26:32 -0700 (PDT)
Received: from rYz3n.attlocal.net ([2600:1700:210:3790::48])
        by smtp.googlemail.com with ESMTPSA id e4sm5050183oti.64.2019.06.24.23.26.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 23:26:32 -0700 (PDT)
From:   Jiunn Chang <c0d1n61at3@gmail.com>
To:     skhan@linuxfoundation.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        rcu@vger.kernel.org, paulmck@linux.ibm.com, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org, corbet@lwn.net
Subject: [Linux-kernel-mentees][PATCH v3 5/6] Documentation: RCU: Add links to rcu.rst
Date:   Tue, 25 Jun 2019 01:26:26 -0500
Message-Id: <20190625062627.26378-6-c0d1n61at3@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190623081413.7095-1-c0d1n61at3@gmail.com>
References: <20190623081413.7095-1-c0d1n61at3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Add the following links:
  - list_rcu
  - up_rcu

Signed-off-by: Jiunn Chang <c0d1n61at3@gmail.com>
---
 Documentation/RCU/rcu.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/RCU/rcu.rst b/Documentation/RCU/rcu.rst
index 000da07d683e..d145decb5c39 100644
--- a/Documentation/RCU/rcu.rst
+++ b/Documentation/RCU/rcu.rst
@@ -10,8 +10,8 @@ A "grace period" must elapse between the two parts, and this grace period
 must be long enough that any readers accessing the item being deleted have
 since dropped their references.  For example, an RCU-protected deletion
 from a linked list would first remove the item from the list, wait for
-a grace period to elapse, then free the element.  See the listRCU.txt
-file for more information on using RCU with linked lists.
+a grace period to elapse, then free the element.  See :ref:`list_rcu`
+for more information on using RCU with linked lists.
 
 Frequently Asked Questions
 --------------------------
@@ -49,7 +49,7 @@ Frequently Asked Questions
 - If I am running on a uniprocessor kernel, which can only do one
   thing at a time, why should I wait for a grace period?
 
-  See the UP.txt file in this directory.
+  See :ref:`up_rcu` for more information.
 
 - How can I see where RCU is currently used in the Linux kernel?
 
@@ -67,7 +67,7 @@ Frequently Asked Questions
 
 - Why the name "RCU"?
 
-  "RCU" stands for "read-copy update".  The file listRCU.txt has
+  "RCU" stands for "read-copy update".  :ref:`list_rcu` has
   more information on where this name came from, search for
   "read-copy update" to find it.
 
-- 
2.22.0

