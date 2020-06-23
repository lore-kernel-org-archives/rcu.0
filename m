Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18734C433E1
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAF27207BC
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592872677;
	bh=G8x8XPcxZs85lPYsBAKK4gjW3vPHBeMjy9sfMokT/vU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AglVdST4MkeKBrGPfLv2XiJfM1iSAQ4jzNoSFT028eWjkLKrF3uYabCcA8+jZ5q0s
	 0vd+gzuCDwKFSmjpoK713vwNRJQ+Unmz4kfZ7qjZaUhY/S4BembzRkSzMRMXv40iMJ
	 CdwEUpn6EOuWQ/wUmrljVaiAbhjRb5WiNU9pd09E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732152AbgFWAh5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:37:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:33670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732035AbgFWAhz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:37:55 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C292208A7;
        Tue, 23 Jun 2020 00:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872675;
        bh=G8x8XPcxZs85lPYsBAKK4gjW3vPHBeMjy9sfMokT/vU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X3/xMKgiP4EpmTAH1AC2PhRM6tXgjGwaFp/g8Sw+iHTnyys0HFGBwZVFyu70mASJY
         4jzschj1n26DBe4TQMTYKR2IajPHodEn5/WA3IevHagrYcJyMJ4gGZszpNzOAMFfHO
         uvGpVpHZFw0bR2M1WkOLDUdNH45PDmXjdvRvGmN4=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 08/23] torture: Remove whitespace from identify_qemu_vcpus output
Date:   Mon, 22 Jun 2020 17:37:37 -0700
Message-Id: <20200623003752.26872-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623003731.GA26717@paulmck-ThinkPad-P72>
References: <20200623003731.GA26717@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The identify_qemu_vcpus bash function can return numbers including
whitespace characters, which can be a bit annoying in some bash
dollar-sign substitutions.  This commit therefore strips all spaces and
tabs from the value that identify_qemu_vcpus outputs.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
index 436b154..51f3464 100644
--- a/tools/testing/selftests/rcutorture/bin/functions.sh
+++ b/tools/testing/selftests/rcutorture/bin/functions.sh
@@ -231,7 +231,7 @@ identify_qemu_args () {
 # Returns the number of virtual CPUs available to the aggregate of the
 # guest OSes.
 identify_qemu_vcpus () {
-	lscpu | grep '^CPU(s):' | sed -e 's/CPU(s)://'
+	lscpu | grep '^CPU(s):' | sed -e 's/CPU(s)://' -e 's/[ 	]*//g'
 }
 
 # print_bug
-- 
2.9.5

