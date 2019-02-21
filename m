Return-Path: <SRS0=rKhI=Q4=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24232C00319
	for <rcu@archiver.kernel.org>; Thu, 21 Feb 2019 05:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDBF62086C
	for <rcu@archiver.kernel.org>; Thu, 21 Feb 2019 05:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="cD4jri7b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbfBUFuG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 21 Feb 2019 00:50:06 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43407 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbfBUFuF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 21 Feb 2019 00:50:05 -0500
Received: by mail-qk1-f195.google.com with SMTP id f196so3594483qke.10
        for <rcu@vger.kernel.org>; Wed, 20 Feb 2019 21:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nv7hlAboBR8L2d9iWBFCyqBxcQDbn2qbimp9HVyPCpU=;
        b=cD4jri7b+UoIGO3mo90h05zxo//ZEQOkVVfU8eLmaukA3Qx9dexvFlsWoDfh2YynV2
         tvzghbBkC2P0wqpE1wwjrvrsarXMxPPY+uqMuUriFWzu7ZCLJqe+t1rVqntH2CIE/6K4
         bu2JYMFh1/uA69c7iEUEw3drY6W6UIJloY+as=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nv7hlAboBR8L2d9iWBFCyqBxcQDbn2qbimp9HVyPCpU=;
        b=CEakCTyM1JuSjiO25IOoI1+OXQZfsZYALLk3bP14JOgHC5U+ZbEBgFGTWnXIUOqPnC
         WnH+hRvBi1QjkLVUUII5+h+lXGRXMsb4kMKfk6uOrbjsHFXxNbk5AGsIuRAOLxCD13D4
         sk3mlpYNJrCdvJH4rjRxwrH9ssej/YKMjMaIaDkwli4XFdAkGLrBIC9GrlGO8OBXInmv
         jnfCmHJHen6Ldtddq2APUrWM4ztq48t3RaoFu61x7BXmfu1wUQYkX65fFKSvzeHs6EAL
         3SZZ61PHmUm0d9v6Yd4dLJORWYfzI81dowVYekoulJ1WGQbFgGl1oVryeQDJAkDcdOtU
         uuqQ==
X-Gm-Message-State: AHQUAuZ7wuytMeZqrUNf3+VdD4Bp8d4frltnlpvGBuEkANQs+jIna681
        T5wGKR0OE/jAhtKXp28c7j/aKQ==
X-Google-Smtp-Source: AHgI3IYD251OD9feSlohnYi9tpXZ3AzdO4nIwcK+7mKpsrnA1wnYeSkmdy3EAfBu5zxbgOgBdew/Ww==
X-Received: by 2002:a37:7845:: with SMTP id t66mr27515988qkc.103.1550728203902;
        Wed, 20 Feb 2019 21:50:03 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id k185sm11561219qkd.62.2019.02.20.21.50.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 21:50:02 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        Ingo Molnar <mingo@redhat.com>,
        intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>, keescook@chromium.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        netdev@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, rcu@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        xdp-newbies@vger.kernel.org, Yonghong Song <yhs@fb.com>
Subject: [PATCH RFC 4/5] sched/topology: Annonate RCU pointers properly
Date:   Thu, 21 Feb 2019 00:49:41 -0500
Message-Id: <20190221054942.132388-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190221054942.132388-1-joel@joelfernandes.org>
References: <20190221054942.132388-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The scheduler's topology code uses rcu_assign_pointer() to initialize
various pointers.

Let us annotate the pointers correctly which also help avoid future
bugs. This suppresses the new sparse errors caused by an annotation
check I added to rcu_assign_pointer().

Also replace rcu_assign_pointer call on rq->sd with WRITE_ONCE. This
should be sufficient for the rq->sd initialization.

This fixes sparse errors:
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

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/sched.h    | 12 ++++++------
 kernel/sched/topology.c | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2ab545d40381..806703afd4b0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -780,7 +780,7 @@ struct root_domain {
 	 * NULL-terminated list of performance domains intersecting with the
 	 * CPUs of the rd. Protected by RCU.
 	 */
-	struct perf_domain	*pd;
+	struct perf_domain __rcu *pd;
 };
 
 extern struct root_domain def_root_domain;
@@ -1305,13 +1305,13 @@ static inline struct sched_domain *lowest_flag_domain(int cpu, int flag)
 	return sd;
 }
 
-DECLARE_PER_CPU(struct sched_domain *, sd_llc);
+DECLARE_PER_CPU(struct sched_domain __rcu *, sd_llc);
 DECLARE_PER_CPU(int, sd_llc_size);
 DECLARE_PER_CPU(int, sd_llc_id);
-DECLARE_PER_CPU(struct sched_domain_shared *, sd_llc_shared);
-DECLARE_PER_CPU(struct sched_domain *, sd_numa);
-DECLARE_PER_CPU(struct sched_domain *, sd_asym_packing);
-DECLARE_PER_CPU(struct sched_domain *, sd_asym_cpucapacity);
+DECLARE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
+DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
+DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
+DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
 extern struct static_key_false sched_asym_cpucapacity;
 
 struct sched_group_capacity {
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 3f35ba1d8fde..2eab2e16ded5 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -586,13 +586,13 @@ static void destroy_sched_domains(struct sched_domain *sd)
  * the cpumask of the domain), this allows us to quickly tell if
  * two CPUs are in the same cache domain, see cpus_share_cache().
  */
-DEFINE_PER_CPU(struct sched_domain *, sd_llc);
+DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
 DEFINE_PER_CPU(int, sd_llc_size);
 DEFINE_PER_CPU(int, sd_llc_id);
-DEFINE_PER_CPU(struct sched_domain_shared *, sd_llc_shared);
-DEFINE_PER_CPU(struct sched_domain *, sd_numa);
-DEFINE_PER_CPU(struct sched_domain *, sd_asym_packing);
-DEFINE_PER_CPU(struct sched_domain *, sd_asym_cpucapacity);
+DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
+DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
+DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
+DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
 DEFINE_STATIC_KEY_FALSE(sched_asym_cpucapacity);
 
 static void update_top_cache_domain(int cpu)
@@ -668,7 +668,7 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
 
 	rq_attach_root(rq, rd);
 	tmp = rq->sd;
-	rcu_assign_pointer(rq->sd, sd);
+	WRITE_ONCE(rq->sd, sd);
 	dirty_sched_domain_sysctl(cpu);
 	destroy_sched_domains(tmp);
 
-- 
2.21.0.rc0.258.g878e2cd30e-goog

