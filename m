Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB74C04A6A
	for <rcu@archiver.kernel.org>; Thu,  3 Aug 2023 03:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbjHCDY0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 2 Aug 2023 23:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjHCDYR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 2 Aug 2023 23:24:17 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42BC2D68
        for <rcu@vger.kernel.org>; Wed,  2 Aug 2023 20:24:15 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-c2cf4e61bc6so483255276.3
        for <rcu@vger.kernel.org>; Wed, 02 Aug 2023 20:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691033055; x=1691637855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMHqujoTuT0RsHzRdVhgkyPvYcb4Kgnj2rbEthA3RMM=;
        b=jmOMCg3aY1NdBWQ0E/xfB3w00lqf6WPH+O3dT/+EXyF79Cpvo08Pb1daWoPjBSPZT6
         bqocWqfWMdrhrDRwxYzLemMLfNLaTPpNFlqm6gyTOU4N5ITwyrd3vSnmCCD0lcK8XGzR
         5WD5DZc70Rq0qy8ulzg0neW+ZH1ryoSqFeF8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691033055; x=1691637855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMHqujoTuT0RsHzRdVhgkyPvYcb4Kgnj2rbEthA3RMM=;
        b=CfDRGskctsR5sA3cgbS5wKEp/L6tfrk91B4jcZXOISqc5mC2CagdQn4CNoLi5ip+0m
         Jb6OPE3SPc8M+OAAPkSSFBiOrR1LcJHTQOqxKD20jUkrSWY+xKOvGBvkp+RtsXH6B/VG
         1dQao6ogKaTPbi+5MF/9Cu0PGhcIDHYD0pYgD1vcRrm8dGcZqbl8TNnMMHy071Ky+iXh
         HlJlUwefEwjqnD13PLr2dKDXh+9E2LHIx4KgC9wpKyaMXIMRKq1JIKVwVT9e0/yHtonJ
         vjsNb8QQ0/1JnyNpcKSr0xz6trI2pLGwQhANEoB8SRWah8kNqwWX1+7AQCLPn4RPQt5v
         sEtA==
X-Gm-Message-State: ABy/qLaludxlS1F/HTOz8YiUA2J2/XNABL7wI8XW8/E7l5nG/tbeM83L
        kLqBXXsNJlsqf3vPwLa+tjqTdQ==
X-Google-Smtp-Source: APBJJlH4GRD9/jRuKtgSZb05B9hoqbfTLgpOFvSbSSnZQlEtSIPmV07jQp3NDVVXj0pcInCGMYURSg==
X-Received: by 2002:a25:d401:0:b0:d15:a265:4c43 with SMTP id m1-20020a25d401000000b00d15a2654c43mr18622880ybf.61.1691033054767;
        Wed, 02 Aug 2023 20:24:14 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id a14-20020a02ac0e000000b0042b67b12363sm4535176jao.37.2023.08.02.20.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 20:24:13 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 2/2] docs: memory-barriers: Add note on plain-accesses to address-dependency barriers
Date:   Thu,  3 Aug 2023 03:24:07 +0000
Message-ID: <20230803032408.2514989-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
In-Reply-To: <20230803032408.2514989-1-joel@joelfernandes.org>
References: <20230803032408.2514989-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The compiler has the ability to cause misordering by destroying
address-dependency barriers if comparison operations are used. Add a
note about this to memory-barriers.txt and point to rcu-dereference.rst
for more information.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 Documentation/memory-barriers.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 06e14efd8662..acc8ec5ce563 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -435,6 +435,11 @@ Memory barriers come in four basic varieties:
      variables such as READ_ONCE() and rcu_dereference() provide implicit
      address-dependency barriers.
 
+     [!] Note that address dependency barriers can be destroyed by comparison
+     of a pointer obtained by a marked accessor such as READ_ONCE() or
+     rcu_dereference() with some value.  For an example of this, see
+     rcu_dereference.rst (part where the comparison of pointers is discussed).
+
  (3) Read (or load) memory barriers.
 
      A read barrier is an address-dependency barrier plus a guarantee that all
-- 
2.41.0.585.gd2178a4bd4-goog

