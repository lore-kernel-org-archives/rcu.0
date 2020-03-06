Return-Path: <SRS0=V1ps=4X=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1091C3F2D9
	for <rcu@archiver.kernel.org>; Fri,  6 Mar 2020 01:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82DE20726
	for <rcu@archiver.kernel.org>; Fri,  6 Mar 2020 01:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="NG1T3fBT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgCFBQh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Mar 2020 20:16:37 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:41899 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgCFBQh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Mar 2020 20:16:37 -0500
Received: by mail-qv1-f65.google.com with SMTP id s15so231393qvn.8
        for <rcu@vger.kernel.org>; Thu, 05 Mar 2020 17:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w/Vqkumn/RHHCHsg28o5TElun0WCp3EnRDLyxx7bNCY=;
        b=NG1T3fBTXkAXVDjCWQdULYeSHkaWIO+lNW6+qNFMIb0eh3q05SunsJOTOTzaMoCmd/
         zVA4gLfxEBLo2TdLQitZbT9fcbCOceM167cFWG8DEi3qZ7q9Ny6f1A6/Z8nW8PnPTNxo
         hHV6gR6kvmC3goH5y5vM7m/K1vWRjrZuR62m0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w/Vqkumn/RHHCHsg28o5TElun0WCp3EnRDLyxx7bNCY=;
        b=h/ndnmS7jR62Tbcod/PN5owsL97BMPgIa/rLXbT7K2jyurZqHQva6p6b6SvvlTTi4J
         U2UH/Y8V/gA/VhOEkuMDrWNP7NonFH15tA0Ls75EhyMDEVxpSMcbJBfl5lhASGsPQmLs
         yQV/gRcRADNi8lUb3WYYTPKW+9LpEiiVX6jgQq+3gB+8eqWOBHmPChrnCg6EJGFHBwL5
         IxbFI8x72IL4wJdJvx/14XEREu3wXLiWXK41fX4SXkpqIv2TtK0XpXSp/is9ak15vbL5
         WXWN1uNLvRxRvaNovz9oWdTSgLesIw/ie9kMt55kSBc587brTBUm4PLQORJPyW+f7EhD
         X8pg==
X-Gm-Message-State: ANhLgQ0tlk/2dCV7QV7REwYH0iTYdhRBD00DPD4DKDcFVPaT0Upu1rZR
        JyZWLxB1XNstRTOO8/yfcDN/Uw==
X-Google-Smtp-Source: ADFU+vu3eXzAwRUQJNXWudiplRiGCsZ1MUGVqnptRhU2xlgymmp2luL5Kh0xMVbNIJQBgcRmdBWyKA==
X-Received: by 2002:a0c:f381:: with SMTP id i1mr948212qvk.163.1583457394590;
        Thu, 05 Mar 2020 17:16:34 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 65sm16934009qtf.95.2020.03.05.17.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 17:16:34 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, urezki@gmail.com
Subject: [PATCH rcu-dev 1/2] rcuperf: Add ability to increase object allocation size
Date:   Thu,  5 Mar 2020 20:16:25 -0500
Message-Id: <20200306011626.97616-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This allows us to increase memory pressure dynamically using a new
rcuperf boot command line parameter called 'rcumult'.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---
 kernel/rcu/rcuperf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index a4a8d097d84d9..16dd1e6b7c09f 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -88,6 +88,7 @@ torture_param(bool, shutdown, RCUPERF_SHUTDOWN,
 torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
 torture_param(int, writer_holdoff, 0, "Holdoff (us) between GPs, zero to disable");
 torture_param(int, kfree_rcu_test, 0, "Do we run a kfree_rcu() perf test?");
+torture_param(int, kfree_mult, 1, "Multiple of kfree_obj size to allocate.");
 
 static char *perf_type = "rcu";
 module_param(perf_type, charp, 0444);
@@ -635,7 +636,7 @@ kfree_perf_thread(void *arg)
 		}
 
 		for (i = 0; i < kfree_alloc_num; i++) {
-			alloc_ptr = kmalloc(sizeof(struct kfree_obj), GFP_KERNEL);
+			alloc_ptr = kmalloc(kfree_mult * sizeof(struct kfree_obj), GFP_KERNEL);
 			if (!alloc_ptr)
 				return -ENOMEM;
 
@@ -722,6 +723,8 @@ kfree_perf_init(void)
 		schedule_timeout_uninterruptible(1);
 	}
 
+	pr_alert("kfree object size=%lu\n", kfree_mult * sizeof(struct kfree_obj));
+
 	kfree_reader_tasks = kcalloc(kfree_nrealthreads, sizeof(kfree_reader_tasks[0]),
 			       GFP_KERNEL);
 	if (kfree_reader_tasks == NULL) {
-- 
2.25.0.265.gbab2e86ba0-goog

