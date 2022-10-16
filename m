Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02934C433FE
	for <rcu@archiver.kernel.org>; Sun, 16 Oct 2022 16:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiJPQXs (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 16 Oct 2022 12:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiJPQXn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 16 Oct 2022 12:23:43 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755A73B720
        for <rcu@vger.kernel.org>; Sun, 16 Oct 2022 09:23:40 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id j21so5395264qkk.9
        for <rcu@vger.kernel.org>; Sun, 16 Oct 2022 09:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCISppMzdHX/DQsNZveHbYvxNRQkJmaJ4AIlPWlWRgs=;
        b=T0aH16H0gjhc829ZwPg95man8+E5dBVOoqyeuStiVen/WktGOsf2hdhMwjW3MNDJyp
         FDFX2078EezAeccQNhKIglhXgb0z9Oz1j0CTQoHB9Lzas0JzQjGMNm9KsRm4ye1VWVmo
         mkr8Qpug60rSgHIIQDOO73wfKOStUXrQwmYos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YCISppMzdHX/DQsNZveHbYvxNRQkJmaJ4AIlPWlWRgs=;
        b=eWDxuphj4TsMEX8GDdLWszLHrcIPhuhN5avolqbLgf1XvlreXNuhEX/XhDwJkIxO2p
         ukoLJCkGGsbAtglsGkKhHqaTkL5A7voUUt6RwQzMsra3cvyeMw8J8g6p79YHmm3aKprm
         4QoVjbQGjKfob3qvpVduRCCH5xpMkgsKxOd99X86FAEGpX5jMZAJQLeRWqBj52X0ZzD1
         +JJAffMjkcLZtOSDcBr3bD0bEDfqZtWqjr0kBmU91COlzeVVxgGajSr09Tn354z0mxw9
         zotXrsJFOgQvfhgZ4HGHPsAPvGfKgbf4uCgMLJtTGqtyRD2aRrq0mvkEDPkJ4aZ8ye32
         wflw==
X-Gm-Message-State: ACrzQf3jm4IQW/6049ZHsAr6q9J2pbyoKgj2oUV5K16fSBrLA6ercuyv
        LmnOwONQ5o1H3b0BDSlDtseBIYV8AV8uGA==
X-Google-Smtp-Source: AMsMyM7no5iesZl/LsaoYOsDoesa+hwFn0sAwmsr5F/nvDM/a7rRfCYiVMAzIjwT3hlrkD6s/oMkWg==
X-Received: by 2002:a05:620a:4252:b0:6d8:9682:c490 with SMTP id w18-20020a05620a425200b006d89682c490mr5058744qko.4.1665937418550;
        Sun, 16 Oct 2022 09:23:38 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id x19-20020ac87ed3000000b003436103df40sm6001207qtj.8.2022.10.16.09.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 09:23:38 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, frederic@kernel.org,
        paulmck@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v9 06/13] percpu-refcount: Use call_rcu_flush() for atomic switch
Date:   Sun, 16 Oct 2022 16:22:58 +0000
Message-Id: <20221016162305.2489629-7-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221016162305.2489629-1-joel@joelfernandes.org>
References: <20221016162305.2489629-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

call_rcu() changes to save power will slow down the percpu refcounter's
"per-CPU to atomic switch" path. The primitive uses RCU when switching to
atomic mode. The enqueued async callback wakes up waiters waiting in the
percpu_ref_switch_waitq. Due to this, per-CPU refcount users will slow down,
such as blk_pre_runtime_suspend().

Use the call_rcu_flush() API instead which reverts to the old behavior.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 lib/percpu-refcount.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
index e5c5315da274..65c58a029297 100644
--- a/lib/percpu-refcount.c
+++ b/lib/percpu-refcount.c
@@ -230,7 +230,8 @@ static void __percpu_ref_switch_to_atomic(struct percpu_ref *ref,
 		percpu_ref_noop_confirm_switch;
 
 	percpu_ref_get(ref);	/* put after confirmation */
-	call_rcu(&ref->data->rcu, percpu_ref_switch_to_atomic_rcu);
+	call_rcu_flush(&ref->data->rcu,
+		       percpu_ref_switch_to_atomic_rcu);
 }
 
 static void __percpu_ref_switch_to_percpu(struct percpu_ref *ref)
-- 
2.38.0.413.g74048e4d9e-goog

