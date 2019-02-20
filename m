Return-Path: <SRS0=hk7p=Q3=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA2BC10F01
	for <rcu@archiver.kernel.org>; Wed, 20 Feb 2019 04:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACFC22147A
	for <rcu@archiver.kernel.org>; Wed, 20 Feb 2019 04:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="lVWOTKd9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730474AbfBTEJQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 19 Feb 2019 23:09:16 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46583 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730434AbfBTEJP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 19 Feb 2019 23:09:15 -0500
Received: by mail-qk1-f196.google.com with SMTP id i5so1101223qkd.13
        for <rcu@vger.kernel.org>; Tue, 19 Feb 2019 20:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1LCwpNs6kStjHl/Jni0GcBly3FB3vdem3YheZShTyrE=;
        b=lVWOTKd9/raYN/WIag7Bel5GABbTDz9ttkxNv2mlSnJbNKkiKemEHn0tY6cccBBNd4
         DfPE4BvxLsqITBDWLUZkCuT0GY7w608EqEsvOavdhUMy38rjwX14jTo7af7eoigx3r8M
         ErNIFjaTFhtXhBwKQfG4ycoNkk82EqNqXiS44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1LCwpNs6kStjHl/Jni0GcBly3FB3vdem3YheZShTyrE=;
        b=HVjaG75ccvCXt4EYOHaVI+zPgjOOn/N6WwpaTkJhuP76NZlRwACeqP3nClypkmdjsO
         qh+aWiDnMVvQlYlJc4gmUj9G4m/Tth/DmUrwdNQ/m1hdmBQnSKHm1ZmENA743lPCYqHa
         uZ6DJB93+zbH3hr1NW+RYqJvsmxvG3oq4lAJNYe4P6z4vAHZ+nagr+h0dAOAmQ+2Qn5J
         zfU4vr6rDPlxGioiEGfQt5YtbfBwU/5qS7BrQyz7mukEzTuaLZzbds/ju//dwW90DfMG
         NxL1YPTXnWdjWfICjK3ATJpC/hGrpeHVxMy3XYwdvGr6RxidaSmOzTF2bWKucgouYwgK
         fldg==
X-Gm-Message-State: AHQUAuZ95/L+wuhtLy3uNkaOQHBZReGr8FibO5C0Lqu2YoY4JoKUyhxK
        o5AuEB0z8YcdOjU38QCKuYu6cQ==
X-Google-Smtp-Source: AHgI3IbwY+Hl1J+PjDH0lxTjs8spGEw8WHm/dMtZKpAk67KpMyBzVF8xm0sH3p0RyPgxANykAE+dFA==
X-Received: by 2002:aed:3f81:: with SMTP id s1mr22594789qth.94.1550635754478;
        Tue, 19 Feb 2019 20:09:14 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id s19sm2024593qth.80.2019.02.19.20.09.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 20:09:13 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>, paulmck@linux.ibm.com
Subject: [RFC 4/5] sched/toplogy: Use smp_store_release() instead of rcu_assign_pointer
Date:   Tue, 19 Feb 2019 23:08:26 -0500
Message-Id: <20190220040827.136184-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190220040827.136184-1-joel@joelfernandes.org>
References: <20190220040827.136184-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Joel Fernandes <joel@joelfernandes.org>

The scheduler's topology code seems to want to use rcu_assign_pointer()
to initialize various pointers for no apparent reason.

With a guess that what was needed here is smp_store_release(), I am
replacing it with that. This suppresses the new sparse errors caused by
an annotation check I added to rcu_assign_pointer(). Let us avoid (ab)using
RCU API and be explicit about what we want.

Fixes sparse errors:
kernel//sched/topology.c:206:1: sparse: warning: symbol
'sched_energy_mutex' was not declared. Should it be static?
kernel//sched/topology.c:207:6: sparse: warning: symbol
'sched_energy_update' was not declared. Should it be static?  >>
kernel//sched/topology.c:378:9: sparse: error: incompatible types in
comparison expression (different address spaces)
kernel//sched/topology.c:387:9: sparse: error: incompatible types in
comparison expression (different address spaces)
kernel//sched/topology.c:612:9: sparse: error: incompatible types in
comparison expression (different address spaces)
kernel//sched/topology.c:615:9: sparse: error: incompatible types in
comparison expression (different address spaces)
kernel//sched/topology.c:618:9: sparse: error: incompatible types in
comparison expression (different address spaces)
kernel//sched/topology.c:621:9: sparse: error: incompatible types in
comparison expression (different address spaces)

Signed-off-by: Joel Fernandes <joel@joelfernandes.org>
---
 kernel/sched/topology.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 3f35ba1d8fde..e7a424d8de8e 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -375,7 +375,7 @@ static bool build_perf_domains(const struct cpumask *cpu_map)
 
 	/* Attach the new list of performance domains to the root domain. */
 	tmp = rd->pd;
-	rcu_assign_pointer(rd->pd, pd);
+	smp_store_release(&rd->pd, pd);
 	if (tmp)
 		call_rcu(&tmp->rcu, destroy_perf_domain_rcu);
 
@@ -384,7 +384,7 @@ static bool build_perf_domains(const struct cpumask *cpu_map)
 free:
 	free_pd(pd);
 	tmp = rd->pd;
-	rcu_assign_pointer(rd->pd, NULL);
+	smp_store_release(&rd->pd, NULL);
 	if (tmp)
 		call_rcu(&tmp->rcu, destroy_perf_domain_rcu);
 
@@ -609,19 +609,19 @@ static void update_top_cache_domain(int cpu)
 		sds = sd->shared;
 	}
 
-	rcu_assign_pointer(per_cpu(sd_llc, cpu), sd);
+	smp_store_release(&per_cpu(sd_llc, cpu), sd);
 	per_cpu(sd_llc_size, cpu) = size;
 	per_cpu(sd_llc_id, cpu) = id;
-	rcu_assign_pointer(per_cpu(sd_llc_shared, cpu), sds);
+	smp_store_release(&per_cpu(sd_llc_shared, cpu), sds);
 
 	sd = lowest_flag_domain(cpu, SD_NUMA);
-	rcu_assign_pointer(per_cpu(sd_numa, cpu), sd);
+	smp_store_release(&per_cpu(sd_numa, cpu), sd);
 
 	sd = highest_flag_domain(cpu, SD_ASYM_PACKING);
-	rcu_assign_pointer(per_cpu(sd_asym_packing, cpu), sd);
+	smp_store_release(&per_cpu(sd_asym_packing, cpu), sd);
 
 	sd = lowest_flag_domain(cpu, SD_ASYM_CPUCAPACITY);
-	rcu_assign_pointer(per_cpu(sd_asym_cpucapacity, cpu), sd);
+	smp_store_release(&per_cpu(sd_asym_cpucapacity, cpu), sd);
 }
 
 /*
@@ -668,7 +668,7 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
 
 	rq_attach_root(rq, rd);
 	tmp = rq->sd;
-	rcu_assign_pointer(rq->sd, sd);
+	smp_store_release(&rq->sd, sd);
 	dirty_sched_domain_sysctl(cpu);
 	destroy_sched_domains(tmp);
 
-- 
2.21.0.rc0.258.g878e2cd30e-goog

