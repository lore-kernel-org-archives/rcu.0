Return-Path: <SRS0=efVp=7L=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C424C433DF
	for <rcu@archiver.kernel.org>; Fri, 29 May 2020 20:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E07112074D
	for <rcu@archiver.kernel.org>; Fri, 29 May 2020 20:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgE2UQq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 29 May 2020 16:16:46 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:39603 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgE2UQp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 29 May 2020 16:16:45 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MORN0-1jMYM121IE-00PttL; Fri, 29 May 2020 22:16:03 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] refperf: work around 64-bit division
Date:   Fri, 29 May 2020 22:15:51 +0200
Message-Id: <20200529201600.493808-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:PQZD4g8Q2moWCWhPr6odJnIapf3nXy4W7wCFPSKsbBz+LPZKhTC
 qsgqYZKPt4ok3/9kY7L8h1XSqNfLh8eIJaIfg8PFg3RH7FqIkxuEN0xIvnQEee4dKwplEHV
 n3EP/BAEpoCMP6THwEiDbh5RSIwPFHN2DY7D0v+25kh0AYyxCVfxB1p9cCUO3xnjJejOWDo
 yOZx8BjNO67JcnsxM9orw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S6dksieHZM8=:eXzyeEHE+x5lh4Ee+F3P/C
 FolV1ChJvm/9+4MVjDwdzUHjGRPnb0Q6W2evHSPi+ZoahDyB7KLGsQYUZLtUl1EITa62AfbDt
 baGvWLB/AYPNxd7iiFQJXpJC6aPT50pa2oHNTSifCTZAw1qRyVHyJWHNvmKFtCGolmkdBxjpt
 WlDHJLNXl/9hMOy47yvIMDp6o1C6U8eoIABhzwUpV9WE6Qn4w6LbZSznAQFCvLxRZ13vKvGwK
 8zuumw3EU+aolIyXWti1zsp0XgwWq4JH+ySq+VKtULvqh4uoXfgeK6HX0LEPNynKbcLspXgKa
 JlepGKqSThAwkIFgxqB5xewEm87CUmsWmUWas29WSsUIhPQWpw6QUWmXO3/TR6j4gn4/4JPhz
 824V71VTRnmJJBQIK4RyrnqYuoINE6MAiz8pg/bd59uycxnSTRbbHU/7QQhU/HhT9RJ0LfLg/
 rzA5llrFE0qluYLwp5To9UhMQtzJDQBMoRCp08v3YqnJYR1xG+MAfHb01vxr1aTpNOnAbhbmR
 LKyaoVWQ30F/0OmvTFMUZvysgcUuF/7nbsW2ca94c1+8ywdk0Hv93AGdNwKe1BAXSD5taISUr
 CGmVdcrY3cKu5ajvDJTv2L43VmcBAiYBByUTwGVE+BHT8U1rK3xE2yZ7vEpkZf3dBoEi5QtZP
 eD1ePtynsNHw6+UlPRzqUiuEcOTbOmFVbnYCTP3gTPyXhPXrVGLizrimlyKiWMgU6TrGm+r+f
 FnKPcbeWnp0vySlo0IVOuAfkIond/yxbwKJAMzrv7ApXcJp1lHXXGDy+e4TXur/p9QieFLr4c
 UkEXrTAqS333iT9mK668q4F01sNow95U1wNg4R7IvCJUPeYdoo=
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

A 64-bit division was introduced in refperf, breaking compilation
on all 32-bit architectures:

kernel/rcu/refperf.o: in function `main_func':
refperf.c:(.text+0x57c): undefined reference to `__aeabi_uldivmod'

Work it by using div_u64 to mark the expensive operation.

Fixes: bd5b16d6c88d ("refperf: Allow decimal nanoseconds")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/rcu/refperf.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index 47df72c492b3..c2366648981d 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -386,7 +386,7 @@ static int main_func(void *arg)
 		if (torture_must_stop())
 			goto end;
 
-		result_avg[exp] = 1000 * process_durations(nreaders) / (nreaders * loops);
+		result_avg[exp] = div_u64(1000 * process_durations(nreaders), nreaders * loops);
 	}
 
 	// Print the average of all experiments
@@ -397,9 +397,14 @@ static int main_func(void *arg)
 	strcat(buf, "Threads\tTime(ns)\n");
 
 	for (exp = 0; exp < nruns; exp++) {
+		u64 avg;
+		u32 rem;
+
 		if (errexit)
 			break;
-		sprintf(buf1, "%d\t%llu.%03d\n", exp + 1, result_avg[exp] / 1000, (int)(result_avg[exp] % 1000));
+
+		avg = div_s64_rem(result_avg[exp], 1000, &rem);
+		sprintf(buf1, "%d\t%llu.%03d\n", exp + 1, avg, rem);
 		strcat(buf, buf1);
 	}
 
-- 
2.26.2

