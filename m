Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8B6C3815B
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 900F021707
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586970729;
	bh=WED0g8p0VyucPsEGiI66uD3UYudFeJSY415JzZLv8Fc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VQnWBrboQ0nZ+4HCZ3PyzD5Z40XLiO7H54T7JjApKVpnys4UD7JGf6TXMOYAlVxpG
	 SMJyxqvaqujAtLDhMJ06hscC4UTo8CvnLiVd+7apzq49xalnSvhioV4YyZgf9WaoM7
	 pz5qwzGGdt+URp24JCwCc8khqu8uwlsFbxf0KYnI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416401AbgDORMF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:12:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:42444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410715AbgDORK7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 13:10:59 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D82BA21D7E;
        Wed, 15 Apr 2020 17:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586970659;
        bh=WED0g8p0VyucPsEGiI66uD3UYudFeJSY415JzZLv8Fc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qxIw+Zx/ct1YPIg20lIHBBg3MKTgzwGJ7fNdBKuq5TRtu36drSJfW8kTs/yxeUXLu
         YEyuPtKsgHG5bs1kFACaPG/q4bUucCMyF5JycXMRfXRXDJbtZHRL0LVwU6/9BlYWFR
         DrycPIpYxFh6GNsoqzt8/SHZ2And77cZ2kKBoU8w=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 09/19] drm: Make drm_dp_mst_dsc_aux_for_port() safe for old compilers
Date:   Wed, 15 Apr 2020 10:10:44 -0700
Message-Id: <20200415171054.9013-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415171017.GA7821@paulmck-ThinkPad-P72>
References: <20200415171017.GA7821@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Older compilers either want two extra pairs of curly braces around the
initializer for local variable desc, or they want a single pair of curly
braces with nothing inside.  Because current Linux-kernel practice favors
the latter, this commit makes it so.

Suggested-by: Chris Wilson <chris@chris-wilson.co.uk>
Suggested-by: Joe Perches <joe@perches.com>
Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 70c4b7a..c409867 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -5494,7 +5494,7 @@ struct drm_dp_aux *drm_dp_mst_dsc_aux_for_port(struct drm_dp_mst_port *port)
 {
 	struct drm_dp_mst_port *immediate_upstream_port;
 	struct drm_dp_mst_port *fec_port;
-	struct drm_dp_desc desc = { 0 };
+	struct drm_dp_desc desc = { };
 	u8 endpoint_fec;
 	u8 endpoint_dsc;
 
-- 
2.9.5

