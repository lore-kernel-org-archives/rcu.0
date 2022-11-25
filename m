Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC18EC4332F
	for <rcu@archiver.kernel.org>; Fri, 25 Nov 2022 12:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiKYMqU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 25 Nov 2022 07:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiKYMqT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 25 Nov 2022 07:46:19 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677DE1A044
        for <rcu@vger.kernel.org>; Fri, 25 Nov 2022 04:46:19 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id mv18so3652339pjb.0
        for <rcu@vger.kernel.org>; Fri, 25 Nov 2022 04:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5LjS1uk/D0svdTm4OsleYTpQTzrNA/EHEEPoJGJnvA=;
        b=IVXhds1RDwXYeKz56wvwcmB5Q90vWTvvZc02d6oWJwca3qD/PHCIyb1zfJPsacYST0
         KgnFVMM7LqeO7p/4H1j+/qY+zSDPBGW/CdAu50eyJ8Ztx7JdoVkbFH+CZ4TneIxOaEu2
         c4S3Hj632nnrDFi+1Wj+ZL9dy251MNKdZN3nYjbBKmwNGV7nronjTziRC1vd4bQPNk0Q
         fVhtpZn8s2WgG8rdtALm9G+nNT3y0VQN9v2uQatKoBuh8oSP0TN5EwO1lhjCGNKYVnNE
         JnUeddLEZaPErqHmW+eRSjqVAiXv6NxNjVG9dfHpYb7w0LCyYQ5dHwLiw/ZkFyZ2nhle
         Q5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l5LjS1uk/D0svdTm4OsleYTpQTzrNA/EHEEPoJGJnvA=;
        b=IT7Id62ntquq0olfD3VJGclQgAyqGW3kCtBzTNmKxfOeVorC9dSlbwVRQ/akw5Yl09
         q9A69HFxkJl+7um6J/YjErDT8xNCI5fR68IN5/eufsZWqZBDckUAsU0P+9ccjJRHJ/JZ
         6Gu+EbiIduDyzATW7dFitXbiAL7rUFmQVdtkvpJDQnWXpEv4UsjCZJpFjNR8faajqfUj
         qKb0W83ErVImelPDyWWn2qSUBe0vIeppIQZRD7v7HYzWGD0CQBv0j6IiZdyzPJgbdDh9
         UF8MxrFJR7vMRSeVVX7Ut4j6Wk9AiqIrAtdbGsjp4nVIk8ixxFYvrsW45SeUitGlRiax
         ZnnQ==
X-Gm-Message-State: ANoB5pmCPYrhdmbkh94QasgRJ/ImPUpNF6pjvlwyTLqWccv2T7z69a6l
        A93Bn14I0Ix6yP9hLXEfqGwb8UdPQuMt
X-Google-Smtp-Source: AA0mqf4aa+z+u+/dWyGKxBCA4BfXx/NPNAgomadGS+MjhNI2v4yGQDeEgUQHlymuhQcDJkV+KVdNuw==
X-Received: by 2002:a17:903:2112:b0:183:9254:cc70 with SMTP id o18-20020a170903211200b001839254cc70mr19049907ple.18.1669380378385;
        Fri, 25 Nov 2022 04:46:18 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q15-20020a170902a3cf00b0017f8094a52asm3320586plb.29.2022.11.25.04.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 04:46:17 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     rcu@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCHv3] srcu: Eliminate the case that snp_seq bigger than snap in srcu_funnel_gp_start()
Date:   Fri, 25 Nov 2022 20:46:06 +0800
Message-Id: <20221125124606.56725-1-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221123135638.79021-3-kernelfans@gmail.com>
References: <20221123135638.79021-3-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Since the srcu read lock is still held during srcu_funnel_gp_start(),
the seq snap should be the largest number for the slot
srcu_have_cbs[idx].

Test info
Running the following test without any failure
  tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 10h --configs 18*SRCU-P
And
  cd res && find . -name  console.log -exec grep WARNING {} \;
prints nothing

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: rcu@vger.kernel.org
---
 kernel/rcu/srcutree.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 7e450bb4ddcf..687f243dd2e2 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -905,14 +905,12 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 		for (snp = snp_leaf; snp != NULL; snp = snp->srcu_parent) {
 			spin_lock_irqsave_rcu_node(snp, flags);
 			snp_seq = snp->srcu_have_cbs[idx];
-			if (!srcu_invl_snp_seq(snp_seq) && ULONG_CMP_GE(snp_seq, s)) {
+			/* s should be the biggest in the current slot. */
+			WARN_ON_ONCE(ULONG_CMP_LT(s, snp_seq));
+			if (!srcu_invl_snp_seq(snp_seq) && (snp_seq == s)) {
 				if (snp == snp_leaf && snp_seq == s)
 					snp->srcu_data_have_cbs[idx] |= sdp->grpmask;
 				spin_unlock_irqrestore_rcu_node(snp, flags);
-				if (snp == snp_leaf && snp_seq != s) {
-					srcu_schedule_cbs_sdp(sdp, do_norm ? SRCU_INTERVAL : 0);
-					return;
-				}
 				if (!do_norm)
 					srcu_funnel_exp_start(ssp, snp, s);
 				return;
-- 
2.31.1

