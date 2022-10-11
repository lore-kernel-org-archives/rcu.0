Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E482C433FE
	for <rcu@archiver.kernel.org>; Tue, 11 Oct 2022 18:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiJKSCg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 Oct 2022 14:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiJKSCW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 Oct 2022 14:02:22 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4844B6C949
        for <rcu@vger.kernel.org>; Tue, 11 Oct 2022 11:02:16 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id f22so4791485qto.3
        for <rcu@vger.kernel.org>; Tue, 11 Oct 2022 11:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PEx0Z5TIM2F2t5dMUAE02+m0LGqCzjjr824tDz7I8rM=;
        b=aAQ/wImN5a5eFkWNQhhb1e6PwIGgl0pg+TRYnNz8W44MzVvZKfI9jiBk3N7D76g/Ab
         vtW44Xe52iYFufqhhnSexThVROJGzrEn9unUSRLj2jsvu+jvCuShwoAK8G3mQVZyo9aj
         LOYtrIwHEccWgL7padCaEVyIuzRXGjj+XP2+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PEx0Z5TIM2F2t5dMUAE02+m0LGqCzjjr824tDz7I8rM=;
        b=nuCh9V6woWtPlzqKEfjNkdW9ZakWptuOxyKwTdL1PR7b/+Z26qKvJAiZSFFtalR7dn
         r4GF6Q7hu4XyWFX4PU7rISZLdgUPfXNAJn8NRtBX/RbGbhm1iK0EvhCemh09CPFGkJqq
         5akUCLjpwLd7pdwiYi8o0OWMjvd/HOF4zPC1hoNhlS5wyK6udwC8xnjwotWYjtR1zBJD
         otbNN7qxWzZKyxeuDAmCWglLIisM39I88CdpdQj7DkuN3eCJAiA2hVWgJDsCu7HNmd1w
         Pj9EFOwKBnEnANRmykhmXrfYlctY0m4VF3E/F3xMgFwb5ewNLVsdXblH0jfs/nsqrufQ
         DkEg==
X-Gm-Message-State: ACrzQf3IBPsjOpcq3kYCdxoGcmpxkN4Rtnkz9QrUDS1ULZ0BncftKV/c
        w5OGwcZ745ZmDMTUFciB3gGwnBKGJVDFig==
X-Google-Smtp-Source: AMsMyM62If1AXgC+j1iYuwPbjOsRZfRgwYhOXNjAAFoeHoNsWQ0qBd6VMoE3Ir+ePKZzSPZG4ubApw==
X-Received: by 2002:ac8:7d92:0:b0:35c:be77:5e2b with SMTP id c18-20020ac87d92000000b0035cbe775e2bmr19891370qtd.505.1665511335035;
        Tue, 11 Oct 2022 11:02:15 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id w22-20020a05620a425600b006cbc00db595sm13464375qko.23.2022.10.11.11.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 11:02:14 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v8 08/13] rcu/rcuscale: Use call_rcu_flush() for async reader test
Date:   Tue, 11 Oct 2022 18:01:37 +0000
Message-Id: <20221011180142.2742289-9-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221011180142.2742289-1-joel@joelfernandes.org>
References: <20221011180142.2742289-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

rcuscale uses call_rcu() to queue async readers. With recent changes to
save power, the test will have fewer async readers in flight. Use the
call_rcu_flush() API instead to revert to the old behavior.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcuscale.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index bbdcac1804ec..0385e9b12399 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -176,7 +176,7 @@ static struct rcu_scale_ops rcu_ops = {
 	.get_gp_seq	= rcu_get_gp_seq,
 	.gp_diff	= rcu_seq_diff,
 	.exp_completed	= rcu_exp_batches_completed,
-	.async		= call_rcu,
+	.async		= call_rcu_flush,
 	.gp_barrier	= rcu_barrier,
 	.sync		= synchronize_rcu,
 	.exp_sync	= synchronize_rcu_expedited,
-- 
2.38.0.rc1.362.ged0d419d3c-goog

