Return-Path: <SRS0=RBzz=CJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D8DC433E6
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BD3721534
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897273;
	bh=V/5+zAPAGDsJaUfpmyYkRjpFiQYBfOLDuFgsWNBLRcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Dz29+jsE5+QvFAavimJV5sTpID45nyOnwYCecTqEWOhVE0uEbStlk2nLax5g6yfC7
	 S2fu9tMhyt7OoFB7BTcWAub9F96b+W5K2DBM3ZWrMi1AI68n0ctnRYcBCHvPFClByk
	 tlPKT/05yQHHBb7/oonY4MTpuQLx/kqdgSzJ3k8s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbgHaSHw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:07:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:55306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728400AbgHaSHw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Aug 2020 14:07:52 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F37F720EDD;
        Mon, 31 Aug 2020 18:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897272;
        bh=V/5+zAPAGDsJaUfpmyYkRjpFiQYBfOLDuFgsWNBLRcw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hafV8f0yx1s6B7gMHhP4zJ5PAWffnGj+5c4b/DJtfkE33xscwL9Tr57aUfroeEaC0
         SMe2yhBrWRJjxtwD8hvYQ15q9/WqRq6v+ybM/GhKFQvI08vuqccRDdhRij/Rm0nYs+
         JgMazBprxLNjATeUmMoH0j9Vz9EjsmIQBEacPMwM=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 02/19] torture: Declare parse-console.sh independence from rcutorture
Date:   Mon, 31 Aug 2020 11:07:32 -0700
Message-Id: <20200831180749.843-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180731.GA582@paulmck-ThinkPad-P72>
References: <20200831180731.GA582@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, parse-torture.sh looks at the fifth field of torture-test
console output for the version number.  This works fine for rcutorture,
but not for scftorture, which lacks the pointer field.  This commit
therefore adjusts matching lines so that the parse-console.sh awk script
always sees the version number as the first field in the lines passed
to it.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/parse-console.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/parse-console.sh b/tools/testing/selftests/rcutorture/bin/parse-console.sh
index 71a9f43..4e081a2 100755
--- a/tools/testing/selftests/rcutorture/bin/parse-console.sh
+++ b/tools/testing/selftests/rcutorture/bin/parse-console.sh
@@ -67,6 +67,7 @@ then
 	grep --binary-files=text 'torture:.*ver:' $file |
 	egrep --binary-files=text -v '\(null\)|rtc: 000000000* ' |
 	sed -e 's/^(initramfs)[^]]*] //' -e 's/^\[[^]]*] //' |
+	sed -e 's/^.*ver: //' |
 	awk '
 	BEGIN	{
 		ver = 0;
@@ -74,13 +75,13 @@ then
 		}
 
 		{
-		if (!badseq && ($5 + 0 != $5 || $5 <= ver)) {
+		if (!badseq && ($1 + 0 != $1 || $1 <= ver)) {
 			badseqno1 = ver;
-			badseqno2 = $5;
+			badseqno2 = $1;
 			badseqnr = NR;
 			badseq = 1;
 		}
-		ver = $5
+		ver = $1
 		}
 
 	END	{
-- 
2.9.5

