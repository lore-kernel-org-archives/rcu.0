Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000B7C433F5
	for <rcu@archiver.kernel.org>; Thu, 12 May 2022 03:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238889AbiELDFE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 11 May 2022 23:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244406AbiELDFC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 11 May 2022 23:05:02 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79981FC2E2
        for <rcu@vger.kernel.org>; Wed, 11 May 2022 20:05:01 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id js14so3455620qvb.12
        for <rcu@vger.kernel.org>; Wed, 11 May 2022 20:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h+Ucrgo0EM0maL7FfExwGPTxb3huWv/XPq/8ObhEBrc=;
        b=jqRk3dVBT7IZGqdmImZ8I3lH98wyBphzHFiz1x1pPIRKIDC45+H5ky4EMeztLFO0wK
         HQF8O5eSVUBJmWvd30U2tp1ibO7N0IkrvMn+gR0l2EVtTfiCIgru9oLeNH+1Bd0Zl8b2
         KBdCbhVzLihTlvIaV63Tf/3zQzehAYzofLxTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h+Ucrgo0EM0maL7FfExwGPTxb3huWv/XPq/8ObhEBrc=;
        b=LZeTFzVvth4UYh8PXK1HEUYKAXoNftRjJ6EtxrQWmajgvSXAddxmjpz7gRmIVf5rIh
         y0rO69fFgwgoEzW5rR53E/+SFqeqBKf1GDAw1bm5CyW7PcO7H/D+ST1VAZdTozZHREyo
         06FX38M87KwkMQ/nC5IBQJRuBxnw6YMACZcf5Ek4HssKBdg+Fc/lQheayNeOhWPUAnC/
         fxrQnP5bo8HTWjcNee9ayg2DF+cL01NGqsYNU6vwrsoLXscH0Dow702uZOS00idPoRNF
         GGGZuTh75LlJ5CbU71WnoSfc4ldMpkD7tyfhSD6fTRh1Ou9OS+ji7AgHovmL44t5niWq
         qcTA==
X-Gm-Message-State: AOAM531N/9FIURAHYWwMkCaIeo0uZtevxOjSqv/HxYjR/STlBhESUUA6
        v8VBbBcZ1qXbUL4VL9Xn/uMW3w6Td2ieBg==
X-Google-Smtp-Source: ABdhPJxl1v/9fRdONzTSO0gtRcKmBrpCm5hTRw3CRpzGVSLVjxXiKT4W/IvYpwSyF6hgqdg9pyrtmw==
X-Received: by 2002:a05:6214:e45:b0:45a:ba94:11 with SMTP id o5-20020a0562140e4500b0045aba940011mr25326095qvc.38.1652324700826;
        Wed, 11 May 2022 20:05:00 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (29.46.245.35.bc.googleusercontent.com. [35.245.46.29])
        by smtp.gmail.com with ESMTPSA id h124-20020a376c82000000b0069fc13ce203sm2270334qkc.52.2022.05.11.20.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 20:04:59 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [RFC v1 02/14] workqueue: Add a lazy version of queue_rcu_work()
Date:   Thu, 12 May 2022 03:04:30 +0000
Message-Id: <20220512030442.2530552-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
In-Reply-To: <20220512030442.2530552-1-joel@joelfernandes.org>
References: <20220512030442.2530552-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This will be used in kfree_rcu() later to make it do call_rcu() lazily.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/workqueue.h |  1 +
 kernel/workqueue.c        | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 7fee9b6cfede..2678a6b5b3f3 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -444,6 +444,7 @@ extern bool queue_delayed_work_on(int cpu, struct workqueue_struct *wq,
 extern bool mod_delayed_work_on(int cpu, struct workqueue_struct *wq,
 			struct delayed_work *dwork, unsigned long delay);
 extern bool queue_rcu_work(struct workqueue_struct *wq, struct rcu_work *rwork);
+extern bool queue_rcu_work_lazy(struct workqueue_struct *wq, struct rcu_work *rwork);
 
 extern void flush_workqueue(struct workqueue_struct *wq);
 extern void drain_workqueue(struct workqueue_struct *wq);
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 33f1106b4f99..9444949cc148 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1796,6 +1796,31 @@ bool queue_rcu_work(struct workqueue_struct *wq, struct rcu_work *rwork)
 }
 EXPORT_SYMBOL(queue_rcu_work);
 
+/**
+ * queue_rcu_work_lazy - queue work after a RCU grace period
+ * @wq: workqueue to use
+ * @rwork: work to queue
+ *
+ * Return: %false if @rwork was already pending, %true otherwise.  Note
+ * that a full RCU grace period is guaranteed only after a %true return.
+ * While @rwork is guaranteed to be executed after a %false return, the
+ * execution may happen before a full RCU grace period has passed.
+ */
+bool queue_rcu_work_lazy(struct workqueue_struct *wq, struct rcu_work *rwork)
+{
+	struct work_struct *work = &rwork->work;
+
+	if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
+		rwork->wq = wq;
+		call_rcu_lazy(&rwork->rcu, rcu_work_rcufn);
+		return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL(queue_rcu_work_lazy);
+
+
 /**
  * worker_enter_idle - enter idle state
  * @worker: worker which is entering idle state
-- 
2.36.0.550.gb090851708-goog

