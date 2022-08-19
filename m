Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA905C32771
	for <rcu@archiver.kernel.org>; Fri, 19 Aug 2022 20:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351479AbiHSUtU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 19 Aug 2022 16:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351587AbiHSUtS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 19 Aug 2022 16:49:18 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F9EB8A59
        for <rcu@vger.kernel.org>; Fri, 19 Aug 2022 13:49:11 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id h27so4098842qkk.9
        for <rcu@vger.kernel.org>; Fri, 19 Aug 2022 13:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=CUKjiZgOClRq235gPyXEiSWcYvWtXl40+K+H8hE5PTY=;
        b=ZeNq/S53z993Qm1b3qc1CtoWTVw+6FELWTENN3rke55aGVFwfejU8VrnxPEcZF3RCM
         QmXAwQ36ohAoS0U7oI14itD54h4q8Lq8EnZ73/RXRv78aP/ZrgsbHmw1fYxSBuzlD8dv
         kiDcrmHTDIax2p0zBZyqFl8pJrq5+RBJA2PIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=CUKjiZgOClRq235gPyXEiSWcYvWtXl40+K+H8hE5PTY=;
        b=hJAXODsYXJ5dqev5Trcniatw/rVCnwUeVOaFOztibyc4pHECmtKmX3ktQwGVJ8Pn6G
         OfWBfoIS37d6n/4z7Iddd5KrBk+8OI3Pz2ydsHeLz7g5QehfOTDVZvPrT7BJsY4RPoSn
         qjRc7h6LCA1DtTenfEXtzJRbh6LbDSbIA8ctCNCS90pK7X+wYErpRbrL7+qijg+N39NR
         cH1VBeeIEHKeOFu65sIawUHPqllf8wnn6VsVdMH6TJ70B6CmR/HdKnaBcWhifYLc5DUB
         glapwk7Ew4RUVEuyKy0ZtMWepTsKNFsNPm368yd2RBnTPhoDOZdb96kq5EpisfgLBYbH
         HQnA==
X-Gm-Message-State: ACgBeo0qwjCHJxCBRZDaSqwfNVj5gW/S+F0IPCnpKAKfG5GIaEPtJGs5
        XttkxYICryYSIfWJtbYup/3Awg==
X-Google-Smtp-Source: AA6agR760kQ1F9HXuvtToQwm97uNKPe+/wm1Rvx67YbqcFXibwH1PNZkV0oM7bJ1+sHzaI6VoDxYlA==
X-Received: by 2002:a05:620a:1243:b0:6bb:daa4:88ea with SMTP id a3-20020a05620a124300b006bbdaa488eamr2431047qkl.628.1660942150634;
        Fri, 19 Aug 2022 13:49:10 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id x8-20020a05620a258800b006b9a89d408csm4377123qko.100.2022.08.19.13.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 13:49:10 -0700 (PDT)
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
Subject: [PATCH v4 09/14] net/core: Move call_rcu() to call_rcu_lazy()
Date:   Fri, 19 Aug 2022 20:48:52 +0000
Message-Id: <20220819204857.3066329-10-joel@joelfernandes.org>
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
 net/core/dst.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dst.c b/net/core/dst.c
index d16c2c9bfebd..68c240a4a0d7 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -174,7 +174,7 @@ void dst_release(struct dst_entry *dst)
 			net_warn_ratelimited("%s: dst:%p refcnt:%d\n",
 					     __func__, dst, newrefcnt);
 		if (!newrefcnt)
-			call_rcu(&dst->rcu_head, dst_destroy_rcu);
+			call_rcu_lazy(&dst->rcu_head, dst_destroy_rcu);
 	}
 }
 EXPORT_SYMBOL(dst_release);
-- 
2.37.2.609.g9ff673ca1a-goog

