Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8A4C25B4E
	for <rcu@archiver.kernel.org>; Tue, 24 Jan 2023 17:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbjAXR3Q (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 24 Jan 2023 12:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbjAXR3L (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 24 Jan 2023 12:29:11 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1C546172
        for <rcu@vger.kernel.org>; Tue, 24 Jan 2023 09:29:09 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id n190so17187423vsc.11
        for <rcu@vger.kernel.org>; Tue, 24 Jan 2023 09:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TlHbSZMlPdXpLeDouv7a3mV2CdQfaeCUY7pl+TBjXQY=;
        b=ib93aF9ek7RuB2GLDrxTjN5TBNM67+QOmR05pq7gw1XaIhfBOHudy8M/sCW9C0vh/k
         QfgN1LO/XpaA54djdNSctqLXRjDPSXCDuqVLluveYdwOr65V0XX8a6OZH7XXX0xjKz/f
         Hp7vksljpSAY52CxDuy97ZJXJch48FRspfwIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TlHbSZMlPdXpLeDouv7a3mV2CdQfaeCUY7pl+TBjXQY=;
        b=u+q8PNraUe1hAFTWnCgX66byB+PdUhpuI31V4bO/Cs4W8nMneFgdnPo9Mby7ui7PH3
         zQXWSQAY30CkHO74KcWRhVRgFMEaZ9K/Y82Q/2sjJHpALJ7onwOoR1YvFGag2FnTu10R
         pS3/wGYpYwoXB9oZ0wNsECYV77dDJ/DfYgOM/c7yOiPnNlwsaAFH1bFho1+b4UdDJEIQ
         1Fx/iJKbjOn+6MKzEVzXI1I42YB8QgRC2aDXqgdPTfjXsYm17jM4edReqJUsQ/OiP5Js
         BCa0sefcJd3FN3X0XNKuJtZs6wwIQrUAEZnRVyjgQF/De6UhZUVIAQ95tCyYvlY2ceNH
         +iFQ==
X-Gm-Message-State: AFqh2kqw3EZ/8x7z4Zv6bLuLh3Ror+CM+D8eqBkrZcCdWEE45V2A9Xv/
        m1rgiMWgQTDSD55xhuD5gYiuNg==
X-Google-Smtp-Source: AMrXdXv4rXfQ73wIG7bS1VfHPEu0lxrDeOySCYttuUSdEtxq0kw2Z2WfC6yBOAcgrOlQOIAe+Bg0cA==
X-Received: by 2002:a67:66c3:0:b0:3d3:c5ba:1f27 with SMTP id a186-20020a6766c3000000b003d3c5ba1f27mr16598637vsc.4.1674581348419;
        Tue, 24 Jan 2023 09:29:08 -0800 (PST)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id e22-20020a05620a209600b006cbe3be300esm1798450qka.12.2023.01.24.09.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 09:29:07 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2] tick/nohz: Fix cpu_is_hotpluggable() by checking with nohz subsystem
Date:   Tue, 24 Jan 2023 17:28:55 +0000
Message-Id: <20230124172855.3489912-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.39.1.405.gd4c25cc71f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

For CONFIG_NO_HZ_FULL systems, the tick_do_timer_cpu cannot be offlined.
However, cpu_is_hotpluggable() still returns true for those CPUs. This causes
torture tests that do offlining to end up trying to offline this CPU causing
test failures. Such failure happens on all architectures.

Fix it by asking the opinion of the nohz subsystem on whether the CPU can
be hotplugged.

[ Apply Frederic Weisbecker feedback on refactoring tick_nohz_cpu_down(). ]

For drivers/base/ portion:
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: rcu <rcu@vger.kernel.org>
Fixes: 2987557f52b9 ("driver-core/cpu: Expose hotpluggability to the rest of the kernel")
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---
 drivers/base/cpu.c       |  3 ++-
 include/linux/tick.h     |  2 ++
 kernel/time/tick-sched.c | 11 ++++++++---
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 55405ebf23ab..450dca235a2f 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -487,7 +487,8 @@ static const struct attribute_group *cpu_root_attr_groups[] = {
 bool cpu_is_hotpluggable(unsigned int cpu)
 {
 	struct device *dev = get_cpu_device(cpu);
-	return dev && container_of(dev, struct cpu, dev)->hotpluggable;
+	return dev && container_of(dev, struct cpu, dev)->hotpluggable
+		&& tick_nohz_cpu_hotpluggable(cpu);
 }
 EXPORT_SYMBOL_GPL(cpu_is_hotpluggable);
 
diff --git a/include/linux/tick.h b/include/linux/tick.h
index bfd571f18cfd..9459fef5b857 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -216,6 +216,7 @@ extern void tick_nohz_dep_set_signal(struct task_struct *tsk,
 				     enum tick_dep_bits bit);
 extern void tick_nohz_dep_clear_signal(struct signal_struct *signal,
 				       enum tick_dep_bits bit);
+extern bool tick_nohz_cpu_hotpluggable(unsigned int cpu);
 
 /*
  * The below are tick_nohz_[set,clear]_dep() wrappers that optimize off-cases
@@ -280,6 +281,7 @@ static inline void tick_nohz_full_add_cpus_to(struct cpumask *mask) { }
 
 static inline void tick_nohz_dep_set_cpu(int cpu, enum tick_dep_bits bit) { }
 static inline void tick_nohz_dep_clear_cpu(int cpu, enum tick_dep_bits bit) { }
+static inline bool tick_nohz_cpu_hotpluggable(unsigned int cpu) { return true; }
 
 static inline void tick_dep_set(enum tick_dep_bits bit) { }
 static inline void tick_dep_clear(enum tick_dep_bits bit) { }
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 9c6f661fb436..63e3e8ebcd64 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -510,7 +510,7 @@ void __init tick_nohz_full_setup(cpumask_var_t cpumask)
 	tick_nohz_full_running = true;
 }
 
-static int tick_nohz_cpu_down(unsigned int cpu)
+bool tick_nohz_cpu_hotpluggable(unsigned int cpu)
 {
 	/*
 	 * The tick_do_timer_cpu CPU handles housekeeping duty (unbound
@@ -518,8 +518,13 @@ static int tick_nohz_cpu_down(unsigned int cpu)
 	 * CPUs. It must remain online when nohz full is enabled.
 	 */
 	if (tick_nohz_full_running && tick_do_timer_cpu == cpu)
-		return -EBUSY;
-	return 0;
+		return false;
+	return true;
+}
+
+static int tick_nohz_cpu_down(unsigned int cpu)
+{
+	return tick_nohz_cpu_hotpluggable(cpu) ? 0 : -EBUSY;
 }
 
 void __init tick_nohz_init(void)
-- 
2.39.1.405.gd4c25cc71f-goog

