Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2882CC433F5
	for <rcu@archiver.kernel.org>; Thu, 12 May 2022 03:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244450AbiELDFQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 11 May 2022 23:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244497AbiELDFK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 11 May 2022 23:05:10 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653BE1FE3C9
        for <rcu@vger.kernel.org>; Wed, 11 May 2022 20:05:09 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id bs17so3784519qkb.0
        for <rcu@vger.kernel.org>; Wed, 11 May 2022 20:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ubeCwGbbIca8I/2Mu+0A56F+uXWjxN0ith+OykgDGUE=;
        b=Tv8/8rp1258TG/oHxE8QnGMI11Nf0JIPrD0Voc0mwoaQEarQYIZiCDLYCkubMdaGrS
         rs/ADIDbVf8HG6IFDYon/iNP89nUay/mAkNdDpqcTYLkUx11uYNTvpLSb/VZuiPm0hwr
         X5jq60H7J95wr88SGhywS6L8lPZttuZXpLUS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ubeCwGbbIca8I/2Mu+0A56F+uXWjxN0ith+OykgDGUE=;
        b=A1Ca+CuSsY46tTD5FcTkoEQqZMy+Q8lE4kp6/PQBBzsKN9nAgTmU7zNDb6XYLIqrBj
         Z1JG5r190pmeulfQ0vEjOScz3UFdYdlibgJOYjyptJANxWzOQ7k0mB6qqJptvdOqKTib
         aQ4n4+X1Bg57qUXDViYZR3CtWdb59gAelYSof0/8QWaSRYiL85nYUCQNHKAJIP0BL7pb
         DwNY5jQWalZxgDsa6bEKrkwZcZvkyHBHzhBA3N/ivpOENkz7Bd6FGcr2qzKaWr63HynJ
         8xxP6Zp2n+38K0u3Jnj6k4Fnw5JbCML2EQHih0QY0dymcW5AM24u4t7YhbxKwk8dLYXU
         MnVA==
X-Gm-Message-State: AOAM533fMAqVvnLxReL/uZ8IP9sD8/x7yAbr+aeNcCb27qjvQLknzWgf
        382dV7QaB3eouU3kMtBMUX7TTOo960/0BQ==
X-Google-Smtp-Source: ABdhPJwYusyqb64lt76aBKKFepAgSqiuLLaIZRktkqKQj0y5RhDW/1dgCHkF6xA+oV3Y7llMoV21uQ==
X-Received: by 2002:ae9:ed8e:0:b0:69f:cc2c:3d6b with SMTP id c136-20020ae9ed8e000000b0069fcc2c3d6bmr21655890qkg.381.1652324708956;
        Wed, 11 May 2022 20:05:08 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (29.46.245.35.bc.googleusercontent.com. [35.245.46.29])
        by smtp.gmail.com with ESMTPSA id h124-20020a376c82000000b0069fc13ce203sm2270334qkc.52.2022.05.11.20.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 20:05:08 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [RFC v1 10/14] kfree/rcu: Queue RCU work via queue_rcu_work_lazy()
Date:   Thu, 12 May 2022 03:04:38 +0000
Message-Id: <20220512030442.2530552-11-joel@joelfernandes.org>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
In-Reply-To: <20220512030442.2530552-1-joel@joelfernandes.org>
References: <20220512030442.2530552-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ebdf6f7c9023..3baf29014f86 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3407,7 +3407,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
 			// be that the work is in the pending state when
 			// channels have been detached following by each
 			// other.
-			queue_rcu_work(system_wq, &krwp->rcu_work);
+			queue_rcu_work_lazy(system_wq, &krwp->rcu_work);
 		}
 	}
 
-- 
2.36.0.550.gb090851708-goog

