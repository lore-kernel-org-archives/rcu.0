Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBD7C6369E
	for <rcu@archiver.kernel.org>; Thu, 19 Nov 2020 00:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5124D246E8
	for <rcu@archiver.kernel.org>; Thu, 19 Nov 2020 00:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="v2CsU4S+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgKSAaa (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 18 Nov 2020 19:30:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:60252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbgKSAaa (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 18 Nov 2020 19:30:30 -0500
Received: from localhost.localdomain (unknown [176.167.53.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC257246E4;
        Thu, 19 Nov 2020 00:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605745829;
        bh=JUxAzR2m1reJ8WdHEL+xpyi7SrhDsmfAbQiH/wG25cQ=;
        h=From:To:Cc:Subject:Date:From;
        b=v2CsU4S+jMbJHZKogD5HKjxs6x5Iyg2bvdKz06OvvCF7SxM4EIosnSDNppg93QL0L
         BpovX8dxd3T2nqDJT4Ks+1VZDzoDFTPyyxMxhLzXqH72GkyJOLmMYoP17V/NSL0/wH
         9FWMU6Pw3CdPGBDQsc7SvpIaiiyA1EQ3YrcmivKo=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH] tools/rcutorture: Make identify_qemu_vcpus() independant of local language
Date:   Thu, 19 Nov 2020 01:30:24 +0100
Message-Id: <20201119003024.10701-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The implementation expects `lscpu` to have a "CPU: " line, for example:

	CPU(s):		8

But some local language settings may advocate for their own version:

	Processeur(s) :		8

As a result the function may return an empty string and rcutorture would
dump the following warning (still with the local taste):

	kvm-test-1-run.sh: ligne 138 : test:  : nombre entier attendu comme expression

Just use a command whose output every language agree with.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: rcu@vger.kernel.org
---
 tools/testing/selftests/rcutorture/bin/functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
index 82663495fb38..fef8b4b55c27 100644
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
2.25.1

