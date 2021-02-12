Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E19C433E0
	for <rcu@archiver.kernel.org>; Fri, 12 Feb 2021 12:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2816664E30
	for <rcu@archiver.kernel.org>; Fri, 12 Feb 2021 12:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbhBLMpQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 12 Feb 2021 07:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbhBLMnP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 12 Feb 2021 07:43:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF10C061793;
        Fri, 12 Feb 2021 04:42:34 -0800 (PST)
Date:   Fri, 12 Feb 2021 12:37:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133448;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=6GGwyLTjsKaS7BpFvXYlT0lMOVCS98EftpjRJtavBzY=;
        b=yKOPDoqDikdrKEkuEXs43dglYa5/I3eJLt0uVCJiSCSLhE5N09QXxpdunyrA4Db2phhLCd
        kudJk5pqvlJFXw8x/29e2Tz/kydSkV6bs4PpBe8WvMfzU4x0iNvrZocgZw58RsicwRam3y
        ICSMRABBVe7Tf4JQt2cGbWh5Fdx5H7ro0o+T9HypwYnism84+6cFxJXWaZU9fTArRBuEVI
        5JbtJeEheGphwc8j0/vGtpFojFnP6Yg9O8D0GYoaUmFFlbZoNuYuHPETyAiMyG5S4Jffft
        kJgIXLeKsti8N0VAlY3uTvm2+imYRkLEGIIUP1qaTsMI3p0sBfcZGVspD4J0Ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133448;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=6GGwyLTjsKaS7BpFvXYlT0lMOVCS98EftpjRJtavBzY=;
        b=fo3kWlbHd+9Kjdnk4tyjzFhpFF1kOmvUKhJ9EXim6SZtF9vjzFBsatb21mhWhazaMGzb4N
        nGhOU8RMvT/E6pBw==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] tools/rcutorture: Make identify_qemu_vcpus()
 independent of local language
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313344762.23325.3799442200572641146.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     106cc0d9e79aa7fcb43bd8feab97ee6e114d348b
Gitweb:        https://git.kernel.org/tip/106cc0d9e79aa7fcb43bd8feab97ee6e114=
d348b
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Thu, 19 Nov 2020 01:30:24 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 14:01:20 -08:00

tools/rcutorture: Make identify_qemu_vcpus() independent of local language

The rcutorture scripts' identify_qemu_vcpus() function expects `lscpu`
to have a "CPU: " line, for example:

	CPU(s):		8

But different local language settings can give different results:

	Processeur(s)=C2=A0:		8

As a result, identify_qemu_vcpus() may return an empty string, resulting
in the following warning (with the same local language settings):

	kvm-test-1-run.sh: ligne 138 : test:  : nombre entier attendu comme expressi=
on

This commit therefore changes identify_qemu_vcpus() to use getconf,
which produces local-language-independend output.

Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: rcu@vger.kernel.org
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/test=
ing/selftests/rcutorture/bin/functions.sh
index 8266349..fef8b4b 100644
--- a/tools/testing/selftests/rcutorture/bin/functions.sh
+++ b/tools/testing/selftests/rcutorture/bin/functions.sh
@@ -232,7 +232,7 @@ identify_qemu_args () {
 # Returns the number of virtual CPUs available to the aggregate of the
 # guest OSes.
 identify_qemu_vcpus () {
-	lscpu | grep '^CPU(s):' | sed -e 's/CPU(s)://' -e 's/[ 	]*//g'
+	getconf _NPROCESSORS_ONLN
 }
=20
 # print_bug
