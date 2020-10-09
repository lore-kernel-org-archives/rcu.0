Return-Path: <SRS0=v0Re=DQ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E80C43457
	for <rcu@archiver.kernel.org>; Fri,  9 Oct 2020 06:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 337AA22251
	for <rcu@archiver.kernel.org>; Fri,  9 Oct 2020 06:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ejyaTDQA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4+mqkksy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732113AbgJIGf6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 9 Oct 2020 02:35:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55718 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732090AbgJIGfs (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:48 -0400
Date:   Fri, 09 Oct 2020 06:35:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225346;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=J0d/UMsc62xpOiT0yZyPwU/CYObiDrK89wW4NwNbZAU=;
        b=ejyaTDQAeTXRazQwW8KBGgsGSQULcNhClPFX7hPlP/ocHYVslWE0zg2/+Us7q0ri++C1w8
        EmQ9EZm0MaRdNHu6CbGsJ6M+aqkLkCB/KR9COkaSDsOf1Sv3i28KEry6VPeMHADw9Bli/M
        uoxMurwuAndLzfrtLmEo2OlrAcYpqfpInB9ceU4lsqig2fKFL846XHJrN0VytRaTb1FsXx
        Z0xIvgFUZaaKDzeowNHDGubsxczW++dRXiOrgAQi068fIu6dLzuiwza2kLC16YKvYHNIRV
        8segPXfflyQ3uZOCxqf9nz9g6qJwIIOos12kHd4iatjvtWoXzami+vOwc/EHpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225346;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=J0d/UMsc62xpOiT0yZyPwU/CYObiDrK89wW4NwNbZAU=;
        b=4+mqkksyxG4bYkTRghBIXhnNH0HFqNUsl6Q7tJDQT5a2v3/B/Yn+blX9d8Ac61yFeFiAVt
        KIueBpXlw07ejEAw==
From:   "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] doc: Drop doubled words from RCU Data-Structures.rst
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222534612.7002.16770645647309093400.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     1b98b7c5eb2f94eddad541d6fc91f1d1995d644b
Gitweb:        https://git.kernel.org/tip/1b98b7c5eb2f94eddad541d6fc91f1d1995d644b
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Fri, 03 Jul 2020 14:33:41 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 14:29:17 -07:00

doc: Drop doubled words from RCU Data-Structures.rst

Drop the doubled word "the".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: rcu@vger.kernel.org
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/Design/Data-Structures/Data-Structures.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/Design/Data-Structures/Data-Structures.rst b/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
index 4a48e20..f4efd68 100644
--- a/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
+++ b/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
@@ -963,7 +963,7 @@ exit and perhaps also vice versa. Therefore, whenever the
 ``->dynticks_nesting`` field is incremented up from zero, the
 ``->dynticks_nmi_nesting`` field is set to a large positive number, and
 whenever the ``->dynticks_nesting`` field is decremented down to zero,
-the the ``->dynticks_nmi_nesting`` field is set to zero. Assuming that
+the ``->dynticks_nmi_nesting`` field is set to zero. Assuming that
 the number of misnested interrupts is not sufficient to overflow the
 counter, this approach corrects the ``->dynticks_nmi_nesting`` field
 every time the corresponding CPU enters the idle loop from process
