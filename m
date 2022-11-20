Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EFFC433FE
	for <rcu@archiver.kernel.org>; Sun, 20 Nov 2022 03:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiKTDkk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 19 Nov 2022 22:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKTDkj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 19 Nov 2022 22:40:39 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D5BA8C24
        for <rcu@vger.kernel.org>; Sat, 19 Nov 2022 19:40:38 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id r18so8305498pgr.12
        for <rcu@vger.kernel.org>; Sat, 19 Nov 2022 19:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WiNXBMi5a60FPiTGLznN6GlG311S8i8YBj6N2/PptqE=;
        b=GylSTi3Itl1GH+rQGnpcDazb7EmawFLZtc15U43Xiojv+08ATT2ZkASGRFnHB6TK6r
         I5Up36C+P50b6TmUT1zkZlDx38GErhIekTqpsZIASOUWq1ZM5M+fpAd/3R24AYrKY2gN
         dBANmbYRvxGmatUVxhjrrc/dmruRyJucdpfkyGWf2EhbDr8U4P9xMuelJ0yqCZM61wPD
         XXjf0vPB+yRuYB+vry5Acrd0JywsXfzrsiTvgjP2mefReXIcVv/U16sAby55qKcOG8Pp
         i7JaqvadkPFiWIGOb+F5pfvbN0QAGfEq/N0elbbKOeQsn+uwd9S5jdrXiqSl+UgCJE42
         MqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WiNXBMi5a60FPiTGLznN6GlG311S8i8YBj6N2/PptqE=;
        b=QgZzoQe2osin2ioznBNEOKGQWC2YvWaV/EMxe7LICQbt6scLYMAtRAxAKwGytEvrHt
         XC8TKyUdk36JfuG/hSSkRGV+3B/OsOBnzmj2YZ4wmud77BoXaSQh1zghSfhLGdIDhhXE
         YoMdhWFYB0h4CQ9RXB2Lw+/oT6N9gxkFdWAb2Q32HMZtxyqotii6cT/W7UJmJLYDh5tL
         GIwODmFl71ZlYIlC4zHyfMUoGwEUL/LSMA0vNOP0LOwI+Yv2C9wyPb4u3w99Skg5/6Uq
         qcdb7HiarCu2I5JGkE+FdaTlE980PJHGhs/K8ps+JbZrCgVaLWFYiMtkM3D/gKLyuDoe
         ogaQ==
X-Gm-Message-State: ANoB5pm0NHisK01mc7s+Bp0B68KNYFvB1SVzsCHDv2lT8ZPv6nwYNm2l
        ZNZGTuQz60yzh4RlzOth8rR8K5I+kg==
X-Google-Smtp-Source: AA0mqf5RfY9u8NnwvWhsJmPCCPJeiiLb2U4SSlCWQ1uR2jwO88y727KTwTnwtUGDMK2XmSZBDX+H8Q==
X-Received: by 2002:a63:1514:0:b0:46e:a4ed:467e with SMTP id v20-20020a631514000000b0046ea4ed467emr1037122pgl.319.1668915637829;
        Sat, 19 Nov 2022 19:40:37 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id gq18-20020a17090b105200b0021864cf062dsm5297260pjb.21.2022.11.19.19.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 19:40:37 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     rcu@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 2/2] srcu: Remove needless updating of srcu_have_cbs in srcu_gp_end()
Date:   Sun, 20 Nov 2022 11:40:14 +0800
Message-Id: <20221120034014.7390-3-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221120034014.7390-1-kernelfans@gmail.com>
References: <20221120034014.7390-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

At present, snp->srcu_have_cbs[idx] is updated by either
srcu_funnel_gp_start() or srcu_gp_end().

But as the code changes, now, srcu_funnel_gp_start() is called with srcu
read lock held. And its input parameter s, s = rcu_seq_snap(&ssp->srcu_gp_seq),
whose counter field always proceeds that of the srcu_gp_seq by one or two.

If the seq snap only proceeds by one, the state machine should be in
state SRCU_STATE_IDLE, the held srcu read lock will prevent the state
machine from moving ahead. So when srcu_gp_end() updates
snp->srcu_have_cbs[idx], the idx must be the past idx for
srcu_funnel_gp_start() that is cared by nobody.

So removing the unnecessary updating in srcu_gp_end().

Test info:
  Running "tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 10h --configs 18*SRCU-P"
without any failure.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: rcu@vger.kernel.org
---
 kernel/rcu/srcutree.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 7df59fc8073e..c54d6c04751f 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -783,8 +783,6 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 			last_lvl = snp >= ssp->level[rcu_num_lvls - 1];
 			if (last_lvl)
 				cbs = ss_state < SRCU_SIZE_BIG || snp->srcu_have_cbs[idx] == gpseq;
-			snp->srcu_have_cbs[idx] = gpseq;
-			rcu_seq_set_state(&snp->srcu_have_cbs[idx], 1);
 			sgsne = snp->srcu_gp_seq_needed_exp;
 			if (srcu_invl_snp_seq(sgsne) || ULONG_CMP_LT(sgsne, gpseq))
 				WRITE_ONCE(snp->srcu_gp_seq_needed_exp, gpseq);
-- 
2.31.1

