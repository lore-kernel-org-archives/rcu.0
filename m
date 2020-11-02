Return-Path: <SRS0=CE9U=EI=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE11C00A89
	for <rcu@archiver.kernel.org>; Mon,  2 Nov 2020 17:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A897E20657
	for <rcu@archiver.kernel.org>; Mon,  2 Nov 2020 17:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TXcEpg7m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vEJcoEFx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbgKBRMb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 2 Nov 2020 12:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbgKBRMb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 2 Nov 2020 12:12:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F96DC0617A6
        for <rcu@vger.kernel.org>; Mon,  2 Nov 2020 09:12:31 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604337149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3WdGZ2IUML+Q2W8HxhW5ugLYk82KrTqX/qoV8PUFRtM=;
        b=TXcEpg7mswJdTxEbVisGVSdqGXNSzk1vIu+zIQk3O0Tz5m5dlWHHp4jKfE+xn5sbZgezyI
        Nd1VN+SfO3qDI0Dr4Jtq8z3HGNzHBqVUOfvkQzfo6ahb1cCWkQTpDMwgHdw5ULBqn/gcqC
        gYGk5E8BcVYkp7y7wUZSUvahNGpKRjxkD9YjCiJwIkxP3sumzWstLQLSHSCOT82F4jEfOf
        fWCLQ1jimVR/kg9B9JhxOMH2vVGJi/QLbjQp9BOx/iffq3CHNU6wAbEqWMiI/kJ4SRnf74
        xJtJoU3qxxi85FICRrR3KXoTP5CFV6EUx3KHuulZAptuSrF39muPR/4W3Oo5HA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604337149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3WdGZ2IUML+Q2W8HxhW5ugLYk82KrTqX/qoV8PUFRtM=;
        b=vEJcoEFxiPzhwL/MSgkWa5hdzu1IuzbhXADDoOyHbiSrviSVeBB/g1DdUCXOdyo8ylqRwM
        zPgcok95PmakjgBQ==
To:     RCU <rcu@vger.kernel.org>
Cc:     "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Benedikt Spranger <b.spranger@linutronix.de>
Subject: [PATCH] tools/rcutorture: Fix BUG parsing of console.log
Date:   Mon,  2 Nov 2020 18:12:20 +0100
Message-Id: <20201102171220.8820-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

For the rcutorture test summary log file console.log of virtual machines is
parsed. When a console.log contains "DEBUG", BUG counter is incremented
because regular expression does not handle to ignore DEBUG.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Benedikt Spranger <b.spranger@linutronix.de>
---
 tools/testing/selftests/rcutorture/bin/parse-console.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/parse-console.sh b/tools/testing/selftests/rcutorture/bin/parse-console.sh
index e03338091a06..263b1be50008 100755
--- a/tools/testing/selftests/rcutorture/bin/parse-console.sh
+++ b/tools/testing/selftests/rcutorture/bin/parse-console.sh
@@ -133,7 +133,7 @@ then
 	then
 		summary="$summary  Warnings: $n_warn"
 	fi
-	n_bugs=`egrep -c 'BUG|Oops:' $file`
+	n_bugs=`egrep -c '\bBUG|Oops:' $file`
 	if test "$n_bugs" -ne 0
 	then
 		summary="$summary  Bugs: $n_bugs"
-- 
2.20.1

