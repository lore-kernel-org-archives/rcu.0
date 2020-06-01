Return-Path: <SRS0=avCC=7O=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022AFC433E0
	for <rcu@archiver.kernel.org>; Mon,  1 Jun 2020 18:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0010207D0
	for <rcu@archiver.kernel.org>; Mon,  1 Jun 2020 18:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsuZ1J6M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbgFASqi (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730022AbgFASqO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 1 Jun 2020 14:46:14 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244B0C03E96B;
        Mon,  1 Jun 2020 11:46:12 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id p5so843098wrw.9;
        Mon, 01 Jun 2020 11:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kOFsyDdtC4tQx70DlVKZyfHhP0kIiFn/byNoh5w8E6o=;
        b=IsuZ1J6M6AqznqHS00K5dEA6yy4uQJk6aMikbPyOVD1y56PIW67DCNjyLHHwHIR6wq
         rnGUL2avrqYY+6YRcd2cEJthIapmNRA7PbLhlauzSPYm16JfmTs+OZyytHYqtYLkHJ9w
         PXUAktZoV1kds4KA/acdYK5Rvq5vKk2GKiPeikJNPjHBfyWybGIGvnYp8Z20NPUcf1og
         oGsx0SjZ+Uq0KoBphj+wYYtQ3B+rp0oWzUKbs1Dwrz24YmqL5YV4Fn1VgwJiNe/X+/RC
         GoIXT9/fNr3jmeTtgaiRJhfSyOO9kMScjs694I5tlZtMZmRrdD5P73M5E6reHnu8H4AG
         Ysbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kOFsyDdtC4tQx70DlVKZyfHhP0kIiFn/byNoh5w8E6o=;
        b=CKzeaoTJU4IGIjMyjMiocaJ+NDK/6dcajX8wHM/my8iyDxgzgUYJsyDjlaXHcDIIhl
         Wqln8uxoj6lXCupGcJKfEk1NZoKrdYr/tGhLdwdn2/G/xjjvAARy2QA9aKPM4D7Dlr2E
         Sy3sviZns81Pmj0VlTGDGhUilPXIBgvxiAy8tYThEWk7a4A9qA7JPae/2XUN8dMajZJL
         T7YDw9qelB75ZyJI95vDMD73UgvBK8s3YK8lo/8+Z3h0jhAj70xyrVccHIqeBJCYPJgX
         WccYkU232MqVgKjNGdMF9UG0GCH/w8DNDVEJ/tMmec1H+jB1si0SHmmgb9m2mTcmv5+g
         PKEw==
X-Gm-Message-State: AOAM532yhKS8pu152MxI2Ct1ZvpL/6C5DBu6ibI+YIGFSLGdpsjd6sgk
        M2VJdh2x3qadPTqdykOUuxCIk/GGyf9Z
X-Google-Smtp-Source: ABdhPJxbhyx+AYkx+0ePohkm8db6fS8uonyl1TG8MEyzjZw+X31riPYUopSsPgmatcyKM2QBQx16sQ==
X-Received: by 2002:adf:f5ca:: with SMTP id k10mr22529511wrp.305.1591037170581;
        Mon, 01 Jun 2020 11:46:10 -0700 (PDT)
Received: from earth3.lan (host-92-15-172-76.as43234.net. [92.15.172.76])
        by smtp.googlemail.com with ESMTPSA id 23sm302229wmg.10.2020.06.01.11.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 11:46:10 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, paulmck@kernel.org, mingo@redhat.com,
        boqun.feng@gmail.com, Jules Irenge <jbi.octave@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        rcu@vger.kernel.org (open list:READ-COPY UPDATE (RCU))
Subject: [PATCH 1/5] rcu/rcutorture: replace 0 with false
Date:   Mon,  1 Jun 2020 19:45:48 +0100
Message-Id: <20200601184552.23128-2-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200601184552.23128-1-jbi.octave@gmail.com>
References: <20200601184552.23128-1-jbi.octave@gmail.com>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Coccinelle reports a warning

WARNING: Assignment of 0/1 to bool variable

The root cause is the variable lastphase  is of bool type is initialised with integer 0
Replacing 0 with false fixes the issue.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/rcu/rcutorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 5453bd557f43..a082bc402f9b 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2065,7 +2065,7 @@ static void rcu_torture_barrier1cb(void *rcu_void)
 static int rcu_torture_barrier_cbs(void *arg)
 {
 	long myid = (long)arg;
-	bool lastphase = 0;
+	bool lastphase = false;
 	bool newphase;
 	struct rcu_head rcu;
 
-- 
2.18.2

