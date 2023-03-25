Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10278C76196
	for <rcu@archiver.kernel.org>; Sat, 25 Mar 2023 17:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjCYReM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 25 Mar 2023 13:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjCYReH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 25 Mar 2023 13:34:07 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDC79EEF
        for <rcu@vger.kernel.org>; Sat, 25 Mar 2023 10:34:01 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id bz27so4514902qtb.1
        for <rcu@vger.kernel.org>; Sat, 25 Mar 2023 10:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1679765641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QyrXPYue4+kcgnuVhPQbl4hTj4jaTNBfGwV5VXHSeY8=;
        b=wY7sjFYpq8YfHJuBRa5ndpAjxilKOxdXrz02f1B0SQldgeClltUK0+9Vtv54p+zDPm
         dRF+8T5ZRft8VqUNlEvzSiiq2rG7I7wFmObEc8Dm9u9xHEzCF0D2P+oJfF8dJ3lmlyql
         fjeWspj+q+fR+IxsTM6N1CXB47IUmZZ28GsLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679765641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QyrXPYue4+kcgnuVhPQbl4hTj4jaTNBfGwV5VXHSeY8=;
        b=J9o4vE/UqLZOzoiqxeYnXbsjqv+N4nvOxNQaWpY6fla38g8vlcdYxZxdXhl0Wio7t1
         yJsCk6kPpYEOaeoyf63e1FIkVe8pXJf+8Y95Prph/Uh78i2VpIEiEpL1EyCC6VepNcXj
         CYxOLeXJhxhy/J0KsWUWQtFQK7KrenHOfSAT6gqDXIuUDY1sU5rmwMpErT/slXqKUvML
         MGFGIMXLCaqGBqfntMet8YARLM2JGmuaKovgfnyRGPZ4bkdpg3kJmrXhEbFhPTXhvn7c
         Z5LhmBDPDA0rtMuOucGbX3QJ4HYEs2YAlUNDc88WgZUVwWVWCo4ISAIxEp1kqw0nVGUb
         MtjA==
X-Gm-Message-State: AO0yUKUuSJs6b1ClOapv5tHnuNuZNMMYl3UkK8/W0f8W7F/qwvud6LYS
        WOyNufmiNBVE01izDmHFdx5tVg==
X-Google-Smtp-Source: AK7set9Jlw5IeClQNc9dTI42kGK/qMIDrAXw7kkLsJ9JP3829DzmHHgq2Y4Qu45ppUcd1z+iFWox1w==
X-Received: by 2002:a05:622a:1749:b0:3e3:a298:7928 with SMTP id l9-20020a05622a174900b003e3a2987928mr12730734qtk.9.1679765640939;
        Sat, 25 Mar 2023 10:34:00 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id m4-20020ac84444000000b003e37ee54b5dsm6762764qtn.90.2023.03.25.10.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 10:34:00 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang1.zhang@intel.com>
Cc:     rcu@vger.kernel.org
Subject: [PATCH v2 08/13] rcu: Register rcu-lazy shrinker only for CONFIG_RCU_LAZY=y kernels
Date:   Sat, 25 Mar 2023 17:33:11 +0000
Message-Id: <20230325173316.3118674-9-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230325173316.3118674-1-joel@joelfernandes.org>
References: <20230325173316.3118674-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Zqiang <qiang1.zhang@intel.com>

The lazy_rcu_shrink_count() shrinker function is registered even in
kernels built with CONFIG_RCU_LAZY=n, in which case this function
uselessly consumes cycles learning that no CPU has any lazy callbacks
queued.

This commit therefore registers this shrinker function only in the kernels
built with CONFIG_RCU_LAZY=y, where it might actually do something useful.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree_nocb.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 9e1c8caec5ce..f2280616f9d5 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1312,6 +1312,7 @@ int rcu_nocb_cpu_offload(int cpu)
 }
 EXPORT_SYMBOL_GPL(rcu_nocb_cpu_offload);
 
+#ifdef CONFIG_RCU_LAZY
 static unsigned long
 lazy_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 {
@@ -1360,6 +1361,7 @@ static struct shrinker lazy_rcu_shrinker = {
 	.batch = 0,
 	.seeks = DEFAULT_SEEKS,
 };
+#endif // #ifdef CONFIG_RCU_LAZY
 
 void __init rcu_init_nohz(void)
 {
@@ -1391,8 +1393,10 @@ void __init rcu_init_nohz(void)
 	if (!rcu_state.nocb_is_setup)
 		return;
 
+#ifdef CONFIG_RCU_LAZY
 	if (register_shrinker(&lazy_rcu_shrinker, "rcu-lazy"))
 		pr_err("Failed to register lazy_rcu shrinker!\n");
+#endif // #ifdef CONFIG_RCU_LAZY
 
 	if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
 		pr_info("\tNote: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs.\n");
-- 
2.40.0.348.gf938b09366-goog

