Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B189C433FE
	for <rcu@archiver.kernel.org>; Mon, 28 Nov 2022 08:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiK1I2h (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 28 Nov 2022 03:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiK1I2g (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 28 Nov 2022 03:28:36 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD95FD2C
        for <rcu@vger.kernel.org>; Mon, 28 Nov 2022 00:28:35 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id x13-20020a17090a46cd00b00218f611b6e9so9496463pjg.1
        for <rcu@vger.kernel.org>; Mon, 28 Nov 2022 00:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9osbYunkdEQCO54Hjg4GTvOQT15p5LG+TotjvBVMAzs=;
        b=pLlMbrIfF0DRhINklW4dgJah9xF7Ksc1JDmGwPAgS/VVVfkv27o+1s7MPtM6gJUv5+
         6s7nlLC9u9TnZ+9jaCl80SPC3+Q+BsCYyOqqRasc0arKfMgxb7yKhbPxqfngUlK4uniF
         51eJO/B48NVeliHcqLafzdVdOKjhMwYK1LkDlpM5XGt7vvBD4VTUyPR30wVrtvIGhdLm
         vJvMdhYztze+14paTSDDN8h0sJSQYdZkgu83y1FTrrfWq6lz/ugaMnmc2yHCK2QShOpT
         ZB4mgHacOYtdBu0KUREH4sGy5aq2xZBqFSpmi+Esk68Tt2kE+K21VQEa/tAudDbUMsKQ
         8ZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9osbYunkdEQCO54Hjg4GTvOQT15p5LG+TotjvBVMAzs=;
        b=FE/qgboGfUS4dhalgDBryJv/NYX8PMTjdVgaLKaURX0IlfE/SkAb8O2JG7mSoDY/pd
         ouv0MvDOB/AQ1dN1vvJh3pDDDBaVE5tlKgJjJUynZVfHyPLb+eP5gcA4B/DcuNmUcGEQ
         47XqhU1Q0vtII9z7qIZMnaeb7RBHhJgMKz6JUsxPAC1V+x6yyGLQZjcxEED5l6zjSko1
         bCVnGHHyz9exdE2UN6d4mbKqZZZCPY8fK//8imQbHb2q9VULcsb3KNi2/sR1uxD50wnl
         NhJyFCCiBcY06nR3liuu1Kbtzave0EIdshAB/JHIEHVKySULJAVYgJ2mEEweHrNeXWRh
         tVqw==
X-Gm-Message-State: ANoB5plYZzliSja+nxwwdE5fXm/w3VyXVSLU4C/M5iK6Hl98ib1Oca7B
        4iWV4jFzhHkn1/LMoxz/Sgj81ciWJGoX
X-Google-Smtp-Source: AA0mqf7Lwsjvdv5mNdSCmHWmbtU/9b3nH9hqK7vkPiUjr1Ne3A1674OAZsK1rkHfDwF4K6KUS1RLKw==
X-Received: by 2002:a17:902:cf4b:b0:186:7a1d:b6ee with SMTP id e11-20020a170902cf4b00b001867a1db6eemr36115204plg.67.1669624115058;
        Mon, 28 Nov 2022 00:28:35 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z20-20020aa79494000000b0056f0753390csm7601637pfk.96.2022.11.28.00.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 00:28:34 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     rcu@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>
Subject: [PATCH 0/3] srcu: shrink the num of srcu_size_state
Date:   Mon, 28 Nov 2022 16:28:13 +0800
Message-Id: <20221128082816.28518-1-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This series fix a bug and improve the note of SRCU_SIZE_*

Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Zhang, Qiang1" <qiang1.zhang@intel.com>
To: rcu@vger.kernel.org

Pingfan Liu (3):
  srcu: Eliminate the requirement of SRCU_SIZE_WAIT_CALL
  srcu: protect against concurrent srcu_gp_end()
  srcu: Decrease the srcu size state numbers

 include/linux/srcutree.h | 15 +++++++++------
 kernel/rcu/srcutree.c    | 19 ++++++++-----------
 2 files changed, 17 insertions(+), 17 deletions(-)

-- 
2.31.1

