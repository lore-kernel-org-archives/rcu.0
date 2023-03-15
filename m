Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E518C6FD1D
	for <rcu@archiver.kernel.org>; Wed, 15 Mar 2023 18:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbjCOST4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Mar 2023 14:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbjCOSTm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Mar 2023 14:19:42 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAAA81CF1
        for <rcu@vger.kernel.org>; Wed, 15 Mar 2023 11:19:36 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id y10so17247619qtj.2
        for <rcu@vger.kernel.org>; Wed, 15 Mar 2023 11:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678904375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5YdSl/dl9DoJC+jKcZh9kCRHqYQQP7O2cdVc7Sb2ak=;
        b=RsVsQ4s1t13v0tdqWA51fkEfKF52Wabe0BT7RvouKtsN3SK0//3iMefFvaIvGSPk3y
         SMfbIluc3bKhAJGiA56yuTxrMPHfSZ3IYJfnGbhREPp5HrIbhQ48sEbDHHmB5GOlCPs6
         ibsxdEx3Lz1874eR10BibIZlrij+HeWqH43x8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678904375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5YdSl/dl9DoJC+jKcZh9kCRHqYQQP7O2cdVc7Sb2ak=;
        b=zTcnr9kZgqA/ixRFGDVT6HFpBclrA/joFDHGtoQZqr7XMsPGLNOvy7HZTkJu54oPac
         cHDx0RikTB8uliLcQ3ga95jS3eVNrt2hUdpr+owDLOJYx9nQfpXMDq84qNXEmpytIWQx
         OPkBzsT0SmdjBcRVuODA4+TMMf2rmIfuwN2P2NHUDn2R3/8Am6T5HKcC8ajA50cE/VLy
         lLElmYar6h9O4lSoktOPoxbcS6YJZOppzSRt1dCHMLSU5jRQBYLptAvwTXsEzVAViGuF
         tYKmbQiIMyssm6gGK/4w2Bcj41qWDHpwy7KDgeGdOa1nl5FVmhWjUX9hLHrXI9jeTUni
         MO/w==
X-Gm-Message-State: AO0yUKVOpHcUuFux3SSoe3oYlCieECuEuMglOlQMLe7zb21kBRwBS/aO
        EigE5KFJ0moExDEAq3PyVlNCfQ==
X-Google-Smtp-Source: AK7set+w/Bt6e/x/yy6K0dkN6uYT2fGt0eAwmnOwDheSYTZWX82N4YPJ8IfFATBHdM3YIhXA6lLZIA==
X-Received: by 2002:ac8:4cd9:0:b0:3bf:cd81:3a31 with SMTP id l25-20020ac84cd9000000b003bfcd813a31mr758797qtv.65.1678904375328;
        Wed, 15 Mar 2023 11:19:35 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id v125-20020a379383000000b007458ae32290sm4113974qkd.128.2023.03.15.11.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 11:19:34 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     Zqiang <qiang1.zhang@intel.com>, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
Subject: [PATCH v2 10/14] rcutorture: Create nocb kthreads only when testing rcu in CONFIG_RCU_NOCB_CPU=y kernels
Date:   Wed, 15 Mar 2023 18:18:57 +0000
Message-Id: <20230315181902.4177819-10-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230315181902.4177819-1-joel@joelfernandes.org>
References: <20230315181902.4177819-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Zqiang <qiang1.zhang@intel.com>

Given a non-zero rcutorture.nocbs_nthreads module parameter, the specified
number of nocb kthreads will be created, regardless of whether or not
the RCU implementation under test is capable of offloading callbacks.
Please note that even vanilla RCU is incapable of offloading in kernels
built with CONFIG_RCU_NOCB_CPU=n.  And when the RCU implementation is
incapable of offloading callbacks, there is no point in creating those
kthreads.

This commit therefore checks the cur_ops.torture_type module parameter and
CONFIG_RCU_NOCB_CPU Kconfig option in order to avoid creating unnecessary
nocb tasks.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcutorture.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 8e6c023212cb..83870c4ae1b8 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -3501,6 +3501,12 @@ rcu_torture_init(void)
 		pr_alert("rcu-torture: ->fqs NULL and non-zero fqs_duration, fqs disabled.\n");
 		fqs_duration = 0;
 	}
+	if (nocbs_nthreads != 0 && (cur_ops != &rcu_ops ||
+					!IS_ENABLED(CONFIG_RCU_NOCB_CPU))) {
+		pr_alert("rcu-torture types: %s and CONFIG_RCU_NOCB_CPU=%d, nocb toggle disabled.\n",
+				cur_ops->name, IS_ENABLED(CONFIG_RCU_NOCB_CPU));
+		nocbs_nthreads = 0;
+	}
 	if (cur_ops->init)
 		cur_ops->init();
 
-- 
2.40.0.rc1.284.g88254d51c5-goog

