Return-Path: <SRS0=/vWc=V5=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2BCC433FF
	for <rcu@archiver.kernel.org>; Thu,  1 Aug 2019 21:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A49206B8
	for <rcu@archiver.kernel.org>; Thu,  1 Aug 2019 21:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="fUH1mN4l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389218AbfHAVji (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 1 Aug 2019 17:39:38 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45186 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389194AbfHAVjh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 1 Aug 2019 17:39:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id o13so34894414pgp.12
        for <rcu@vger.kernel.org>; Thu, 01 Aug 2019 14:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j1AX7G3AAA/tnytpSfFq4pjKq9dl/+OLzsU5jY2FLns=;
        b=fUH1mN4lHJMjpaL1kjdx1lHZT36m9b6BMD4Gl1dmubDENPnm+M+MkiBof3mL3UEMsp
         iipMUkx3xodxQr8C52NiqF7E0jDaa/oWQ5sWoxTrFhOKRRGm7Ka35odiZuVUTnbF03bf
         EvxU3yYEI5/OcwcRbMBqPXefdQjysPkG0u+vc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j1AX7G3AAA/tnytpSfFq4pjKq9dl/+OLzsU5jY2FLns=;
        b=XSgRWD3UxB12kchEKpLTfMbAjZHutIgN+wFWKOPBHqFq82Vk0Yw2A3djMBYSvSPRlQ
         2hwB554Xj072BeK/4BbfP62EKaOjjwUFxh7NSmCIiuNBUpVjPE44Kvy5Aba3lJi/ftJT
         lraE9d8u+00iSIJRGDVaaYPQXkYnm7K6ezPGC23Jg+V2YPxNbg1UbBR4psVW3OwCkrFB
         L8ioTkhe7mPk1xG9z+Mebm48iuFskhUzAWhnZ5dH7oXjrnOuj7pTUQbkxTo7CvPgGlJM
         ITdsGO3xyimoY8s46LcyGgMUzaTjejrmoH7BktvpxeXGxOTsx5RaNqmL+M5fx8+QPmgh
         s7jw==
X-Gm-Message-State: APjAAAVXSK/LGdD0dzWQLB10f4goXVQsxFvb+in/86RdFS8C+ixpXHfz
        ChAlPCnAFxKLEobgRKU1Rak=
X-Google-Smtp-Source: APXvYqzB7FRx1tbmLcs7nIQjZpO/6ZD37WRqE4ps6X/Hr62Fpl8GIMaZ8AD2W3JMZWVAt26KSaevtA==
X-Received: by 2002:a63:6bc5:: with SMTP id g188mr91160409pgc.225.1564695577078;
        Thu, 01 Aug 2019 14:39:37 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id r61sm5940423pjb.7.2019.08.01.14.39.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 14:39:36 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>, rcu@vger.kernel.org
Subject: ['PATCH v2' 2/7] Revert docs from "treewide: Rename rcu_dereference_raw_notrace() to _check()"
Date:   Thu,  1 Aug 2019 17:39:17 -0400
Message-Id: <20190801213922.158860-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801213922.158860-1-joel@joelfernandes.org>
References: <20190801213922.158860-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This reverts docs from commit 355e9972da81e803bbb825b76106ae9b358caf8e.
---
 Documentation/RCU/Design/Requirements/Requirements.html | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.html b/Documentation/RCU/Design/Requirements/Requirements.html
index bdbc84f1b949..5a9238a2883c 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.html
+++ b/Documentation/RCU/Design/Requirements/Requirements.html
@@ -2512,7 +2512,7 @@ disabled across the entire RCU read-side critical section.
 <p>
 It is possible to use tracing on RCU code, but tracing itself
 uses RCU.
-For this reason, <tt>rcu_dereference_raw_check()</tt>
+For this reason, <tt>rcu_dereference_raw_notrace()</tt>
 is provided for use by tracing, which avoids the destructive
 recursion that could otherwise ensue.
 This API is also used by virtualization in some architectures,
-- 
2.22.0.770.g0f2c4a37fd-goog

