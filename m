Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCEBEB64DD
	for <rcu@archiver.kernel.org>; Tue, 25 Jul 2023 23:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjGYX32 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 25 Jul 2023 19:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbjGYX31 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 25 Jul 2023 19:29:27 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F4B19BA
        for <rcu@vger.kernel.org>; Tue, 25 Jul 2023 16:29:26 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-785d738d3feso11609439f.0
        for <rcu@vger.kernel.org>; Tue, 25 Jul 2023 16:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1690327766; x=1690932566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XskhyFxausVEKDa69mPrTba2xx/2UiRzs2iaafcHW9Y=;
        b=bxd6mWv0jxIK0mSMvOs0QEkrssoJdAQb9LD2SIJNiQajQ7TI6uSw1o4RpnrZno2+bh
         QhYknwTfmiLZTA1bkJZnjl8LU8KdgSUklfgZkYzXf4GjMJexjyvOwMHom7xXHHcJw1bc
         HcLwaEMCdFJj0zKfzgnAN7didRVNwCr4OhE6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690327766; x=1690932566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XskhyFxausVEKDa69mPrTba2xx/2UiRzs2iaafcHW9Y=;
        b=PK8RzyWfDrIDxJKhCs3xR/TpfpNEk1Hj+tFndMNEZoNGv1nKZ98j7KPiIl0UGSZNTQ
         Gb+bf4pJWCrsb6BwVnA7uzm0LgsEXlvm6FBkiyITcPY7LE2ocolOks77qRMN2RXKNDzh
         TtEqPvpXFWlazw69EJq9PC2c+abZttNXsj9tQauDQd8olBB3q39kKQqfkT3J29wjP/3G
         BTLDtzHVaigDrjEYrCNquSjzz9jC1xIBMQ19VBoZEdcB7WjcY7OBu9kcCaNWlCFfr8HQ
         8H+Ym3bcLtxwTnfuo4BRgQpFPfD/2p5BdTVRgLH01vQDTqt8p+zC7lza1HgODItMqZ+5
         9w/Q==
X-Gm-Message-State: ABy/qLbHrwW0mq01fxV6RIv5NCqeyNJE2vx5RWbH2OL5Ine7H5E2VyJZ
        QHLyyMOmtVwyW84PKevKQfDldw==
X-Google-Smtp-Source: APBJJlEXrYsv1laOOOPXu57nHWmEe+B61bHLj+F3QYQrE4VSub6WJkN4PCPEuF++v8DZgNOFsHfxKA==
X-Received: by 2002:a05:6602:164b:b0:785:cac9:2d49 with SMTP id y11-20020a056602164b00b00785cac92d49mr2740006iow.1.1690327766107;
        Tue, 25 Jul 2023 16:29:26 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id m18-20020a02c892000000b0041d859c5721sm3932053jao.64.2023.07.25.16.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 16:29:25 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     rcu@vger.kernel.org, paulmck@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH 0/5] misc RCU fixes and cleanups
Date:   Tue, 25 Jul 2023 23:29:05 +0000
Message-ID: <20230725232913.2981357-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Here are some RCU fixes and cleanups. The main one is the TREE07 stuttering fix
which makes the test pass now. I am continuing to test these but I am sending
it out for review in advance. Thanks.

Joel Fernandes (Google) (5):
  rcutorture: Fix stuttering races and other issues
  srcu: Fix error handling in init_srcu_struct_fields()
  tree/nocb: Adjust RCU_NOCB_WAKE_* macros from weaker to stronger
  tree/nocb: Improve readability of nocb_gp_wait()
  Revert "checkpatch: Error out if deprecated RCU API used"

 kernel/rcu/srcutree.c  |  31 ++++++-----
 kernel/rcu/tree.h      |   4 +-
 kernel/rcu/tree_nocb.h | 113 ++++++++++++++++++++++++-----------------
 kernel/torture.c       |  46 +++++------------
 scripts/checkpatch.pl  |   9 ----
 5 files changed, 98 insertions(+), 105 deletions(-)

-- 
2.41.0.487.g6d72f3e995-goog

