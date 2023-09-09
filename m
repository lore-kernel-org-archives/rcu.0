Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844D0EEB57C
	for <rcu@archiver.kernel.org>; Sat,  9 Sep 2023 01:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjIIBvS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 8 Sep 2023 21:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241453AbjIIBvR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 8 Sep 2023 21:51:17 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604051716
        for <rcu@vger.kernel.org>; Fri,  8 Sep 2023 18:51:12 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2bcc4347d2dso43708751fa.0
        for <rcu@vger.kernel.org>; Fri, 08 Sep 2023 18:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1694224270; x=1694829070; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PrToj7FeDRLWjKBQmt7EM4KaQEIvjVbVJx9Xts6lKOU=;
        b=FU/jo9CmBRp87h5YF6u89FZLl2nXROKCYBvuMKyMAErvenw/EmaHq2zB+mVe/jwnRD
         8ZQKCwQdtQLlSxbor6OVKMAbpJ/YQMqGQK/CEpJOy2nWZhNCLpH+LPALfrEbd3W32at2
         Dr/5/RieJNlZLmjOKE+ji3rdDPyO5d/PWa1OQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694224270; x=1694829070;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PrToj7FeDRLWjKBQmt7EM4KaQEIvjVbVJx9Xts6lKOU=;
        b=uwspVnjRmdflzT0iNvNUOHaapBtzYdGmgsb6MRUHvyTQoAKRqzzE6+5gX7sFfBuYsy
         oi83mKhFFRnwS+w6Fy4Bxuil4IFFkRiIN7Yl/VfVMvjtIfG+A5MiVYZeUjXmTRJqZ6xG
         vJunnPOdpGsyySHgjIzl7cWk3zNeru5nY8A3jCfNeWG8RYPJNfxQt1tovlBGtexCLELt
         HcLwl8LULoASTXXjfaihykGmH23NDtqX/hwJ2tvUVBV1X2eYGJHYnt7/JL8Ooitftb3f
         uGGL4IWQ0KUwMXp+jFu+6pCrRYmc7yUA7ZwEb3amnjFAOHGgxiIJ8+lO6Ibqmh2vbQSw
         iAYw==
X-Gm-Message-State: AOJu0YxxLBRmFdm6w/McOx8uQadXAha2xNhO+SKB4J27XV7zlDDF5N5b
        xr9PLeV9k9uEWa2Ci2pYCw+1OEimTA/8lijwkmxjVA==
X-Google-Smtp-Source: AGHT+IHOIuHOCzsUY5H2PPqv3Yp9QbQ2cgHuTrW+0DRaNEAH0oKwk+XmuIxDsdNpVRHw7osDHATTPHsIdwdlvW4jllM=
X-Received: by 2002:a2e:9b5a:0:b0:2bc:c51d:da9e with SMTP id
 o26-20020a2e9b5a000000b002bcc51dda9emr3351866ljj.21.1694224270514; Fri, 08
 Sep 2023 18:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230908203603.5865-1-frederic@kernel.org> <20230908203603.5865-4-frederic@kernel.org>
 <CAEXW_YTxSft0cZkq6UOsdkDxLCjMZfqqK3fBVz6He0UebCqS+g@mail.gmail.com>
In-Reply-To: <CAEXW_YTxSft0cZkq6UOsdkDxLCjMZfqqK3fBVz6He0UebCqS+g@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 8 Sep 2023 21:50:59 -0400
Message-ID: <CAEXW_YQec-aUxMQ_tGx9N6_pF=K9vhWZEPT6JGKcemcBXOM+7g@mail.gmail.com>
Subject: Re: [PATCH 03/10] rcu/nocb: Remove needless LOAD-ACQUIRE
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> > * Callbacks can be concurrently advanced between the LOAD-ACQUIRE on
> >   ->nocb_cb_sleep and the call to rcu_segcblist_extract_done_cbs() in
> >   rcu_do_batch(), making any ordering based on ->nocb_cb_sleep broken.
>
> If you don't mind, could you elaborate more?

Ah, I see you deleted the counterpart memory barrier in the next
patch. I was reading the patches in order, so I did not notice. I'll
go read that as well. It might make sense to combine this and the next
patch, not sure.

 - Joel
