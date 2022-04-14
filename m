Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7DEC433F5
	for <rcu@archiver.kernel.org>; Thu, 14 Apr 2022 19:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345324AbiDNTWW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 14 Apr 2022 15:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345259AbiDNTWU (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 14 Apr 2022 15:22:20 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58762B53D5
        for <rcu@vger.kernel.org>; Thu, 14 Apr 2022 12:19:50 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id e22so4808438qvf.9
        for <rcu@vger.kernel.org>; Thu, 14 Apr 2022 12:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AmOv5rtWsBjN+AH3Yiwh3/xuZYgmQM8D4+J7GjX0x60=;
        b=HopD3qrAEWycdOfimAP39aurNTsYZT/k4CNX23xV4pYQRBDzfqGfZmdo/hskHJEDDq
         eyI7fHLthCq8riD92+r3ERUkkLegaIc7DSazq9AJIS8DoBLzFSQgQzsCppKaIZUwmt+O
         unHHUfKfCq1xHxSOf03GpNReZrzdcEKaUdHv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AmOv5rtWsBjN+AH3Yiwh3/xuZYgmQM8D4+J7GjX0x60=;
        b=yIKizwSXQvdbxtccn8iIZ66mkFPGYYjG19NMT6ieQVbLgVmQ5y+ZTFirlqlkATP9qi
         n0JY10Lj9DzR0C4EppmJZOxz65HCgJdfATdvY2jkxBu03EevZd/1AdgvBTCVbl5NfFoU
         kJDme+367CP9s8o7IrCHB2MC0F8S9Yce1wvsPkvEynwFVb3u217F3iCyAhW5XjtAnsAh
         4LEZznPUgK+CV6Rh36XaKWMiJr8jaoH5Hd/14z87XLwLXWVF2OIe0VWpFKNwTsLdEBde
         yYC3D+Kl8NQvDZIXMavMdBckSuXXnnTQG/Xl889T6d3Ww1ZCMzyipwuVfdyslzc16nie
         d4Lw==
X-Gm-Message-State: AOAM530OiVo0FfsN2qQViBVAZLGfX4+PC2FSl520b48Ut292HOSlE3qu
        AGv0cq7WLfGzk4s4OwO0Nz3Bzg==
X-Google-Smtp-Source: ABdhPJyga0NX+wOgXs9y23L4yB3ht5AzMjEnNjGwPgsAEO1IpewiA3RRQlb9oQk0hYxufs1bdCeEmw==
X-Received: by 2002:a05:6214:19c8:b0:444:32f0:2351 with SMTP id j8-20020a05621419c800b0044432f02351mr14188611qvc.109.1649963989216;
        Thu, 14 Apr 2022 12:19:49 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id w17-20020a05622a135100b002ef480d2559sm1718617qtk.34.2022.04.14.12.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 12:19:48 -0700 (PDT)
Date:   Thu, 14 Apr 2022 19:19:48 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH RFC] rcu/nocb: Provide default all-CPUs mask for
 RCU_NOCB_CPU=y
Message-ID: <Ylhz1LOIf+JyjH7n@google.com>
References: <20220408142232.GA4285@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQWeqfcKdAKmCn4fFGyWXjOGd=29wvi6bL3k7s2bGkDJw@mail.gmail.com>
 <20220408155002.GF4285@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQDgSO2XkkVhN3RBBz3vwYdAtTuPz-xYYsAPnwEnbYZPA@mail.gmail.com>
 <20220408174908.GK4285@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQ+oE3xQ0tLnBMFxRXLqKZkT5UfjF+CULxnhf9F-dEA2g@mail.gmail.com>
 <CAEXW_YRK2t2JO4RyBTd8cR9sTVpgP7Z5Ywhb1g7CRz3HJ_kNQA@mail.gmail.com>
 <20220408205440.GL4285@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTunj5j7cxT3VYGGmJwcQowpDiyqmewiwHjyXP-zJd4FA@mail.gmail.com>
 <20220411154109.GX4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411154109.GX4285@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Apr 11, 2022 at 08:41:09AM -0700, Paul E. McKenney wrote:
[..]
> > > [4]     All CPUs are offloaded at boot, and any CPU can be de-offloaded
> > >         and offloaded at runtime.  This is the same behavior that
> > >         you would currently get with CONFIG_RCU_NOCB_CPU_ALL=n and
> > >         rcu_nocbs=0-N.
> > 
> > Yes, this is the behavior I intend. So then there would not be a need
> > to pass a mask (and I suspect for a large number of users, it
> > simplifies boot params).
> 
> Very good, and from what I can see, this should work for everyone.

Just to clarify, what I am going to do is, if this new option =y, then
rcu_nocbs effectively wont do anything. i.e. All CPUs are offloaded at boot.
Let me know if we are not on the same page about it though. I do feel that is
a sensible choice given =y. If we are on same page, please ignore my comment.

> > > I believe that Steve Rostedt's review would carry weight for ChromeOS,
> > > however, I am suffering a senior moment on the right person for Android.
> > 
> > I think for Android, Kalesh Singh is in the kernel team and Tim Murray
> > is the performance lead. They could appropriately represent their RCU
> > needs.
> 
> Sounds good!  Please collect a Reviewed-by from one or both of them.

Ok.

thanks,

 - Joel

