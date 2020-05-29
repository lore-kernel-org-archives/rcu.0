Return-Path: <SRS0=efVp=7L=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9E8C433E0
	for <rcu@archiver.kernel.org>; Fri, 29 May 2020 17:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47ACD2073B
	for <rcu@archiver.kernel.org>; Fri, 29 May 2020 17:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="TFFlX+ag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgE2Rzp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 29 May 2020 13:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728148AbgE2Rzo (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 29 May 2020 13:55:44 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD77C03E969
        for <rcu@vger.kernel.org>; Fri, 29 May 2020 10:55:44 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id x29so2654789qtv.4
        for <rcu@vger.kernel.org>; Fri, 29 May 2020 10:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gv39I/ih8lAtkcAoM2d9l8Vc2We+TLPp+fYVCFm40Xs=;
        b=TFFlX+agMNFLnBirOI5jvTNvS/ZkjzFrM7s2zVZwK7qhQQ+NF2TrK+BVhiOBrRxe9a
         yf2B79/hLWE8gtbi1Hp7FY8lyjqvRSVZ20gGDmLIgtaDrcbBiWxVAXGD9UGfuz3DO/m0
         ORkCMDsUHxk8SoyVnUNEFo5vHt/YWk+LMUdeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gv39I/ih8lAtkcAoM2d9l8Vc2We+TLPp+fYVCFm40Xs=;
        b=Pf2l9kZapuTrNP22dAMU1NsDEnAQbVbHIPPoFXd9IQws1tkHE7avKE1fwSmHdCVyAD
         3GHcsW9tFYk86UJ77YqvnVR4/x93LM2NhqvMIK6lmpJKDVMds8ooM9Ut+l0z9d7rilL/
         YtmwofmQn/0i9p2ZxDSwQOZ3Sb1jnqXuvV8XkGNpoD6nToTMwtLHLSQVxkK82huEAfiu
         rbBRScX2HUqporICzCjHcO5WSmr/49gvBZ0narEL03j9qVeRM6jbS0FdjqIfSbhG+n4v
         iW114P7Mte9j87/IKzCPSUCEpk6dC35EOMkq/MRXN151aiB4MhJzoGJgeGwnj8PepslS
         pO+A==
X-Gm-Message-State: AOAM531ovLoRIahUtpWdpoAzCDBg7VH3r4hTCAraCtXTa/LsNtBMzt6j
        Gf+ja4vJJKvKYs4A0c+pPU1Bwg==
X-Google-Smtp-Source: ABdhPJy5+F5YMXcqRSfVtsl7N4AM6y253dEfslIEzRpxBicrOtIY+el4csDNn7knKPbnTBDoE7QAMw==
X-Received: by 2002:aed:33c1:: with SMTP id v59mr7071537qtd.250.1590774943446;
        Fri, 29 May 2020 10:55:43 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a188sm7439403qkg.11.2020.05.29.10.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 10:55:43 -0700 (PDT)
Date:   Fri, 29 May 2020 13:55:42 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     paulmck@kernel.org, rcu@vger.kernel.org
Subject: Re: [bug report] refperf: Dynamically allocate experiment-summary
 output buffer
Message-ID: <20200529175542.GA197424@google.com>
References: <20200529094829.GA1302781@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529094829.GA1302781@mwanda>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, May 29, 2020 at 12:48:29PM +0300, Dan Carpenter wrote:
> Hello Paul E. McKenney,
> 
> This is a semi-automatic email about new static checker warnings.
> 
> The patch 54c0ed208976: "refperf: Dynamically allocate
> experiment-summary output buffer" from May 25, 2020, leads to the
> following Smatch complaint:
> 
>     kernel/rcu/refperf.c:395 main_func()
>     error: we previously assumed 'buf' could be null (see line 352)
> 
> kernel/rcu/refperf.c
>    351		buf = kzalloc(64 + nruns * 32, GFP_KERNEL);
>    352		if (!result_avg || !buf) {
>                                    ^^^^
> Check for NULL

Makes sense. Looks like Paul already fixed it so should be good.

Thanks!
