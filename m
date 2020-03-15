Return-Path: <SRS0=wCpI=5A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9274DC10DCE
	for <rcu@archiver.kernel.org>; Sun, 15 Mar 2020 18:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66EE020736
	for <rcu@archiver.kernel.org>; Sun, 15 Mar 2020 18:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4heRVqS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbgCOSSv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 15 Mar 2020 14:18:51 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41264 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgCOSSv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 15 Mar 2020 14:18:51 -0400
Received: by mail-lj1-f193.google.com with SMTP id o10so16049836ljc.8;
        Sun, 15 Mar 2020 11:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kr0p3uiBn0+PqEDpYaKy2kM1olPceJ/BdBXpVhg56SM=;
        b=h4heRVqS3qgN8IbtMKfEP2HRXw23WiOAEGNRJq48REv1PiHQkR2CraaXxnX7pxuM7s
         /F0JwEsw8yNZbqbw4KXz3T0GvS/fjmlZYuXLAbrJcl/I9JAbtYUEHGNu3vLK7WcINgAt
         lDrA0D5J7emMv5IFmUlpRARCKHuuyJ5yywIpFBgcCd2RnaI2FUkJa+hTZ0CUEGsVvGtH
         hVwhYUKSkF3hUL7i9bt63NYKMD6b+n1/nJKrTOaNNDSm6QLX2vAyeRFXpX6e2gz0xDmJ
         jzuOEW1YWfyhtKOx0dqweFIvSNa/Mls91R2OLI6GCt6lukshuTchooNePcRQbQIeY2Zx
         gxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kr0p3uiBn0+PqEDpYaKy2kM1olPceJ/BdBXpVhg56SM=;
        b=WO0lHWyHdhM4tIr6i5bY9Y+Wh2dBO1E5fUSlWHr0yhTzOOjljsGPLCxyia1GSXf+zy
         VtH3nJ6YZnVGyGqa+Jdtxm7SpQbEpREMmkvXDNlUJ4agBw2wSIOAdubuU29PlH+n8YPz
         x64BQTaPlO8qVWchTK//cAoAAT8zMfzDukwrurGystdQwqOErZFjp/esDsXRrJDwLGLn
         Gxba7jwh2JgqZh1hfB/VEtr1eSaB9+CCVUTrVam2tQ2EI0YELz/YSjj7rWA6RGjKSkab
         o7OhXTiDhqiXBwNrOc65IL2QNyuVSfRRDIS4XfZhJyG/oE8KIQppcu8FEQNK26F5L7X0
         Lh7g==
X-Gm-Message-State: ANhLgQ0EGxYYKs/jyfgJR7APT6PBc9837JAAZ5Dw4H8dGUTpoLvqEp3D
        kKaJYCcKWdQ8sLkXS7m7WP4RWsfrfR/i2A==
X-Google-Smtp-Source: ADFU+vv7TiphgmUNdWWxFvTH4+aNyHVt/tWbH0bGsQoTq5mELOvpdGNDRKGUlmT/6eMcRd/Tlz0Y2w==
X-Received: by 2002:a05:651c:2046:: with SMTP id t6mr14316529ljo.180.1584296328638;
        Sun, 15 Mar 2020 11:18:48 -0700 (PDT)
Received: from pc636.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id o15sm3040629ljj.55.2020.03.15.11.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 11:18:48 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     RCU <rcu@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH v1 0/6] Introduce kvfree_rcu() logic
Date:   Sun, 15 Mar 2020 19:18:34 +0100
Message-Id: <20200315181840.6966-1-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This small series introduces kvfree_rcu() API. An interface is the
same as kfree_rcu(), i.e. a structure that is about to be freed,
after GP, has to embed an "rcu_head" inside. Currently we have one
user that is mm/list_lru.c, but there was also request/interest
so there will be new comers.

Also there was a discussion about having kvfree_rcu() but head-less
variant. So this series is also a way forward to it and next step is
to introduce it. For example ext4 needs it.

It is based on dev.2020.03.11b branch.

Uladzislau Rezki (Sony) (6):
  mm/list_lru.c: rename kvfree_rcu() to local variant
  rcu: introduce kvfree_rcu() interface
  rcu: rename rcu_invoke_kfree_callback/rcu_kfree_callback
  rcu: rename __is_kfree_rcu_offset() macro
  rcu: rename kfree_call_rcu()/__kfree_rcu()
  mm/list_lru.c: remove kvfree_rcu_local() function

 include/linux/rcupdate.h   | 23 ++++++++++++++++-------
 include/linux/rcutiny.h    |  2 +-
 include/linux/rcutree.h    |  2 +-
 include/trace/events/rcu.h |  8 ++++----
 kernel/rcu/tiny.c          |  7 ++++---
 kernel/rcu/tree.c          | 33 ++++++++++++++++++++-------------
 mm/list_lru.c              | 11 ++---------
 7 files changed, 48 insertions(+), 38 deletions(-)

-- 
2.20.1

