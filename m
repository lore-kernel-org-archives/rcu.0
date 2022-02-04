Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34ACC433FE
	for <rcu@archiver.kernel.org>; Fri,  4 Feb 2022 23:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378527AbiBDX4N (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 4 Feb 2022 18:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378496AbiBDX4I (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 4 Feb 2022 18:56:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E0EDB788CD;
        Fri,  4 Feb 2022 15:56:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F978B8397C;
        Fri,  4 Feb 2022 23:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEDF8C340FB;
        Fri,  4 Feb 2022 23:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644018962;
        bh=5LHH/udgFWNwegl1ai3PJBMHlKqUN4SkpOmVzHlGIQE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gBVhtPaP0NXHORAbnAmOOAJnlOZCs1CQ1VXCxLIXYcdMdXuW67+Z/NT90qEgdhTHY
         JGKXFlSs4Cj/Rj5IjkrIpPy9Rhfvur0xHnmY8lS5mS0sR6dsZhJlJbeaRaBu1vHS4t
         cXyX5nt01Ohy5KEx8nFgTSkdOduCdH6qjhOYark0Q9qaZr1mbXLITlsSWzonX9f82H
         twrtuQDNeGvtnre3eiaL+OlfJ2j3FA6lamprPookVOnVhyCCh0NeoIvIush6I563cL
         71NLkXCzXhHp7BCBoom8QlEIogBuSL2kOsM9FrlDuwpSIsR+8bg7VPVOsn6ntt+U6T
         xknyJNZh/G2+A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 676995C0DB8; Fri,  4 Feb 2022 15:56:02 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 11/13] torture: Make torture.sh help message match reality
Date:   Fri,  4 Feb 2022 15:55:59 -0800
Message-Id: <20220204235601.3438-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204235558.GA3221@paulmck-ThinkPad-P17-Gen-1>
References: <20220204235558.GA3221@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This commit fixes a couple of typos: s/--doall/--do-all/ and
s/--doallmodconfig/--do-allmodconfig/.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index e00e60efb2310..bfe09e2829c8d 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -71,8 +71,8 @@ usage () {
 	echo "       --configs-rcutorture \"config-file list w/ repeat factor (3*TINY01)\""
 	echo "       --configs-locktorture \"config-file list w/ repeat factor (10*LOCK01)\""
 	echo "       --configs-scftorture \"config-file list w/ repeat factor (2*CFLIST)\""
-	echo "       --doall"
-	echo "       --doallmodconfig / --do-no-allmodconfig"
+	echo "       --do-all"
+	echo "       --do-allmodconfig / --do-no-allmodconfig"
 	echo "       --do-clocksourcewd / --do-no-clocksourcewd"
 	echo "       --do-kasan / --do-no-kasan"
 	echo "       --do-kcsan / --do-no-kcsan"
-- 
2.31.1.189.g2e36527f23

