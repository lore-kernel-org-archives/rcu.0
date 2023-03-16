Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874B0C6FD1D
	for <rcu@archiver.kernel.org>; Thu, 16 Mar 2023 02:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjCPC3G (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Mar 2023 22:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjCPC3F (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Mar 2023 22:29:05 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7F0EB78
        for <rcu@vger.kernel.org>; Wed, 15 Mar 2023 19:28:55 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id t9so350718qtx.8
        for <rcu@vger.kernel.org>; Wed, 15 Mar 2023 19:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678933734;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KG1r9kbQqAfNoWzYNzz6bJ+MT9bAShSCfI7fsXqrf/o=;
        b=m3vKxWOfLEopey4P8LpX6utUyayrLDNztqtTK5qlZlMpGozb0jK0xeFY3JBjaJ6r6y
         7+eegABYmlMqBn4DVR3d1oZUZbGLZ2VCQYRu4ZsQY185dgQ9qsabOHxqy6tBopw6gX62
         YMh9Jcc33JpjbMDUseu0hYTNp8xFMosxHw09c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678933734;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KG1r9kbQqAfNoWzYNzz6bJ+MT9bAShSCfI7fsXqrf/o=;
        b=WDdmB3vgLSRmFy5riP5pNAZcUzLD9NWToB6ahwLuqf+aiHt5EGA40X9KY0Xpe4F/A0
         ecmYVkulFPbTiyjE+e/6IcOAZYKdOMbrpuhirbR/ZOTVlEotB9AyKkD0Klp6D4NyIbOe
         Bw3jHcmnYuMLDJI3S6RJ05anyzT9DGRrx8yqnkWxZ6uVKr2KLNeZy9Ng1mYLDiu63CBs
         qIROr40T6yGXCFVOHv4nW/Bh1dnTIaYGAxDM49JKwRzuJXB9NZ7Rl1/tcZ7qlVHplqYC
         bXdNw9YOxPc2aLGsoHys/udoGnQ9RYOZ13Xw6v0RopDdgn6Xug/vOcw4KB+R/eAC3vnQ
         WKpg==
X-Gm-Message-State: AO0yUKWx1Y7sXs58oOU1NPpCBrvkNDYmBpOiw/8wW5IQyOJluTns7uyy
        RPlUpWR61vXznKJKZFHbWFJw6Q==
X-Google-Smtp-Source: AK7set9j25ceInnfVhwEylSlTyaH9XxqIg+YiHpbF3rcR/mqN8/4KnIzNfpAVswqTmOuOyySZ5d9Mg==
X-Received: by 2002:ac8:4e88:0:b0:3ba:26a0:d0ee with SMTP id 8-20020ac84e88000000b003ba26a0d0eemr3562630qtp.52.1678933734410;
        Wed, 15 Mar 2023 19:28:54 -0700 (PDT)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id z9-20020ac84309000000b003d2d815825fsm3924906qtm.40.2023.03.15.19.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 19:28:53 -0700 (PDT)
Date:   Thu, 16 Mar 2023 02:28:53 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang1.zhang@intel.com>, rcu@vger.kernel.org
Subject: Re: [PATCH 4/9] rcu: Register rcu-lazy shrinker only for
 CONFIG_RCU_LAZY=y kernels
Message-ID: <20230316022853.GA110573@google.com>
References: <20230315194349.10798-1-joel@joelfernandes.org>
 <20230315194349.10798-4-joel@joelfernandes.org>
 <ZBJSd9tJ8RU7er1o@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZBJSd9tJ8RU7er1o@localhost.localdomain>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Mar 16, 2023 at 12:19:19AM +0100, Frederic Weisbecker wrote:
> Le Wed, Mar 15, 2023 at 07:43:44PM +0000, Joel Fernandes (Google) a écrit :
> > From: Zqiang <qiang1.zhang@intel.com>
> > 
> > The lazy_rcu_shrink_count() shrinker function is registered even in
> > kernels built with CONFIG_RCU_LAZY=n, in which case this function
> > uselessly consumes cycles learning that no CPU has any lazy callbacks
> > queued.
> > 
> > This commit therefore registers this shrinker function only in the kernels
> > built with CONFIG_RCU_LAZY=y, where it might actually do something useful.
> > 
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thanks!

 - Joel

