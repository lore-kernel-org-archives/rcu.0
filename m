Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85585C433EF
	for <rcu@archiver.kernel.org>; Fri, 13 May 2022 14:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353025AbiEMOzl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 13 May 2022 10:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349568AbiEMOzk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 13 May 2022 10:55:40 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF6217054
        for <rcu@vger.kernel.org>; Fri, 13 May 2022 07:55:39 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id d15so14979451lfk.5
        for <rcu@vger.kernel.org>; Fri, 13 May 2022 07:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Cbc1ebLi+bapLdes0n8ulDAJENFljYfU/XpUlsOIVqg=;
        b=ZBW6QsnfEE+d260arZpbT10hRl/xSF38vJq07xxU7fTjQ57MHwl96J1EWJZnbLjoFq
         au2leRsNF8i8zdxQNmfmD9Ni+lGTCaWIDHhgob3X8MAJbiwxKlZ+YiS+VF+xXvIHMFRl
         W8OzwYewG/QPc0xS4cGlVIWG/6dV+3Ajii1BMGj337Ff1gY6EOKkiTfA2jcYPoOJIIiz
         gUPp2TzZsja2PO4/NVNd3VMXuHcLhW17cs1U5pkAybv1XszC+Rq8VB0czygdVmKcYvcN
         M+GfXWyU6S8XYtE+eeM0VwkkluBCNwGPva0HRos5oBUzJc5uqUe1WUbycY5LilZbAQE1
         17VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cbc1ebLi+bapLdes0n8ulDAJENFljYfU/XpUlsOIVqg=;
        b=c1LNNMRBzFRP88m6evjgii4FRyDA1Uy4Ohj/XXRcpVfh6uHpvSgVWPWpOJ3FvlfkP/
         xdg2Sp3Nakb/szEuz3RiK+cX2mnNjHGM9L2kSzyVM07oqCzv86D6gfTJ3KWzwu5hxuBx
         fr+nv3XHe58tvjjp5mYJfWB6qcs+W7lvn22LTjZEehYaA29YOo4u2A+cxWXWp0+gBkxV
         bxG3jTCAbkS3xZkl1OXd+T1QOr/R3cF51KwItfba6jLelixkHLCpvB/OhfaswX1VJFDL
         0kjrn8jKEvj6D84c7UW2ACad6OMlYahAJ5185N1BPLVHX57tr4zZOmbcJBToy0PIiMEN
         cWeQ==
X-Gm-Message-State: AOAM530FAF3HbNrN4r0daGWvWsB5wj3VbgRVjCgNG+pZmfGiO/lM3V4O
        SYCyKIH0bd+LmawS3Y+XidY=
X-Google-Smtp-Source: ABdhPJzZTetY7Av8ZaxQujrKkxwf/HIUZ/7C9uFehsyV0Gf+6tT4cJUu3becLZHH5IYuY6sE2bT5vQ==
X-Received: by 2002:a05:6512:2313:b0:473:a307:b1ee with SMTP id o19-20020a056512231300b00473a307b1eemr3689141lfu.159.1652453737556;
        Fri, 13 May 2022 07:55:37 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id u8-20020ac24c28000000b0047255d211c7sm400620lfq.246.2022.05.13.07.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 07:55:36 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Fri, 13 May 2022 16:55:34 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        rcu@vger.kernel.org, rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [RFC v1 10/14] kfree/rcu: Queue RCU work via
 queue_rcu_work_lazy()
Message-ID: <Yn5xZkENgmnd7wyq@pc638.lan>
References: <20220512030442.2530552-1-joel@joelfernandes.org>
 <20220512030442.2530552-11-joel@joelfernandes.org>
 <20220513001206.GZ1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513001206.GZ1790663@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> On Thu, May 12, 2022 at 03:04:38AM +0000, Joel Fernandes (Google) wrote:
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> Again, given that kfree_rcu() is doing its own laziness, is this really
> helping?  If so, would it instead make sense to adjust the kfree_rcu()
> timeouts?
> 
IMHO, this patch does not help much. Like Paul has mentioned we use
batching anyway.

--
Uladzislau Rezki
