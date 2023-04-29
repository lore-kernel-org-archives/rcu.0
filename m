Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F31CC77B61
	for <rcu@archiver.kernel.org>; Sat, 29 Apr 2023 01:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347307AbjD2B7w (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 28 Apr 2023 21:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347372AbjD2B7n (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 28 Apr 2023 21:59:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63275589;
        Fri, 28 Apr 2023 18:59:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6057E6463E;
        Sat, 29 Apr 2023 01:59:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D0EC433EF;
        Sat, 29 Apr 2023 01:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682733554;
        bh=pexP+Ju7knjMu0xJI9XrT5m97IMWiJu/StdvZHL0Ky4=;
        h=From:To:Cc:Subject:Date:From;
        b=EnIAKBOJLJ7Yww0Jld3Cme/eMZIsR0fxoHdeWsJ1fgS7Nyqk1Q+ylvb7AC9ZTQ0L5
         H/WalH/nCoQieo28+e9EBlH7O2jNp6Lop9ATNmjnG6Ev6BN5jvcnmdksSzawhP16uF
         uVdlTZtCwIPRY7dnn1uRI6fd2WQ2BNb/VM32PBVfQjUDim3qBIzNMMl2OIsajM6DX/
         1RF5WvxTx9xNnF7qxDnpPDKKS+Ta8Hup6hwle+FSHT/fipYY1Is0Iw+bYDV9zZ2DgI
         nWSxYnuuWst3AbHNTclzUKsykLLfuHcxocsxZxgoV0EtkYemdEcPkkO5YsgxtUKP//
         WQjypngHD8uzQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sasha Levin <sashal@kernel.org>, dave@stgolabs.net,
        josh@joshtriplett.org, frederic@kernel.org,
        quic_neeraju@quicinc.com, rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 1/2] refscale: Move shutdown from wait_event() to wait_event_idle()
Date:   Fri, 28 Apr 2023 21:59:10 -0400
Message-Id: <20230429015911.3027384-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

[ Upstream commit 6bc6e6b27524304aadb9c04611ddb1c84dd7617a ]

The ref_scale_shutdown() kthread/function uses wait_event() to wait for
the refscale test to complete.  However, although the read-side tests
are normally extremely fast, there is no law against specifying a very
large value for the refscale.loops module parameter or against having
a slow read-side primitive.  Either way, this might well trigger the
hung-task timeout.

This commit therefore replaces those wait_event() calls with calls to
wait_event_idle(), which do not trigger the hung-task timeout.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/refscale.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 66dc14cf5687e..5abb0cf52803a 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -777,7 +777,7 @@ ref_scale_cleanup(void)
 static int
 ref_scale_shutdown(void *arg)
 {
-	wait_event(shutdown_wq, shutdown_start);
+	wait_event_idle(shutdown_wq, shutdown_start);
 
 	smp_mb(); // Wake before output.
 	ref_scale_cleanup();
-- 
2.39.2

