Return-Path: <SRS0=oPal=A3=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB90C433E0
	for <rcu@archiver.kernel.org>; Thu, 16 Jul 2020 14:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1A55206F4
	for <rcu@archiver.kernel.org>; Thu, 16 Jul 2020 14:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgGPOjJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:39:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58226 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgGPOjJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Jul 2020 10:39:09 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jw52G-0006r1-D3; Thu, 16 Jul 2020 14:38:56 +0000
From:   Colin King <colin.king@canonical.com>
To:     "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] refperf: avoid null pointer dereference when buf fails to allocate
Date:   Thu, 16 Jul 2020 15:38:56 +0100
Message-Id: <20200716143856.1708123-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently in the unlikely event that buf fails to be allocated it
is dereferenced a few times.  Use the errexit flag to determine if
buf should be written to to avoid the null pointer dereferences.

Addresses-Coverity: ("Dereference after null check")
Fixes: f518f154ecef ("refperf: Dynamically allocate experiment-summary output buffer")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 kernel/rcu/refscale.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index d9291f883b54..952595c678b3 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -546,9 +546,11 @@ static int main_func(void *arg)
 	// Print the average of all experiments
 	SCALEOUT("END OF TEST. Calculating average duration per loop (nanoseconds)...\n");
 
-	buf[0] = 0;
-	strcat(buf, "\n");
-	strcat(buf, "Runs\tTime(ns)\n");
+	if (!errexit) {
+		buf[0] = 0;
+		strcat(buf, "\n");
+		strcat(buf, "Runs\tTime(ns)\n");
+	}
 
 	for (exp = 0; exp < nruns; exp++) {
 		u64 avg;
-- 
2.27.0

