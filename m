Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D51C32792
	for <rcu@archiver.kernel.org>; Fri, 19 Aug 2022 20:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351854AbiHSUti (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 19 Aug 2022 16:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351645AbiHSUtS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 19 Aug 2022 16:49:18 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34C4BFA83
        for <rcu@vger.kernel.org>; Fri, 19 Aug 2022 13:49:13 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id cr9so4200686qtb.13
        for <rcu@vger.kernel.org>; Fri, 19 Aug 2022 13:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=F8eqajEJ1oxnqHr7+lKrv0iQaE0C9fuKhV4+YpdptQc=;
        b=thJJdMHDttiQHWHA9YMQ6t8JnYuDXswlIU6Fd+r+vPkOe/Ek1KbSL/8SQcoZu2Q1dm
         a6l64ZImF9AQuS+8r2YgWRnXA993zdsdBeTloskJo8YE3oISzmLAx3TnSZz5CXa4vi2n
         6l+d+3Ebcjv72aP2LdFQGNu2iIZgKzSg77Fq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=F8eqajEJ1oxnqHr7+lKrv0iQaE0C9fuKhV4+YpdptQc=;
        b=xMbUaDzXG+zY9lbfBa5/97PWK3I3yg42uw5CEej62cilzxqkZ0I6yc+ArbIYo22n9A
         fP7HiFPv68W+xwjyxx+Ixab+FO8wL9Vyd5+mHfRY2NbU1g9O99aav4Peo3C92BYjkEXy
         9mAI08HVJJ7RNqXxb/OCz0tTTTiHYGcp21347m9oi1YyGVz56Gk1fUdiRn7zRf/m5WZY
         ROBsov5A1y4+tz/5xUjKsWkMYydTJXON5OS7cXLWwAZVWFySEiSg5V4ArEdDlfnO5Vr9
         MvtjRtDPlbpfOU0OqGJXTdSyf1yZCBG5Lx3aBIXlcDMsp8nARe/EB5h4CUp8UDtPikuq
         REpA==
X-Gm-Message-State: ACgBeo1gK49/Fi8Y1rcS9vn2UghyKF2pPaUMntxbTTpOXoZ9v/iiN+Oe
        qjSj4aSE+IFNB4dJefEPhw4z0w==
X-Google-Smtp-Source: AA6agR4uPFXBKcvKDD94qylED1tqBj5WVVD6PD6c49FLD/T+dqSi7r/B+UGnudkd1B7IAJicQq6Yxg==
X-Received: by 2002:a05:622a:1048:b0:344:9494:3617 with SMTP id f8-20020a05622a104800b0034494943617mr6809664qte.143.1660942152841;
        Fri, 19 Aug 2022 13:49:12 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id x8-20020a05620a258800b006b9a89d408csm4377123qko.100.2022.08.19.13.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 13:49:12 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        paulmck@kernel.org,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>, vineeth@bitbyteword.org
Subject: [PATCH v4 12/14] i915: Move call_rcu() to call_rcu_lazy()
Date:   Fri, 19 Aug 2022 20:48:55 +0000
Message-Id: <20220819204857.3066329-13-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
In-Reply-To: <20220819204857.3066329-1-joel@joelfernandes.org>
References: <20220819204857.3066329-1-joel@joelfernandes.org>
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
index 06b1b188ce5a..74f4b6e707c2 100644
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
2.37.2.609.g9ff673ca1a-goog

