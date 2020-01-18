Return-Path: <SRS0=UQpt=3H=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A2AC33CB6
	for <rcu@archiver.kernel.org>; Sat, 18 Jan 2020 03:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF9C524679
	for <rcu@archiver.kernel.org>; Sat, 18 Jan 2020 03:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cT7tAvPz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbgARDG1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 17 Jan 2020 22:06:27 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35384 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgARDG0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 17 Jan 2020 22:06:26 -0500
Received: by mail-pg1-f194.google.com with SMTP id l24so12571753pgk.2;
        Fri, 17 Jan 2020 19:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ZOS/QKfJuYHMcS4p5y33x0lWJFFfhgPkwQi+6BWE0/s=;
        b=cT7tAvPzEQGvP8FwNaSz5sJQJr16JuwCeKy76J7+0CXYibIXw5W9H3ImH/XF6Y1y2f
         l/CB6PhveH0EW7bldI3GYIsM5xB7dibtyGiLFyCwniQtWvLc2j6mQiNMs7Lhb29WT1Sc
         RzPCEeOd1QeCvdbDZAPv2glcGElX7NvwYG697Z5z6HvhQ9OFctcDGI0Dx/JP8HoP6A8b
         plDGQGF++TK5lj8ih3gcGHlBKGppcyMtH11TRDVoQMaUM23xvtRizceMkNmDqTXzi3f7
         GQEFvEcCdDNv2CdQXITNzLcOIW4sYIOx83eNe7O/IQ/e5LNsP4HCuNTjvS8Vz1WjVx2U
         UIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ZOS/QKfJuYHMcS4p5y33x0lWJFFfhgPkwQi+6BWE0/s=;
        b=iBWbwqQM6/5MCi/J+khlV4tMVJvhF9C4J9TNb1UvhszWHNt4Ir7cSvMRho68qVSGed
         Q/Po2Yjqs4Gra4SfbHPcSbTny7k87v8QcnYpmZBlISVbvEzE7aqdkz7zINx6bixOqw8s
         5GIzYZiNqdpL6z4HCnjLI34Ivwqc9VmZf5udBYTKdpeqlpXGFUncnkmM26FKTw7XWh/a
         fPtgxe+Hovs8A4dSlsh3KLU2JdCE+mzKLKBjFhdpXj2Xt3gQmT48SsVJi3NP1qW1eqCo
         NlFF7YvARSdI2LwXQlSF89c/OaoBUmXw4SW9h8vIf6wF69ihZI2JCxy/W1WlbZSu4I2L
         j7Hg==
X-Gm-Message-State: APjAAAUqr/7MVO4jBU7jKdR7Qd7+1gOnYjAxcqDWN8kN3NjIwmTWfinR
        2/2/KVzsIgZt6FWlGT9d+g==
X-Google-Smtp-Source: APXvYqynSuHb7zqQFO6TPM9eaLCNeLc6NMrMJ4WBFqPMvpJD0F/OdoY3zjM/mK1N3r4FVktNXKFNbg==
X-Received: by 2002:a63:1c13:: with SMTP id c19mr49126467pgc.450.1579316786303;
        Fri, 17 Jan 2020 19:06:26 -0800 (PST)
Received: from madhuparna-HP-Notebook ([2402:3a80:1ee0:feca:7477:122a:17db:72ef])
        by smtp.gmail.com with ESMTPSA id s22sm184620pji.30.2020.01.17.19.06.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Jan 2020 19:06:25 -0800 (PST)
Date:   Sat, 18 Jan 2020 08:36:18 +0530
From:   Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
To:     peterz@infradead.org, --@madhuparna-HP-Notebook, mingo@redhat.com,
        -c@madhuparna-HP-Notebook, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        rcu@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org, frextrite@gmail.com
Subject: [PATCH] events:core.c: Use built-in RCU list checking
Message-ID: <20200118030618.GA28502@madhuparna-HP-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

list_for_each_entry_rcu has built-in RCU and lock checking.

Pass cond argument to list_for_each_entry_rcu() to silence
false lockdep warning when CONFIG_PROVE_RCU_LIST is enabled
by default.

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
---
 kernel/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4ff86d57f9e5..04d28f3eb8df 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3760,7 +3760,8 @@ static void perf_adjust_freq_unthr_context(struct perf_event_context *ctx,
 	raw_spin_lock(&ctx->lock);
 	perf_pmu_disable(ctx->pmu);
 
-	list_for_each_entry_rcu(event, &ctx->event_list, event_entry) {
+	list_for_each_entry_rcu(event, &ctx->event_list, event_entry,
+				lockdep_is_held(&ctx->lock)) {
 		if (event->state != PERF_EVENT_STATE_ACTIVE)
 			continue;
 
-- 
2.17.1

