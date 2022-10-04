Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972DBC433F5
	for <rcu@archiver.kernel.org>; Tue,  4 Oct 2022 02:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiJDCm2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 3 Oct 2022 22:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiJDCmZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 3 Oct 2022 22:42:25 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A33222B3
        for <rcu@vger.kernel.org>; Mon,  3 Oct 2022 19:42:23 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id de14so7906965qvb.5
        for <rcu@vger.kernel.org>; Mon, 03 Oct 2022 19:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=aIQWgogL70KBeJErO0exnOrlpnBgvI8Xk7BtYbAB+wo=;
        b=jQNACJXowFiDkPWD7+EFcZtDHi/hgxEROq6hvkGBx1hTz4J0GkRV3isC2wHPBb3ykG
         OEPa3FVqr30DpKZJ9uUX+TB2RBrtEF5ezf848U0JO51ZQ13+JEgDkAqDFyuYJ548qpfm
         TyIUrbvtIsFy2uZtb+/9GPClszwiWCMz2zxJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=aIQWgogL70KBeJErO0exnOrlpnBgvI8Xk7BtYbAB+wo=;
        b=51znweP55gc/qndja0EWmaPCtVFHW8XKdU3qFwtg8qOS1RZnC2nHm3hMwBaaTHLmws
         GejsrlkxtmhOvKkzTLAsIlSizDbzjOo3OM3TBizTs3rlbCCbQNTkZKM049qCyu808r8Y
         puSTtuYzgK5U1uhqj8ZMaP+HfgDiA4GQk80fFTilUJ9bczpZT6rVmvbHmYXEdnI6evhi
         Xns0KyoG1oq56qbrmr1yvzOlEfepzlZCvIcANch/HFPeHY4a4lEom8Z7zHoLR7CM1BKT
         iHG6rXo9BHjArxDu6FfYYot/1QdedkVdb/vbcqo7WLUGi9UHWz2CXSI4zMkNP2dq62J8
         IlFQ==
X-Gm-Message-State: ACrzQf2qvrOBBR79B2xgm54hDo8IQIDAmRIxOpHZi8tSX9Zk6ekZyFrQ
        RlR68w4IaCiAH0foOWq/F8z/0AR5aG1MfQ==
X-Google-Smtp-Source: AMsMyM6WTJ2VUrkUju8TxwZi5R2f0XpXBWCjO48/L5iv6LzmnfL7p1wEGtwB2NMIAkxpncjDVA2FuA==
X-Received: by 2002:a0c:c684:0:b0:4af:a08c:f4c7 with SMTP id d4-20020a0cc684000000b004afa08cf4c7mr18006438qvj.91.1664851342486;
        Mon, 03 Oct 2022 19:42:22 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id 1-20020ac85901000000b0035cf5edefa6sm11793875qty.56.2022.10.03.19.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 19:42:22 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com, Vineeth Pillai <vineeth@bitbyteword.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH v7 04/11] rcu: shrinker for lazy rcu
Date:   Tue,  4 Oct 2022 02:41:50 +0000
Message-Id: <20221004024157.2470238-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221004024157.2470238-1-joel@joelfernandes.org>
References: <20221004024157.2470238-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Vineeth Pillai <vineeth@bitbyteword.org>

The shrinker is used to speed up the free'ing of memory potentially held
by RCU lazy callbacks. RCU kernel module test cases show this to be
effective. Test is introduced in a later patch.

Signed-off-by: Vineeth Pillai <vineeth@bitbyteword.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree_nocb.h | 52 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index dfa736da68ab..0162aa10f9e4 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1313,6 +1313,55 @@ int rcu_nocb_cpu_offload(int cpu)
 }
 EXPORT_SYMBOL_GPL(rcu_nocb_cpu_offload);
 
+static unsigned long
+lazy_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
+{
+	int cpu;
+	unsigned long count = 0;
+
+	/* Snapshot count of all CPUs */
+	for_each_possible_cpu(cpu) {
+		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+
+		count +=  READ_ONCE(rdp->lazy_len);
+	}
+
+	return count ? count : SHRINK_EMPTY;
+}
+
+static unsigned long
+lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
+{
+	int cpu;
+	unsigned long flags;
+	unsigned long count = 0;
+
+	/* Snapshot count of all CPUs */
+	for_each_possible_cpu(cpu) {
+		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+		int _count = READ_ONCE(rdp->lazy_len);
+
+		if (_count == 0)
+			continue;
+		rcu_nocb_lock_irqsave(rdp, flags);
+		WRITE_ONCE(rdp->lazy_len, 0);
+		rcu_nocb_unlock_irqrestore(rdp, flags);
+		wake_nocb_gp(rdp, false);
+		sc->nr_to_scan -= _count;
+		count += _count;
+		if (sc->nr_to_scan <= 0)
+			break;
+	}
+	return count ? count : SHRINK_STOP;
+}
+
+static struct shrinker lazy_rcu_shrinker = {
+	.count_objects = lazy_rcu_shrink_count,
+	.scan_objects = lazy_rcu_shrink_scan,
+	.batch = 0,
+	.seeks = DEFAULT_SEEKS,
+};
+
 void __init rcu_init_nohz(void)
 {
 	int cpu;
@@ -1343,6 +1392,9 @@ void __init rcu_init_nohz(void)
 	if (!rcu_state.nocb_is_setup)
 		return;
 
+	if (register_shrinker(&lazy_rcu_shrinker, "rcu-lazy"))
+		pr_err("Failed to register lazy_rcu shrinker!\n");
+
 	if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
 		pr_info("\tNote: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs.\n");
 		cpumask_and(rcu_nocb_mask, cpu_possible_mask,
-- 
2.38.0.rc1.362.ged0d419d3c-goog

