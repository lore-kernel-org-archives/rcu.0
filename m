Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDB7C05027
	for <rcu@archiver.kernel.org>; Wed,  1 Feb 2023 20:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjBAUp2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 1 Feb 2023 15:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjBAUpV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 1 Feb 2023 15:45:21 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEE6783E5
        for <rcu@vger.kernel.org>; Wed,  1 Feb 2023 12:44:51 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id a3so11807437wrt.6
        for <rcu@vger.kernel.org>; Wed, 01 Feb 2023 12:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D35a783y9+r4vRds/PMwj8fmKYL9Opm+FKXtqgXxLHg=;
        b=eF8Rk+MtnUKV+dEzht46DG3sSGDcWvQ+IioOradRjywouK3nVCjQwpj3Pr2GEwQsba
         7tLkNcl3tQT+CsojvjzsmHXw3l5ju/hSDjM55geghkRVpzOcX64DsACf3gT/2f6tBq1v
         aR57e9OqJVLpNokFXvga1NUbihdw4wjpjf5RlKzKlJk8kcwPRTcI7hteq2tOGSP3JSdz
         lagaOVJTlIP6+d3zuFyuNZrTVYnYUJJG9+gb44942jTHDWCeqZ3hVcrv7et+Jd0yXjy4
         T9U/Rk+fw81fCu0qbz7UvgD4bw0sBXqpupRoGdTndDVubTi0zk6EvndWP0ijiSZw+jB1
         wjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D35a783y9+r4vRds/PMwj8fmKYL9Opm+FKXtqgXxLHg=;
        b=7ATEGtXdkTR+CPAzMN4URf3cAQC5Si4OBGDoF+lWQrFSoHy1lNIVbEz7T/pwTNG6ON
         kVCTEy/v7pc+RGbwLLdLM/BXMoNpuMvUhqIsn65pkYTmIwLucjESbGkk4mNsXMFj1pb8
         R1tXXBAKa/4dWaCpqORMYm4oLji7ry+wPbRHdHen3gZQkz0ImpyysM2K546aYcocMxOA
         boq3e/hlSCjRuLmQvDYw4cjYMAac00dT7AyVA+VBVGX7PFRizX5onIWMsj12+LLbi7h+
         apReq/PyzPqGBbDz+KSuMWpYs2gqLjsY3mt5OpGlMiiutifDWF6CPWdgHDwSsiuM/jn3
         t72A==
X-Gm-Message-State: AO0yUKXw3WRRLWhaiEvRVVkWwuJJVVjqqa4xbHOF8zDjpqpdBdUv/9li
        OAhzOfiXzKiiemEM5aZHC4l64g==
X-Google-Smtp-Source: AK7set9dzcCBGGbRYGTZ36N8GwRkQfwAcCCzIZv/iDMDQ+lhYIt17VF6kTIoT2JY3rFwj7xy8NehwA==
X-Received: by 2002:adf:f5ca:0:b0:2bf:d686:c873 with SMTP id k10-20020adff5ca000000b002bfd686c873mr123344wrp.28.1675284289627;
        Wed, 01 Feb 2023 12:44:49 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:7611:c340:3d8d:d46c])
        by smtp.gmail.com with ESMTPSA id n15-20020a5d598f000000b002bdff778d87sm19993584wri.34.2023.02.01.12.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 12:44:49 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     dwmw2@infradead.org, tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, x86@kernel.org, pbonzini@redhat.com,
        paulmck@kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, rcu@vger.kernel.org, mimoja@mimoja.de,
        hewenliang4@huawei.com, thomas.lendacky@amd.com, seanjc@google.com,
        pmenzel@molgen.mpg.de, fam.zheng@bytedance.com,
        punit.agrawal@bytedance.com, simon.evans@bytedance.com,
        liangma@liangbit.com, David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 3/9] cpu/hotplug: Add dynamic parallel bringup states before CPUHP_BRINGUP_CPU
Date:   Wed,  1 Feb 2023 20:43:32 +0000
Message-Id: <20230201204338.1337562-4-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230201204338.1337562-1-usama.arif@bytedance.com>
References: <20230201204338.1337562-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: David Woodhouse <dwmw@amazon.co.uk>

If the platform registers these states, bring all CPUs to each registered
state in turn, before the final bringup to CPUHP_BRINGUP_CPU. This allows
the architecture to parallelise the slow asynchronous tasks like sending
INIT/SIPI and waiting for the AP to come to life.

