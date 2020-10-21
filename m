Return-Path: <SRS0=Ug6t=D4=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE29FC4363A
	for <rcu@archiver.kernel.org>; Wed, 21 Oct 2020 07:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F64C222C8
	for <rcu@archiver.kernel.org>; Wed, 21 Oct 2020 07:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="l7kbINg6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501941AbgJUHiq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Oct 2020 03:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2501939AbgJUHiq (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Oct 2020 03:38:46 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49DAC0613CE
        for <rcu@vger.kernel.org>; Wed, 21 Oct 2020 00:38:45 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id hk7so706893pjb.2
        for <rcu@vger.kernel.org>; Wed, 21 Oct 2020 00:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eKb/Frrmvnv/33KqdsWJeWab+iCRIkq7ieYQ8AwTtF0=;
        b=l7kbINg6T/rz6Keu9fmDlCMWTmG1/+08mJYH8VriXgDUtnBz482eOAJUIWtzmtlYz0
         PKDHIC1+HgplcztSUfW2klaXGDBR41YyjZnx+JPC5JJwQawrxGiBd0OTFKupsmtDaDLq
         PGVdnixhhvZ5xMX79Z30zeDrgO1Ci+QetOhSnLTnUCMk0MoMdfxFTkqZtI3p0IlKIsZh
         mv5712Ma76EeZL2y5EKdpqFcza3faHEOozzMrj53xDEEEwTsQVUIYTWRmVyd8N8J5Ao7
         HYf4RNjbRfdvHDQ8AWEz6FWM86CAOoQLdyN9GmC1VJ0wQy7KgLnpv2BVbdQS2bqJTwEe
         IvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eKb/Frrmvnv/33KqdsWJeWab+iCRIkq7ieYQ8AwTtF0=;
        b=oWMAkU6Su+t8Ri64/Z/1uWGCxz81FSq9hSIzkzKzDjMm/Ndo23VUVsSqNRyPmpfdy1
         gJF9Uuwvi+BoHDH8OSgBi4tkBIL1w/lzKbaM8zcLar2iC6CId0USDfb+YjB5ioJadzU7
         g2pFIpw4G5huFjHE9uAq64f988l343TgI0ePw8B/X9WZfhjZh0Hiuh0rfTXm1owDhlNc
         PX6jf5bKzKfn0bea3wdPPjM9W79gMp7r2V+zkpcUcgylBd9JTuufa9LRecICIigjQ6rS
         QnWdtJPnO6u3Tk6S7zw601EOmxT/CZ5jam8T1d0JToMFR0g8XjaBRfR1zC3e+WvdnW8H
         B5yQ==
X-Gm-Message-State: AOAM533GuGiZTXA+RJw0olblN3NfOukmHThb7SFKy5SsAzMDjdJWZyGE
        ImdHebARjihOl5vXSnR3YzPwSw==
X-Google-Smtp-Source: ABdhPJyzrXm1MLbJMUQ0FC+foLeuohSmfg6Akqt9RLeeEZrF6HQJPb9ipKyS0GVo68plN8dHtSIl1w==
X-Received: by 2002:a17:902:ba96:b029:d5:f36b:44af with SMTP id k22-20020a170902ba96b02900d5f36b44afmr1927407pls.51.1603265925314;
        Wed, 21 Oct 2020 00:38:45 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id s20sm1131333pfu.112.2020.10.21.00.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 00:38:44 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, vincent.whitchurch@axis.com,
        tglx@linutronix.de, paul.walmsley@sifive.com,
        palmerdabbelt@google.com, guoren@kernel.org, atishp@atishpatra.org,
        mhiramat@kernel.org, greentime.hu@sifive.com,
        colin.king@canonical.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH] stop_machine: Mark functions as notrace
Date:   Wed, 21 Oct 2020 15:38:39 +0800
Message-Id: <20201021073839.43935-1-zong.li@sifive.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Like the commit cb9d7fd51d9f ("watchdog: Mark watchdog touch functions
as notrace"), some architectures assume that the stopped CPUs don't make
function calls to traceable functions when they are in the stopped
state. For example, it causes unexpected kernel crashed when switching
tracer on RISC-V.

The following patches added calls to these two functions, fix it by
adding the notrace annotations.

Fixes: 4ecf0a43e729 ("processor: get rid of cpu_relax_yield")
Fixes: 366237e7b083 ("stop_machine: Provide RCU quiescent state in
multi_cpu_stop()")

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 kernel/rcu/tree.c     | 2 +-
 kernel/stop_machine.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 06895ef85d69..2a52f42f64b6 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -409,7 +409,7 @@ bool rcu_eqs_special_set(int cpu)
  *
  * The caller must have disabled interrupts and must not be idle.
  */
-void rcu_momentary_dyntick_idle(void)
+notrace void rcu_momentary_dyntick_idle(void)
 {
 	int special;
 
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index 865bb0228ab6..890b79cf0e7c 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -178,7 +178,7 @@ static void ack_state(struct multi_stop_data *msdata)
 		set_state(msdata, msdata->state + 1);
 }
 
-void __weak stop_machine_yield(const struct cpumask *cpumask)
+notrace void __weak stop_machine_yield(const struct cpumask *cpumask)
 {
 	cpu_relax();
 }
-- 
2.28.0

