Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0536C10F1E
	for <rcu@archiver.kernel.org>; Sun, 18 Dec 2022 19:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiLRTNT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 18 Dec 2022 14:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiLRTNS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 18 Dec 2022 14:13:18 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80075B860
        for <rcu@vger.kernel.org>; Sun, 18 Dec 2022 11:13:17 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id bw27so4669269qtb.3
        for <rcu@vger.kernel.org>; Sun, 18 Dec 2022 11:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6wBQIku0dQkyfB58N1D5s2KPLrixlbfwvdwL9dUxK98=;
        b=lroTRSYT+lpaoGdLTvSe0vNJT4ct3IB3eeOKCL3YQRvVP5j2VrdsOPUcLi8fN4+xcQ
         tqx9I1ei9F8C2t0E6UYlk4BJAjVqoiJuWOBCAE31g+550nlQkhBhVROKlRx+VoNaGB/1
         bWNL2XgieQGjgcDJbwvxzTqS2q3XrhB/3WDXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6wBQIku0dQkyfB58N1D5s2KPLrixlbfwvdwL9dUxK98=;
        b=NHtAjD2tQI9d/vz9Y6B1AkzybvY4Ep+bMXe4Q6H7cgLNloofIZQM4FgBgnCwt9fQph
         dk6jiDTA05T5XMPvl5KO6RWiXojO1CdFbj2ss5uddPv+z93rjW5D9VP3xAfilv8QkK8z
         9TwhPikPtfUbmwH36+djEUf1I0U+Oe6l/VP3aWiTegP8fcXzhwYc0mKVmMvZ6UQRYaRQ
         IuxpF57Tl7Q/EhvM80PqcKdRSZSOQ2QKnocHeGuHjz+3d5Ur8X57iEdO+dpXbVGjbKcI
         zHbYp3HDtR5I9MhcR/XqJJU0aOxHUd8JVlXRfDwcBfzzvZRbJAEa2ZzKSFS/Da0o5Gbx
         sPCg==
X-Gm-Message-State: ANoB5plaejCPpL3v/7tydiv83wQk8Md2N1E9TjfUonQ5B9SpZ5WXETVd
        o0fYH4fwlxLz/pfghbn1k5wlhw==
X-Google-Smtp-Source: AA0mqf7J6UsYdtU3I+7qCCh94ebdBJCmtFyROhsopD/KPQRuOlbhn8h1ckK0lufGxdBXEQVLb6pAww==
X-Received: by 2002:ac8:1019:0:b0:39c:da20:683 with SMTP id z25-20020ac81019000000b0039cda200683mr46753016qti.38.1671390796655;
        Sun, 18 Dec 2022 11:13:16 -0800 (PST)
Received: from joelboxx.c.googlers.com.com (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id cq8-20020a05622a424800b003a591194221sm4952864qtb.7.2022.12.18.11.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 11:13:15 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC 0/2] srcu: Remove pre-flip memory barrier
Date:   Sun, 18 Dec 2022 19:13:07 +0000
Message-Id: <20221218191310.130904-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello, I believe the pre-flip memory barrier is not required. The only reason I
can say to remove it, other than the possibility that it is unnecessary, is to
not have extra code that does not help. However, since we are issuing a fully
memory-barrier after the flip, I cannot say that it hurts to do it anyway.

For this reason, please consider these patches as "informational", than a
"please merge". :-) Though, feel free to consider merging if you agree!

All SRCU scenarios pass with these, with 6 hours of testing.

thanks,

 - Joel

Joel Fernandes (Google) (2):
srcu: Remove comment about prior read lock counts
srcu: Remove memory barrier "E" as it is not required

kernel/rcu/srcutree.c | 10 ----------
1 file changed, 10 deletions(-)

--
2.39.0.314.g84b9a713c41-goog

