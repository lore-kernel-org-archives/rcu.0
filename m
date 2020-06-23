Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA35C433E1
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E6632053B
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592872283;
	bh=0+NCie9ftnXh951nKqU1Zp6l6vYZqBI6Y+1hRSk46Ic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IuSJ/duBGrB6GB3dvJaAp95gfP4w0J2HLhGvoRs6RhL6jstz2aoT2fVhJY/nspkaz
	 qiIrXzPCZXDw2c2UoJGkC7iQ+PJnNXRcgOaD+bB2YGo8Xr3pW63thmVqM/nuVEHAQN
	 Zio66hDCLw9koDxnr9Ms289YIjb6aMgBxJIDRtRw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731485AbgFWAbL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:31:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731633AbgFWAaU (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:30:20 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2D0720CC7;
        Tue, 23 Jun 2020 00:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872219;
        bh=0+NCie9ftnXh951nKqU1Zp6l6vYZqBI6Y+1hRSk46Ic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gbiI402XbCS9b6MxRKZMRLFBg0C78erjEON/VN+6rEl2OPgR3EpTiZWeW90O3FbR3
         J05MksXRHGeOuhyjg40vdLTaGEZ7nMlM8Fof3l4GBbywr+/hiJmzPz+RDUXPy8R3uh
         6YLbaxQAdnd7UjvZWnRzbr08LxLRp5/0yTyzPfa0=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Arnd Bergmann <arnd@arndb.de>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 23/30] refperf: Work around 64-bit division
Date:   Mon, 22 Jun 2020 17:30:06 -0700
Message-Id: <20200623003013.26252-23-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002941.GA26089@paulmck-ThinkPad-P72>
References: <20200623002941.GA26089@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

A 64-bit division was introduced in refperf, breaking compilation
on all 32-bit architectures:

kernel/rcu/refperf.o: in function `main_func':
refperf.c:(.text+0x57c): undefined reference to `__aeabi_uldivmod'

Fix this by using div_u64 to mark the expensive operation.

[ paulmck: Update primitive and format per Nathan Chancellor. ]
Fixes: bd5b16d6c88d ("refperf: Allow decimal nanoseconds")
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Valdis Klētnieks <valdis.kletnieks@vt.edu>
Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refperf.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index 063eeb0..80d4490 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -478,7 +478,7 @@ static int main_func(void *arg)
 		if (torture_must_stop())
 			goto end;
 
-		result_avg[exp] = 1000 * process_durations(nreaders) / (nreaders * loops);
+		result_avg[exp] = div_u64(1000 * process_durations(nreaders), nreaders * loops);
 	}
 
 	// Print the average of all experiments
@@ -489,9 +489,13 @@ static int main_func(void *arg)
 	strcat(buf, "Runs\tTime(ns)\n");
 
 	for (exp = 0; exp < nruns; exp++) {
+		u64 avg;
+		u32 rem;
+
 		if (errexit)
 			break;
-		sprintf(buf1, "%d\t%llu.%03d\n", exp + 1, result_avg[exp] / 1000, (int)(result_avg[exp] % 1000));
+		avg = div_u64_rem(result_avg[exp], 1000, &rem);
+		sprintf(buf1, "%d\t%llu.%03u\n", exp + 1, avg, rem);
 		strcat(buf, buf1);
 	}
 
-- 
2.9.5

