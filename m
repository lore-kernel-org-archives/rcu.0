Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA63EB64D9
	for <rcu@archiver.kernel.org>; Thu,  6 Jul 2023 10:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjGFK3O (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 6 Jul 2023 06:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjGFK3N (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 6 Jul 2023 06:29:13 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E220D124;
        Thu,  6 Jul 2023 03:29:08 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-55b5a3915f5so389800a12.0;
        Thu, 06 Jul 2023 03:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688639348; x=1691231348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VnlH8MccAZMYoMDI3psp6RqfIgvAOAMCIptWGfJmN1I=;
        b=k92luRummkbHMGauymvPTxrWcofyTapD5nBG+UYQRk+/MRrNusMxHQnE0witR6h0js
         B/euUq0SBCcUewyJ8m3BRytsH1TRlDc4mjMICvl0tw3eVEcAJZQ289Ng2p4ejV7X8Dih
         rW4kINLn5jQ0kRco9qU/JSmcwVtlx3abOjSfNWpNuuWMNco7kirrGJb1wqBa174pSDRs
         04ECp9gBoIP4YSVfeUC8ZTRHgXgnUG2DnrN9OtQkSnTW6aojkSC7wJAfkGES6oNXzzco
         tufhPNtmP7Lv1QFI3v4K3iodSWuWrhfthkQWbEFbcDjS63eLFpAt9xasl5zVaPt/FAOV
         J2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688639348; x=1691231348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VnlH8MccAZMYoMDI3psp6RqfIgvAOAMCIptWGfJmN1I=;
        b=P8T+FUEdUQnB58z9vWmid+t6M7CWTdWKs/BmvbCUJQH/iGp4Mx8XI8iscFNR3gc0eC
         6MtzaIEQN462iS+cp+YUEp2HyVXrWmfy39eK775IivMs4zHW48BoI+d5v1tONMKw+HZl
         JjLOKBlvme883Xic6OI7qWunIe4GcEoqB/td3TX6yWd36gy1q4PPUH97Pg4kAAgqeRm2
         CuyKHkAS9faFRmAx6G00YQJQ79QxJwXy02OqIXg+OOl0WLchZqNSDt1XL1s2v7EqJ2iG
         MSHGnMtx9e2HaFSNuL6dFsiRbcIDZdm5LRjsy5arXzJuPRt9LY/sfcz/jYrndCUhjHhv
         vL1w==
X-Gm-Message-State: ABy/qLaILJgTlpAH9fFzt4bavkZuTZi100Prn0dN/IvVOL1oK4zKUlle
        bmiZeEoKtNwWW7xQ5E5jL2Y=
X-Google-Smtp-Source: APBJJlGv8VvYWyzBidbSyox40HkzQgyIPYJz3z5K30MeWNfp2eP8XKh02VALWwqZvP+Y2n0NZvqVBQ==
X-Received: by 2002:a17:90b:3b41:b0:263:43c6:69ac with SMTP id ot1-20020a17090b3b4100b0026343c669acmr824813pjb.44.1688639348308;
        Thu, 06 Jul 2023 03:29:08 -0700 (PDT)
Received: from localhost ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id 14-20020a17090a19ce00b0026356c056cbsm1107797pjj.34.2023.07.06.03.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 03:29:07 -0700 (PDT)
From:   Alan Huang <mmpgouride@gmail.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        boqun.feng@gmail.com, corbet@lwn.net
Cc:     rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        Alan Huang <mmpgouride@gmail.com>
Subject: [PATCH 0/2] rcu: Fix rculist_nulls and doc
Date:   Thu,  6 Jul 2023 10:28:47 +0000
Message-Id: <20230706102849.437687-1-mmpgouride@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Fix cases where using rculist_nulls combined with SLAB_TYPESAFE_BY_RCU.

Alan Huang (2):
  rcu: Use WRITE_ONCE() for assignments to ->next for rculist_nulls
  docs/RCU: Bring back smp_wmb()

 Documentation/RCU/rculist_nulls.rst | 9 +++++++--
 include/linux/rculist_nulls.h       | 4 ++--
 2 files changed, 9 insertions(+), 4 deletions(-)

-- 
2.34.1