There is a subtlety here: even with an empty CPUHP_BP_PARALLEL_DYN step,
this means that *all* CPUs are brought through the prepare states and to
CPUHP_BP_PREPARE_DYN before any of them are taken to CPUHP_BRINGUP_CPU
and then are allowed to run for themselves to CPUHP_ONLINE.

So any combination of prepare/start calls which depend on A-B ordering
for each CPU in turn, such as the X2APIC code which used to allocate a
cluster mask 'just in case' and store it in a global variable in the
prep stage, then potentially consume that preallocated structure from
the AP and set the global pointer to NULL to be reallocated in
CPUHP_X2APIC_PREPARE for the next CPU... would explode horribly.

We believe that X2APIC was the only such case, for x86. But this is why
it remains an architecture opt-in. For now.

Note that the new parallel stages do *not* yet bring each AP to the
CPUHP_BRINGUP_CPU state. The final loop in bringup_nonboot_cpus() is
untouched, bringing each AP in turn from the final PARALLEL_DYN state
(or all the way from CPUHP_OFFLINE) to CPUHP_BRINGUP_CPU and then
waiting for that AP to do its own processing and reach CPUHP_ONLINE
before releasing the next. Parallelising that part by bringing them all
to CPUHP_BRINGUP_CPU and then waiting for them all is an exercise for
the future.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 include/linux/cpuhotplug.h |  2 ++
 kernel/cpu.c               | 27 +++++++++++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index f61447913db9..3c08d9acc7b1 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -132,6 +132,8 @@ enum cpuhp_state {
 	CPUHP_MIPS_SOC_PREPARE,
 	CPUHP_BP_PREPARE_DYN,
 	CPUHP_BP_PREPARE_DYN_END		= CPUHP_BP_PREPARE_DYN + 20,
+	CPUHP_BP_PARALLEL_DYN,
+	CPUHP_BP_PARALLEL_DYN_END		= CPUHP_BP_PARALLEL_DYN + 4,
 	CPUHP_BRINGUP_CPU,
 
 	/*
diff --git a/kernel/cpu.c b/kernel/cpu.c
index bbad5e375d3b..67e4db9f334b 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1481,6 +1481,24 @@ int bringup_hibernate_cpu(unsigned int sleep_cpu)
 void bringup_nonboot_cpus(unsigned int setup_max_cpus)
 {
 	unsigned int cpu;
+	int n = setup_max_cpus - num_online_cpus();
+
+	/* ∀ parallel pre-bringup state, bring N CPUs to it */
+	if (n > 0) {
+		enum cpuhp_state st = CPUHP_BP_PARALLEL_DYN;
+
+		while (st <= CPUHP_BP_PARALLEL_DYN_END &&
+		       cpuhp_hp_states[st].name) {
+			int i = n;
+
+			for_each_present_cpu(cpu) {
+				cpu_up(cpu, st);
+				if (!--i)
+					break;
+			}
+			st++;
+		}
+	}
 
 	for_each_present_cpu(cpu) {
 		if (num_online_cpus() >= setup_max_cpus)
@@ -1858,6 +1876,10 @@ static int cpuhp_reserve_state(enum cpuhp_state state)
 		step = cpuhp_hp_states + CPUHP_BP_PREPARE_DYN;
 		end = CPUHP_BP_PREPARE_DYN_END;
 		break;
+	case CPUHP_BP_PARALLEL_DYN:
+		step = cpuhp_hp_states + CPUHP_BP_PARALLEL_DYN;
+		end = CPUHP_BP_PARALLEL_DYN_END;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1882,14 +1904,15 @@ static int cpuhp_store_callbacks(enum cpuhp_state state, const char *name,
 	/*
 	 * If name is NULL, then the state gets removed.
 	 *
-	 * CPUHP_AP_ONLINE_DYN and CPUHP_BP_PREPARE_DYN are handed out on
+	 * CPUHP_AP_ONLINE_DYN and CPUHP_BP_P*_DYN are handed out on
 	 * the first allocation from these dynamic ranges, so the removal
 	 * would trigger a new allocation and clear the wrong (already
 	 * empty) state, leaving the callbacks of the to be cleared state
 	 * dangling, which causes wreckage on the next hotplug operation.
 	 */
 	if (name && (state == CPUHP_AP_ONLINE_DYN ||
-		     state == CPUHP_BP_PREPARE_DYN)) {
+		     state == CPUHP_BP_PREPARE_DYN ||
+		     state == CPUHP_BP_PARALLEL_DYN)) {
 		ret = cpuhp_reserve_state(state);
 		if (ret < 0)
 			return ret;
-- 
2.25.1

