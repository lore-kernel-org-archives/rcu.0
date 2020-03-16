Return-Path: <SRS0=IXig=5B=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B610BC18E5B
	for <rcu@archiver.kernel.org>; Mon, 16 Mar 2020 16:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF50206C0
	for <rcu@archiver.kernel.org>; Mon, 16 Mar 2020 16:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="BZFrWGdL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732140AbgCPQcf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 16 Mar 2020 12:32:35 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:45649 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732044AbgCPQcf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 16 Mar 2020 12:32:35 -0400
Received: by mail-qv1-f67.google.com with SMTP id h20so5255269qvr.12
        for <rcu@vger.kernel.org>; Mon, 16 Mar 2020 09:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R+EJ0NlYqKDTdXP5FIK6OXNmAa652KgdhB+MYl0wXpU=;
        b=BZFrWGdL8/GnNyd7hwSMmMklvJmb6Va5pJ/PE02Eh8fvKGMxfLvo13T3DctcEMQAUr
         Nfouqu26mWmQyNmvm48wTg3ZY43KQH20dH49t/A1xBDx/UB191/kQw9wIWy4RuuWTV6B
         gbeyymWhmNd6weREuQiT2NvvShO75hbAyiync=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R+EJ0NlYqKDTdXP5FIK6OXNmAa652KgdhB+MYl0wXpU=;
        b=Mg7q4qhIrU4oGmxq1aKA6qKgqOP6wzg+LWMy+CjFdm7295A4UFetvteO+K5gTKxrUj
         6kFo9ZxIYF2+PZChG7smynzUdBW51KKxQATEywnQNTMRiAsm9dCxBISj9ZuOi7Vsb4+m
         wLkki8N9Xes8Wc4dvPDpXCAuYUxsoqeOZiB4QTuoYDavCJZEon+SY6ocTbsoX8CdJrVH
         WjogiEmD/wQRlUYEnTWECbX0Bo5JpbCp05yzoGhywFBpQ20XyLkRTc341ANcHT2ZoCK7
         HDl3/0skh6TN7PNdI7LQfTP9ADKENVQAiRJok8fTlwavXlaXD9UOqih/matF4vnqcGmy
         hgaw==
X-Gm-Message-State: ANhLgQ1JyWENiJBw3GSmsTXKTNtcXRcMDH84l83AHvfoXzEmBlheab3I
        zAqrXtPwPOz372P/niWSKW0Kig==
X-Google-Smtp-Source: ADFU+vuuX+NpDcguWehotUOXD5p8DVgzSaAjvOlrBERaveVbuKnU0fKd19hdYfQTfniLZs6BJ9fN4Q==
X-Received: by 2002:ad4:4802:: with SMTP id g2mr584866qvy.95.1584376353712;
        Mon, 16 Mar 2020 09:32:33 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id y127sm84139qkb.76.2020.03.16.09.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 09:32:33 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, urezki@gmail.com
Subject: [PATCH v2 rcu-dev 1/3] rcuperf: Add ability to increase object allocation size
Date:   Mon, 16 Mar 2020 12:32:26 -0400
Message-Id: <20200316163228.62068-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
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

The Series v1->v2 only has added a new patch (3/3).


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
2.25.1.481.gfbce0eb801-goog
