Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9FFC4321E
	for <rcu@archiver.kernel.org>; Tue,  8 Feb 2022 11:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359468AbiBHLbh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 8 Feb 2022 06:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348189AbiBHKxA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 8 Feb 2022 05:53:00 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C411C03FEC3;
        Tue,  8 Feb 2022 02:52:58 -0800 (PST)
Received: from localhost.localdomain (ip5f5aebc2.dynamic.kabel-deutschland.de [95.90.235.194])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1742661E64846;
        Tue,  8 Feb 2022 11:52:57 +0100 (CET)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcutorture: Add missing - to `--do-allmodconfig` in usage
Date:   Tue,  8 Feb 2022 11:52:40 +0100
Message-Id: <20220208105240.43600-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The usage currently lists `--doallmodconfig`, resulting in:

    $ tools/testing/selftests/rcutorture/bin/torture.sh --doallmodconfig
    Unknown argument --doallmodconfig
    […]

Add the missing dash for `--do-allmodconfig`.

Fixes: a115a775a8d5 ("torture: Add "make allmodconfig" to torture.sh")
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index eae88aacca2a..3adcc83dd55d 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -72,7 +72,7 @@ usage () {
 	echo "       --configs-locktorture \"config-file list w/ repeat factor (10*LOCK01)\""
 	echo "       --configs-scftorture \"config-file list w/ repeat factor (2*CFLIST)\""
 	echo "       --doall"
-	echo "       --doallmodconfig / --do-no-allmodconfig"
+	echo "       --do-allmodconfig / --do-no-allmodconfig"
 	echo "       --do-clocksourcewd / --do-no-clocksourcewd"
 	echo "       --do-kasan / --do-no-kasan"
 	echo "       --do-kcsan / --do-no-kcsan"
-- 
2.34.1

