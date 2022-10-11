Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EBFC433F5
	for <rcu@archiver.kernel.org>; Tue, 11 Oct 2022 18:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiJKSCl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 Oct 2022 14:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiJKSCX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 Oct 2022 14:02:23 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E93A6D547
        for <rcu@vger.kernel.org>; Tue, 11 Oct 2022 11:02:18 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id c23so4752902qtw.8
        for <rcu@vger.kernel.org>; Tue, 11 Oct 2022 11:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdhlIj+6HcqRKTVWPc10GaEiGeAKWAIvBWIoYXYLCMk=;
        b=qYmNR34LcxDkzJOEnT6+PNcqkE2xLNpaeiJaJT3FbtB76+Ta7EtjclA6vXTHrJidA/
         cromdLzJq0zsPrm/wiEInQW3QlK+lbEbviw9g2HON841vdJ6w+bMRTCpV0Vrxq8F2gNk
         5cdcOUi0pxXmuNreBTbfb+GLR49WYoSR/l5h0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qdhlIj+6HcqRKTVWPc10GaEiGeAKWAIvBWIoYXYLCMk=;
        b=mI2sNdCEUum2mxTC8Z0Fxyc1MoElmD8M8u8+L/kQ7kBUOt4uVk52LZ5ISKOhcQ6VBk
         0y+Wj2Z/iKi2Q+ObgnXGJopw/Fi+Fp1EXZVUa2N2koLJsogFgFy5BAgdGhEloHad5pAz
         dkoBsIGwWiNxFD/22rr1v9nGvi6vNhJ/dPqxiJJWhmmgmAGR0IiB+7RQjH3gVh1qx2lm
         mBOoDU6X35x8jwHg1YuSVhlyR/H5icbdeHgsa0iuQo6xl6430SCBhM7m5oBltuIia5ge
         Y/YocRAhYViGTM7Dz0YwpMbteUd/Rwl2hBpD1N2RxX3sAkbGrNWIkTpE2hT7pWsQjyvR
         z1nw==
X-Gm-Message-State: ACrzQf0ae4uVpo03a7S8pxhNHBOGbUE0PDjZRNLOtJYZD8GV0qo8lRdF
        PaVjDiiLuie/Y8/3aFRkHnFjwTdpuzG0LQ==
X-Google-Smtp-Source: AMsMyM7iHDTOAo/am5jyfXTS3XqJquXNhZYTGraRR62aZTYIM5rBX/5GH98UEa4LuEFOd1dzvITjSg==
X-Received: by 2002:a05:622a:1904:b0:35c:c657:14e4 with SMTP id w4-20020a05622a190400b0035cc65714e4mr20308128qtc.65.1665511337402;
        Tue, 11 Oct 2022 11:02:17 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id w22-20020a05620a425600b006cbc00db595sm13464375qko.23.2022.10.11.11.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 11:02:16 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com, Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH v8 11/13] workqueue: Make queue_rcu_work() use call_rcu_flush()
Date:   Tue, 11 Oct 2022 18:01:40 +0000
Message-Id: <20221011180142.2742289-12-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221011180142.2742289-1-joel@joelfernandes.org>
References: <20221011180142.2742289-1-joel@joelfernandes.org>
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

