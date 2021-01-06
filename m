Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE236C433E9
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B332423333
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbhAFR1b (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:27:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:37856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbhAFR1a (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:27:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80B7123125;
        Wed,  6 Jan 2021 17:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609953970;
        bh=QzYVEe2w9m6ajQtBPj6Eqq7V5BDvpziS9qabL6ZqwuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kom8LIBynpL5tWXFHebr4srWH5dgOqJOrjtyGhBHhQjmEglxo3Hs6f5viMkdeE/lL
         rNBuMWPvqijzBSHcd8GUWCYU5SQEqPaJ3hf7kNzea2YecPRi+DH+6ydqV3xVme7kl5
         vJ22Fi198qXus5HTHluWmk0jF1QDEpf1HRFsXBVnr1GoznuhwC0RxkOzxy4CKVV4Uv
         iLPVW7rkcalmWbSVkHXLtr0OjbAogGWtpPvKjKgmpaWjpxk5AF86+h+i3SiRT+NW+j
         llqZ3utEnd/tOCZWZ8py/mbgRVzLk/KrYVzDNriMyc6WxOY+Hcyw+CohlDZ+wQUVo2
         FuUbleBsfq3Vw==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 07/20] tools/rcutorture: Make identify_qemu_vcpus() independent of local language
Date:   Wed,  6 Jan 2021 09:25:54 -0800
Message-Id: <20210106172607.22816-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106172547.GA22404@paulmck-ThinkPad-P72>
References: <20210106172547.GA22404@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

The rcutorture scripts' identify_qemu_vcpus() function expects `lscpu`
to have a "CPU: " line, for example:

	CPU(s):		8

But different local language settings can give different results:

	Processeur(s) :		8

As a result, identify_qemu_vcpus() may return an empty string, resulting
in the following warning (with the same local language settings):

	kvm-test-1-run.sh: ligne 138 : test:  : nombre entier attendu comme expression

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

diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
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
 
 # print_bug
-- 
2.9.5

