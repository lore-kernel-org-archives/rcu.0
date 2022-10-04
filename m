Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC42C4332F
	for <rcu@archiver.kernel.org>; Tue,  4 Oct 2022 02:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiJDCma (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 3 Oct 2022 22:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiJDCm0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 3 Oct 2022 22:42:26 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3C023BE2
        for <rcu@vger.kernel.org>; Mon,  3 Oct 2022 19:42:25 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id z12so119190qtn.11
        for <rcu@vger.kernel.org>; Mon, 03 Oct 2022 19:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=WO1zLatTGk7w49T3dw38/yevK8lFIMN7WGO9rdhO2q0=;
        b=LTfgasgQcTjFsGz+V8WCIdkb4lS/q3wgkeVWhhyK3Zn8lRgOBurVMCqxo905f/y1LB
         ZTnC11ZQ1e42UXbBBaTKpudvzk/Bbk1lwFXKP0iGpIeQV8dzYc85xmyqbN6dCx6qrJJZ
         gS98L/7H8bGqZeilTYaYhzc8309phRVnsm0qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=WO1zLatTGk7w49T3dw38/yevK8lFIMN7WGO9rdhO2q0=;
        b=ZcdkBHjj2G8F2D1/0E4vYMSsbsf1e83srBnDykEqgKrogRGby8HJe/pFlBf0ShuECH
         3GJTC61XPJCURwimSkuSE/2Yd0w+Y7x9C1qvmwTAqy+w8sfwyJJWY1+kCCh4BmB6bAoZ
         6Tsvpu6KKJ9DtNyXILgXdGjEQvvhduFB+fCIoJhhPIcd4fSnlRY7jsQKNK00VB7q+Ioa
         dAT/qALYn3QHOMF7sSrPgAGgvHLm8YOKKFSyCaB5E92lwYiP5EKbB3+TE8nKowqqCjQw
         1iOzagAdxqKk1Rv3aErQiZwXryb2wdagwtTShfHVSzLrU5nneEeu5A841UUs4PUN6RY5
         asng==
X-Gm-Message-State: ACrzQf1xdIzWNlCK6lesQdlY6atFYq69Y5m5CnwI4y74r7rRErzTd4CM
        oBbA99ENegfhGwEYc/5OFStgLx/jzQ9gKg==
X-Google-Smtp-Source: AMsMyM5Q7a7JmASuMY9pParoCfdqJdNS8Z+rq2KnBsVAFf04LpYyy2lX7qbKr1crKFTr+0BmPTWioQ==
X-Received: by 2002:a05:622a:304:b0:35d:4825:f812 with SMTP id q4-20020a05622a030400b0035d4825f812mr18214493qtw.467.1664851344183;
        Mon, 03 Oct 2022 19:42:24 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id 1-20020ac85901000000b0035cf5edefa6sm11793875qty.56.2022.10.03.19.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 19:42:23 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v7 06/11] percpu-refcount: Use call_rcu_flush() for atomic switch
Date:   Tue,  4 Oct 2022 02:41:52 +0000
Message-Id: <20221004024157.2470238-7-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221004024157.2470238-1-joel@joelfernandes.org>
References: <20221004024157.2470238-1-joel@joelfernandes.org>
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
2.38.0.rc1.362.ged0d419d3c-goog

