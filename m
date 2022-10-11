Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9FCC433F5
	for <rcu@archiver.kernel.org>; Tue, 11 Oct 2022 18:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiJKSCZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 Oct 2022 14:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiJKSCV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 Oct 2022 14:02:21 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D41D6C12B
        for <rcu@vger.kernel.org>; Tue, 11 Oct 2022 11:02:15 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id w3so997076qtv.9
        for <rcu@vger.kernel.org>; Tue, 11 Oct 2022 11:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyNPGKSpanWg1PBp+oFJtta8YoEUOyUADsqxsJVyYKI=;
        b=RtJLh8hhWnLgz7H2ouhSD8X603653sxyhN7F+Uyl3LsoMZ495whCSzGe0Tv82QG8AY
         40OZ8tMwqiBkGxWoZc5D8yzi4E0VacjdZbVahuN0sq8Q1HnKHfvDz0bt12Qgk5RsQOvo
         iDkd3DZofVxvv2YqJvV9mFXxc8ixoqdCvLMR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cyNPGKSpanWg1PBp+oFJtta8YoEUOyUADsqxsJVyYKI=;
        b=rRCt0cign0BUv62mAk5U3VGjx5vyr60YHTZ55NqoAbcRMO+1j8RgiTGu4+Gp05XMQa
         fOsjPeZeICngNZ0wTHzDHeL0owAW49YsN9P63DgQ3p7otKgMo/YhfL9+1YHnCvynpFrw
         6tEuL1S6QE8jiqVNuQDuSO7cBXd4oeZ784eUTV6W5YHfX7QLOciNyLSGMbJWOMZId0jt
         Qe9BmXjm/CoQuggaBbA1EamGmyQGalOXuurd2IT5k8B+SlrKSETluW1aKFihCobom7SC
         sAzI+wDoAyt8iWjzUceA/hocvT+wnOkmiPqCjsxGyIoNfvBj950Xvk6RvVBSgWOznN3e
         0DFQ==
X-Gm-Message-State: ACrzQf3V/zezhBjnjHhE2ot1T3VoDCKE6vOO0EO68IpxUU2nNPljF2BY
        7ZI+mB4VZ2fbeHCSv0axXFvcu/sQ32Fnog==
X-Google-Smtp-Source: AMsMyM5NxunybvBu18cQe7HH24MwPf/Pyl1zvCxtMO7bdugqWtTjcqNtWX0QeIY/yx3X5mIwNou/yA==
X-Received: by 2002:a05:622a:1ba6:b0:393:d282:9a8b with SMTP id bp38-20020a05622a1ba600b00393d2829a8bmr20297291qtb.342.1665511334364;
        Tue, 11 Oct 2022 11:02:14 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id w22-20020a05620a425600b006cbc00db595sm13464375qko.23.2022.10.11.11.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 11:02:13 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v8 07/13] rcu/sync: Use call_rcu_flush() instead of call_rcu
Date:   Tue, 11 Oct 2022 18:01:36 +0000
Message-Id: <20221011180142.2742289-8-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221011180142.2742289-1-joel@joelfernandes.org>
References: <20221011180142.2742289-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

call_rcu() changes to save power will slow down rcu sync. Use the
call_rcu_flush() API instead which reverts to the old behavior.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/sync.c b/kernel/rcu/sync.c
index 5cefc702158f..bdce3b5d7f71 100644
--- a/kernel/rcu/sync.c
+++ b/kernel/rcu/sync.c
@@ -44,7 +44,7 @@ static void rcu_sync_func(struct rcu_head *rhp);
 
 static void rcu_sync_call(struct rcu_sync *rsp)
 {
-	call_rcu(&rsp->cb_head, rcu_sync_func);
+	call_rcu_flush(&rsp->cb_head, rcu_sync_func);
 }
 
 /**
-- 
2.38.0.rc1.362.ged0d419d3c-goog

