Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3318AC433F5
	for <rcu@archiver.kernel.org>; Thu, 12 May 2022 03:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244217AbiELDFT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 11 May 2022 23:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244529AbiELDFM (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 11 May 2022 23:05:12 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679B01FE3CE
        for <rcu@vger.kernel.org>; Wed, 11 May 2022 20:05:11 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id hh4so3427927qtb.10
        for <rcu@vger.kernel.org>; Wed, 11 May 2022 20:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=au0WoB+u99j5yQ6lmarkVSHpLzgPDYFuYSvbCBirDpk=;
        b=TGcnN/8wF1fa16DoEg1TA5IThvSDVSqnwmG2s4kijAaJ71BF54l8I823QaWnXGw02w
         yU+VEV+Lm6wL3okVAWOXHuRLKGSfFtPo2gMjp5JhFty/oPxfJKYUuL9G3eos66hyIMk5
         wYNhHYmP0I1M8cO3txWEJD9BAYQhtS+TYe0Ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=au0WoB+u99j5yQ6lmarkVSHpLzgPDYFuYSvbCBirDpk=;
        b=JS5oL/wpa2aqeezs5yclD+gpVUMlP3KQkNCyNsrRVdYPMYHILShmT+d4iorzSXiuc1
         A6WMNmOSmMABSPpG9GnrVxA7zXrheLnbBgByS1ZTyh0i4KVC5Yqcw3e+CiTOJgA76Mcx
         Z00tJq/fdyb/+/uXopLzrX24+ibb0uH0WTHPC2n04cbvGncG2FBLo88en9fpaGpSKFPj
         3FfRmwoJu8nxpbsLv3jLRAI+ree2uNenZPAczjiZQryWOS++AkK21bSNNjsmp4jSUogC
         E5A23jszLN1EQiNgLaEquxV6IhwDf6dk/XnHf8GpaFEeeV6BdVHKM3Z8YXe8P+WN4rxO
         IadA==
X-Gm-Message-State: AOAM5337yJ3SxYFM+sIKuYZl84urFQ00Jkt7bbCon1LrAZgAclC+eEQm
        s/ANFafPqdPii9O2pQwNHewbwLzkEVBldQ==
X-Google-Smtp-Source: ABdhPJxOga9EoctgpdwhL7qg/2+dgrYEWWdAgD5wYdcuPXWi6bTyq/3ttWuNgsYJGbcOXFoDhBCnUQ==
X-Received: by 2002:ac8:5b8e:0:b0:2f3:f12d:bab5 with SMTP id a14-20020ac85b8e000000b002f3f12dbab5mr5520609qta.183.1652324710178;
        Wed, 11 May 2022 20:05:10 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (29.46.245.35.bc.googleusercontent.com. [35.245.46.29])
        by smtp.gmail.com with ESMTPSA id h124-20020a376c82000000b0069fc13ce203sm2270334qkc.52.2022.05.11.20.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 20:05:09 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [RFC v1 11/14] i915: Move call_rcu() to call_rcu_lazy()
Date:   Thu, 12 May 2022 03:04:39 +0000
Message-Id: <20220512030442.2530552-12-joel@joelfernandes.org>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
In-Reply-To: <20220512030442.2530552-1-joel@joelfernandes.org>
References: <20220512030442.2530552-1-joel@joelfernandes.org>
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
index d87b508b59b1..b54d1be3ee68 100644
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
2.36.0.550.gb090851708-goog

