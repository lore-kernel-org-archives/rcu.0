Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF98C001DC
	for <rcu@archiver.kernel.org>; Sat, 29 Jul 2023 14:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjG2O15 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 29 Jul 2023 10:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjG2O14 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 29 Jul 2023 10:27:56 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EEFE7A
        for <rcu@vger.kernel.org>; Sat, 29 Jul 2023 07:27:55 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-348fac49ef1so9673545ab.0
        for <rcu@vger.kernel.org>; Sat, 29 Jul 2023 07:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1690640875; x=1691245675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8IWBZgms5btefVZlTaezAIwxlPX9SRsrOFa3RHW5pXM=;
        b=O9PYpjAU2mRlvZCRI3y99M0z4R349x+52Ib8Dc28f895NT3GrjR1GSxX47Wgh9dLb0
         ukrEPgBwXmeoAB3/P8c/JylfAwo7dCTN+gVuSYhck9s0iTXEWerrZ+lsD+0fpjOr23ti
         dNApW9itmzCSz2tZE9VQOYUGwQsoBhJRDW5o4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690640875; x=1691245675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8IWBZgms5btefVZlTaezAIwxlPX9SRsrOFa3RHW5pXM=;
        b=bb4ITGLfP0RO/lBA6AuhLI08jIYPKZPUNpx/ff1AElgK7CSLFF99HoNKK0m2WmgJoF
         luw9xyq4Rm771H4C5LHIKoenIs/3/piPRW9eUaLUS/nzUT9TNTqc5FRE6/rPJU1VZDPB
         2FJyGhf5Gx85HXtvUNojhnQHJQCA2cLd8ib3QTrI2bR7Y+D7ty9q6Dx2uObhhUfueGGl
         fmvBhxUM407Ois+2JSNB27fJufOa7/VnNQdPaT1RmXuxbt8nlZmiu3hg4Ub3VXlLrr+x
         ulSLVV97sEHC5dsFeU9nN0yi66IQQD3GNFjRdwZ3bfLyE4Kk8yeaQM6UjxCkRvCO0Mnn
         l4dA==
X-Gm-Message-State: ABy/qLaG4bx6Cld6CYZt9mQfxR+29VEJwTAjtcvzA4WdYlx7FGsU5KVY
        lkFkRK0Amyal/XRtZVNownBwBQ==
X-Google-Smtp-Source: APBJJlGJY6no0cIsUkgJAXHpi+vW+SWmEfHSKAb+ivdT3ojIa4isYLZDeGSAIcbyWDyPITK8UZvEZw==
X-Received: by 2002:a05:6e02:164d:b0:348:f1c6:b978 with SMTP id v13-20020a056e02164d00b00348f1c6b978mr3138451ilu.0.1690640874846;
        Sat, 29 Jul 2023 07:27:54 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (254.82.172.34.bc.googleusercontent.com. [34.172.82.254])
        by smtp.gmail.com with ESMTPSA id q9-20020a0566380ec900b0042b35c7b8c5sm1855362jas.61.2023.07.29.07.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 07:27:54 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     rcu@vger.kernel.org, paulmck@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v2 0/5] misc RCU fixes and cleanups
Date:   Sat, 29 Jul 2023 14:27:30 +0000
Message-ID: <20230729142738.222208-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Here are some RCU fixes and cleanups. The main one is the TREE07 stuttering fix
which makes the test pass now. Thanks.

Joel Fernandes (Google) (5):
  rcutorture: Fix stuttering races and other issues
  srcu: Fix error handling in init_srcu_struct_fields()
  tree/nocb: Adjust RCU_NOCB_WAKE_* macros from weaker to stronger
  tree/nocb: Improve readability of nocb_gp_wait()
  rcu/tree: Remove superfluous return from void call_rcu* functions

 kernel/rcu/srcutree.c  |  32 ++++++------
 kernel/rcu/tree.c      |   4 +-
 kernel/rcu/tree.h      |   4 +-
 kernel/rcu/tree_nocb.h | 113 ++++++++++++++++++++++++-----------------
 kernel/torture.c       |  45 +++++-----------
 5 files changed, 99 insertions(+), 99 deletions(-)

-- 
2.41.0.487.g6d72f3e995-goog

