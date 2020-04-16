Return-Path: <SRS0=pJ0D=6A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9B6C2BB55
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 18:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A683206A2
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 18:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="kGTMON9V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbgDPSnv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Apr 2020 14:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728815AbgDPSnu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Apr 2020 14:43:50 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94033C061A0C
        for <rcu@vger.kernel.org>; Thu, 16 Apr 2020 11:43:50 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id m67so22409989qke.12
        for <rcu@vger.kernel.org>; Thu, 16 Apr 2020 11:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C2vAstrjhAJ56IKYjJzFmkIkwEEcyH1H0MarRmZYyf8=;
        b=kGTMON9V7azjzPr2Ol8kSgQROb9u8GSyCkZUaRTS3SmQtZNGt2T6c2LYsEq0ID3tmv
         UeYtnBVmFC2zWfwKWmGYZe4bVBMhgVuIr0WUpV+oqy/GVb/vY4hfUw2xljgD1+UzMAVM
         Gyi+MU60Cu9za9XEnAVWFsborbXiVTkTT/uTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C2vAstrjhAJ56IKYjJzFmkIkwEEcyH1H0MarRmZYyf8=;
        b=NjFO2B/RniojQvW3Q1YNNXYVOhcDGkVo/LwYLBvVBPz2YAPMQIGnfdNC+VRtWlEKKn
         Rx3bYBnlJPcSYyqQF9ipFgVKjTW3Ihw/GJFNUrecKHJAbXFkrBCmaHwpx4BO+eK7A/fI
         TUFnVYnd9qiCuCR/K1nWFT8csEGZlUV9QIfRRKK+XDaDmqk5cRyoFTk+GufuorPhjNrt
         5nfNz33NXbvRauGiR1i3s6n6dRsMTt3bCoANwaLvyRGDR9UHo3RAQstq4uZTX/5bbMlG
         oppz+oP8tJnmRrpxTmtO2JDI2JOwYK2Q9rEZZEmoT/KqoejYf7JUZHHWNXZkTCQXn8IJ
         R80g==
X-Gm-Message-State: AGi0Pub1iFqG2k3I0KaPMHwydzI4wHeZAiCrG5iKR611peeKwGKpAkq7
        kr62t8X7b6IwoGOFXOiVlF6bWA==
X-Google-Smtp-Source: APiQypK6f8uorydN1YEyAMrKL6+hgbZ5lp4CsCpZJPwU2I5bGFWsXQJchoXEYuySFm64uCKhs7TV3w==
X-Received: by 2002:a05:620a:b03:: with SMTP id t3mr31214331qkg.209.1587062629791;
        Thu, 16 Apr 2020 11:43:49 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id t15sm16559616qtc.64.2020.04.16.11.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 11:43:49 -0700 (PDT)
Date:   Thu, 16 Apr 2020 14:43:48 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
Message-ID: <20200416184348.GB149999@google.com>
References: <20200416152027.wkpxr2fvuf4jkgct@linutronix.de>
 <20200416153844.GA8191@pc636>
 <20200416154647.ceotefna34pdxpfi@linutronix.de>
 <20200416160129.GA8337@pc636>
 <20200416161149.lkvkfwevanff36kb@linutronix.de>
 <20200416161819.GA8551@pc636>
 <20200416163302.3fsroillwk2om5dh@linutronix.de>
 <20200416172953.GR17661@paulmck-ThinkPad-P72>
 <20200416182309.zytrgowlngpewxbt@linutronix.de>
 <20200416182948.GV17661@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416182948.GV17661@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Apr 16, 2020 at 11:29:48AM -0700, Paul E. McKenney wrote:
> On Thu, Apr 16, 2020 at 08:23:09PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2020-04-16 10:29:53 [-0700], Paul E. McKenney wrote:
> > > > migrate_disable() would work.
> > > 
> > > Or moving to a raw spinlock, correct?
> > 
> > I'm currently in favour of that migrate_disable(). raw spinlock does not
> > work because there is memory allocation via get_page() later on.
> 
> Fair enough!  IIRC, get_page() uses non-raw spinlocks, so...

Oh, I see Paul made the same suggestion I did for raw spinlocks.

migrate_disable() is fine, but note that in the later code we will not be
sleeping even during the get_page(), so I don't see a problem with raw
spinlock... did I miss something?

thanks,

 - Joel

