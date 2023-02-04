Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C66C05027
	for <rcu@archiver.kernel.org>; Sat,  4 Feb 2023 02:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjBDCVL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 3 Feb 2023 21:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjBDCVK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 3 Feb 2023 21:21:10 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23781CAE3
        for <rcu@vger.kernel.org>; Fri,  3 Feb 2023 18:21:07 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id e6so1886566qvp.1
        for <rcu@vger.kernel.org>; Fri, 03 Feb 2023 18:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O+Rvn1JkfUTqQUprG3LidZWtpE2Owjne4mF5ZG2WHZQ=;
        b=HxpEjUaIgXZu4UXq0hMXQMd9KfFVD9LWbiToWocN96/h5IO9U7eTTnXtxRpzpUiggi
         0Y8pChI5LH+FwY2ndyfBUlbsctjREJs9G3oOUUxMaENd1bxQoXEABtuMMIw2DpPf5eZY
         2/P6jvWZpgUjLx6SJNWfl/FB/6Y6gQM7F6zns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O+Rvn1JkfUTqQUprG3LidZWtpE2Owjne4mF5ZG2WHZQ=;
        b=ySVYJ1xSThXOEAhXEVSdFl1mYJE3GW2zycuoOlf7emSN3x/u2s70DQGeTPmihRDPcH
         1eyxdk5diTKEJ3NQFOR3vKVWYVm4WALCtH9/xzH2QtR5LJmMHFtHahzxcuGXG8GGtbG4
         QY0HOrVKZIunlSmTao9pY+UxjKPPf8PVw5W5ezE4XCHMghXp71ytYsuXwVDtmsK8XSED
         4NE//8VokU6nRHHOQPvWiDnGgXDT5IVqtUrD1WcwecNcYGbKksbzaTfb50KKzOat9yCR
         7vRdBy9dGnRDlNIMQKFlolBJ55DWyllpaMlqIg1Hbq5ikB+d+vA1EI2T+sXiKdAq4VmK
         HDKQ==
X-Gm-Message-State: AO0yUKUWgZ3Z5/EeOTBdvW1siELKqfTwIBh5a66mka8LLjBX8FcQE6ee
        ReU75b/JGEJDvIVUxX3RnLVPzQ==
X-Google-Smtp-Source: AK7set+pZFXne3CvWwywDjMU82pRMhzTejMzmm5xQQS2AojsdM9jO+Em6XDs4qW6zE6LjdoXrM3cVw==
X-Received: by 2002:a05:6214:300c:b0:56a:d22b:5821 with SMTP id ke12-20020a056214300c00b0056ad22b5821mr4739456qvb.22.1675477266824;
        Fri, 03 Feb 2023 18:21:06 -0800 (PST)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id n2-20020a05620a294200b006f9ddaaf01esm3056951qkp.102.2023.02.03.18.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 18:21:05 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Qiang Zhang <Qiang1.zhang@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH] rcu/tree: Improve comments in rcu_report_qs_rdp()
Date:   Sat,  4 Feb 2023 02:20:50 +0000
Message-Id: <20230204022051.2737724-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Recent discussion triggered due to a patch linked below, from Qiang,
shed light on the need to accelerate from QS reporting paths.

Update the comments to capture this piece of knowledge.

Link: https://lore.kernel.org/all/20230118073014.2020743-1-qiang1.zhang@intel.com/
Cc: Qiang Zhang <Qiang1.zhang@intel.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---
 kernel/rcu/tree.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 93eb03f8ed99..713eb6ca6902 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1983,7 +1983,12 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 	} else {
 		/*
 		 * This GP can't end until cpu checks in, so all of our
-		 * callbacks can be processed during the next GP.
+		 * callbacks can be processed during the next GP. Do
+		 * the acceleration from here otherwise there may be extra
+		 * grace period delays, as any accelerations from rcu_core()
+		 * or note_gp_changes() may happen only after the GP after the
+		 * current one has already started. Further, rcu_core()
+		 * only accelerates if RCU is idle (no GP in progress).
 		 *
 		 * NOCB kthreads have their own way to deal with that...
 		 */
@@ -1993,6 +1998,12 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 			/*
 			 * ...but NOCB kthreads may miss or delay callbacks acceleration
 			 * if in the middle of a (de-)offloading process.
+			 *
+			 * Such missed acceleration may cause the callbacks to
+			 * be stranded until RCU is fully de-offloaded, as
+			 * acceleration from rcu_core() and note_gp_changes()
+			 * cannot happen for fully/partially offloaded mode due
+			 * to ordering dependency between rnp lock and nocb_lock.
 			 */
 			needacc = true;
 		}
-- 
2.39.1.519.gcb327c4b5f-goog

