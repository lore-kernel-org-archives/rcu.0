Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C401CC43219
	for <rcu@archiver.kernel.org>; Tue,  4 Oct 2022 02:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiJDCnB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 3 Oct 2022 22:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiJDCmn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 3 Oct 2022 22:42:43 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE872A711
        for <rcu@vger.kernel.org>; Mon,  3 Oct 2022 19:42:29 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id h10so6326697qvq.7
        for <rcu@vger.kernel.org>; Mon, 03 Oct 2022 19:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=qdhlIj+6HcqRKTVWPc10GaEiGeAKWAIvBWIoYXYLCMk=;
        b=bF6d+BQqT21uSDzoEmgc6ltXLVsiSH0flXr0a66hmvq7zz6s2Dq02XIGUNiWasBO6l
         IB2p/eCTJGTdDIETKvUDIb/jDWWkCWTUpUQAOYk3rdCu//nizylNlM/r8n0CT5bZvGRX
         BW5DpSVU8CvCLezoUFGMJGleu6LL+2N8zGzBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=qdhlIj+6HcqRKTVWPc10GaEiGeAKWAIvBWIoYXYLCMk=;
        b=pizCKTnkpjJIXS0aFXA84qthUY7J8OQY+POePLVJS5j2HWT9erusCj2TLraxTwzXj8
         mxbnMMD9Pf3qRgYW4NN7vtxmzHUAVHqzRauUiM9mO6f4MAHsSlSFTSYdsugHI9Cg3Jee
         y1GeZwbQ2dCYNrhB/af6szqDCL9QRDi96jzzCGVDofkm9JLtlbqXcZiktpWh1wWdhvZt
         yVkEXETLnRcn8vtEqQPfr/OjnIwN8oWBeFL974VvrQ16TVQJaGSQfj0jIMYRew4K42wn
         SdPcSaf/EyqVk821BUNIUejsO9aXXcVrkKy6qb0hL7k6J57f5vdKiHg4dd369V38ELZm
         PLUA==
X-Gm-Message-State: ACrzQf1c3a5uo/W2tcxE3XGkbOvQJpE1wlJxB8ia1haXPwseXLfmEha/
        TWMl44BoeelnBwPvqxKdVDqq/pLpecBXuA==
X-Google-Smtp-Source: AMsMyM64lAZaufUU71QItbF95H8BI+H5w0uqK+zf53+ZrJbgoNrUAe7L8FKb0CryPiGGH8u8KpnGtg==
X-Received: by 2002:ad4:5d6f:0:b0:4b1:93a4:8f1f with SMTP id fn15-20020ad45d6f000000b004b193a48f1fmr5307099qvb.50.1664851348212;
        Mon, 03 Oct 2022 19:42:28 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id 1-20020ac85901000000b0035cf5edefa6sm11793875qty.56.2022.10.03.19.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 19:42:27 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com, Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH v7 11/11] workqueue: Make queue_rcu_work() use call_rcu_flush()
Date:   Tue,  4 Oct 2022 02:41:57 +0000
Message-Id: <20221004024157.2470238-12-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221004024157.2470238-1-joel@joelfernandes.org>
References: <20221004024157.2470238-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Uladzislau Rezki <urezki@gmail.com>

call_rcu() changes to save power will slow down RCU workqueue items
queued via queue_rcu_work(). This may not be an issue, however we cannot
assume that workqueue users are OK with long delays. Use
call_rcu_flush() API instead which reverts to the old behavior.

Signed-off-by: Uladzislau Rezki <urezki@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index aeea9731ef80..fe1146d97f1a 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1771,7 +1771,7 @@ bool queue_rcu_work(struct workqueue_struct *wq, struct rcu_work *rwork)
 
 	if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
 		rwork->wq = wq;
-		call_rcu(&rwork->rcu, rcu_work_rcufn);
+		call_rcu_flush(&rwork->rcu, rcu_work_rcufn);
 		return true;
 	}
 
-- 
2.38.0.rc1.362.ged0d419d3c-goog

