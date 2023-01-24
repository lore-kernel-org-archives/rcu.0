Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6D5C54E94
	for <rcu@archiver.kernel.org>; Tue, 24 Jan 2023 17:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbjAXRK1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 24 Jan 2023 12:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjAXRK1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 24 Jan 2023 12:10:27 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923F11A9
        for <rcu@vger.kernel.org>; Tue, 24 Jan 2023 09:10:23 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-4c24993965eso227394817b3.12
        for <rcu@vger.kernel.org>; Tue, 24 Jan 2023 09:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Nqe+HXQOazdzEGwqM1I5HZfpsQcB7ky+WS7pe/K1K8s=;
        b=I2daPYabCwhhvalqsSjeqgziiGddRvYVQkANoocsTycIFP1rZEekiH4w1jtyqw+acW
         fysjeF7QScdcTttplOvHIWxN0OArh3vjHiQ68R88p5+CYXxW++GLzLLrAIKtyjJY3FGc
         2RpgRz1JPqDhVq6d9T+g4/hfQj5CwP472yR08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nqe+HXQOazdzEGwqM1I5HZfpsQcB7ky+WS7pe/K1K8s=;
        b=Ii+Ot87+qNjzmPgYQ6M21HBebPjq7pmQgxBBBBK4ypAV2hti6D4RXmZBAU8d3w/KXf
         GBLfLDEjm4/elnUs2uT+JqtzFjYeggaFcLxRi072jNtKLoYCVuoWYnuiPFVlcEugoVGN
         kY9O37c/kN5EsfrHeI24jn1G0M/dqsUCh2klzsIgYjzt91P7yxG76c9tkk3zt2r89lH9
         3iBf5ZgeiQPfg9CyvjrstzQQsjWnlM+ZO2D0JNtd8htLu9lCJTZ2LdoSZBslcsS7tOKE
         IPNw2tVc/rMplo1xM9FXymjdGHiBvmZ4R8rfPXK4igYs/e9zZrDgVNAMWfeBETlOI0iB
         ANqg==
X-Gm-Message-State: AFqh2kqE4ttqbEtbZumcoYYohnvoL7Y2rp+oysyU0fKADznR4K2UIPIz
        flGMX1S/F64mpsfbitly58wRyPY39tjOLyB5
X-Google-Smtp-Source: AMrXdXvSxePWmAVG/XXlBs85oBznPK/PcdtlA/v9gnl+VzsT32EbOK3b47MYG5lamgfkd/QwwniEjw==
X-Received: by 2002:a05:7500:3ec1:b0:f1:a03d:e3d4 with SMTP id lj1-20020a0575003ec100b000f1a03de3d4mr1815528gab.15.1674580222607;
        Tue, 24 Jan 2023 09:10:22 -0800 (PST)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id h15-20020a05620a13ef00b006cec8001bf4sm1776318qkl.26.2023.01.24.09.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 09:10:21 -0800 (PST)
Date:   Tue, 24 Jan 2023 17:10:21 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] rcu: Remove impossible wakeup rcu GP kthread action
 from rcu_report_qs_rdp()
Message-ID: <Y9AQ/Yob7x/dif82@google.com>
References: <PH0PR11MB5880A16045A842AB80A25C4BDAC59@PH0PR11MB5880.namprd11.prod.outlook.com>
 <B3E458A6-9279-4716-B242-873C77EC1E3A@joelfernandes.org>
 <PH0PR11MB58803DFEDD61EE66AF49074EDACA9@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR11MB58803DFEDD61EE66AF49074EDACA9@PH0PR11MB5880.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Jan 21, 2023 at 12:38:35AM +0000, Zhang, Qiang1 wrote:
[...]
> >If you are in an intermediate state, part way to a !nocb state — 
> >you may have missed a nocb-related accel and wake, correct? Why does that matter? 
> >Once we transition to a !nocb state, we do not do a post-qs-report accel+wake anyway
> 
> Should it be transition to a !nocb state, we do a post-qs-report accel+wake.
> 
> >as we clearly know from the discussion. So why do we need to do it if we missed it for
> >the intermediate stage? So, I am not fully sure yet what that needac is doing and why it is needed.
> 
> For de-offloading, when in the process of
> de-offloading(rcu_segcblist_completely_offloaded() return false), we're not
> doing bypass even though this rdp is offloaded
> state(rcu_rdp_is_offloaded(rdp) return true), at this time, the rcuog
> kthread probably won't accel+wakeup, so we do accel+wakeup in
> rcu_report_qs_rdp(), as you say why does that matter?  for !nocb state,
> we've always tried to accel+wakeup as much as possible(compared to nocb),
> let rcu callback be executed as soon as possible.
> 
> This is just my personal opinion, please correct me if I am wrong.

I think your opinion is correct. The acceleration after the QS reporting may
be needed for the case where we are part way between the offload and
de-offload state as in this state (which we could call limbo state), there
does not seem to be anywhere that acceleration is performed, and if this state
persists for a long period of time, then no other path can accelerate the CBs
thus likely starving them as Frederic mentioned..

thanks,

 - Joel


> Thanks
> Zqiang
> 
> 
> >
> >Do not get me wrong, stellar work here. But I suggest challenge the assumptions and the design, not always just the code that was already written :), apologies for any misplaced or noisy advice.
> >
> >Thanks!
> >
> > - Joel
> 
> 
> >    
> > Thanks
> > Zqiang
> > 
> >> 
> >> (I am out of office till Monday but will intermittently (maybe) check
> >> in, RCU is one of those things that daydreaming tends to lend itself
> >> to...)
> >> 
> >> - Joel
