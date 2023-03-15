Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6147C61DA4
	for <rcu@archiver.kernel.org>; Wed, 15 Mar 2023 12:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbjCOMX1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Mar 2023 08:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbjCOMW7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Mar 2023 08:22:59 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5DC94779
        for <rcu@vger.kernel.org>; Wed, 15 Mar 2023 05:21:53 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id jl13so12301671qvb.10
        for <rcu@vger.kernel.org>; Wed, 15 Mar 2023 05:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678882910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MsV1dSmZQh2TX7/derbiKkACl9wwmr90MM8z5+HIK6E=;
        b=GYaA+pdVbdgjEhemVrCwtlfYBAeN1d4VpjRq95GnqMJMZq1x3za5Q75+BTySA80esv
         Uf9qvbQVez/QLMGD+pDxoTa7EQmVbNbwskT3h88OqtPifLGc8dbI4ajqUlq5WaaTBQF8
         cTDoTEC1o8cIidPqzac5QPuJurpO5FBMayST8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678882910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsV1dSmZQh2TX7/derbiKkACl9wwmr90MM8z5+HIK6E=;
        b=K0DITsmMu6EihYe3pZjm4A9qzF+C3EUiPTVJenG8w0lHImfz5uGy+iy8IHRrWr5yUz
         nw9aj4vCjAOHwI8NhsHLZo7ulIHkTDY6YPwlb292B6v1CEkNQSg/njDIjUGkBTN1lQm+
         cCiPO2nYzDD7uzQoPXUWauyzwI9SXvHvo4NHkLYNUbEw6I/7kO1qCP2PPFSDkgM7QCwP
         HT+FtlenJ8kh/PnOjsjgtQ6fv6qe8v0YdQ4obgr8ZB+K0pYYoGZ7AFBJto6xoKT+OS1P
         4xuzmK5hDKA6mjami/pu9QIFNoNE7og/3lZb07nznDzcACnPEP9ko/OnZIHfQ1Ks4z3Q
         ERjg==
X-Gm-Message-State: AO0yUKU5HTPK25/Qz0b8uiV8LtgTxSl8sQ/Uop31fMk+T+tFGmIx7hSD
        MYMMnLfNGZNy5ETKXKOUCQp02w==
X-Google-Smtp-Source: AK7set+Y3Y7lCVHbdYRmbXrUZPyAmjA3Az7QpROjvnuBgJ5o6K6T6f1lAdt2WLh2u3oCdM/3e6FfxQ==
X-Received: by 2002:a05:6214:1d2c:b0:577:6271:a035 with SMTP id f12-20020a0562141d2c00b005776271a035mr28473275qvd.1.1678882909589;
        Wed, 15 Mar 2023 05:21:49 -0700 (PDT)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id t62-20020a374641000000b0073b878e3f30sm3571908qka.59.2023.03.15.05.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 05:21:49 -0700 (PDT)
Date:   Wed, 15 Mar 2023 12:21:48 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v3] rcu: Add a minimum time for marking boot as completed
Message-ID: <20230315122148.GF3784687@google.com>
References: <ZAc+vVZUhXdhpSki@pc636>
 <CAEXW_YRTLQpQpOW-+n+X59pmB=4TkV=gdsMiQfBkdK_4wO9Jug@mail.gmail.com>
 <20230307173313.GJ1301832@paulmck-ThinkPad-P17-Gen-1>
 <20230307185443.GA516865@google.com>
 <20230307192726.GL1301832@paulmck-ThinkPad-P17-Gen-1>
 <ZAhYP9a8u05hzsOn@pc636>
 <20230308144528.GR1301832@paulmck-ThinkPad-P17-Gen-1>
 <ZAnXxr9OyFT63xSx@pc636>
 <20230309221056.GB148448@google.com>
 <ZArwZjcEYXAYwmqi@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZArwZjcEYXAYwmqi@pc636>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Mar 10, 2023 at 09:55:02AM +0100, Uladzislau Rezki wrote:
> On Thu, Mar 09, 2023 at 10:10:56PM +0000, Joel Fernandes wrote:
> > On Thu, Mar 09, 2023 at 01:57:42PM +0100, Uladzislau Rezki wrote:
> > [..]
> > > > > > > > See this commit:
> > > > > > > > 
> > > > > > > > 3705b88db0d7cc ("rcu: Add a module parameter to force use of
> > > > > > > > expedited RCU primitives")
> > > > > > > > 
> > > > > > > > Antti provided this commit precisely in order to allow Android
> > > > > > > > devices to expedite the boot process and to shut off the
> > > > > > > > expediting at a time of Android userspace's choosing.  So Android
> > > > > > > > has been making this work for about ten years, which strikes me
> > > > > > > > as an adequate proof of concept.  ;-)
> > > > > > > 
> > > > > > > Thanks for the pointer. That's true. Looking at Android sources, I
> > > > > > > find that Android Mediatek devices at least are setting
> > > > > > > rcu_expedited to 1 at late stage of their userspace boot (which is
> > > > > > > weird, it should be set to 1 as early as possible), and
> > > > > > > interestingly I cannot find them resetting it back to 0!.  Maybe
> > > > > > > they set rcu_normal to 1? But I cannot find that either. Vlad? :P
> > > > > > 
> > > > > > Interesting.  Though this is consistent with Antti's commit log,
> > > > > > where he talks about expediting grace periods but not unexpediting
> > > > > > them.
> > > > > > 
> > > > > Do you think we need to unexpedite it? :))))
> > > > 
> > > > Android runs on smallish systems, so quite possibly not!
> > > > 
> > > We keep it enabled and never unexpedite it. The reason is a performance.  I
> > > have done some app-launch time analysis with enabling and disabling of it.
> > > 
> > > An expedited case is much better when it comes to app launch time. It
> > > requires ~25% less time to run an app comparing with unexpedited variant.
> > > So we have a big gain here.
> > 
> > Wow, that's huge. I wonder if you can dig deeper and find out why that is so
> > as the callbacks may need to be synchronize_rcu_expedited() then, as it could
> > be slowing down other usecases! I find it hard to believe, real-time
> > workloads will run better without those callbacks being always-expedited if
> > it actually gives back 25% in performance!
> > 
> I can dig further, but on a high level i think there are some spots
> which show better performance if expedited is set. I mean synchronize_rcu()
> becomes as "less blocking a context" from a time point of view.
> 
> The problem of a regular synchronize_rcu() is - it can trigger a big latency
> delays for a caller. For example for nocb case we do not know where in a list
> our callback is located and when it is invoked to unblock a caller.
> 
> I have already mentioned somewhere. Probably it makes sense to directly wake-up
> callers from the GP kthread instead and not via nocb-kthread that invokes our callbacks
> one by one.

Looking forward to your optimization, I wonder if to overcome the issue Paul
mentioned about wake up overhead, whether it is possible to find out how many
tasks there are to wake without much overhead, and for the common case of
likely one task to wake up which is doing a synchronize_rcu(), wake that up.
But there could be dragons..

thanks,

 - Joel

