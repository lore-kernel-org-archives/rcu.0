Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A9FECAAD2
	for <rcu@archiver.kernel.org>; Thu,  1 Sep 2022 22:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbiIAWSu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 1 Sep 2022 18:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234937AbiIAWSm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 1 Sep 2022 18:18:42 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088766A480
        for <rcu@vger.kernel.org>; Thu,  1 Sep 2022 15:18:11 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id x5so219571qtv.9
        for <rcu@vger.kernel.org>; Thu, 01 Sep 2022 15:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=uvMol3uyneGva4YyiwYlT7IjMY9wNfnMaY4BpajVnC0=;
        b=vB0TPhC+ETNKaorpvy0zXtEQMbIqrE0wkU/h5SP9iHJyWzeG/Kp/jpHxx6dt746Npa
         QOHvSTUY4nY6DTxMILIli4C/sMT/xiS5q23jK7GsK9NDcZWBJDyMJp2HL8fP0VFkqEZF
         VvTw7as9Jv9mHmLJUawLZKjNlgVaU2bZ1YoPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=uvMol3uyneGva4YyiwYlT7IjMY9wNfnMaY4BpajVnC0=;
        b=WcxjkjfmpZtim2AxM++DlupfUMcMwdXJjcZjjxgmnWLsylJT8G6S0LOdpra8Z20Xj6
         l2o1lp2CaexceR/8eNoBiZ35bDBRg/FMfpQAFd76QwMxYpIrlXIsdjjYYh+tfM+vnWhI
         2L1OiL8FWn9aWxyoEAUclWQYLJaog8NxE0dy5/OxfV8CHZOaYLpUdwSvEyYwfznuV8hS
         iNnPfc6daYM4VfzOE6bGcEo8wsuRs/fKrK4acUzq1VytCO4ccE2Dtq0y6p3L+JKA5V7g
         s6iFptzAmp29vGNVJmT5HvCgO0Tiqc+zCC9FQiwx5UY6AD9eU6XISNAj6BDCFW7/mo0e
         5boA==
X-Gm-Message-State: ACgBeo10CsSiwsun/I7EUY83unE5LcPfGPw/I4dKGiiyGqceHxn2ZjIW
        BCYI22HoB44iBN3qK3xMVu3FwVT3MQVuDg==
X-Google-Smtp-Source: AA6agR7IUlccHMDPHEeKk4mHGnWwUpV/eTK+kjnIV8R3LGYG/QjIQq6jZqPANDerA0E/GIkXT0vkdA==
X-Received: by 2002:ac8:58c8:0:b0:344:87c2:c495 with SMTP id u8-20020ac858c8000000b0034487c2c495mr25705752qta.631.1662070689867;
        Thu, 01 Sep 2022 15:18:09 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id s16-20020ac85290000000b0034305a91aaesm11060794qtn.83.2022.09.01.15.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 15:18:09 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, vineeth@bitbyteword.org,
        boqun.feng@gmail.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v5 17/18] i915: Move call_rcu() to call_rcu_lazy()
Date:   Thu,  1 Sep 2022 22:17:19 +0000
Message-Id: <20220901221720.1105021-18-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220901221720.1105021-1-joel@joelfernandes.org>
References: <20220901221720.1105021-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This is required to prevent callbacks triggering RCU machinery too
quickly and too often, which adds more power to the system.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 drivers/gpu/drm/i915/gem/i915_gem_object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.c b/drivers/gpu/drm/i915/gem/i915_gem_object.c
index ccec4055fde3..21d6f66fb394 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object.c
@@ -343,7 +343,7 @@ static void __i915_gem_free_objects(struct drm_i915_private *i915,
 		__i915_gem_free_object(obj);
 
 		/* But keep the pointer alive for RCU-protected lookups */
-		call_rcu(&obj->rcu, __i915_gem_free_object_rcu);
+		call_rcu_lazy(&obj->rcu, __i915_gem_free_object_rcu);
 		cond_resched();
 	}
 }
-- 
2.37.2.789.g6183377224-goog

