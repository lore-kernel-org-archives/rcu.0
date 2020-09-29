Return-Path: <SRS0=CVHC=DG=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91DBC4727C
	for <rcu@archiver.kernel.org>; Tue, 29 Sep 2020 19:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43E0A207F7
	for <rcu@archiver.kernel.org>; Tue, 29 Sep 2020 19:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="siCtqrfj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbgI2TZz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 29 Sep 2020 15:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgI2TZy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 29 Sep 2020 15:25:54 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D44C061755
        for <rcu@vger.kernel.org>; Tue, 29 Sep 2020 12:25:54 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id p20so3171116qvl.4
        for <rcu@vger.kernel.org>; Tue, 29 Sep 2020 12:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=rYftVaj976XAVBBPD1tw6YKpSPevzCd8/SePPlUAJ1M=;
        b=siCtqrfjEEMVi2yF63FhGYeZSPJGGgIFsjp02OHmUhBAgvg7nXnxYs0u3Jij+pDOi/
         aaUOWyxYPvHQwt3ucdhvmboX4cgQ7hu4gbFQ2HpdMx6Is0NFW5ycThzrgub3jJ0Ahb6B
         0F48VrKa40b1yLeHahn+d8Ym3XS/8/dS4MskZFES19vpRlIa95obeoTN/m13RVVTJEDB
         fSwqrbc+fQM7+IHe01GrNe09AdxszY23Vc04EF3+xerJYFdHY7rjIqf0qtN8/uoHuYXU
         xkieDcS2BVxCMzqGonbSb9HE18kY2ttjOYwJx6WH3mIln/0djUiI+YLbBYRODu4QU+7B
         Ze2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rYftVaj976XAVBBPD1tw6YKpSPevzCd8/SePPlUAJ1M=;
        b=nYIIZNO6C0F/fmP+zEe1NuA0VovcFAp5b35gUMKmPm05j9LRQdfJg8dZt5FTMTh2WD
         D6//vzz1F09tdLVq9naFz9t8Ed1BycbPdKk/nLpfNzGRwsBLaqJcISvnsgSfLoU2PEk7
         kVLleNZMZ0QnSS3P8XQIYTsoXD525LKwLTnsNEJQEtS71N+dHdC41TZPSevJBk1WtviG
         tgF+xZ0Ytonbf4d7d03pb46bT3Qxu+aYCkW8yte3k+mVwFSiZo19q/SVCIaa//YElszC
         fnwWW+aNRn4CAMNHRuQy6ut8Qip5P2TohutynBIcHFwMlIXg6z3QSE5IyakgAEL98z8+
         uK5A==
X-Gm-Message-State: AOAM532IFypj/JAqYCWuznooanWyRTehUS+HVARrJaXV5gTp7kjiGhaD
        MD/Dts/Z2J0pr7TM3t3C998Ueq5OsND2TkB2D2M=
X-Google-Smtp-Source: ABdhPJwco412wUhwx4p0sbTHmoj7w2c8QO+QNegOV++VsHPsuzZEEydgm6hxQuBFySTARFLRC7RbAziWW5Y0bUifTwA=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a0c:ee6a:: with SMTP id
 n10mr5625188qvs.45.1601407553788; Tue, 29 Sep 2020 12:25:53 -0700 (PDT)
Date:   Tue, 29 Sep 2020 12:25:49 -0700
In-Reply-To: <CAKwvOd=s+N4+X94sTams_hKn8uV5Hc6QyCc7OHyOGC-JFesS8A@mail.gmail.com>
Message-Id: <20200929192549.501516-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <CAKwvOd=s+N4+X94sTams_hKn8uV5Hc6QyCc7OHyOGC-JFesS8A@mail.gmail.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v2] srcu: avoid escaped section names
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The stringification operator, `#`, in the preprocessor escapes strings.
For example, `# "foo"` becomes `"\"foo\""`.  GCC and Clang differ in how
they treat section names that contain \".

The portable solution is to not use a string literal with the
preprocessor stringification operator.

Link: https://bugs.llvm.org/show_bug.cgi?id=42950
Fixes: commit fe15b50cdeee ("srcu: Allocate per-CPU data for DEFINE_SRCU() in modules")
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes V1->V2:
* drop unrelated Kconfig changes accidentally committed in v1.

 include/linux/srcutree.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 9cfcc8a756ae..9de652f4e1bd 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -124,7 +124,7 @@ struct srcu_struct {
 # define __DEFINE_SRCU(name, is_static)					\
 	is_static struct srcu_struct name;				\
 	struct srcu_struct * const __srcu_struct_##name			\
-		__section("___srcu_struct_ptrs") = &name
+		__section(___srcu_struct_ptrs) = &name
 #else
 # define __DEFINE_SRCU(name, is_static)					\
 	static DEFINE_PER_CPU(struct srcu_data, name##_srcu_data);	\
-- 
2.28.0.709.gb0816b6eb0-goog

