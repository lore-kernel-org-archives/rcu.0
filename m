Return-Path: <SRS0=5ltB=EL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DA0C55178
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19F9320756
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604620115;
	bh=rNcDc0nqZb3mhX8p82fY0o843TlkCTSfcdWRyKKOYtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aSzG1mY5Im9vU7oEUL+1JpboAGlpCgCbXhwQUUoTgWQCabB2hDTDLhqim1PcNc01c
	 FVbKeTdV5coBXoRqt7ropeq8v9rYHewbAL1bs2GHdsQHF7ScrrPip6pA5Dh9d6OPZN
	 ymWLSGoGfPfINZuT1pDrmBrvy6pXvfFducLftiww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732772AbgKEXr3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Nov 2020 18:47:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:46062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732743AbgKEXr2 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Nov 2020 18:47:28 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F394520885;
        Thu,  5 Nov 2020 23:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604620048;
        bh=rNcDc0nqZb3mhX8p82fY0o843TlkCTSfcdWRyKKOYtg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oqOaUJ27rSn/JntrufbKXmvGU7jM2SaKMTy4Wl63Atm1CS6oWlmtyRsAEPP609Y88
         y8wZKEx0cBEf/LWR1LrLBL2LIrJoPFIiwNx6G76rVmTKN1RZHsKhrrhBN9KSh12yX+
         UoeHEb+CQI9cyaCgE9GN/j5fMFHfptFj7clCLMY0=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 17/28] torture: Force weak-hashed pointers on console log
Date:   Thu,  5 Nov 2020 15:47:08 -0800
Message-Id: <20201105234719.23307-17-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105234658.GA23142@paulmck-ThinkPad-P72>
References: <20201105234658.GA23142@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Although the rcutorture scripting now deals correctly with full-up
security-induced pointer obfuscation, it is still counter-productive for
kernel hackers who are analyzing console output.  This commit therefore
sets the debug_boot_weak_hash kernel boot parameter, which enables
printing of weak-hashed pointers for torture-test runs.

Please note that this change applies only to runs initiated by the
kvm.sh scripting.  If you are instead using modprobe and rmmod, it is
your responsibility to build and boot the underlying kernel to your taste.

Please note further that this change does not result in a security hole
in normal use.  The rcutorture testing runs with a negligible userspace,
no networking, and no user interaction.  Besides which, there is no data
of value that can be extracted from an rcutorture guest OS that could
not also be extracted from the host that this guest is running on.

Suggested-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/functions.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
index 51f3464..8266349 100644
--- a/tools/testing/selftests/rcutorture/bin/functions.sh
+++ b/tools/testing/selftests/rcutorture/bin/functions.sh
@@ -169,6 +169,7 @@ identify_qemu () {
 # Output arguments for the qemu "-append" string based on CPU type
 # and the TORTURE_QEMU_INTERACTIVE environment variable.
 identify_qemu_append () {
+	echo debug_boot_weak_hash
 	local console=ttyS0
 	case "$1" in
 	qemu-system-x86_64|qemu-system-i386)
-- 
2.9.5

