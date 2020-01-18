Return-Path: <SRS0=UQpt=3H=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E513C33CB1
	for <rcu@archiver.kernel.org>; Sat, 18 Jan 2020 16:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE95C21D7D
	for <rcu@archiver.kernel.org>; Sat, 18 Jan 2020 16:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cuzk/v2r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgARQz7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 18 Jan 2020 11:55:59 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41750 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgARQz7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 18 Jan 2020 11:55:59 -0500
Received: by mail-pg1-f195.google.com with SMTP id x8so13254295pgk.8;
        Sat, 18 Jan 2020 08:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pHjwyacvYMGoFpBb1ji3Ywgw20nYhNtNHuaRMfwxOs0=;
        b=Cuzk/v2rmZxlFbH1iwUh1jcfOyH4GZH0PoB4rDQhzMC2VZ2cGsxXT9sS8GasXDNIrs
         AlkuBGsxK98YSd2RFM9FbmvQRmcTlP7ka5xpTSFIeeSrSSB66mfDh23S31ELk/vz4em7
         Xihf1bM4Akxd0ppex6SP3ivSR/QIiC4evnsYdRjidZDmg3g13H2z9RfxAFCd3QM8WZIS
         Cq7lun7KzCXChlt7+hGEnCInXMEwtm4YUQ6DjASR/NR4W+yeyH/xYjuSlbzcM6aCIsHe
         XpqFLy0aLpOkeieWgjx5Pgg1S5JSnNp1SuLaCeskvY7Kiw2ZYUptTRgjfjWB331VY5Ki
         eluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pHjwyacvYMGoFpBb1ji3Ywgw20nYhNtNHuaRMfwxOs0=;
        b=bvbU63ask1hhNH0MQbOPyHbs8fhhvkCXR6kqVp4dSUo81kS+g2MIsD9QKOQuQKX3n1
         2w/uQU9pdawuFX2Dqcbex5/YV9PxRy1sdF12gUCEubInmyl4fYu5X9KBjeIkdtGE0RMJ
         CQv/to1HRQxC92FjBa+9dZn1uA1VLIG34bQ/ZrAmeKigg6kvddKlGny9RJMjE04n5lCu
         +8LbJReRiR+MCSwtgkk0oT0vG4XeLdOwuvSeLhVJRo4or7AgjdP3CHZtf3CtrSAfMx/x
         YCi6oRRWkohDMjvdPJA5OKhVaQo+vv9hWBidkycxfr7gKP/jqYWkiUzRd4sIETkNSxh3
         TSRQ==
X-Gm-Message-State: APjAAAUt+4RpRfrcuAX/3LfGljpk6u///z55l/HXmoO7xKycSB254scc
        +tFnmr3/MAGqJRl+gOz9jt6FaxD8
X-Google-Smtp-Source: APXvYqzL3uU0K97mb0rwv+HwRhmmpc3cE2p0938r2jZsWjKwjG8pFWjesMBAZ1rEpZFisR48RYDyNA==
X-Received: by 2002:aa7:80c5:: with SMTP id a5mr8989492pfn.53.1579366558488;
        Sat, 18 Jan 2020 08:55:58 -0800 (PST)
Received: from localhost.localdomain ([146.196.37.181])
        by smtp.googlemail.com with ESMTPSA id s7sm12389009pjk.22.2020.01.18.08.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 08:55:58 -0800 (PST)
From:   Amol Grover <frextrite@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        Amol Grover <frextrite@gmail.com>
Subject: [PATCH] rculist: Add brackets around cond argument in __list_check_rcu macro
Date:   Sat, 18 Jan 2020 22:24:18 +0530
Message-Id: <20200118165417.12325-1-frextrite@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Passing a complex lockdep condition to __list_check_rcu results
in false positive lockdep splat due to incorrect expression
evaluation.

For example, a lockdep check condition `cond1 || cond2` is
evaluated as `!cond1 || cond2 && !rcu_read_lock_any_held()`
which, according to operator precedence, evaluates to
`!cond1 || (cond2 && !rcu_read_lock_any_held())`.
This would result in a lockdep splat when cond1 is false
and cond2 is true which is logically incorrect.

Signed-off-by: Amol Grover <frextrite@gmail.com>
---
 include/linux/rculist.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index 4158b7212936..dce491f0b354 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -50,9 +50,9 @@ static inline void INIT_LIST_HEAD_RCU(struct list_head *list)
 #define __list_check_rcu(dummy, cond, extra...)				\
 	({								\
 	check_arg_count_one(extra);					\
-	RCU_LOCKDEP_WARN(!cond && !rcu_read_lock_any_held(),		\
+	RCU_LOCKDEP_WARN(!(cond) && !rcu_read_lock_any_held(),		\
 			 "RCU-list traversed in non-reader section!");	\
-	 })
+	})
 #else
 #define __list_check_rcu(dummy, cond, extra...)				\
 	({ check_arg_count_one(extra); })
-- 
2.24.1

