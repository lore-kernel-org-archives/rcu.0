Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75FEC433F5
	for <rcu@archiver.kernel.org>; Tue, 11 Oct 2022 18:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiJKSCj (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 Oct 2022 14:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiJKSCX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 Oct 2022 14:02:23 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743646C97E
        for <rcu@vger.kernel.org>; Tue, 11 Oct 2022 11:02:17 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id x13so6474065qkg.11
        for <rcu@vger.kernel.org>; Tue, 11 Oct 2022 11:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGj5k/DwJhJPXcGunz0g9sDYK6vlgcelG7wytJgmcF0=;
        b=KUpS3o1sZJqLAW9IafevA0PVB44FfYK2aZOqGdn9y/rpm0BZ4d0cLGyMogYsalkdSJ
         N1oDguKqPTxhwA/NiXi8ijdAtRYa/0xEBcHmPQO/m3mNh+Dxq0zRy8+k3bcKZcsty7+/
         7opHuCcB5BDa5yBRxosIIYkcIrN75sAb2L24Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iGj5k/DwJhJPXcGunz0g9sDYK6vlgcelG7wytJgmcF0=;
        b=Ao/eW2aeswkhhdZv4vPpevUuNIJmoY73D0CX5GUeweCjEprhswMxgpbecDkiGO0HLk
         4RVyUl3n2JNWA3LJK2t8yjcRVF1a8FmXZYFv1hLaz8lT4g/4CGO2wxqqoonqGBOUbDWh
         5DfyzJ2WEmeo6iulolQ5JJpVyMwxCzq1Ml4eiDG4Q70vZIuBHHNP7yUOPnTfKjjWuLIR
         4GvPW1FtDhuA01kR4t59KmCKnYsqQyA5qYJUp/BzU+XJ6fkzucLmchGnl3IvNQ3LspPM
         7P09Sz2A/gK9UOCE0eDw4HgXX1LUrj11Vhx1pMVEYzaZLzziymFV1ETWi4IAC/UokVfx
         jI3Q==
X-Gm-Message-State: ACrzQf3LWKTS1mHCjracjFijlBe3fvJx0e1DyJOMFt11woFmxXrPt/WN
        NRZXKZXpzGVHfE9O8m4vV3T1a/y56F/HVg==
X-Google-Smtp-Source: AMsMyM7+GZHvi1fZos/roBbQAPTwMhcU7LhnvwDeTi6oBEvU78l4wd2V8rQViKh5Og/oOAElnlxm/Q==
X-Received: by 2002:a05:620a:150b:b0:6ee:8d04:f70 with SMTP id i11-20020a05620a150b00b006ee8d040f70mr1887175qkk.101.1665511336568;
        Tue, 11 Oct 2022 11:02:16 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id w22-20020a05620a425600b006cbc00db595sm13464375qko.23.2022.10.11.11.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 11:02:16 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com, Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH v8 10/13] scsi/scsi_error: Use call_rcu_flush() instead of call_rcu()
Date:   Tue, 11 Oct 2022 18:01:39 +0000
Message-Id: <20221011180142.2742289-11-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221011180142.2742289-1-joel@joelfernandes.org>
References: <20221011180142.2742289-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Uladzislau Rezki <urezki@gmail.com>

Slow boot time is seen on KVM running typical Linux distributions due to
SCSI layer calling call_rcu(). Recent changes to save power may be
causing this slowness. Using call_rcu_flush() fixes the issue and brings
the boot time back to what it originally was. Convert it.

Tested-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Uladzislau Rezki <urezki@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 drivers/scsi/scsi_error.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 448748e3fba5..a56cfd612e3a 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -312,7 +312,7 @@ void scsi_eh_scmd_add(struct scsi_cmnd *scmd)
 	 * Ensure that all tasks observe the host state change before the
 	 * host_failed change.
 	 */
-	call_rcu(&scmd->rcu, scsi_eh_inc_host_failed);
+	call_rcu_flush(&scmd->rcu, scsi_eh_inc_host_failed);
 }
 
 /**
-- 
2.38.0.rc1.362.ged0d419d3c-goog

