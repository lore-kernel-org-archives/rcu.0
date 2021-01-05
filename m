Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BBCC433E6
	for <rcu@archiver.kernel.org>; Tue,  5 Jan 2021 13:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 616FF229EF
	for <rcu@archiver.kernel.org>; Tue,  5 Jan 2021 13:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbhAENP0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Jan 2021 08:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbhAENP0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Jan 2021 08:15:26 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EB2C061793;
        Tue,  5 Jan 2021 05:14:45 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id h22so72523151lfu.2;
        Tue, 05 Jan 2021 05:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tQKbFrNJhZtnkQVAJYkn3GuvMlIvsBf16oBsGWuoFBg=;
        b=Qgcs4Xx6lLq0YZhAP+b3iXdVigcYK/deCQAJeY+C1VNb9zFq0ywyeJXslL8S6zNt26
         oMdstuxuBGDOvQ0f4VNaTt5aEQthq7vPE66VQkNdfu1+ugV5to9YzhrNTqZqRSfWY2xq
         EoJQs2veM7c22hFQAPIVdYjXXKVTn/FG6Oo1qzfTPoHiu53wGXkauVd8ALaIynNN8BGc
         yN74qQ2qBj8KGbxQOnpYfVO9y3fBiyZyUdU00YRMf45t1EAODcfDqMjvV38EzIIi6tK7
         F7J/aBxnojloVN0+XEpes+OlJ4xXNXDr0jyglTcvTyOVXDiDbVtOXMn+C7gUfUkjHkFO
         090Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tQKbFrNJhZtnkQVAJYkn3GuvMlIvsBf16oBsGWuoFBg=;
        b=RzTwZ3CUrb1GpqJf5+FVKxHaasAWep8qxh1kzPBblCzRCqxYoE1mWnenZleG3IbPyR
         NwYBRRn0ReDrCZbcnjuWJSHob3DSXB85WwdWP5ErkFIULyJQ+MkMW20XW/l2kQEO6P/W
         sur1DMoocQGn5zRTc2lGX6dZFCh9ykMeprK9YGVtD9s4IvYxCuicHaEkw/n7wGjgvWCu
         VUcc8jknefI42kNHAYLuhczYRi5XCuXqCVciJ27cxtQlyCIC2YXB3ktFG0OedbzhEY44
         xyPJBPnISfxunSnZoKdh0Yuo8FqV68tN3yh+QaGcxjKcaTvNM+96fzwHLwJrqGwexP7M
         NaYg==
X-Gm-Message-State: AOAM532yY+b5Qqvnz/7y43pg9TxT4O+pR/F9BAFud7Dj8z78jor5k8G2
        cznGV46kCXP1yK0jaUHsGkQ=
X-Google-Smtp-Source: ABdhPJyeY24/g5kvCBsLLaTN+RDyjtpbSWCKqEnHATmX3nVrdhUp3hZJPi9Y5sxP84E4B53L/qOF6Q==
X-Received: by 2002:a05:6512:3051:: with SMTP id b17mr30077247lfb.16.1609852484397;
        Tue, 05 Jan 2021 05:14:44 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id t30sm7608665lft.266.2021.01.05.05.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 05:14:43 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Tue, 5 Jan 2021 14:14:41 +0100
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: kerneldoc warnings since commit 538fc2ee870a3 ("rcu: Introduce
 kfree_rcu() single-argument macro")
Message-ID: <20210105131441.GA2457@pc638.lan>
References: <CAKXUXMygqbupE_6CK92=PwLw4DjnSuo9-+6iHs_DrZeZ55iRKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKXUXMygqbupE_6CK92=PwLw4DjnSuo9-+6iHs_DrZeZ55iRKg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Dear, Lukas.

> Dear Uladzislau,
> 
> in commit 538fc2ee870a3 ("rcu: Introduce kfree_rcu() single-argument
> macro"), you have refactored the kfree_rcu macro.
> 
> Since then, make htmldocs warns:
> 
> ./include/linux/rcupdate.h:882: warning: Excess function parameter
> 'ptr' description in 'kfree_rcu'
> ./include/linux/rcupdate.h:882: warning: Excess function parameter
> 'rhf' description in 'kfree_rcu'
> 
> As you deleted the two arguments in the macro definition, kerneldoc
> cannot resolve the argument names in the macro's kerneldoc
> documentation anymore and warns about that.
> 
> Probably, it is best to just turn the formal kerneldoc references to
> the two arguments, which are not used in the macro definition anymore,
> simply into two informal references in the documentation.
> 
Thanks for your suggestion. I am not sure if htmldocs supports something
like "__maybe_unused", but tend to say that it does not. See below the
patch:

<snip>
From 65ecc7c58810c963c02e0596ce2e5758c54ef55d Mon Sep 17 00:00:00 2001
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Date: Tue, 5 Jan 2021 13:23:30 +0100
Subject: [PATCH] rcu: fix kerneldoc warnings

After refactoring of the kfree_rcu(), it becomes possible to use
the macro with one or two arguments. From the other hand, in the
description there are two arguments in the macro definition expected.
That is why the "htmldocs" emits a warning about it:

<snip>
./include/linux/rcupdate.h:882: warning: Excess function parameter
'ptr' description in 'kfree_rcu'
./include/linux/rcupdate.h:882: warning: Excess function parameter
'rhf' description in 'kfree_rcu'
<snip>

Fix it by converting two parameters into informal references in the
macro description.

Fixes: 3d3d9ff077a9 ("rcu: Introduce kfree_rcu() single-argument macro")
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/rcupdate.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index ebd8dcca4997..e678ce7f5ca2 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -854,8 +854,8 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
 
 /**
  * kfree_rcu() - kfree an object after a grace period.
- * @ptr: pointer to kfree for both single- and double-argument invocations.
- * @rhf: the name of the struct rcu_head within the type of @ptr,
+ * ptr: pointer to kfree for both single- and double-argument invocations.
+ * rhf: the name of the struct rcu_head within the type of ptr,
  *       but only for double-argument invocations.
  *
  * Many rcu callbacks functions just call kfree() on the base structure.
-- 
2.20.1
<snip>

Paul, does it work for you?

Thanks!

--
Vlad Rezki
