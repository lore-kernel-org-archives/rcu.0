Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C869C7EE29
	for <rcu@archiver.kernel.org>; Sat, 10 Jun 2023 04:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjFJEGP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 10 Jun 2023 00:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjFJEGP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 10 Jun 2023 00:06:15 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5572DB4;
        Fri,  9 Jun 2023 21:06:14 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-25bb2c4c2c0so91266a91.3;
        Fri, 09 Jun 2023 21:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686369974; x=1688961974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1QL858XpWq1gyc+aFCkvUOLM4U+ENH6pEQV7n4dJiOQ=;
        b=dpYbFs5zQuJmr/3dteWCVbRqboYHhX0xQbLgB/qxiecrPc4Hi1rBhkeXn/ZNNuKrOK
         oOck9ASRfDaTtXHVDgrCBz1pWODHYBaJ4OcCibDTs59ZWZmqW+jPU3DrXOrnHKI0hfeT
         8rnBkO9L8FNRciU4CgBTVeydF4RK33AjtEGl4t7mswP8FrpbC03q/F02w030tocVcEMy
         1IMUJlinVrdgEyxdxni5m1ljtjnl/ib5FsNTkM3rMtgIhwExZ1ig3yqQ04zxrEkbM4Uy
         bUnYmnvss4VQiqNDB/Xu+3aec/2CzNcgILh0iUuz3+AS2VPqEeFBFsvSCptp5oKcaDRK
         eiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686369974; x=1688961974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1QL858XpWq1gyc+aFCkvUOLM4U+ENH6pEQV7n4dJiOQ=;
        b=cwxM6oUjNta8jhEp5xcl0HyFr3tqUn6oINgUWU80FI8q3EqnOAZClZ5WbrxFx2B+QI
         p9buuM6DxxxPoZTFUu5E8iyMeZhfQ5IqhE5CFsz6aYyle0AQORGHqVo3h4BuT5lFNhGi
         QFc3PS4kxhrBBk8zI+d4d3CSu5MVSUFNxiDEglpFuijyKi6MHoBvsKaru2Zwzm7j799r
         FxyCLTxytE58+UU992sWmfPbQQ49CYo5mYttDaxSuzfXqgBUa1jOz249FEzsyulEf55G
         n1Fmc0Do3ZgE0j7yoQ0mcy4aV9zukRcrFT4Ji9nW9mv1ieBVZ9iypTSD/wdHyIVL6Cg6
         CENg==
X-Gm-Message-State: AC+VfDxCLhcK7cTScQfYtzFswfkiP0xPww0N7kbFhoJ5u5W9z8BUxnEn
        R6kBs8ySz9jdFTU55D/EUuA=
X-Google-Smtp-Source: ACHHUZ6yiBp7wqtK1i+n594l5Z/7iCRrWaUJ3h5GcokFK03k9txWzgPu0c8oJeXpZG5Lp7TCmhqafQ==
X-Received: by 2002:a17:90a:70cf:b0:259:3cf1:6188 with SMTP id a15-20020a17090a70cf00b002593cf16188mr2859035pjm.40.1686369973687;
        Fri, 09 Jun 2023 21:06:13 -0700 (PDT)
Received: from localhost ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id r9-20020a655089000000b0050f9b7e64fasm992720pgp.77.2023.06.09.21.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 21:06:13 -0700 (PDT)
From:   Alan Huang <mmpgouride@gmail.com>
To:     paulmck@kernel.org
Cc:     corbet@lwn.net, rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        Alan Huang <mmpgouride@gmail.com>
Subject: [PATCH] docs/RCU: Add the missing rcu_read_unlock()
Date:   Sat, 10 Jun 2023 04:06:08 +0000
Message-Id: <20230610040608.6355-1-mmpgouride@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

We should exit the RCU read-side critical section before re-entering.

Signed-off-by: Alan Huang <mmpgouride@gmail.com>
---
 Documentation/RCU/rculist_nulls.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/RCU/rculist_nulls.rst b/Documentation/RCU/rculist_nulls.rst
index 9a734bf54..4370ac864 100644
--- a/Documentation/RCU/rculist_nulls.rst
+++ b/Documentation/RCU/rculist_nulls.rst
@@ -30,6 +30,7 @@ algorithms:
   obj = lockless_lookup(key);
   if (obj) {
     if (!try_get_ref(obj)) // might fail for free objects
+      rcu_read_unlock();
       goto begin;
     /*
     * Because a writer could delete object, and a writer could
-- 
2.34.1

